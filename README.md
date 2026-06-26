# ISP Billing Management System

Sebuah aplikasi web komprehensif yang dirancang untuk menyederhanakan dan mengotomatiskan operasi bisnis bagi Penyedia Layanan Internet (ISP). Aplikasi ini menyediakan Dasbor Admin yang kuat untuk manajemen menyeluruh dan Portal Pelanggan yang ramah pengguna untuk interaksi dan pembayaran mandiri.

---

## ✨ Fitur Utama

### 👨‍💻 Dasbor Admin

Platform terpusat untuk mengelola setiap aspek bisnis ISP Anda.

- **Dasbor Statistik:**

  - Ringkasan data vital: jumlah pelanggan total & aktif, pendapatan bulanan, dan total tagihan tertunggak.
  - Tampilan aktivitas terkini seperti pelanggan baru dan pembayaran terakhir.
  - Pemantauan status koneksi ke perangkat jaringan utama (Router MikroTik).

- **Manajemen Pelanggan:**

  - **CRUD** (Create, Read, Update, Delete) untuk data pelanggan.
  - **Tindakan Massal:** Aktivasi, penangguhan, atau pengiriman pesan WhatsApp ke banyak pelanggan sekaligus.
  - Pencarian cepat berdasarkan berbagai parameter.
  - **Integrasi Lokasi:** Tautkan pelanggan ke lokasi geografis menggunakan pemilih peta interaktif (Leaflet).

- **Penagihan & Keuangan:**

  - Manajemen **Invoice** (CRUD).
  - **Generator Invoice Otomatis & Cerdas:** Buat tagihan bulanan untuk semua pelanggan aktif, dengan penanganan **prorata** otomatis untuk bulan pertama pelanggan.
  - **Integrasi Gateway Pembayaran:** Hasilkan tautan pembayaran unik per tagihan menggunakan **Tripay**.
  - Pencatatan pembayaran manual dan otomatis.
  - Unduh invoice dalam format **PDF**.
  - Halaman **Transaksi** untuk melacak semua arus kas masuk, termasuk penjualan voucher dan top-up saldo reseller.

- **Manajemen Jaringan (Integrasi MikroTik & ACS):**

  - **PPPoE:**
    - Lihat dan kelola **Pengguna PPPoE** (Enable, Disable, Reconnect, CRUD).
    - Lihat status online/offline pengguna secara real-time.
    - Kelola **Profil PPPoE** yang menentukan paket kecepatan.
  - **Hotspot:**
    - **Manajemen Voucher Dinamis:**
      - **Generator Voucher:** Buat voucher dalam jumlah besar atau satu per satu.
      - **Logika Aktivasi Otomatis:** Masa aktif voucher dimulai secara otomatis saat pengguna **pertama kali login**.
      - **Pelacakan Kedaluwarsa:** Sistem secara otomatis mendeteksi dan menonaktifkan voucher yang telah kedaluwarsa, serta memutuskan koneksi pengguna yang aktif.
      - **Cetak Voucher:** Hasilkan halaman siap cetak untuk voucher yang baru dibuat atau yang sudah ada.
    - Lihat pengguna **Hotspot Aktif** secara real-time dan putuskan koneksi mereka jika perlu.
  - **ACS (TR-069):**
    - Lihat daftar perangkat yang terkelola (ONT/ONU) dari server ACS.
    - Pantau status online/offline dan parameter kunci seperti **RX Power**.
    - **Reboot Perangkat Jarak Jauh:** Kirim perintah reboot ke perangkat dari dasbor.
    - Lihat dan ubah parameter perangkat secara mendalam (misalnya, nama Wi-Fi/SSID dan kata sandi).
  - **Visualisasi Jaringan:**
    - **Peta Jaringan Interaktif:** Visualisasikan lokasi semua pelanggan dan **ODP** (Optical Distribution Point) di peta.
    - Tampilkan garis koneksi dari ODP ke pelanggan dan antar ODP, dengan animasi untuk koneksi yang aktif.

- **Manajemen Keluhan:**

  - Lacak dan kelola keluhan yang diajukan oleh pelanggan dari portal mereka.
  - Tugaskan keluhan ke teknisi lapangan tertentu untuk penanganan.

- **Administrasi & Pengaturan:**
  - **Manajemen Pengguna:** Kelola pengguna admin, **reseller**, dan **teknisi**, termasuk pengelolaan saldo reseller.
  - **Pengaturan Aplikasi:** Konfigurasikan nama aplikasi, URL dasar, dan pengaturan keamanan seperti **Login OTP Pelanggan**.
  - **Pengaturan MikroTik & ACS:** Masukkan kredensial API dan uji koneksi langsung dari antarmuka.
  - **Pengaturan Penagihan:** Atur otomatisasi seperti tanggal pembuatan tagihan, hari jatuh tempo, tarif pajak, dan aturan penangguhan layanan.
  - **Pengaturan WhatsApp:** Hubungkan akun WhatsApp dengan memindai kode QR dan kelola templat pesan untuk berbagai notifikasi.

### 🤖 Interaksi Pelanggan

- **Chatbot WhatsApp Cerdas:**
  - Pelanggan dapat berinteraksi dengan asisten AI melalui nomor WhatsApp resmi.
  - **Identifikasi Otomatis:** Sistem mengenali pelanggan berdasarkan nomor telepon mereka.
  - **Layanan Mandiri:**
    - Meminta **reboot modem** dari jarak jauh.
    - **Mengubah nama Wi-Fi (SSID)**.
    - **Mengubah password Wi-Fi**.
  - **Didukung oleh Google Gemini:** Memahami bahasa alami pelanggan untuk menjalankan tindakan yang benar atau menjawab pertanyaan berdasarkan data pelanggan.

### 💼 Portal Reseller

Platform khusus untuk agen penjualan voucher Anda.

- **Manajemen Saldo:** Reseller memiliki saldo virtual yang dapat diisi ulang oleh admin. Saldo ini digunakan sebagai "modal" untuk membeli voucher dari sistem.
- **Penjualan Voucher:**
  - Lihat daftar profil voucher yang tersedia untuk dijual, lengkap dengan harga jual dan harga modal.
  - Jual dan hasilkan voucher satu per satu. Sistem akan otomatis memotong saldo reseller sesuai harga modal.
  - Opsi untuk langsung mencetak voucher yang baru saja dibuat.
- **Riwayat Transaksi:**
  - Dasbor ringkasan yang menampilkan total penjualan, total laba, dan sisa saldo untuk periode waktu yang dapat dipilih.
  - Lihat riwayat terperinci dari semua transaksi, termasuk setiap penjualan voucher dan penambahan saldo.

### 🔧 Portal Teknisi

Sebuah portal khusus yang dirancang untuk memberdayakan tim lapangan Anda dengan semua informasi yang mereka butuhkan untuk menyelesaikan pekerjaan secara efisien.

- **Login & Alur Kerja Terpusat:** Teknisi masuk melalui halaman login admin dan diarahkan ke dasbor tugas mereka.
- **Daftar Tugas Harian:** Tampilan utama adalah "Tugas Hari Ini", yang secara otomatis mencakup:
  - **Instalasi Baru:** Untuk pelanggan berstatus "Inactive".
  - **Tiket Perbaikan:** Keluhan yang secara spesifik telah ditugaskan kepada mereka oleh admin.
- **Detail Tugas Komprehensif:** Setiap tugas menyediakan semua data yang relevan dalam satu layar:
  - **Info Pelanggan:** Nama, alamat lengkap, dan nomor telepon yang dapat dihubungi.
  - **Navigasi Sekali Klik:** Tombol "Navigasi" yang membuka Google Maps dengan lokasi pelanggan yang sudah ditandai.
  - **Checklist Interaktif:** Daftar periksa langkah-demi-langkah yang harus diselesaikan (misalnya, "Cek sinyal ODP", "Konfigurasi modem"). Tombol "Selesaikan Tugas" tidak akan aktif sampai semua item dicentang, memastikan pekerjaan selesai sesuai prosedur.
  - **Dokumentasi Lapangan:** Area untuk menambahkan catatan teknis dan tombol untuk mengunggah foto langsung dari lokasi.
- **Manajemen Status Tugas:** Alur kerja yang jelas dengan tombol untuk memperbarui status pekerjaan, seperti "Mulai Kerja" dan "Selesaikan Tugas", memberikan visibilitas progres kepada admin.

### 👤 Portal Pelanggan

Area layanan mandiri yang mudah diakses oleh pelanggan Anda.

- **Login Aman:** Pelanggan masuk menggunakan ID Pelanggan, dengan opsi keamanan tambahan **OTP via WhatsApp**.
- **Profil & Perangkat:** Lihat detail profil, rincian paket internet, dan informasi perangkat (ONT/ONU) mereka, termasuk status online/offline dan perangkat Wi-Fi yang terhubung.
- **Manajemen Mandiri:**
  - **Ubah Pengaturan Wi-Fi:** Pelanggan dapat mengubah nama (SSID) dan kata sandi jaringan Wi-Fi mereka sendiri.
  - **Reboot Perangkat:** Pelanggan dapat memulai ulang perangkat mereka dari portal untuk mencoba memperbaiki masalah koneksi.
- **Riwayat Penagihan & Pembayaran:**
  - Akses daftar lengkap semua tagihan.
  - Bayar tagihan yang belum lunas langsung melalui gateway pembayaran **Tripay**.
  - Unduh salinan PDF dari setiap tagihan.
- **Sistem Keluhan:** Ajukan keluhan baru dan lihat status keluhan sebelumnya.

### 🎨 Fitur Umum

- **Mode Terang & Gelap (Light & Dark Mode):** Beralih antara tema terang dan gelap untuk kenyamanan visual.
- **Desain Responsif:** Antarmuka yang dapat diakses dengan baik di perangkat desktop maupun seluler.

---

## 🚀 Pembaruan Terkini (Oktober 2024)

- **Implementasi Portal Reseller:** Menambahkan sistem reseller lengkap yang memungkinkan admin untuk mengelola agen penjualan. Reseller dapat login ke portal khusus mereka untuk menjual voucher hotspot menggunakan sistem saldo, melihat riwayat penjualan, dan melacak keuntungan.
- **Keamanan Login Pelanggan dengan OTP:** Memperkenalkan opsi autentikasi dua faktor untuk portal pelanggan. Admin dapat mengaktifkan fitur ini, yang akan mewajibkan pelanggan untuk memasukkan Kode Sandi Sekali Pakai (OTP) yang dikirim ke nomor WhatsApp terdaftar mereka saat login.
- **Fungsi Reboot Perangkat Jarak Jauh:** Menambahkan kemampuan bagi admin (dari Dasbor ACS) dan pelanggan (dari Portal Pelanggan mereka) untuk memulai ulang perangkat ONT/ONU mereka dari jarak jauh, memberikan alat pemecahan masalah dasar yang mudah diakses.
- **Peningkatan Manajemen Perangkat:** Portal Pelanggan sekarang memungkinkan pengguna untuk melihat perangkat Wi-Fi yang terhubung ke ONT mereka dan mengubah nama (SSID) serta kata sandi Wi-Fi mereka sendiri.
- **Chatbot WhatsApp Cerdas:** Mengintegrasikan chatbot yang didukung oleh Google Gemini langsung ke WhatsApp. Pelanggan kini dapat melakukan tindakan layanan mandiri seperti me-reboot modem, mengubah SSID, atau mengubah kata sandi Wi-Fi hanya dengan mengirim pesan. Sistem secara otomatis mengenali pelanggan dari nomor telepon mereka dan mengeksekusi perintah yang sesuai.
- **BARU Portal Teknisi Terintegrasi:** Meluncurkan portal khusus untuk teknisi lapangan. Fitur ini menyediakan daftar tugas harian (instalasi baru dan perbaikan), detail pelanggan lengkap dengan navigasi Google Maps, checklist pekerjaan interaktif, dan kemampuan untuk memperbarui status serta mengunggah dokumentasi (catatan & foto) langsung dari lapangan.

---

## 💡 Rencana Fitur Mendatang (Future Plans)

Berikut adalah beberapa ide fitur yang sedang dipertimbangkan untuk pengembangan di masa depan:

### 🌐 Sistem Pemantauan Kesehatan Jaringan Otomatis

- **Konsep:** Secara proaktif memantau parameter kunci jaringan (seperti RX Power pelanggan dan status ODP massal) dan membuat peringatan dini di dasbor admin jika terdeteksi anomali.
- **Manfaat:** Memungkinkan tim teknis untuk mengidentifikasi dan memperbaiki masalah sebelum pelanggan mengajukan keluhan, sehingga meningkatkan keandalan jaringan dan kepuasan pelanggan.

### 🔄 Peningkatan & Penurunan Paket Mandiri (Self-Service Upgrade/Downgrade)

- **Konsep:** Memberikan pelanggan kemampuan untuk mengganti paket internet mereka (upgrade atau downgrade) secara mandiri langsung dari Portal Pelanggan. Perubahan akan dijadwalkan dan dieksekusi secara otomatis pada awal siklus penagihan berikutnya.
- **Alur Kerja:**
  1.  Pelanggan memilih paket baru dari portal mereka.
  2.  Sistem menjadwalkan perubahan untuk diterapkan pada tanggal pembuatan tagihan berikutnya.
  3.  Pada tanggal tersebut, sebuah _cron job_ akan secara otomatis:
      - Memperbarui `packageId` pelanggan di database.
      - Mengubah profil PPPoE pengguna di router MikroTik.
      - Mengirim notifikasi WhatsApp bahwa paket telah berhasil diubah.
- **Manfaat:**
  - **Peningkatan Pendapatan:** Mendorong _upselling_ otomatis.
  - **Mengurangi Beban Kerja Admin:** Menghilangkan proses manual untuk permintaan perubahan paket.
  - **Meningkatkan Kepuasan Pelanggan:** Memberikan fleksibilitas dan kontrol kepada pelanggan.

---

## 🛠️ Teknologi yang Digunakan

- **Frontend:**
  - **React**
  - **TypeScript**
  - **Tailwind CSS**
  - **Vite**
- **Backend:**
  - **Node.js**
  - **Express.js**
  - **MySQL** (via `mysql2`)
  - **node-routeros:** Untuk integrasi API MikroTik.
  - **@whiskeysockets/baileys:** Untuk integrasi WhatsApp.
  - **@google/genai:** Untuk Chatbot AI.
- **Lainnya:**
  - **Leaflet:** Untuk peta interaktif.
  - **jsPDF:** Untuk pembuatan PDF di sisi klien.

---

## 🚀 Instalasi & Pengaturan

Ikuti langkah-langkah ini untuk menjalankan aplikasi di lingkungan lokal Anda.

### Prasyarat

- **Node.js** (v18 atau lebih tinggi)
- **Server Database MySQL**

### Langkah-langkah

1.  **Clone repositori ini:**

    ```bash
    git clone <URL_REPOSITORI>
    cd <NAMA_DIREKTORI>
    ```

2.  **Install semua dependensi:**

    ```bash
    npm install
    ```

3.  **Pengaturan Database:**

    - Buat database baru di server MySQL Anda (misalnya, `isp_billing_db`).
    - Buat file `.env` di dalam direktori `backend/`. Salin konten dari contoh di bawah dan sesuaikan dengan konfigurasi database Anda.

4.  **Konfigurasi Lingkungan (`backend/.env`):**

    ```env
    # Konfigurasi Database MySQL
    DB_HOST=localhost
    DB_USER=root
    DB_PASSWORD=
    DB_NAME=isp_billing_db
    DB_PORT=3306

    # Port untuk server backend
    PORT=3002
    ```

5.  **Jalankan Aplikasi (Mode Pengembangan):**
    Perintah ini akan secara otomatis:

    1.  Menjalankan skrip migrasi (`backend/migrate.js`) untuk membuat atau memperbarui tabel database Anda.
    2.  Memulai server backend dan server development frontend secara bersamaan.

    ```bash
    npm run dev
    ```

6.  **Akses Aplikasi:**

    - Aplikasi frontend akan tersedia di `http://localhost:5173`.
    - Server backend akan berjalan di `http://localhost:3002`.

7.  **Login Awal:**

    - **Admin:** Login dengan `admin` / `password123`. **PENTING:** Segera ubah kata sandi ini melalui halaman Pengguna.
    - **Pelanggan:** Gunakan salah satu ID pelanggan yang ada (misalnya, dari halaman Pelanggan di dasbor admin).

8.  **Konfigurasi Lanjutan:**
    Setelah login sebagai admin, buka halaman **Settings** untuk mengonfigurasi koneksi MikroTik, gateway pembayaran Tripay, dan integrasi WhatsApp. Aplikasi tidak akan berfungsi sepenuhnya tanpa konfigurasi ini.

### Menjalankan di Produksi

Untuk produksi, Anda harus membuat build frontend terlebih dahulu, lalu menjalankan server Node.js.

```bash
# 1. Bangun aset frontend
npm run build

# 2. Jalankan server backend (yang juga akan menyajikan file frontend yang sudah di-build)
npm start
```

---

# Catatan revisi 70 sudah mulai menerapkan fungsi untuk apikey untuk mengamankan permintaan api ke backend harus menyertakan apikey

# pada revisi 71 integrasi dengan halaman landing page untuk registrasi dan penambahan halaman registrasi juga di halaman costumer portal

# perbaikan fungsi creat payment link, dengan menambahkan opsi payment methode

# penambahan fitur public page untuk pembayaran via link di wa

# pada update rev 77 penambahan PWA agar aplikasi dapat diinstall di perangkat

# penambahan fungsi obfuscator agar kode tidak mudah dibaca dengan cara install obfuscator : npm install javascript-obfuscator --save-dev

# cara menjalankanya dengan : npm run build:backend

# revisi 118 mulai penambahan fitru pppob

# setelah revisi 124 sudah ada penambahan fitur olt

prefix nomor hp:

tambahkan kode berikut ini sebagao reperensi prefix nomor handphone di indonesia, prefix ini diperlukan saat customer melakukan pengisian pulsa, jika cutomer melakukan pengetikan nomor hp maka kenali prefixnya kemudian tampilkan daftar produk yang sesuai dengan prefix, Kode Prefix Nomor HP Indonesia per Operator (2024) 📞 Telkomsel 0811, 0812, 0813 (Simpati) 0821, 0822, 0823 (Kartu AS) 0852, 0853 (Kartu AS & by.U) 0851 (by.U) 📞 Indosat Ooredoo 0814, 0815, 0816 (IM3) 0855, 0856, 0857, 0858 (IM3 & Matrix) 📞 XL Axiata 0817, 0818, 0819 0859, 0877, 0878 📞 Smartfren 0881, 0882, 0883, 0884, 0885, 0886, 0887, 0888, 0889 (Semua diawali 088) 📞 Axis (sekarang bagian XL Axiata) 0831, 0832, 0833, 0838 📞 3 (Three) 0895, 0896, 0897, 0898, 0899

# handle wa close
- device user agent acak
- cek nomor valid whatsapp sebelum kirim
- karakter random 4~20 di akhir pesan
- rekonek wa acak 20~50detik agar tdk terlalu cepat