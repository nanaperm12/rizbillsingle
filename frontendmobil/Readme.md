# Aplikasi Seluler RIZKITECH BILL Plus

Aplikasi seluler ini adalah portal pelanggan khusus untuk sistem Manajemen Penagihan ISP RIZKITECH BILL. Aplikasi ini dibangun menggunakan Expo (React Native) dan menyediakan antarmuka yang mulus bagi pelanggan untuk mengelola akun internet mereka, membayar tagihan, dan mendapatkan dukungan langsung dari perangkat seluler mereka.

---

## ✨ Fitur Utama

- **Login Aman:** Pelanggan masuk menggunakan ID Pelanggan unik mereka. Sistem ini terintegrasi dengan backend untuk mendukung login dengan **OTP (One-Time Password)** melalui WhatsApp jika diaktifkan oleh admin.
- **Dasbor Beranda:** Tampilan ringkasan yang menampilkan:
  - Detail paket layanan internet pelanggan.
  - Peringatan untuk tagihan yang belum dibayar.
  - **Pemantauan Lalu Lintas Langsung:** Grafik real-time untuk kecepatan unduh (RX) dan unggah (TX).
- **Manajemen Perangkat (Integrasi ACS):**
  - Lihat status perangkat modem (ONT/ONU) secara real-time (Online/Offline).
  - Pantau parameter kunci seperti **kekuatan sinyal optik (RX Power)**.
  - **Reboot Jarak Jauh:** Pelanggan dapat memulai ulang modem mereka langsung dari aplikasi.
  - **Pengaturan Wi-Fi Mandiri:** Pelanggan dapat mengubah nama jaringan Wi-Fi (SSID) dan kata sandi mereka.
  - Lihat daftar perangkat yang terhubung ke jaringan Wi-Fi.
- **Penagihan & Pembayaran:**
  - Lihat riwayat lengkap semua tagihan (lunas, belum dibayar, jatuh tempo).
  - **Pembayaran Dalam Aplikasi:** Lakukan pembayaran untuk tagihan yang belum lunas melalui gateway pembayaran (Tripay) yang ditampilkan dalam **WebView**, memastikan pengalaman pengguna yang lancar.
- **Pusat Bantuan & Dukungan:**
  - **Sistem Tiket:** Pelanggan dapat membuat keluhan baru (misalnya, koneksi lambat, tidak ada koneksi).
  - **Obrolan Keluhan:** Lacak status dan lihat balasan dari admin dalam format obrolan dua arah yang intuitif.
  - Pelanggan dapat membalas keluhan langsung dari aplikasi.
- **Manajemen Profil:**
  - Lihat detail profil pribadi (nama, alamat, kontak).
  - Opsi untuk keluar (logout) dengan aman.

---

## 🛠️ Tumpukan Teknologi

- **Framework:** Expo (React Native)
- **Bahasa:** TypeScript
- **Navigasi:** React Navigation (Stack & Bottom Tabs)
- **Manajemen State:** React Hooks (useState, useEffect, useCallback)
- **Komunikasi Jaringan:** Fetch API
- **Penyimpanan Lokal:** AsyncStorage untuk manajemen sesi.

---

## 🚀 Instalasi & Menjalankan

Ikuti langkah-langkah ini untuk menjalankan aplikasi di lingkungan pengembangan lokal.

### Prasyarat

- **Node.js** (v18 atau lebih tinggi)
- **Expo CLI** (`npm install -g expo-cli`)
- Aplikasi **Expo Go** di perangkat seluler (Android atau iOS) atau emulator/simulator yang sudah diatur.
- Pastikan server **backend** utama sedang berjalan.

### Langkah-langkah

1.  **Navigasi ke Direktori Aplikasi:**
    Buka terminal dan arahkan ke direktori `frontendmobil`.

    ```bash
    cd frontendmobil
    ```

2.  **Install Dependensi:**

    ```bash
    npm install
    ```

3.  **Konfigurasi Alamat IP Backend (Sangat Penting!):**

    - Buka file `frontendmobil/api/config.ts`.
    - Temukan variabel `LOCAL_IP_ADDRESS`.
    - **Ganti nilai placeholder** dengan alamat IP lokal dari komputer tempat server **backend** Anda berjalan. Anda bisa menemukan IP ini dengan menjalankan `ipconfig` (Windows) atau `ifconfig` (macOS/Linux).
    - Pastikan perangkat seluler Anda terhubung ke jaringan Wi-Fi yang **sama** dengan komputer Anda.

    ```typescript
    // Contoh di frontendmobil/api/config.ts
    const LOCAL_IP_ADDRESS = "192.168.1.102"; // <-- ⚠️ GANTI INI
    ```

4.  **Jalankan Aplikasi:**
    Gunakan perintah dari direktori root proyek atau langsung di `frontendmobil`. Perintah `npm run mobile` di root sudah dikonfigurasi.

    ```bash
    # Dari direktori root proyek
    npm run mobile

    # Atau dari direktori frontendmobil
    expo start
    ```

5.  **Hubungkan Perangkat Anda:**
    - Setelah server Metro bundler berjalan, sebuah kode QR akan muncul di terminal.
    - Buka aplikasi **Expo Go** di perangkat seluler Anda.
    - Pindai kode QR tersebut. Aplikasi akan mulai membangun bundel JavaScript dan menjalankannya di perangkat Anda.

---

## 📦 Membangun Aplikasi untuk Produksi (Build)

Untuk membuat file `.apk` (untuk instalasi langsung) atau `.aab` (untuk Google Play Store), kita akan menggunakan **EAS (Expo Application Services) Build**.

1.  **Install EAS CLI:**
    Jika belum terinstal, jalankan perintah ini di terminal Anda:

    ```bash
    npm install -g eas-cli
    ```

2.  **Login ke Akun Expo:**

    ```bash
    eas login
    ```

3.  **Konfigurasi Proyek (hanya sekali):**
    Di dalam direktori `frontendmobil`, jalankan:

    ```bash
    eas build:configure
    ```

    Ini akan membuat file `eas.json` yang berisi konfigurasi build.

4.  **(Opsional) Konfigurasi untuk APK:**
    Jika Anda ingin menghasilkan file `.apk` untuk pengujian, bukan `.aab` untuk Play Store, ubah file `eas.json` Anda. Tambahkan `"buildType": "apk"` di bawah profil `preview` atau `production`.

    ```json
    {
      "build": {
        "production": {
          "android": {
            "buildType": "apk"
          }
        }
      }
    }
    ```

5.  **Mulai Proses Build:**
    Jalankan perintah berikut dari dalam direktori `frontendmobil`:

    ```bash
    # Untuk membuat AAB (atau APK jika dikonfigurasi di atas) untuk produksi
    eas build -p android

    # Atau, jika Anda ingin menggunakan profil build yang berbeda
    # eas build -p android --profile preview
    ```

Proses ini akan mengunggah proyek Anda ke server build Expo dan membuat file aplikasi Anda di cloud. Setelah selesai, Anda akan mendapatkan tautan untuk mengunduh artefak build tersebut.

# build android local

npx expo prebuild
cd android
./gradlew assembleRelease

# jika ingin membuat keystore

keytool -genkeypair -v -keystore my-key.keystore -alias my-key -keyalg RSA -keysize 2048 -validity 10000

Simpan di android/app/

Tambahkan ke android/gradle.properties:

MYAPP_UPLOAD_STORE_FILE=my-key.keystore
MYAPP_UPLOAD_KEY_ALIAS=my-key
MYAPP_UPLOAD_STORE_PASSWORD=isi_password
MYAPP_UPLOAD_KEY_PASSWORD=isi_password

# penambahan fitur admob

atur id iklan di halaman app.json dan CustomerHomeScreen
\*\*bannerAdUnitID
