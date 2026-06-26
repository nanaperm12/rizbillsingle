import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { fileURLToPath, URL } from 'node:url';
import { VitePWA } from 'vite-plugin-pwa';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: 'autoUpdate',
      injectRegister: 'script',
      // The workbox configuration will automatically find all assets in the build output directory.
      workbox: {
        globPatterns: ['**/*.{js,css,html,ico,png,svg,json,webmanifest}'],
        globIgnores: ['**/pwaicon.svg'],
        maximumFileSizeToCacheInBytes: 5 * 1024 * 1024,
      },
      // By using includeAssets, the plugin will handle copying the icons,
      // hashing them, and generating the correct paths in the manifest.
      includeAssets: ['/pwa-192.png', '/pwa-512.png'],
      manifest: {
        "name": "RIZKITECHBILL",
        "short_name": "RIZKITECHBILL",
        "description": "Kelola akun internet Anda, bayar tagihan, dan dapatkan dukungan.",
        "start_url": "/",
        "scope": "/",
        "id": "/",
        "display": "standalone",
        "background_color": "#f9fafb",
        "theme_color": "#2563eb",
        "icons": [
          {
            "src": "/pwa-192.png",
            "sizes": "192x192",
            "type": "image/png",
            "purpose": "any"
          },
          {
            "src": "/pwa-192.png",
            "sizes": "192x192",
            "type": "image/png",
            "purpose": "maskable"
          },
          {
            "src": "/pwa-512.png",
            "sizes": "512x512",
            "type": "image/png",
            "purpose": "any"
          }
        ]
      }
    })
  ],
  resolve: {
    alias: {
      '~': fileURLToPath(new URL('./', import.meta.url))
    },
  },
  server: {
    // This allows Vite to be accessed from outside localhost,
    // which is necessary for ngrok to work.
    host: true,
    // REMOVED: The explicit HMR port configuration was causing a port conflict
    // when the default port (5173) was already in use. Removing this allows
    // Vite to automatically manage the HMR port, resolving the startup error.
    proxy: {
      '/api': {
        // PENTING: Untuk pengembangan web lokal, target ini harus localhost.
        // Untuk pengujian di perangkat seluler fisik di jaringan yang sama, ganti 'localhost'
        // dengan alamat IP LOKAL komputer Anda (misalnya, http://192.168.1.19:3002).
        target: 'http://localhost:3002',
        changeOrigin: true,
      },
      '/uploads': {
        target: 'http://localhost:3002',
        changeOrigin: true,
      }
    }
  },
  // This forces Vite to re-bundle dependencies, clearing any stale caches,
  // which is a direct solution for persistent import resolution errors.
  optimizeDeps: {
    force: true,
  },
})
