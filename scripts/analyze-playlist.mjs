import fs from 'node:fs/promises';
import path from 'node:path';

const inputPath = process.argv[2];
if (!inputPath) {
  console.error('Usage: node scripts/analyze-playlist.mjs <playlist-file>');
  process.exit(1);
}

const drmPattern = /<ContentProtection\b|cenc:pssh|schemeIdUri="urn:uuid:/i;
const m3u8Pattern = /\.m3u8(\?|$)/i;
const mpdPattern = /\.mpd(\?|$)/i;
const attrPattern = /([a-zA-Z0-9-:]+)="([^"]*)"/g;

const readFile = async (filePath) => fs.readFile(filePath, 'utf8');

const parsePlaylist = (text) => {
  const lines = String(text || '').split(/\r?\n/).map((line) => line.trim());
  const items = [];

  for (let i = 0; i < lines.length; i += 1) {
    const line = lines[i];
    if (!line.startsWith('#EXTINF')) continue;

    let streamUrl = '';
    for (let j = i + 1; j < lines.length; j += 1) {
      const candidate = lines[j];
      if (!candidate) continue;
      if (candidate.startsWith('#') && !/^https?:\/\//i.test(candidate)) continue;
      streamUrl = candidate;
      break;
    }

    if (!streamUrl || streamUrl.startsWith('#')) continue;

    const commaIndex = line.lastIndexOf(',');
    const title = commaIndex >= 0 ? line.slice(commaIndex + 1).trim() : line.replace(/^#EXTINF:-?\d+\s*/, '').trim();
    const attrsPart = commaIndex >= 0 ? line.slice(0, commaIndex) : line;
    const attrs = {};
    attrPattern.lastIndex = 0;
    let match;
    while ((match = attrPattern.exec(attrsPart)) !== null) {
      attrs[match[1]] = match[2];
    }

    items.push({
      title: title || 'Unknown Channel',
      groupTitle: attrs['group-title'] || attrs.groupTitle || 'Lainnya',
      logoUrl: attrs['tvg-logo'] || attrs['group-logo'] || attrs.logo || '',
      streamUrl: streamUrl.trim(),
      extinf: line,
    });
  }

  return items;
};

const fetchWithTimeout = async (url, timeoutMs = 20000) => {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(new Error(`Timeout after ${timeoutMs}ms`)), timeoutMs);
  try {
    const response = await fetch(url, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
        'Accept': '*/*',
      },
      redirect: 'follow',
      signal: controller.signal,
    });
    const text = await response.text();
    return { response, text };
  } finally {
    clearTimeout(timeout);
  }
};

const analyzeItem = async (item) => {
  const url = item.streamUrl;
  const result = {
    ...item,
    type: m3u8Pattern.test(url) ? 'hls' : mpdPattern.test(url) ? 'dash' : 'other',
    drmProtected: false,
    fetchOk: true,
    status: undefined,
    contentType: undefined,
    note: '',
  };

  if (result.type !== 'dash') {
    return result;
  }

  try {
    const { response, text } = await fetchWithTimeout(url, 25000);
    result.status = response.status;
    result.contentType = response.headers.get('content-type') || undefined;
    result.drmProtected = drmPattern.test(text);
    if (!response.ok) {
      result.fetchOk = false;
      result.note = `HTTP ${response.status}`;
    } else if (result.drmProtected) {
      result.note = 'DRM detected';
    } else {
      result.note = 'DASH non-DRM';
    }
  } catch (error) {
    result.fetchOk = false;
    result.note = error?.name === 'AbortError' ? 'Timeout' : (error?.message || 'Fetch failed');
  }

  return result;
};

const main = async () => {
  const absolutePath = path.resolve(inputPath);
  const raw = await readFile(absolutePath);
  const items = parsePlaylist(raw);

  const analyzed = [];
  let idx = 0;
  const concurrency = 5;

  while (idx < items.length) {
    const batch = items.slice(idx, idx + concurrency);
    const batchResults = await Promise.all(batch.map(analyzeItem));
    analyzed.push(...batchResults);
    idx += concurrency;
  }

  const counts = analyzed.reduce((acc, item) => {
    acc.total += 1;
    acc[item.type] = (acc[item.type] || 0) + 1;
    if (item.type === 'dash') {
      if (item.drmProtected) acc.drm += 1;
      else if (item.fetchOk) acc.dashNonDrm += 1;
      else acc.dashUnknown += 1;
    }
    return acc;
  }, { total: 0, hls: 0, dash: 0, other: 0, drm: 0, dashNonDrm: 0, dashUnknown: 0 });

  const cleanLines = ['#EXTM3U'];
  for (const item of analyzed) {
    if (item.type === 'dash' && item.drmProtected) continue;
    cleanLines.push(item.extinf);
    cleanLines.push(item.streamUrl);
  }

  const outBase = absolutePath.replace(/(\.m3u8?|\.txt)?$/i, '');
  const reportPath = `${outBase}.report.json`;
  const cleanPath = `${outBase}.non-drm.m3u8`;

  await fs.writeFile(reportPath, JSON.stringify({
    source: absolutePath,
    counts,
    analyzed: analyzed.map((item) => ({
      title: item.title,
      groupTitle: item.groupTitle,
      streamUrl: item.streamUrl,
      type: item.type,
      drmProtected: item.drmProtected,
      fetchOk: item.fetchOk,
      status: item.status,
      contentType: item.contentType,
      note: item.note,
    })),
  }, null, 2), 'utf8');

  await fs.writeFile(cleanPath, cleanLines.join('\n') + '\n', 'utf8');

  console.log(JSON.stringify({
    source: absolutePath,
    counts,
    reportPath,
    cleanPath,
  }, null, 2));
};

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
