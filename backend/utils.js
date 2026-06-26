import pool from './db.js';

// Default timezone configuration. 
// In production, this should ideally come from process.env.APP_TIMEZONE
const DEFAULT_TIMEZONE = process.env.APP_TIMEZONE || 'Asia/Jakarta';

const normalizeBillingType = (value) => String(value || '').trim().toLowerCase();

export const defaultSettings = {
    mikrotik: { host: '', user: '', password: '', port: 8728 },
    tripay: { apiKey: '', privateKey: '', merchantCode: '', sandboxMode: true, enabledMethods: [] },
    digiflazz: { username: '', apiKey: '', sandboxMode: false },
    olt: { devices: [] },
    gemini: { apiKey: '', enabled: false },
    video: {
        enabled: false,
        title: 'TV Channel',
        playlistUrl: '',
        playlistText: '',
        posterUrl: '',
        description: '',
        autoplay: false,
        loop: false,
        controls: true,
    },
    billing: { 
        taxRate: 0, 
        dueDays: 10, // For Postpaid: Day of month (e.g., 10th)
        fixedBillDueDays: 3, // For Fixed: Duration after issue (e.g., 3 days)
        fixedInvoiceLeadDays: 10,
        generationDay: 1, 
        suspensionDays: 3, 
        suspensionProfileName: '', 
        whatsappNotificationsEnabled: false, 
        reminderDaysBeforeDue: 3, 
        sendInvoiceOnCreate: false,
        bonusVoucherProfile: '',
        bonusVoucherPrefix: 'bonus-',
        bonusVoucherPackageIds: [],
    },
    app: { baseUrl: '', appName: '', appLogoUrl: '', companyPhone: '', companyAddress: '', customerIdPrefix: '310890', apiKey: '', timezone: 'Asia/Jakarta' },
    otp: {
        enabled: false,
        whatsappTemplate: 'Your OTP code for ISP Billing Pro is: {{otpCode}}. This code expires in 5 minutes.'
    },
    whatsapp: {
        invoiceCreated: '', invoiceReminder: '', paymentSuccess: 'Salam, Kak *{{customerName}}* \n\nPembayaran Invoice dengan rincian :\nNama : *{{customerName}}* \nId Pelanggan : {{customerId}}\nLayanan : *{{packageName}}*\nPeriode : {{billingPeriod}}\nInvoice : #{{invoiceId}} \nTotal : *{{amount}}* \nStatus : *PAID | LUNAS* via *{{paymentMethod}}*\n\nTerimakasih sudah menggunakan layanan kami, \nSelamat menikmati koneksi internet tanpa batas!\n\nSalam Rizkitech By Lintas Jaringan Nusantara',
        suspensionWarning: '', adminPhoneNumber: '', newComplaintNotification: '', newRegistrationNotification: 'PENDAFTARAN BARU\n\nPelanggan: {{customerName}}\nID Pelanggan: {{customerId}}\nNo. HP: {{customerPhone}}\nEmail: {{customerEmail}}\nPaket: {{packageName}}\n\nAlamat:\n{{address}}',
        accountSuspended: '',
        accountReactivated: '',
        accountDeactivated: '',
        resellerBalanceAdded: '',
        technicianTaskAssignment: 'TUGAS BARU DITERIMA\n\nHalo {{technicianName}},\n\nAnda telah ditugaskan untuk menangani keluhan baru:\n\nTiket: #{{ticketId}}\nPelanggan: {{customerName}}\nAlamat: {{customerAddress}}\nKeluhan: {{complaintType}}\n\nDeskripsi:\n"{{complaintDescription}}"\n\nSilakan periksa dasbor teknisi Anda untuk detail lebih lanjut dan untuk memulai tugas. Terima kasih.',
        packageChanged: 'PERUBAHAN PAKET BERHASIL\n\nYth. Bapak/Ibu {{customerName}},\n\nSesuai permintaan Anda, paket internet Anda telah berhasil diubah ke *{{newPackageName}}*.\n\nPerubahan ini aktif mulai hari ini dan tagihan Anda berikutnya akan disesuaikan dengan harga paket baru.\n\nTerima kasih.',
        chatbotEnabled: false,
        affiliateTopupSuccess: '',
        broadcastGeneral: '',
        broadcastOutage: '',
        broadcastDelayMode: 'step',
        broadcastDelayStartMs: 1000,
        broadcastDelayIncrementMs: 750,
        broadcastDelayMaxMs: 7000,
        broadcastDelayStepEvery: 5,
        broadcastDelayRandomJitterMs: 1500,
        standbyEnabled: false,
    },
    email: {
        enabled: false,
        smtpHost: '',
        smtpPort: 587,
        smtpSecure: false,
        smtpUser: '',
        smtpPass: '',
        fromName: '',
        fromEmail: '',
        dueSubject: 'Pengingat jatuh tempo invoice #{{invoiceId}} - {{customerName}}',
        dueBody: 'Halo {{customerName}},\n\nInvoice #{{invoiceId}} sebesar {{amount}} untuk paket {{packageName}} (periode {{billingPeriod}}) jatuh tempo pada {{dueDate}}.\n\nLink pembayaran: {{paymentLink}}\n\nTerima kasih.',
        paidSubject: 'Pembayaran berhasil invoice #{{invoiceId}} - {{customerName}}',
        paidBody: 'Halo {{customerName}},\n\nPembayaran untuk invoice #{{invoiceId}} sebesar {{amount}} telah kami terima melalui {{paymentMethod}}.\n\nTerima kasih.',
    },
        acs: { // Pengaturan default untuk ACS
            apiUrl: '',
            username: '',
            password: '',
        },
};

export const parseLocalDateString = (value) => {
    if (value == null) return null;
    let date = null;

    if (value instanceof Date) {
        date = new Date(value);
    } else if (typeof value === 'number') {
        date = value.toString().length > 11 ? new Date(value) : new Date(value * 1000);
    } else if (typeof value === 'string') {
        const trimmed = value.trim();
        if (/^\d+$/.test(trimmed)) {
            const numeric = Number(trimmed);
            date = trimmed.length >= 12 ? new Date(numeric) : new Date(numeric * 1000);
        } else {
            const normalized = trimmed.length === 10 ? `${trimmed}T00:00:00` : trimmed;
            date = new Date(normalized);
        }
    }

    if (!date || isNaN(date.getTime())) return null;
    return date;
};

export const parseDateOnlyString = (value) => {
    if (typeof value !== 'string') return null;
    const match = value.trim().match(/^(\d{4})-(\d{2})-(\d{2})$/);
    if (!match) return null;

    const year = Number(match[1]);
    const monthIndex = Number(match[2]) - 1;
    const day = Number(match[3]);
    const date = new Date(year, monthIndex, day);
    date.setHours(0, 0, 0, 0);
    return Number.isNaN(date.getTime()) ? null : date;
};

export const normalizeToBusinessDate = (value, timezone = null) => {
    const parsed = parseLocalDateString(value);
    if (!parsed) return null;

    const businessYmd = dateToYMD(parsed, timezone);
    return parseDateOnlyString(businessYmd);
};

export const addMonthsKeepDay = (sourceDate, deltaMonths) => {
    if (!sourceDate) return null;
    const date = new Date(sourceDate);
    const targetDay = date.getDate();
    const targetMonthBase = new Date(date);
    targetMonthBase.setDate(1);
    targetMonthBase.setMonth(targetMonthBase.getMonth() + deltaMonths);
    const daysInTargetMonth = new Date(targetMonthBase.getFullYear(), targetMonthBase.getMonth() + 1, 0).getDate();
    targetMonthBase.setDate(Math.min(targetDay, daysInTargetMonth));
    return targetMonthBase;
};

export const getCurrentFixedCycleStart = (customer, referenceDate = new Date(), timezone = null) => {
    const parsedActive = normalizeToBusinessDate(customer?.activeDate, timezone);
    if (!parsedActive) return null;

    const ref = normalizeToBusinessDate(referenceDate, timezone) || parseLocalDateString(referenceDate) || new Date(referenceDate);
    if (!ref || Number.isNaN(ref.getTime())) return null;

    let currentStart = new Date(parsedActive);
    currentStart.setHours(0, 0, 0, 0);

    const normalizedRef = new Date(ref);
    normalizedRef.setHours(0, 0, 0, 0);

    let nextStart = addMonthsKeepDay(currentStart, 1);
    while (nextStart && nextStart <= normalizedRef) {
        currentStart = nextStart;
        nextStart = addMonthsKeepDay(currentStart, 1);
    }

    return currentStart;
};

export const getFirstUnbilledFixedCycleStart = ({ customer, existingPeriodStarts = [], referenceDate = new Date(), includeFutureCycle = false, timezone = null }) => {
    const parsedActive = normalizeToBusinessDate(customer?.activeDate, timezone);
    if (!parsedActive) return null;

    const ref = normalizeToBusinessDate(referenceDate, timezone) || parseLocalDateString(referenceDate) || new Date(referenceDate);
    if (!ref || Number.isNaN(ref.getTime())) return null;

    const normalizedRef = new Date(ref);
    normalizedRef.setHours(0, 0, 0, 0);

    const existingSet = new Set(
        existingPeriodStarts
            .map((value) => {
                const parsed = parseLocalDateString(value);
                return parsed ? dateToYMD(parsed, timezone) : null;
            })
            .filter(Boolean)
    );

    let currentStart = new Date(parsedActive);
    currentStart.setHours(0, 0, 0, 0);

    let fallbackFutureStart = null;

    while (currentStart) {
        const startKey = dateToYMD(currentStart, timezone);
        const nextStart = addMonthsKeepDay(currentStart, 1);

        if (currentStart > normalizedRef) {
            if (!existingSet.has(startKey)) {
                fallbackFutureStart = currentStart;
            }
            break;
        }

        if (!existingSet.has(startKey)) {
            return currentStart;
        }

        if (!nextStart) break;
        currentStart = nextStart;
    }

    return includeFutureCycle ? fallbackFutureStart : null;
};

export const getSettings = async (conn) => {
    // Gunakan koneksi yang diberikan jika ada, jika tidak gunakan pool utama
    const querier = conn || pool;
    try {
        const [rows] = await querier.query("SELECT settings_value FROM settings WHERE settings_key = 'main'");
        if (rows.length === 0 || !rows[0].settings_value) {
            return defaultSettings;
        }
        
        // Secara aman mengurai, default ke objek kosong jika gagal atau nilainya null
        let dbSettings = {};
        try {
            const parsed = JSON.parse(rows[0].settings_value);
            // Pastikan kita memiliki objek, bukan null atau primitif lainnya
            if (parsed && typeof parsed === 'object') {
                dbSettings = parsed;
            }
        } catch (e) {
            console.error("Could not parse settings from DB, using defaults. Error:", e);
            return defaultSettings;
        }

        const mergedSettings = {
            mikrotik: { ...defaultSettings.mikrotik, ...(dbSettings.mikrotik || {}) },
            tripay: { ...defaultSettings.tripay, ...(dbSettings.tripay || {}) },
            digiflazz: { ...defaultSettings.digiflazz, ...(dbSettings.digiflazz || {}) },
            gemini: { ...defaultSettings.gemini, ...(dbSettings.gemini || {}) },
            video: {
                ...defaultSettings.video,
                enabled: Boolean(dbSettings.video?.enabled),
                title: dbSettings.video?.title || defaultSettings.video.title,
                playlistUrl: dbSettings.video?.playlistUrl || '',
                playlistText: dbSettings.video?.playlistText || dbSettings.video?.m3u8Url || dbSettings.video?.videoUrl || '',
                posterUrl: dbSettings.video?.posterUrl || '',
                description: dbSettings.video?.description || '',
                autoplay: Boolean(dbSettings.video?.autoplay),
                loop: Boolean(dbSettings.video?.loop),
                controls: dbSettings.video?.controls !== false,
            },
            olt: { ...defaultSettings.olt, ...(dbSettings.olt || {}) },
            billing: { ...defaultSettings.billing, ...(dbSettings.billing || {}) },
            app: { ...defaultSettings.app, ...(dbSettings.app || {}) },
            otp: { ...defaultSettings.otp, ...(dbSettings.otp || {}) },
            whatsapp: { ...defaultSettings.whatsapp, ...(dbSettings.whatsapp || {}) },
            email: { ...defaultSettings.email, ...(dbSettings.email || {}) },
            acs: { ...defaultSettings.acs, ...(dbSettings.acs || {}) },
        };

        return mergedSettings;
    } catch (dbError) {
        console.error("Database error while fetching settings:", dbError);
        return defaultSettings; // Kembalikan default jika ada galat DB
    }
};

/**
 * Generates a new, unique customer ID based on application settings.
 * Format: [PREFIX]{TIME_PART}{RANDOM_PART} (e.g., 31089012345)
 * @param {string} prefix - The 6-digit prefix from settings.
 * @returns {string} The new 11-digit customer ID.
 */
export const generateNewCustomerId = (prefix) => {
  // Suffix part 1: last 3 digits of timestamp (milliseconds) for high variance
  const timePart = (Date.now() % 1000).toString().padStart(3, '0');
  // Suffix part 2: 2 random digits to further prevent collisions
  const randomPart = Math.floor(Math.random() * 100).toString().padStart(2, '0');
  
  return `${prefix}${timePart}${randomPart}`;
};

export const generateNewInvoiceId = () => {
    // Format: INV-{TIMESTAMP}-{RANDOM}
    return `INV-${Date.now()}-${Math.floor(Math.random() * 1000)}`;
};

export const formatRupiah = (amount) => {
    return new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
    }).format(amount);
};

export const replacePlaceholders = (template, data) => {
    if (!template) return '';
    return template.replace(/{{(\w+)}}/g, (_, key) => {
        return data[key] || `{{${key}}}`;
    });
};

/**
 * Converts a Date object to a MySQL DATETIME string (YYYY-MM-DD HH:MM:SS).
 * IMPORTANT: This function forces the output to be in the configured TARGET_TIMEZONE (e.g., Asia/Jakarta).
 * This ensures that even if the server is in UTC, the database stores the correct local time.
 * 
 * @param {Date} date - The date object to format.
 * @param {string} timezone - The IANA timezone string (e.g., 'Asia/Jakarta'). Defaults to 'Asia/Jakarta' or env var.
 */
export const toMySQLDatetime = (date = new Date(), timezone = null) => {
    const targetTz = timezone || DEFAULT_TIMEZONE;
    
    // Use Intl.DateTimeFormat to get parts in the specific timezone
    const formatter = new Intl.DateTimeFormat('en-CA', { // en-CA gives YYYY-MM-DD format
        timeZone: targetTz,
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false
    });

    const parts = formatter.formatToParts(date);
    const partValue = (type) => parts.find(p => p.type === type)?.value;

    return `${partValue('year')}-${partValue('month')}-${partValue('day')} ${partValue('hour')}:${partValue('minute')}:${partValue('second')}`;
};

/**
 * Converts a Date object to a YYYY-MM-DD string using the TARGET_TIMEZONE.
 * 
 * @param {Date} date - The date object to format.
 * @param {string} timezone - The IANA timezone string.
 */
export const dateToYMD = (date = new Date(), timezone = null) => {
    const targetTz = timezone || DEFAULT_TIMEZONE;

    const formatter = new Intl.DateTimeFormat('en-CA', {
        timeZone: targetTz,
        year: 'numeric',
        month: '2-digit',
        day: '2-digit'
    });
    
    const parts = formatter.formatToParts(date);
    const partValue = (type) => parts.find(p => p.type === type)?.value;

    return `${partValue('year')}-${partValue('month')}-${partValue('day')}`;
};

/**
 * Converts a database date string (potentially UTC or ISO) to a local ISO string.
 * This is often used for input[type="datetime-local"] values.
 */
export const dbDateTimeToLocalISO = (dateString) => {
    if (!dateString) return '';
    const date = new Date(dateString);
    if (isNaN(date.getTime())) return '';
    
    // Format to MySQL string first using the timezone logic, then replace space with T
    // This is a bit hacky but ensures consistency with how we store data
    const mysqlString = toMySQLDatetime(date);
    return mysqlString.replace(' ', 'T').substring(0, 16); // Trim seconds for datetime-local input
};

/**
 * Formats a database date string to a readable ISO-like string (YYYY-MM-DDTHH:mm:ss.sssZ)
 * Effectively just ensuring it's a standard string format for frontend parsing.
 */
export const dbDateToISO = (dateString) => {
    if (!dateString) return null;
    try {
        const date = new Date(dateString);
        return isNaN(date.getTime()) ? null : date.toISOString();
    } catch (e) {
        return null;
    }
};

export const formatDateDisplay = (dateString) => {
    if (!dateString) return 'N/A';
    const date = new Date(dateString);
    return date.toLocaleDateString('id-ID', { day: '2-digit', month: 'short', year: 'numeric' });
};

export const formatBillingPeriod = (start, end) => {
    if (!start || !end) return 'N/A';
    return `${formatDateDisplay(start)} - ${formatDateDisplay(end)}`;
};

/**
 * Calculates billing details (dates, amounts, prorata) for a customer.
 */
export const calculateBillingDetails = (customer, pkg, settings, targetPeriodStart) => {
    const { taxRate, dueDays } = settings.billing;

    const price = pkg.price;
    const tz = settings.app.timezone;
    const isFixedDateBilling = normalizeBillingType(customer?.billing_type) === 'fixed';
    
    let billingStart;
    let billingEnd;
    let dueDate;
    
    if (isFixedDateBilling) {
        const now = new Date();
        if (targetPeriodStart) {
            billingStart = parseDateOnlyString(targetPeriodStart) || normalizeToBusinessDate(targetPeriodStart, tz) || new Date(targetPeriodStart);
        } else if (customer.activeDate) {
            const parsedActive = normalizeToBusinessDate(customer.activeDate, tz);
            billingStart = parsedActive ? new Date(parsedActive) : now;
        } else {
            billingStart = now;
        }
        billingStart.setHours(0, 0, 0, 0);

        billingEnd = addMonthsKeepDay(billingStart, 1);
        billingEnd.setDate(billingEnd.getDate() - 1);

        dueDate = new Date(billingEnd);
        dueDate.setHours(0, 0, 0, 0);
    } else {
        // === POSTPAID LOGIC (Default) ===
        // Billing is for the PREVIOUS month.
        
        if (targetPeriodStart) {
            billingStart = new Date(targetPeriodStart);
        } else {
            const now = new Date();
            // Date.UTC handles year wrap-around automatically (Jan -> Dec prev year).
            billingStart = new Date(Date.UTC(now.getFullYear(), now.getMonth() - 1, 1));
        }

        // Calculate End Date: Last day of the billing month
        billingEnd = new Date(Date.UTC(billingStart.getUTCFullYear(), billingStart.getUTCMonth() + 1, 0));

        // Calculate Due Date based on FIXED Day of Month setting
        // Logic: Due date is the {dueDays}-th of the CURRENT month (the month following the billing period).
        const targetDueDay = dueDays || 10; // Default to 10th if not set
        
        const dueYear = billingStart.getFullYear(); 
        const dueMonth = billingStart.getMonth() + 1; // Month FOLLOWING billing start

        // Get the last day of the Due Date month to prevent overflow
        const daysInDueMonth = new Date(dueYear, dueMonth + 1, 0).getDate();
        const actualDueDay = Math.min(targetDueDay, daysInDueMonth);

        dueDate = new Date(dueYear, dueMonth, actualDueDay);
    }
    
    // 3. Prorata Calculation 
    let finalAmount = price;
    let notes = `Monthly invoice for ${pkg.name}`;

    if (!isFixedDateBilling && customer.activeDate) {
        const activeDateObj = new Date(customer.activeDate);
        
        // Only calculate prorata if the customer joined DURING this specific billing period
        if (activeDateObj.getUTCFullYear() === billingStart.getUTCFullYear() && 
            activeDateObj.getUTCMonth() === billingStart.getUTCMonth() &&
            activeDateObj.getUTCDate() > 1) { 
            
            const daysInMonth = billingEnd.getUTCDate();
            const activeDay = activeDateObj.getUTCDate();
            const daysActive = daysInMonth - activeDay + 1;
            
            const proratedPrice = Math.round((price / daysInMonth) * daysActive);
            finalAmount = proratedPrice;
            notes = `Prorated invoice (${daysActive} days) for ${pkg.name}`;
            
            // ADJUST BILLING START DATE TO REFLECT PRORATA PERIOD
            billingStart = activeDateObj;
        }
    }
    
    // 4. Apply Tax if applicable
    if (pkg.useTax && taxRate > 0) {
        finalAmount = Math.round(finalAmount * (1 + taxRate / 100));
    }

    return {
        amount: finalAmount,
        billingPeriodStart: dateToYMD(billingStart, tz),
        billingPeriodEnd: dateToYMD(billingEnd, tz),
        dueDate: dateToYMD(dueDate, tz),
        notes
    };
};

export const randomDelay = (minMs, maxMs) => {
    const ms = Math.floor(Math.random() * (maxMs - minMs + 1)) + minMs;
    return new Promise(resolve => setTimeout(resolve, ms));
};
