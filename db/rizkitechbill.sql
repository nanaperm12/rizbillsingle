-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 21 Nov 2025 pada 14.00
-- Versi server: 10.4.27-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rizkitechbill`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `acs_devices`
--

CREATE TABLE `acs_devices` (
  `serialNumber` varchar(255) NOT NULL,
  `productClass` varchar(255) DEFAULT NULL,
  `ipAddress` varchar(45) DEFAULT NULL,
  `pppoeUsername` varchar(255) DEFAULT NULL,
  `rxPower` varchar(50) DEFAULT NULL,
  `lastInform` datetime DEFAULT NULL,
  `isOnline` tinyint(1) DEFAULT NULL,
  `ssid1` varchar(255) DEFAULT NULL,
  `ssid5` varchar(255) DEFAULT NULL,
  `ssid1Connected` int(11) DEFAULT NULL,
  `ssid5Connected` int(11) DEFAULT NULL,
  `last_sync_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `acs_devices`
--

INSERT INTO `acs_devices` (`serialNumber`, `productClass`, `ipAddress`, `pppoeUsername`, `rxPower`, `lastInform`, `isOnline`, `ssid1`, `ssid5`, `ssid1Connected`, `ssid5Connected`, `last_sync_at`) VALUES
('00259E-EG8141H5-48575443CB825516', 'EG8141H5', '172.16.0.40', 'Adas_Dasuki', '-18.00 dBm', '2025-11-21 19:12:38', 1, 'PUTRA', NULL, 1, 0, '2025-11-21 12:13:18'),
('00259E-EG8141H5-48575443CB825558', 'EG8141H5', '172.16.0.47', 'Teh_Ade', '-23.00 dBm', '2025-11-21 19:12:36', 1, 'ARFA', NULL, 2, 0, '2025-11-21 12:13:18'),
('00259E-EG8141H5-48575443CB825608', 'EG8141H5', '172.16.0.16', 'tiara_urizki_0002', '-18.00 dBm', '2025-11-21 19:12:37', 1, 'TiaraNurizki', NULL, 4, 0, '2025-11-21 12:13:20'),
('00259E-EG8141H5-48575443CB834367', 'EG8141H5', '172.16.0.107', 'salsa_fitri_novianti_30002', '-18.00 dBm', '2025-11-21 19:13:50', 1, 'Raffi', NULL, 0, 0, '2025-11-21 12:14:16'),
('00259E-EG8145V5-4857544367546AB1', 'EG8145V5', '172.16.0.120', 'ayi_hamdan', '-18.00 dBm', '2025-11-21 19:13:16', 1, 'DUA PUTRA2', NULL, 0, 0, '2025-11-21 12:14:18'),
('00259E-EG8145V5-48575443F27D32AE', 'EG8145V5', '172.16.0.115', 'nana_supriatna', '-21.00 dBm', '2025-11-21 19:13:17', 1, 'Aawildan08', NULL, 2, 0, '2025-11-21 12:14:18'),
('00259E-EG8145V5-48575443F2ABAAAE', 'EG8145V5', '172.16.0.134', 'kandang', '-26.00 dBm', '2025-11-21 19:13:54', 1, 'Lingga', NULL, 0, 0, '2025-11-21 12:14:18'),
('00259E-ET8546MCUS-45434F4DBB39FF9B', 'ET8546MCUS', '172.16.0.83', 'dueDate', '-17.00 dBm', '2025-11-21 19:10:40', 1, 'ASIK', NULL, 0, 0, '2025-11-21 12:12:03'),
('00259E-ET8546MCUS-45434F4DBB3A5F9B', 'ET8546MCUS', '172.16.0.39', 'm_jefri', '-27.00 dBm', '2025-11-21 19:12:42', 1, 'Putraputri', NULL, 4, 0, '2025-11-21 12:13:18'),
('00259E-ET8546MCUS-45434F4DBB3A7F9B', 'ET8546MCUS', '172.16.0.32', 'asep_au', '-16.00 dBm', '2025-11-21 19:12:43', 1, 'Khaizan Wifi', NULL, 2, 0, '2025-11-21 12:13:18'),
('00259E-ET8546MCUS-45434F4DBB407F9B', 'ET8546MCUS', '172.16.0.21', 'cepi_rosdiana', '-27.00 dBm', '2025-11-21 19:13:20', 1, 'KARWINA DINATA', NULL, 0, 0, '2025-11-21 12:14:14'),
('00259E-ET8546MCUS-45434F4DBB895F9B', 'ET8546MCUS', '172.16.0.108', 'Tyenisusana', '-25.00 dBm', '2025-11-21 19:14:03', 1, NULL, NULL, 0, 0, '2025-11-21 12:14:17'),
('00259E-ET8546MCUS-45434F4DBB8A1F9B', 'ET8546MCUS', '172.16.0.55', 'nisa_4750', '-24.00 dBm', '2025-11-21 19:12:41', 1, 'Nisa26', NULL, 0, 0, '2025-11-21 12:13:18'),
('00259E-ET8546MCUS-45434F4DBB8ADF9B', 'ET8546MCUS', '172.16.0.53', 'Syifa_uldzansyah', '-17.00 dBm', '2025-11-21 19:13:27', 1, 'Cipaa', NULL, 2, 0, '2025-11-21 12:14:15'),
('00259E-ET8546MCUS-45434F4DBB8B6F9B', 'ET8546MCUS', '172.16.0.33', 'dian_widya_safia', '-20.00 dBm', '2025-11-21 19:13:28', 1, 'M Athhar Alfarizky', NULL, 0, 0, '2025-11-21 12:14:15'),
('00259E-HG8245-485754436AAEBD05', 'HG8245', '172.16.0.80', 'WAWAN_CMS', '-26.00 dBm', '2025-11-21 19:13:46', 1, 'KA-APUT', NULL, 2, 0, '2025-11-21 12:14:16'),
('00259E-HG8245H-485754434923E59C', 'HG8245H', '172.16.0.63', 'daryanto_daryanto', '-26.00 dBm', '2025-11-13 20:22:14', 0, 'Salsa', NULL, 2, 0, '2025-11-21 12:12:00'),
('00259E-HG8245H-485754434B26CB9A', 'HG8245H', '172.16.0.87', 'tuun', '-19.00 dBm', '2025-11-21 19:09:57', 1, 'RAYA REVIANA', NULL, 0, 0, '2025-11-21 12:12:03'),
('00259E-HG8245H-4857544390B7219C', 'HG8245H', '172.16.0.28', 'dudu_dudu', '-22.00 dBm', '2025-11-21 19:14:03', 1, 'ELLYDUDU78', NULL, 0, 0, '2025-11-21 12:14:15'),
('00259E-HG8245H-4857544392AA8B9B', 'HG8245H', '172.16.0.81', 'Yanto_cms', '-15.00 dBm', '2025-11-21 19:09:38', 1, 'AZQIARA', NULL, 0, 0, '2025-11-21 12:12:03'),
('00259E-HG8245H-48575443A0B3789D', 'HG8245H', '172.16.0.139', 'AGUS_CMS', '-19.00 dBm', '2025-11-21 19:13:32', 1, 'ALFARUQ', NULL, 3, 0, '2025-11-21 12:14:15'),
('00259E-HG8245H-48575443B4E16F9C', 'HG8245H', '172.16.0.50', 'teten_2150083398EGJ5038628', '-26.00 dBm', '2025-11-21 19:13:39', 1, 'Raka Vilage', NULL, 0, 0, '2025-11-21 12:14:15'),
('00259E-HG8245H-48575443DDE3999A', 'HG8245H', '172.16.0.65', 'dewi_dewi', '-23.00 dBm', '2025-11-21 19:12:52', 1, 'DEWI', NULL, 0, 0, '2025-11-21 12:13:19'),
('00259E-HG8245H5-4857544303FCAFA9', 'HG8245H5', '172.16.0.119', 'mangnono', '-15.00 dBm', '2025-11-21 19:13:26', 1, 'NAZRIL APRIYANSYAH', NULL, 0, 0, '2025-11-21 12:14:15'),
('00259E-HG8245H5-485754430D55BC9F', 'HG8245H5', '172.16.0.70', 'bayu_sumarna', '-26.00 dBm', '2025-11-21 19:12:59', 1, 'TELKOMSEL', NULL, 0, 0, '2025-11-21 12:13:19'),
('00259E-HG8245H5-48575443258271A3', 'HG8245H5', '172.16.0.64', 'utep_muhidin_90005', '-24.00 dBm', '2025-11-21 19:13:47', 1, 'Tiara Komalasari', NULL, 0, 0, '2025-11-21 12:14:17'),
('00259E-HG8245H5-4857544329315F9E', 'HG8245H5', '172.16.0.22', 'iwan_iwan', '-24.00 dBm', '2025-11-21 19:12:04', 1, 'Graneza', NULL, 0, 0, '2025-11-21 12:12:34'),
('00259E-HG8245H5-485754432D52669E', 'HG8245H5', '172.16.0.74', 'ai_cbhl', '-26.00 dBm', '2025-11-21 19:12:59', 1, 'SCTV', NULL, 0, 0, '2025-11-21 12:13:19'),
('00259E-HG8245H5-48575443636E929E', 'HG8245H5', '172.16.0.79', 'ai_sumiati_0001', '-19.00 dBm', '2025-11-21 19:13:45', 1, 'NAUFAL NAZRIEL', NULL, 0, 0, '2025-11-21 12:14:17'),
('00259E-HG8245H5-485754437A076D9D', 'HG8245H5', '172.16.0.75', 'KIKI_CMS', '-21.00 dBm', '2025-11-21 19:12:52', 1, 'WIFITITA', NULL, 0, 0, '2025-11-21 12:13:18'),
('00259E-HG8245H5-485754439617609E', 'HG8245H5', '172.16.0.37', 'yani_yani', '-22.00 dBm', '2025-11-21 19:12:59', 1, 'RITA', NULL, 1, 0, '2025-11-21 12:13:19'),
('00259E-HG8245H5-48575443A5DDA89E', 'HG8245H5', '172.16.0.46', 'OYANG_CMS', '-20.00 dBm', '2025-11-13 20:23:07', 0, 'CMSHOME', NULL, 0, 0, '2025-11-21 12:12:03'),
('00259E-HG8245H5-48575443A6AF8F9E', 'HG8245H5', '172.16.0.58', 'diki_eryanto_jkg', '-23.00 dBm', '2025-11-21 19:09:20', 1, 'RaisaNurRizky', NULL, 0, 0, '2025-11-21 12:12:03'),
('00259E-HG8245H5-48575443B75CD7AA', 'HG8245H5', '172.16.0.48', 'febby', '-27.00 dBm', '2025-11-21 19:09:33', 1, 'Febby', NULL, 0, 0, '2025-11-21 12:12:03'),
('00259E-HG8245H5-48575443B75DE6AA', 'HG8245H5', '172.16.0.135', 'memetkn', '-20.00 dBm', '2025-11-21 19:13:07', 1, 'Alika shafa khoirunnisa', NULL, 2, 0, '2025-11-21 12:13:19'),
('00259E-HG8245H5-48575443BFD9749D', 'HG8245H5', '172.16.0.43', 'intan_intan', '-17.00 dBm', '2025-11-21 19:12:59', 1, 'INTAN HOERUNISA', NULL, 0, 0, '2025-11-21 12:13:19'),
('00259E-HG8245H5-48575443BFF3C19D', 'HG8245H5', '172.16.0.52', 'pitri_sawitri', '-27.00 dBm', '2025-11-21 19:13:26', 1, 'OPAL ENDUT', NULL, 0, 0, '2025-11-21 12:14:15'),
('00259E-HG8245H5-48575443C1DFBC9E', 'HG8245H5', '172.16.0.46', 'desy_siti_nurjanah', '-19.00 dBm', '2025-11-21 19:13:47', 1, 'Cikurjingkang', NULL, 0, 0, '2025-11-21 12:14:17'),
('00259E-HG8245H5-48575443C23EB0A2', 'HG8245H5', '172.16.0.77', 'asep_tatang', '-26.00 dBm', '2025-11-21 19:13:08', 1, 'TIARA', NULL, 0, 0, '2025-11-21 12:13:19'),
('00259E-HG8245H5-48575443FD86F5A4', 'HG8245H5', '172.16.0.60', 'rangga_rangga', '-20.00 dBm', '2025-11-21 19:09:56', 1, 'Rangga', NULL, 0, 0, '2025-11-21 12:12:03'),
('00259E-HG8245U-4857544342BEBFA4', 'HG8245U', '172.16.0.89', 'Tuti_CMS', '-18.00 dBm', '2025-11-21 19:13:08', 1, 'GILANG HOME', NULL, 0, 0, '2025-11-21 12:13:19'),
('00259E-HG8245U-48575443B3E66D9C', 'HG8245U', '172.16.0.113', 'FITRI_CMS', '-20.00 dBm', '2025-11-21 19:12:36', 1, 'HOMENA', NULL, 3, 0, '2025-11-21 12:13:17'),
('00259E-HG8245U-48575443B3F26D9C', 'HG8245U', '172.16.0.56', 'warung_putra', '-18.00 dBm', '2025-11-21 19:09:39', 1, 'WARUNG PUTRA', 'HOMENA', 0, 0, '2025-11-21 12:12:03'),
('00259E-HG8546M-485754432CA2AC9B', 'HG8546M', '172.16.0.66', 'ernika06_ernika06', '-25.00 dBm', '2025-11-21 19:10:23', 1, 'Erika06', NULL, 0, 0, '2025-11-21 12:12:03'),
('00259E-HG8546M-48575443A3C1F4B4', 'HG8546M', '172.16.0.89', 'wildan_wildan', '-27.00 dBm', '2025-11-13 20:21:58', 0, 'Namora11', NULL, 0, 0, '2025-11-21 12:12:03'),
('00259E-HG8546M-48575443A3C1F4C0', 'HG8546M', '172.16.0.86', 'elis_nurhayati_0001', '-21.00 dBm', '2025-11-21 19:14:03', 1, 'ikyy homieee', NULL, 1, 0, '2025-11-21 12:14:15'),
('00259E-HG8546M-48575443A3C1F4E4', 'HG8546M', '172.16.0.31', 'ruhenda_50002', '-21.00 dBm', '2025-11-21 19:13:36', 1, 'EFUL', NULL, 1, 0, '2025-11-21 12:14:16'),
('00259E-HG8546M-48575443A3C1F50E', 'HG8546M', '172.16.0.36', 'Asep_ahmad_M', '-13.00 dBm', '2025-11-21 19:09:31', 1, 'St.Enung', NULL, 0, 0, '2025-11-21 12:12:03'),
('00259E-HG8546M-48575443A3C1F598', 'HG8546M', '172.16.0.25', 'eni_suhaeni_0005', '-21.00 dBm', '2025-11-21 19:13:50', 1, 'Anggi08', NULL, 0, 0, '2025-11-21 12:14:17'),
('00259E-HG8546M-48575443A3C1FB08', 'HG8546M', '172.16.0.45', 'sindi_sindi', '-28.00 dBm', '2025-11-21 19:13:52', 1, 'Witachan', NULL, 2, 0, '2025-11-21 12:14:15'),
('00259E-HS8145C-48575443C29BBC9C', 'HS8145C', '172.16.0.105', 'maryam_0003', '-19.00 dBm', '2025-11-21 19:13:47', 1, 'MARYAM', NULL, 0, 0, '2025-11-21 12:14:17'),
('00259E-HS8145C-48575443C2A0829C', 'HS8145C', '172.16.0.104', 'mellyprimi', '-21.00 dBm', '2025-11-21 19:13:45', 1, 'ZIMatZIVA', NULL, 4, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C-48575443C2B07E9C', 'HS8145C', '172.16.0.121', 'rita_septiani_0020', '-19.00 dBm', '2025-11-21 19:13:45', 1, 'RITHA HAHA', NULL, 2, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C-48575443C2B44F9C', 'HS8145C', '172.16.0.90', 'arip_setiawan_0003', '-17.00 dBm', '2025-11-21 19:14:00', 1, 'Rumah kebun', NULL, 0, 0, '2025-11-21 12:14:17'),
('00259E-HS8145C5-48575443047CB175', 'HS8145C5', '172.16.0.103', 'suryati_90002', '-21.00 dBm', '2025-11-21 19:13:35', 1, 'Radit', NULL, 6, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C5-48575443082A0DA5', 'HS8145C5', '172.16.0.49', 'saeful_palah_20008', '-18.00 dBm', '2025-11-21 19:13:35', 1, 'Mang Dukun', NULL, 0, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C5-485754431BB1E1AC', 'HS8145C5', '172.16.0.38', 'Siti_Aminah_43199', '-26.00 dBm', '2025-11-21 19:13:35', 1, 'Warung Babakan', NULL, 4, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C5-485754431C824FA0', 'HS8145C5', '172.16.0.54', 'ade_faisal_70001', '-17.00 dBm', '2025-11-21 19:13:42', 1, 'HOMETEST', NULL, 4, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C5-48575443283F0DA4', 'HS8145C5', '172.16.0.102', 'rangga_pirman_50001', '-23.00 dBm', '2025-11-21 19:13:40', 1, 'Wifkirobby', NULL, 5, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C5-48575443501ACF9A', 'HS8145C5', '172.16.0.82', 'mimi_rohaemi_002', '-23.00 dBm', '2025-11-21 19:13:32', 1, 'IM\'santuy', NULL, 3, 0, '2025-11-21 12:14:15'),
('00259E-HS8145C5-48575443504A789A', 'HS8145C5', '172.16.0.57', 'HESTI_CMS', '-25.00 dBm', '2025-11-21 19:12:36', 1, 'CHANTIKA', NULL, 0, 0, '2025-11-21 12:13:18'),
('00259E-HS8145C5-4857544350504E9A', 'HS8145C5', '172.16.0.61', 'nardi_30002', '-17.00 dBm', '2025-11-21 19:13:35', 1, 'WILDAN', NULL, 6, 0, '2025-11-21 12:14:15'),
('00259E-HS8145C5-48575443802B58A4', 'HS8145C5', '172.16.0.72', 'sudaryat_50004', '-22.00 dBm', '2025-11-21 19:13:56', 1, 'Gibran Ramadani', NULL, 6, 0, '2025-11-21 12:14:15'),
('00259E-HS8145C5-48575443A899779E', 'HS8145C5', '172.16.0.106', 'mohamad_nabil_50004', '-20.00 dBm', '2025-11-21 19:13:36', 1, 'A.RAMDAN ', NULL, 0, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C5-48575443ABA5F6A5', 'HS8145C5', '172.16.0.72', 'wahidin_30001', '-23.00 dBm', '2025-09-13 02:00:45', 0, 'Wahidin Ozos', NULL, 1, 0, '2025-11-21 12:12:01'),
('00259E-HS8145C5-48575443B2115FA4', 'HS8145C5', '172.16.0.59', 'ramdani_rahmat_hidayat', '-17.00 dBm', '2025-11-21 19:13:40', 1, 'Aditya', NULL, 0, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C5-48575443B2239FA4', 'HS8145C5', '172.16.0.66', 'yati_sukmawati_0007', '-16.00 dBm', '2025-11-13 16:05:29', 0, 'NAZWA WA', NULL, 3, 0, '2025-11-21 12:12:01'),
('00259E-HS8145C5-48575443B27E1BA4', 'HS8145C5', '172.16.0.26', 'romansyah_sidiq_0001', '-17.00 dBm', '2025-11-21 19:13:40', 1, 'Wifi Aa', NULL, 0, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C5-48575443C353179A', 'HS8145C5', '172.16.0.24', 'wa_wat_32639', '-23.00 dBm', '2025-11-21 19:13:54', 1, 'FARHAN', NULL, 0, 0, '2025-11-21 12:14:15'),
('00259E-HS8145C5-48575443E429E4BB', 'HS8145C5', '172.16.0.30', 'asih_wangsih_0002', '-24.00 dBm', '2025-11-21 19:13:42', 1, 'Sansan Maulana', NULL, 0, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C5-48575443E45B667D', 'HS8145C5', '172.16.0.42', 'nia', '-17.00 dBm', '2025-11-21 19:13:45', 1, NULL, NULL, 0, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C5-48575443E4967EAB', 'HS8145C5', '172.16.0.88', 'maman_70002jkg', '-23.00 dBm', '2025-11-21 19:13:42', 1, 'Syakira', NULL, 1, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C5-48575443E4D352C6', 'HS8145C5', '172.16.0.35', 'entangian_1002', '-26.00 dBm', '2025-11-21 19:13:42', 1, 'AN Broiler', NULL, 0, 0, '2025-11-21 12:14:16'),
('00259E-HS8145C5-48575443E4FB4011', 'HS8145C5', '172.16.0.71', 'novi_widiyanti_40002', '-14.00 dBm', '2025-11-21 19:13:42', 1, 'HOMETEST', NULL, 0, 0, '2025-11-21 12:14:16'),
('1479F3-GS3101-CMHI408AE442', 'GS3101', '172.16.0.10', 'Ade', '-11.49 dBm', '2025-11-21 19:13:14', 1, 'AIRISNA', NULL, 0, 0, '2025-11-21 12:14:15'),
('1479F3-GS3101-CMHI408C373C', 'GS3101', '172.16.0.110', 'komala_dewi', '-15.38 dBm', '2025-11-13 20:23:48', 0, 'kinan khairatunisa', NULL, 0, 0, '2025-11-21 12:12:00'),
('1479F3-GS3101-CMHI4093F211', 'GS3101', '172.16.0.15', 'ABIL-HOME', 'N/A', '2025-11-21 19:12:55', 1, 'ABIL-HOME', NULL, 2, 0, '2025-11-21 12:13:18'),
('1479F3-GS3101-CMHI40994844', 'GS3101', '172.16.0.13', 'apong_30001', '-11.80 dBm', '2025-11-21 19:11:47', 1, 'maco', NULL, 0, 0, '2025-11-21 12:12:34'),
('1479F3-GS3101-CMHI40A911E9', 'GS3101', '172.16.0.9', 'tehcucu_djkg', '-14.09 dBm', '2025-11-21 19:13:14', 1, 'DC PUTRA PUTRI', NULL, 2, 0, '2025-11-21 12:14:15'),
('1479F3-GS3101-CMHI40AB335D', 'GS3101', '172.16.0.5', 'PEPEP_CMS', '-14.56 dBm', '2025-11-21 19:11:55', 1, 'Nabila ', NULL, 1, 0, '2025-11-21 12:12:34'),
('1479F3-GS3101-CMHI40AE8EA1', 'GS3101', '172.16.0.8', 'cica', '-12.37 dBm', '2025-11-21 19:13:14', 1, 'CICA SRI CAHYANI', NULL, 0, 0, '2025-11-21 12:14:15'),
('1479F3-GS3101-CMHI40AFB912', 'GS3101', '172.16.0.6', 'mamancms', '-16.99 dBm', '2025-11-21 19:13:21', 1, 'giena sr', NULL, 0, 0, '2025-11-21 12:14:15'),
('1479F3-GS3101%20XPON-CMHI408B0ED6', 'GS3101 XPON', '172.16.0.138', 'rosmayati_0003', '-14.00 dBm', '2025-11-21 19:13:24', 1, '4R', NULL, 0, 0, '2025-11-21 12:14:18'),
('1479F3-GS3101%20XPON-CMHI409D6AB4', 'GS3101 XPON', '172.16.0.111', 'darmini_darmini', '-15.69 dBm', '2025-11-21 19:13:09', 1, 'Mimirian', NULL, 0, 0, '2025-11-21 12:14:15'),
('1479F3-GS3101%20XPON-CMHI40B30AEA', 'GS3101 XPON', '172.16.0.7', 'tia-setiawati', '-15.09 dBm', '2025-11-21 19:13:14', 1, 'ALDI REFAN', NULL, 1, 0, '2025-11-21 12:14:15'),
('1869DA-H1s%2D3-CMDCB2039C6F', 'H1s-3', '172.16.0.19', ' ', 'N/A', '2025-11-21 19:09:15', 1, NULL, NULL, 0, 0, '2025-11-21 12:12:03'),
('1869DA-H1s%2D3-CMDCB20BAD7A', 'H1s-3', '172.16.0.18', ' ', 'N/A', '2025-11-21 13:39:52', 0, NULL, NULL, 0, 0, '2025-11-21 12:12:02'),
('3C574F-GS3101-CMDC10ACC43A', 'GS3101', '172.16.0.14', 'waunay', '-13.10 dBm', '2025-11-21 19:13:29', 1, 'Kembar', NULL, 3, 0, '2025-11-21 12:14:15'),
('3C574F-GS3101-CMDC10C1EB02', 'GS3101', '172.16.0.11', 'rizki_gian', '-12.84 dBm', '2025-11-21 19:11:53', 1, 'RIZKI GIAN', NULL, 0, 0, '2025-11-21 12:12:34'),
('3C574F-GS3101-CMDC10CE8C0D', 'GS3101', '172.16.0.91', 'herisantosa', '-12.84 dBm', '2025-11-21 19:13:01', 1, 'Heri Imas', NULL, 0, 0, '2025-11-21 12:13:19'),
('68D1BA-PON%2DHGU-YHTCBA4864D8', 'PON-HGU', '172.16.0.142', 'kandang', '-16.78 dBm', '2025-11-05 14:33:48', 0, 'rizkitechcam', 'rizki-tech.com', 0, 0, '2025-11-21 12:12:02'),
('68D1BA-SY%2D939-YHTC482AB7B0', 'SY-939', '172.16.0.108', 'serve', '-18.24 dBm', '2025-11-05 14:36:33', 0, 'HOMETEST', 'rizki-tech.com', 0, 0, '2025-11-21 12:12:02'),
('702E22-F609%20V9-RTEGC60F204C', 'F609 V9', '172.16.0.92', 'didin_awaludin_0002', '-11.94 dBm', '2025-11-21 19:13:50', 1, 'DUA PUTRI', NULL, 0, 0, '2025-11-21 12:14:17'),
('702E22-F609%20V9-RTEGC60F5588', 'F609 V9', '172.16.0.110', 'heni_0002', '-35.00 dBm', '2025-11-21 19:09:26', 1, 'Az zahra', NULL, 0, 0, '2025-11-21 12:12:04'),
('702E22-F609%20V9-RTEGC60F71BC', 'F609 V9', '172.16.0.132', 'siti_nurjanah_0001', '-12.20 dBm', '2025-11-21 19:11:26', 1, 'Lingga', NULL, 0, 0, '2025-11-21 12:12:04'),
('78C1A7-F663NV3a-ELWGC997270B', 'F663NV3a', '172.16.0.4', 'AI_CMS', '-18.24 dBm', '2025-11-21 19:13:46', 1, 'ZIDAN', NULL, 5, 0, '2025-11-21 12:14:16'),
('C0D0FF-F663NV3a-ZXICFF0746B8', 'F663NV3a', '172.16.0.97', 'dedentest', '-18.54 dBm', '2025-11-21 19:13:46', 1, NULL, NULL, 0, 0, '2025-11-21 12:14:17'),
('C0D0FF-F663NV3a-ZXICFF0B2FF8', 'F663NV3a', '172.16.0.93', 'ainoval_walfatimah_30001', '-30.50 dBm', '2025-11-21 19:13:36', 1, 'DedeReval', NULL, 0, 0, '2025-11-21 12:14:16'),
('CCF0FD-GS3101-CMDC40489745', 'GS3101', '172.16.0.94', 'sitirojah', '-17.45 dBm', '2025-07-30 16:46:43', 0, NULL, NULL, 0, 0, '2025-11-21 12:12:00'),
('CCF0FD-GS3101%20XPON-CMDC404A4700', 'GS3101 XPON', '172.16.0.12', 'Dede_Juli_0002', '-12.29 dBm', '2025-11-21 19:09:39', 1, 'Nanda Arkana', NULL, 0, 0, '2025-11-21 12:12:04'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-CbyYPFHYJd', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-11 17:38:13', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:20'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-dHNgBLNvel', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-13 14:04:08', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:20'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-hcBPlHfATW', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-09 15:20:08', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:19'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-HThLQUUMqI', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-15 08:53:30', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:20'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-JcDCoujHfG', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-12 10:47:41', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:20'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-jufrFCYkrk', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-06 09:42:50', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:19'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-KfwejAWqVL', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-20 12:41:13', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:20'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-MTyXtrlqaj', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-16 12:13:22', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:20'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-nUJlsTSQYr', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-08 09:26:33', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:19'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-ORMZTgwNtG', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-10 12:43:10', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:20'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-OWTSoAdvbW', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-18 08:59:36', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:20'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-QpxMJXYIaj', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-14 12:37:13', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:20'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-QskWVMUfLB', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-21 15:48:41', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:20'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-SAbhdAPRtg', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-07 13:53:33', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:19'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-soOkxpoEgX', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-17 14:14:14', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:20'),
('DISCOVERYSERVICE-DISCOVERYSERVICE-wieUHUFJJS', 'DISCOVERYSERVICE', 'N/A', 'N/A', 'N/A', '2025-11-19 13:40:47', 0, NULL, NULL, 0, 0, '2025-11-21 12:13:20'),
('E0456D-H1s%2D3-CMDCB218C10C', 'H1s-3', '172.16.0.20', 'EDEN_CMS', 'N/A', '2025-11-21 19:09:33', 1, NULL, NULL, 0, 0, '2025-11-21 12:12:03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin_notifications`
--

CREATE TABLE `admin_notifications` (
  `id` int(11) NOT NULL,
  `type` enum('error','warning','info') NOT NULL,
  `source` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `related_entity_id` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `complaints`
--

CREATE TABLE `complaints` (
  `id` varchar(255) NOT NULL,
  `customerId` varchar(255) DEFAULT NULL,
  `customerName` varchar(255) DEFAULT NULL,
  `dateSubmitted` datetime DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `replies` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`replies`)),
  `assignedTo` varchar(255) DEFAULT NULL,
  `technicianNotes` text DEFAULT NULL,
  `photos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`photos`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `customers`
--

CREATE TABLE `customers` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `packageId` int(10) UNSIGNED DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `location` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`location`)),
  `odpId` varchar(255) DEFAULT NULL,
  `pppoeUsername` varchar(255) DEFAULT NULL,
  `activeDate` datetime DEFAULT NULL,
  `nextBillingStart` date DEFAULT NULL,
  `previousPppoeProfile` varchar(255) DEFAULT NULL,
  `acsSerialNumber` varchar(255) DEFAULT NULL,
  `voucher_balance` decimal(15,2) DEFAULT 0.00,
  `billing_type` enum('postpaid','fixed') DEFAULT 'postpaid'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `customers`
--

INSERT INTO `customers` (`id`, `name`, `address`, `phone`, `email`, `packageId`, `status`, `location`, `odpId`, `pppoeUsername`, `activeDate`, `nextBillingStart`, `previousPppoeProfile`, `acsSerialNumber`, `voucher_balance`, `billing_type`) VALUES
('31089004306', 'Saeful palah', 'Dusun kamal kidul rt03/rw02 desa kamal, kecamatan tanjungmrdar kab. Sumedang', '082115062437', '', 1, 'Active', NULL, NULL, 'saeful_palah_20008', '2025-05-21 14:39:00', NULL, NULL, '00259E-HS8145C5-48575443082A0DA5', 0.00, 'postpaid'),
('31089006983', 'Mohamad nabil Ramdhani', 'dusun kamal kaler RT02 RW03 Desa Kamal, Kec Tanjungmedar', '6281324962806', 'ramdaninabil201004@gmail.com', 1, 'Active', NULL, NULL, 'mohamad_nabil_50004', '2025-06-02 11:38:00', NULL, NULL, '00259E-HS8145C5-48575443A899779E', 0.00, 'postpaid'),
('31089009195', 'Desy Siti Nurjanah', 'Desa Jingkang Kec.Tanjung medar kab. Sumedang Rt.02 Rw. 02\nNIK: 3211215709040002\nNama WiFi Pilihan: Cikurjingkang\nPassword WiFi Pilihan: (Disediakan)', '082121164223', 'sitinurjanahdesy494@gmail.com', 1, 'Active', '{\"lat\":-6.7130576,\"lng\":107.864831}', NULL, 'desy_siti_nurjanah', '2025-10-19 19:52:00', NULL, NULL, '00259E-HG8245H5-48575443C1DFBC9E', 0.00, 'postpaid'),
('31089009383', 'Dede Juli Hermawan', 'dusun kamal desa kamal RT02 RW03 ', '082240588814', '', 2, 'Active', NULL, NULL, 'Dede_Juli_0002', '2025-10-04 19:27:00', NULL, NULL, 'CCF0FD-GS3101%20XPON-CMDC404A4700', 0.00, 'postpaid'),
('31089009427', 'HENI', 'Dusun kamal kidul, RT02 RW02 DESA KAMAL KEC TANJUNGMEDAR\nNIK: 3207115805730002\nNama WiFi Pilihan: Az Zahra\nPassword WiFi Pilihan: (Disediakan)', '082218972445', 'heni@gmail.com', 2, 'Active', '{\"lat\":-6.203743982263666,\"lng\":106.85594558715822}', NULL, 'heni_0002', '2025-11-15 15:03:00', NULL, NULL, '702E22-F609%20V9-RTEGC60F5588', 0.00, 'postpaid'),
('31089012424', 'Maman', 'Dusun babakan sawah desa jingkang rt02/rw13 kecamatan tanjungmedar kabupaten sumedang', '6282116480663', NULL, 1, 'Active', NULL, NULL, 'maman_70002jkg', '2025-09-03 00:14:00', NULL, NULL, '00259E-HS8145C5-48575443E4967EAB', 0.00, 'postpaid'),
('31089013662', 'Ade Faisal Arifin', 'desa kamal rt 04 rw 02 kec tanjungmedar kab sumedang', '6281383924869', 'ade_faisal_70001@gmail.com', 1, 'Active', NULL, NULL, 'ade_faisal_70001', '2025-09-02 17:14:00', NULL, NULL, '00259E-HS8145C5-485754431C824FA0', 0.00, 'postpaid'),
('31089014222', 'yati sukmawati', 'Dusun Ciomas kamal', '085215223361', NULL, 1, 'Suspended', NULL, NULL, 'yati_sukmawati_0007', '2025-08-01 00:14:00', NULL, 'FAMILY', '00259E-HS8145C5-48575443B2239FA4', 0.00, 'postpaid'),
('31089014999', 'Romansyah Sidiq', 'Dusun Ciomas RT 01 RW 04 desa Kamal kecamatan tanjungmedar kabupaten sumedang', '6282215436858', NULL, 2, 'Active', NULL, NULL, 'romansyah_sidiq_0001', '2025-09-03 07:14:00', NULL, NULL, '00259E-HS8145C5-48575443B27E1BA4', 0.00, 'postpaid'),
('31089015212', 'Apong', 'Alamat jajaway', '6285720459390', NULL, 2, 'Active', NULL, NULL, 'apong_30001	', '2025-06-30 00:14:00', NULL, NULL, '1479F3-GS3101-CMHI40994844', 0.00, 'postpaid'),
('31089015405', 'Novi Widiyanti', 'Dusun jajaway RT03 RW06 Desa Jingkang Kec Tanjungmedar Kab Sumedang', '6282215289832', NULL, 2, 'Active', NULL, NULL, 'novi_widiyanti_40002', '2025-09-02 17:14:00', NULL, NULL, '00259E-HS8145C5-48575443E4FB4011', 0.00, 'postpaid'),
('31089015553', 'Ai Noval Walfatimah', 'Dusun comas kamal RT02 RW04 Desa Kamal Kec Tanjungmedar', '6285659472070', NULL, 1, 'Active', NULL, NULL, 'ainoval_walfatimah_30001', '2025-09-02 10:14:00', NULL, NULL, 'C0D0FF-F663NV3a-ZXICFF0B2FF8', 0.00, 'postpaid'),
('31089015653', 'Upit Sekar Arum', NULL, '6282123907730', NULL, 1, 'Active', NULL, NULL, 'Upit_Sekar_Arum', '2025-09-02 17:14:00', NULL, NULL, NULL, 0.00, 'postpaid'),
('31089015718', 'Salsa Fitri Novianti', 'Dusun kamal Rt/001 Rw/003 tanjungmedar', '085353780414', NULL, 2, 'Active', NULL, NULL, 'salsa_fitri_novianti_30002', '2025-09-02 10:14:00', NULL, NULL, '00259E-EG8141H5-48575443CB834367', 0.00, 'postpaid'),
('31089015914', 'Rangga Pirman', 'Desa Kamal kaler RT.2 RW.3 kec.tanjung medar kab.sumedang', '6282120702356', NULL, 1, 'Active', NULL, NULL, 'rangga_pirman_50001', '2025-09-03 00:14:00', NULL, NULL, '00259E-HS8145C5-48575443283F0DA4', 0.00, 'postpaid'),
('31089016358', 'Sudaryat', 'Dusun cimuncang rt 01 rw 06', '085314496040', NULL, 1, 'Active', NULL, NULL, 'sudaryat_50004', '2025-09-02 17:14:00', NULL, NULL, '00259E-HS8145C5-48575443802B58A4', 0.00, 'postpaid'),
('31089016434', 'Mimi Rohaemi', 'Desa jingkang Babakan sawah rt 02 RW 12', '083894653512', NULL, 1, 'Active', NULL, NULL, 'mimi_rohaemi_002', '2025-09-02 17:14:00', NULL, NULL, '00259E-HS8145C5-48575443501ACF9A', 0.00, 'postpaid'),
('31089016489', 'Nardi', 'dusun kamal kidul rt02 rw02 desa kamal tanjungmedar', '082264229293', NULL, 1, 'Active', NULL, NULL, 'nardi_30002', '2025-09-02 17:14:00', NULL, NULL, '00259E-HS8145C5-4857544350504E9A', 0.00, 'postpaid'),
('31089016568', 'Wawat', 'Dusun ciomas RT02 RW07 DESA JINGKANG KEC TANJUNGMEDAR', '082216932639', NULL, 1, 'Active', NULL, NULL, 'wa_wat_32639', '2025-09-03 00:14:00', NULL, NULL, '00259E-HS8145C5-48575443C353179A', 0.00, 'postpaid'),
('31089016610', 'Siti Aminah', 'Dusun ciomas RT1 RW04 Desa Kamal Kec Tanjungmedar', '081218743199', NULL, 1, 'Active', NULL, NULL, 'Siti_Aminah_43199', '2025-09-03 00:14:00', NULL, NULL, '00259E-HS8145C5-485754431BB1E1AC', 0.00, 'postpaid'),
('31089016754', 'Ade Haryati', 'Dusun ciomas RT02 RW07 Desa Jingkang Kec. Tanjungmedar Kab. Sumedang', '0859102687123', NULL, 1, 'Active', NULL, NULL, 'Teh_Ade', '2025-09-03 00:14:00', NULL, NULL, '00259E-EG8141H5-48575443CB825558', 0.00, 'postpaid'),
('31089016989', 'Asep Ahmad M', 'dusun kamal rt/rw 003/002 desa kamal kec. tanjungmedar', '082320729004', NULL, 2, 'Active', NULL, NULL, 'Asep_ahmad_M', '2025-09-02 17:14:00', NULL, NULL, '00259E-HG8546M-48575443A3C1F50E', 0.00, 'postpaid'),
('31089017033', 'Dian widya safia', 'Dusun Ciomas RT/02 RW 04 Desa Kamal', '085723908505', NULL, 5, 'Suspended', NULL, NULL, 'dian_widya_safia', '2025-09-03 00:14:00', NULL, 'PELAJAR', '00259E-ET8546MCUS-45434F4DBB8B6F9B', 0.00, 'postpaid'),
('31089017254', 'Khaizan wifi', 'Ciomas lapang', '083101602062', NULL, 5, 'Active', NULL, NULL, 'asep_au', '2025-09-03 00:14:00', NULL, NULL, '00259E-ET8546MCUS-45434F4DBB3A7F9B', 0.00, 'postpaid'),
('31089017305', 'PUTRA PUTRI', 'Ciomas RT 02 RW 04 DS kamal', '085932913481', NULL, 5, 'Active', NULL, NULL, 'm_jefri', '2025-09-03 00:14:00', NULL, NULL, '00259E-ET8546MCUS-45434F4DBB3A5F9B', 0.00, 'postpaid'),
('31089017354', 'Cepi Rohdiana', 'Ciomas wetan', '081573554868', NULL, 5, 'Suspended', NULL, NULL, 'cepi_rosdiana', '2025-07-01 00:14:00', NULL, 'PELAJAR', '00259E-ET8546MCUS-45434F4DBB407F9B', 0.00, 'postpaid'),
('31089017472', 'Nisa', 'Dusun babakan sawah jingkang', '081903994750', NULL, 5, 'Active', NULL, NULL, 'nisa_4750', '2025-09-03 00:14:00', NULL, NULL, '00259E-ET8546MCUS-45434F4DBB8A1F9B', 0.00, 'postpaid'),
('31089017523', 'Wa Unay', 'Ciomas', '083130631041', NULL, 5, 'Suspended', NULL, NULL, 'waunay', '2025-01-10 07:14:00', NULL, 'FAMILY', '3C574F-GS3101-CMDC10ACC43A', 0.00, 'postpaid'),
('31089017635', 'Daryanto', 'Jingkang', '082321656453', NULL, 5, 'Suspended', NULL, NULL, 'daryanto_daryanto', '2025-09-02 17:14:00', NULL, 'PELAJAR', '00259E-HG8245H-485754434923E59C', 0.00, 'postpaid'),
('31089017688', 'Komala Dewi', 'Dusun sukamanah RT02 RW06 Desa jingkang tanjungmedar', '082128460280', NULL, 5, 'Suspended', NULL, NULL, 'komala_dewi', '2025-07-01 17:14:00', NULL, 'PELAJAR', '1479F3-GS3101-CMHI408C373C', 0.00, 'postpaid'),
('31089017798', 'Tia Setiawati', 'Dusun babakan sawah rt 3 rw13', '082318060894', NULL, 5, 'Active', NULL, NULL, 'tia-setiawati', '2025-07-01 00:14:00', NULL, NULL, '1479F3-GS3101%20XPON-CMHI40B30AEA', 0.00, 'postpaid'),
('31089017877', 'Darmini', 'Dusun babakan sawah RT03 RW13 desa jingkang kec tanjungmedar', '085860013223', NULL, 5, 'Active', NULL, NULL, 'darmini_darmini', '2025-09-02 17:14:00', NULL, NULL, '1479F3-GS3101%20XPON-CMHI409D6AB4', 0.00, 'postpaid'),
('31089018095', 'Rangga', 'dusun ciomas rt02 rw07 desa jingkang kecamatan tanjungmedar', '082120978366', NULL, NULL, 'Suspended', NULL, NULL, 'rangga_rangga', '2025-07-01 10:14:00', NULL, 'PAKET_MINI', '00259E-HG8245H5-48575443FD86F5A4', 0.00, 'postpaid'),
('31089018119', 'Bayu Sumarna', 'ciomas kamal', '081394515568', NULL, 5, 'Suspended', NULL, NULL, 'bayu_sumarna', '2025-09-03 00:14:00', NULL, 'PELAJAR', '00259E-HG8245H5-485754430D55BC9F', 0.00, 'postpaid'),
('31089018266', 'Pitri Sawitri', 'Duaun cibihbul desa kamal', '082319102533', NULL, 5, 'Active', NULL, NULL, 'pitri_sawitri', '2025-09-02 17:14:00', NULL, NULL, '00259E-HG8245H5-48575443BFF3C19D', 0.00, 'postpaid'),
('31089018321', 'Ai-Samiin', 'Dusun cibihbul', '081911802864', NULL, 5, 'Active', NULL, NULL, 'ai_cbhl', '2025-09-03 00:14:00', NULL, NULL, '00259E-HG8245H5-485754432D52669E', 0.00, 'postpaid'),
('31089018328', 'didin awaludin', 'dusun cimuncang rt/01 rw/06 desa jingkang kec tnjung medar kab sumedang prof jawa barat\nNIK: 3211212507840002\nNama WiFi Pilihan: dua putri\nPassword WiFi Pilihan: (Disediakan)', '082317112427', 'Sabahsastra@gmail.com', 2, 'Active', '{\"lat\":-6.7199039,\"lng\":107.8670875}', NULL, 'didin_awaludin_0002', '2025-11-06 05:56:00', NULL, NULL, '702E22-F609%20V9-RTEGC60F204C', 0.00, 'postpaid'),
('31089018505', 'Siti Jubaedah', 'Dusun ciomas RT02 RW04 Desa Kamal Tanjungmedar', '082126090429', NULL, 5, 'Active', NULL, NULL, 'siti_jubaedah', '2025-09-04 04:14:00', NULL, NULL, NULL, 0.00, 'postpaid'),
('31089018546', 'Warung Putra', 'Ciomas kidul', '081222564124', NULL, 5, 'Active', NULL, NULL, 'warung_putra', '2025-09-03 00:14:00', NULL, NULL, '00259E-HG8245U-48575443B3F26D9C', 0.00, 'postpaid'),
('31089018650', 'Erik Wa Ade', 'Dusun jingkang', '085710901103', NULL, 5, 'Active', NULL, NULL, 'ernika06_ernika06', '2025-09-03 00:14:00', NULL, NULL, '00259E-HG8546M-485754432CA2AC9B', 0.00, 'postpaid'),
('31089018741', 'Iwan Hermawan', 'Dusun babakan sawah jingkang', '082318838194', NULL, 5, 'Active', NULL, NULL, 'iwan_iwan', '2025-09-03 14:14:00', NULL, NULL, '00259E-HG8245H5-4857544329315F9E', 0.00, 'postpaid'),
('31089018837', 'Asep Tatang', 'Ciomas Kamal', '08388549925', NULL, 5, 'Active', NULL, NULL, 'asep_tatang', '2025-09-03 00:14:00', NULL, NULL, '00259E-HG8245H5-48575443C23EB0A2', 0.00, 'postpaid'),
('31089019011', 'Manah', 'Ciomas kamal', '081511128422', NULL, 5, 'Active', NULL, NULL, 'dudu_dudu', '2025-09-03 00:14:00', NULL, NULL, '00259E-HG8245H-4857544390B7219C', 0.00, 'postpaid'),
('31089019144', 'Diki Eryanto', 'Dusun Babakan Sawah', '085318106128', NULL, 5, 'Active', NULL, NULL, 'diki_eryanto_jkg', '2025-09-03 00:14:00', NULL, NULL, '00259E-HG8245H5-48575443A6AF8F9E', 0.00, 'postpaid'),
('31089019263', 'Intan hoerunisa', 'Ciomas kamal', '081324439081', NULL, 5, 'Active', NULL, NULL, 'intan_intan', '2025-05-01 00:14:00', NULL, NULL, '00259E-HG8245H5-48575443BFD9749D', 0.00, 'postpaid'),
('31089019264', 'Yani', 'Ciomas jingkang', '082317281064', NULL, 5, 'Active', NULL, NULL, 'yani_yani', '2025-09-03 07:14:00', NULL, NULL, '00259E-HG8245H5-485754439617609E', 0.00, 'postpaid'),
('31089019313', 'Fitri Nurlaela', 'Dusun ciomas RT02 RW07 Desa JIngkang Kec Tanjungmedar\nNIK: 3211210105890004\nNama WiFi Pilihan: Nama wifi\nPassword WiFi Pilihan: (Disediakan)', '082214165522', 'nanaperm12@gmail.com', 2, 'Active', '{\"lat\":-6.713829616503354,\"lng\":107.8750589489937}', 'ODP-001', 'FITRI_CMS', '2025-08-14 07:38:00', NULL, NULL, '00259E-EG8145V5-4857544367546AB1', 0.00, 'postpaid'),
('31089019350', 'Febby', 'Ciomas', '085603970527', NULL, 1, 'Active', NULL, NULL, 'febby', '2025-09-03 07:14:00', NULL, NULL, '00259E-HG8245H5-48575443B75CD7AA', 0.00, 'postpaid'),
('31089019497', 'Yeni Susana', 'Dusun ciomas kamal', '081316629012', NULL, 5, 'Inactive', NULL, NULL, 'Tyenisusana', '2025-09-02 17:14:00', NULL, 'PELAJAR', NULL, 0.00, 'postpaid'),
('31089019521', 'Nazril', 'Dusun ciomas kamal', '082315472792', NULL, 5, 'Active', NULL, NULL, 'mangnono', '2025-09-03 00:14:00', NULL, NULL, '00259E-HG8245H5-4857544303FCAFA9', 0.00, 'postpaid'),
('31089019546', 'Syifa uldzansyah', 'Dusun kamal kaler desa kamal, RT01 RW 03', '083879238531', '', 2, 'Active', NULL, NULL, 'Syifa_uldzansyah', '2025-03-09 14:02:00', NULL, NULL, '00259E-ET8546MCUS-45434F4DBB8ADF9B', 0.00, 'postpaid'),
('31089019659', 'Teh Cucu | wina', 'Jingkang babakan sawah', '085221572763', NULL, 5, 'Active', NULL, NULL, 'tehcucu_djkg', '2025-09-03 00:14:00', NULL, NULL, '1479F3-GS3101-CMHI40A911E9', 0.00, 'postpaid'),
('31089019667', 'Unayah', 'Duaun ciomas kamal', '085603519968', NULL, 5, 'Active', NULL, NULL, 'tuun', '2024-04-07 00:14:00', NULL, NULL, '00259E-HG8245H-485754434B26CB9A', 0.00, 'postpaid'),
('31089019762', 'Haji Atep', 'Dusun ciomas Desa kamal kec tanjungmesar', '081386855596', NULL, 5, 'Active', NULL, NULL, 'test2', '2025-09-02 17:14:00', NULL, NULL, '1869DA-H1s%2D3-CMDCB2039C6F', 0.00, 'postpaid'),
('31089019987', 'Siti Rojah', 'Dusun ciomas RT02 RW07 Desa Kamal', '085860786490', NULL, 5, 'Suspended', NULL, NULL, 'sitirojah', '2025-03-01 14:14:00', NULL, 'PELAJAR', 'CCF0FD-GS3101-CMDC40489745', 0.00, 'postpaid'),
('31089020039', 'Nunung Nurhayati', 'Dusun ciomas RT02 RW04 Desa Kamal Kecamatan tanjungmedar', '082117581727', NULL, 5, 'Suspended', NULL, NULL, 'nunungnurhayati', '2025-06-01 00:14:00', NULL, 'PELAJAR', NULL, 0.00, 'postpaid'),
('31089020104', 'Cica sri cahyani', 'Dusun ciomas rt 02 rw 4', '0881011257291', NULL, 5, 'Active', NULL, NULL, 'cica', '2025-09-03 00:14:00', NULL, NULL, '1479F3-GS3101-CMHI40AE8EA1', 0.00, 'postpaid'),
('31089020281', 'Maman', 'Ciomas', '082263069134', NULL, 5, 'Active', NULL, NULL, 'mamancms', '2025-09-03 07:14:00', NULL, NULL, '1479F3-GS3101-CMHI40AFB912', 0.00, 'postpaid'),
('31089020330', 'Endang Rismayanti', 'Dusun ciomas RT2 RW04 desa kamal', '6281563205951', NULL, 5, 'Active', NULL, NULL, 'entangian_1002', '2025-09-02 17:14:00', NULL, NULL, '00259E-HS8145C5-48575443E4D352C6', 0.00, 'postpaid'),
('31089020539', 'Memet Kusnandang', 'Ciomas kamal', '085871548492', NULL, NULL, 'Suspended', NULL, NULL, 'memetkn', '2025-04-01 00:14:00', NULL, 'PAKET_MINI', '00259E-HG8245H5-48575443B75DE6AA', 0.00, 'postpaid'),
('31089020616', 'Heri Santosa', 'Dusun sukatamu RT02 RW01 Desa jingkang Kec Tanjungmedar', '081224131947', NULL, 5, 'Active', NULL, NULL, 'herisantosa', '2025-09-03 00:14:00', NULL, NULL, '3C574F-GS3101-CMDC10CE8C0D', 0.00, 'postpaid'),
('31089020752', 'Ai Yuningsih', 'Dusun babakan sawah jingkang', '083856943127', NULL, 5, 'Active', NULL, NULL, 'aiyuningsih', '2025-09-03 00:14:00', NULL, NULL, '1869DA-H1s%2D3-CMDCB20BAD7A', 0.00, 'postpaid'),
('31089020897', 'ACA Asep  Caris', 'ciamis', '081317827284', NULL, 5, 'Active', NULL, NULL, 'aca', '2025-09-03 00:14:00', NULL, NULL, NULL, 0.00, 'postpaid'),
('31089020956', 'Ian Wiyana', 'Ciamis', '081321519581', NULL, 5, 'Suspended', NULL, NULL, 'iyan_wiyana', '2025-09-03 14:14:00', NULL, 'PELAJAR', NULL, 0.00, 'postpaid'),
('31089021054', 'Wawan n Riska', 'Dusun ciomas kamal', '082315445775', NULL, NULL, 'Suspended', NULL, NULL, 'WAWAN_CMS', '2025-05-01 00:14:00', NULL, 'PAKET_MINI', '00259E-HG8245-485754436AAEBD05', 0.00, 'postpaid'),
('31089021173', 'Epon', 'Ciomas kidul', '082129616574', NULL, NULL, 'Active', NULL, NULL, 'epon_epon', '2025-09-03 00:14:00', NULL, NULL, NULL, 0.00, 'postpaid'),
('31089021193', 'Ai Apriain', 'Ciomas', '081384666166', NULL, 5, 'Active', NULL, NULL, 'teten_2150083398EGJ5038628', '2025-09-03 00:14:00', NULL, NULL, '00259E-HG8245H-48575443B4E16F9C', 0.00, 'postpaid'),
('31089021284', 'komala wati', 'Dusun babkana sawah jingkang', '085846634927', NULL, 5, 'Suspended', NULL, NULL, 'komalawati', '2025-05-01 00:14:00', NULL, 'PELAJAR', NULL, 0.00, 'postpaid'),
('31089021350', 'BU DESI RUSYANI', NULL, '087821013728', NULL, 5, 'Inactive', NULL, NULL, 'BUDESI_CMS', '2025-09-03 00:14:00', NULL, 'ISOLIRNA', NULL, 0.00, 'postpaid'),
('31089021375', 'Elis Nurhayati', 'Dusun ciomas, Rt 01/Rt 04, ds kamal, kec. Tanjungmedar.', '6281223862204', 'nurhayatielis417@gmail.com', 1, 'Active', NULL, NULL, 'elis_nurhayati_0001', '2025-08-11 17:21:00', NULL, NULL, '00259E-HG8546M-48575443A3C1F4C0', 0.00, 'postpaid'),
('31089021465', 'A Yanto', 'Ciomas Kamal', '6282119944667', NULL, 5, 'Active', NULL, NULL, 'Yanto_cms', '2025-09-03 00:14:00', NULL, NULL, '00259E-HG8245H-4857544392AA8B9B', 0.00, 'postpaid'),
('31089021688', 'Ai Nurhayati', 'Ciomas Kamal', '081222761470', NULL, 2, 'Active', NULL, NULL, 'AINUR_CMS', '2025-09-03 00:14:00', NULL, NULL, NULL, 0.00, 'postpaid'),
('31089021808', 'OYANG_ADMINCMS', NULL, '082320355644', NULL, 5, 'Suspended', NULL, NULL, 'OYANG_CMS', '2025-09-02 10:14:00', NULL, 'PAKET_MINI', NULL, 0.00, 'postpaid'),
('31089021832', 'Utep Muhidin', 'Dusun babakan sawah, desa jingkang rt03 rw13 desa jingkang kecamatan tanjungmedar kab sumedng', '082191130366', 'utep0634@gmail.com', 1, 'Active', '{\"lat\":-6.7146617,\"lng\":107.8603034}', NULL, 'utep_muhidin_90005', '2025-10-14 04:57:00', NULL, NULL, '00259E-HG8245H5-48575443258271A3', 0.00, 'postpaid'),
('31089021898', 'Agus Cahyadi', 'Ciomas RT02 RW07 Desa Jingkang', '085861552171', NULL, NULL, 'Active', NULL, NULL, 'AGUS_CMS', '2025-09-03 00:14:00', NULL, NULL, '00259E-HG8245H-48575443A0B3789D', 0.00, 'postpaid'),
('31089021995', 'Ai Apriyani Sa\'adah', 'Dusun Ciomas RT02 RW07 Desa Jingkang Kec Tanjungmedar', '081395957113', NULL, NULL, 'Active', NULL, NULL, 'AI_CMS', '2025-09-03 00:14:00', NULL, NULL, '78C1A7-F663NV3a-ELWGC997270B', 0.00, 'postpaid'),
('31089022159', 'Imas Nurhayati', 'Dusun ciomas RT02 RW 07', '085732269809', NULL, NULL, 'Suspended', NULL, NULL, 'IMAS_CMS', '2025-09-03 00:14:00', NULL, 'PAKET_MINI', NULL, 0.00, 'postpaid'),
('31089022219', 'HESTI', NULL, '083189621150', NULL, NULL, 'Active', NULL, NULL, 'HESTI_CMS', '2025-09-03 00:14:00', NULL, NULL, '00259E-HS8145C5-48575443504A789A', 0.00, 'postpaid'),
('31089022458', 'Romlah', NULL, '081214177585', NULL, NULL, 'Active', NULL, NULL, 'ROMLAH_CMS', '2025-09-03 00:14:00', NULL, NULL, NULL, 0.00, 'postpaid'),
('31089022677', 'A ADE', 'Jingkang', '081212717500', NULL, NULL, 'Suspended', NULL, NULL, 'Ade', '2025-04-01 00:14:00', NULL, 'PAKET_MINI', '1479F3-GS3101-CMHI408AE442', 0.00, 'postpaid'),
('31089022723', 'Jajang Daud Yusuf', NULL, '085213273525', NULL, NULL, 'Active', NULL, NULL, 'ABIL-HOME', '2025-09-03 00:14:00', NULL, NULL, '1479F3-GS3101-CMHI4093F211', 0.00, 'postpaid'),
('31089023007', 'Entang Purnama', NULL, '082315285524', NULL, 5, 'Active', NULL, NULL, 'ENTANG_CMS', '2025-09-03 00:14:00', NULL, NULL, NULL, 0.00, 'postpaid'),
('31089023183', 'A Ahmad Barqie', NULL, '082315594554', NULL, 5, 'Active', NULL, NULL, 'A_AHMAD', '2025-09-02 17:14:00', NULL, NULL, NULL, 0.00, 'postpaid'),
('31089023229', 'Tita', NULL, '6281223016828', NULL, 5, 'Active', NULL, NULL, 'KIKI_CMS', '2025-09-03 00:14:00', NULL, NULL, '00259E-HG8245H5-485754437A076D9D', 0.00, 'postpaid'),
('31089023317', 'Tatang akum', NULL, '082318085177', NULL, NULL, 'Active', NULL, NULL, 'AKUM_CMS', '2025-09-03 00:14:00', NULL, NULL, NULL, 0.00, 'postpaid'),
('31089023495', 'Tuti Neng dea', 'Ciomas rt02 rw07', '085860338611', NULL, NULL, 'Active', NULL, NULL, 'Tuti_CMS', '2025-09-03 00:14:00', NULL, NULL, '00259E-HG8245U-4857544342BEBFA4', 0.00, 'postpaid'),
('31089025284', 'Chindy Warlita', 'Dusun babakan sawah , jingkang, tanjungmedar, sumedang', '087868889178', '', 5, 'Active', NULL, NULL, 'sindi_sindi', '2025-10-13 13:48:00', NULL, NULL, '00259E-HG8546M-48575443A3C1FB08', 0.00, 'postpaid'),
('31089026393', 'Ramdani Rahmat Hidayat', 'Dusun Kamal RT01 RW02 Desa kamal, Kec Tanjungmedar', '082218852289', '', 2, 'Active', NULL, NULL, 'ramdani_rahmat_hidayat', '2025-07-14 12:59:00', NULL, NULL, '00259E-HS8145C5-48575443B2115FA4', 0.00, 'postpaid'),
('31089033203', 'Acep Suryaman', 'Jingkang babakan sawah', '081312336608', 'nanaperm12@gmail.com', 5, 'Active', NULL, 'ODP-002', 'PEPEP_CMS', '2023-04-13 19:06:00', NULL, NULL, '1479F3-GS3101-CMHI40AB335D', 0.00, 'postpaid'),
('31089034135', 'Nia Rosdiniati', 'Dusun ciomas RT001 RW004, Desa Kamal, kec Tanjungmedar, Kab Sumedang', '081553079136', '', 1, 'Active', NULL, NULL, 'dueDate', '2025-10-13 13:19:00', NULL, NULL, '00259E-ET8546MCUS-45434F4DBB39FF9B', 0.00, 'postpaid'),
('31089035894', 'wahidin', 'Desa Kamal, Dusun Kamal, RT 02/RW 03, kecamatan tanjungmedar, kabupaten sumedang', '6281214328422', 'mirawatiwati033@gmail.com', 1, 'Suspended', NULL, NULL, 'wahidin_30001', '2025-07-01 16:59:00', NULL, 'FAMILY', NULL, 0.00, 'postpaid'),
('31089041275', 'wildan', 'Dusun ciomas desa kamal, kec tanjungmedar\n', '081321766066', '', 5, 'Suspended', NULL, NULL, 'wildan_wildan', '2025-10-13 13:57:00', NULL, 'PELAJAR', '00259E-HG8546M-48575443A3C1F4B4', 0.00, 'postpaid'),
('31089042484', 'cecep krismanto', 'ciomas kidul rt03 rwo7', '085659716324', '', 5, 'Suspended', NULL, NULL, 'ocos', '2025-03-01 13:45:00', NULL, 'PELAJAR', NULL, 0.00, 'postpaid'),
('31089047548', 'Rita Septiani', 'Dusun Kamal Kidul RT02 RW02 Desa Kamal Jln Sukaratu No 10 Tanjungmedar Sumedang', '082219030243', 'ritaseptiani020@gmail.com', 2, 'Active', NULL, NULL, 'rita_septiani_0020', '2025-10-12 06:49:00', NULL, NULL, '00259E-HS8145C-48575443C2B07E9C', 0.00, 'postpaid'),
('31089049393', 'Ruhenda', 'Cimuncang, RT2 RW6', '6282111685369', '', 2, 'Active', NULL, '', 'ruhenda_50002', '2025-05-27 05:56:00', NULL, NULL, '00259E-HG8546M-48575443A3C1F4E4', 0.00, 'postpaid'),
('31089051359', 'Melly Primi Nuryanti', 'Dusun kamal rt 01 rw 03, desa kamal, kec tanjungmedar,kab sumedang', '6281212715671', 'mellyprimi06@gmail.com', 2, 'Active', NULL, NULL, 'mellyprimi', '2025-05-29 17:55:00', NULL, NULL, '00259E-HS8145C-48575443C2A0829C', 0.00, 'postpaid'),
('31089059944', 'Rizki Gian', 'Ciomas wetan, desa kamal\n', '6282298990623', '', 5, 'Active', NULL, NULL, 'rizki_gian', '2025-06-01 10:27:00', NULL, NULL, '3C574F-GS3101-CMDC10C1EB02', 0.00, 'postpaid'),
('31089064953', 'Dewi', 'Dsn. Babakan sawah RT02 RW12, Desa jingkang, kec tanjungmedar, kab sumedang', '081380584889', '', 5, 'Active', NULL, NULL, 'dewi_dewi', '2024-11-16 13:28:00', NULL, NULL, '00259E-HG8245H-48575443DDE3999A', 0.00, 'postpaid'),
('31089064962', 'Adas Dasuki', 'Dusun ciomas RT01 RW07, Desa Jingkang Kec Tanjungmedar', '083186724299', '', 1, 'Active', NULL, NULL, 'Adas_Dasuki', '2025-04-01 12:39:00', NULL, NULL, '00259E-EG8141H5-48575443CB825516', 0.00, 'postpaid'),
('31089066116', 'Asih Wangsih', 'Dusun jingkang,Babakan sawah rt01 rw02, kecamatan tanjungmedar,kabupaten sumedang', '6281223004798', 'asihwangsih9@gmail.com', 1, 'Active', NULL, NULL, 'asih_wangsih_0002', '2025-08-19 05:54:00', NULL, NULL, '00259E-HS8145C5-48575443E429E4BB', 0.00, 'postpaid'),
('31089066296', 'Arip Setiawan', 'Ciomas kidul', '082226106980', 'ar13p.t033751@gmail.com', 1, 'Active', NULL, NULL, 'arip_setiawan_0003', '2025-10-12 15:46:00', NULL, NULL, '00259E-HS8145C-48575443C2B44F9C', 0.00, 'postpaid'),
('31089071599', 'Siti Nurjanah', 'Dsn Kamal jajaway RT 01 RW 02 Desa Kamal kec Tanjungmedar\nNIK: 3211214105900001\nNama WiFi Pilihan: Lingga\nPassword WiFi Pilihan: (Disediakan)', '081220154218', 'snurjanah33774@gmail.com', 1, 'Active', '{\"lat\":-6.1187233363309375,\"lng\":106.86376815776123}', NULL, 'siti_nurjanah_0001', '2025-11-14 08:30:00', NULL, NULL, NULL, 0.00, 'postpaid'),
('31089072968', 'Maryam', 'Dusun kamal kaler, desa kamal, rt01/rw03, kecamatan Tanjungmedar, kabupaten sumedang', '081214450149', 'hermawanrobby931@gmail.com', 2, 'Active', '{\"lat\":-6.7138466,\"lng\":107.8753614}', 'ODP-001', 'maryam_0003', '2025-10-12 02:08:00', NULL, NULL, '00259E-HS8145C-48575443C29BBC9C', 0.00, 'postpaid'),
('31089073612', 'Suryati', 'Desa Kamal,kec Tanjung medar Rt01/03', '081222030580', 'soniasore00@gmail.com', 1, 'Active', NULL, NULL, 'suryati_90002', '2025-05-22 06:18:00', NULL, NULL, '00259E-HS8145C5-48575443047CB175', 0.00, 'postpaid'),
('31089084863', 'Nana supriatna', 'Dusun kamal rt 01/rw 03 ds kamal kecatan tajung medar kab sumedang\nNIK: 321121090991003\nNama WiFi Pilihan: Aawildan08\nPassword WiFi Pilihan: (Disediakan)', '085312248223', 'widanhadid396@gmail.com', 2, 'Active', '{\"lat\":-6.719406819254635,\"lng\":107.87860894900437}', NULL, 'nana_supriatna', '2025-11-17 14:17:00', NULL, NULL, '00259E-EG8145V5-48575443F27D32AE', 0.00, 'postpaid'),
('31089088340', 'Eni suhaeni ', 'Dusun cimuncang, rt01/rw06, desa jingkang, kecamatan tanjungmedar, kabupaten sumedang. \nNIK: 3211214805860005\nNama WiFi Pilihan: Anggi08\nPassword WiFi Pilihan: (Disediakan)', '081317827252', 'nienamaku120@gmail.com', 1, 'Active', '{\"lat\":-6.7198883,\"lng\":107.8653951}', NULL, 'eni_suhaeni_0005', '2025-10-25 11:07:00', NULL, NULL, '00259E-HG8546M-48575443A3C1F598', 0.00, 'postpaid'),
('31089092949', 'Ai Sumiati', 'Dusun Jongkang, desa Jongkang, kecamatan tanjungmedar\nNIK: 3211216506910001\nNama WiFi Pilihan: Naufal Nazriel\nPassword WiFi Pilihan: (Disediakan)', '081312478586', 'aysumy15@gmail.com', 2, 'Active', '{\"lat\":-6.7128983,\"lng\":107.8653817}', NULL, 'ai_sumiati_0001', '2025-11-01 08:28:00', NULL, NULL, '00259E-HG8245H5-48575443636E929E', 0.00, 'postpaid'),
('31089099194', 'Tiara Nurizki', 'Dusun kamal kaler, desa kamal, rt 02/rw03 ,kecamatan Tanjungmedar , kabupaten sumedang', '081282751923', 'nurizkitiara4@gmail.com', 1, 'Active', '{\"lat\":-6.7191128,\"lng\":107.8809317}', NULL, 'tiara_urizki_0002', '2025-10-11 16:12:00', NULL, NULL, '00259E-EG8141H5-48575443CB825608', 0.00, 'postpaid');

-- --------------------------------------------------------

--
-- Struktur dari tabel `customer_commissions`
--

CREATE TABLE `customer_commissions` (
  `id` int(11) NOT NULL,
  `customer_id` varchar(255) NOT NULL,
  `voucher_id` int(10) UNSIGNED DEFAULT NULL,
  `profit_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','applied') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `applied_to_invoice_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `hotspot_profiles`
--

CREATE TABLE `hotspot_profiles` (
  `id` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `rateLimit` varchar(255) DEFAULT NULL,
  `sharedUsers` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `sellingPrice` int(11) DEFAULT NULL,
  `duration_minutes` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `hotspot_profiles`
--

INSERT INTO `hotspot_profiles` (`id`, `name`, `rateLimit`, `sharedUsers`, `price`, `sellingPrice`, `duration_minutes`) VALUES
('*0', 'default', '', 1, 0, 0, NULL),
('*1', 'HP', '2M/2M 3M/3M 2M/2M 200/187', 1, 0, 0, NULL),
('*4', 'PAKET-4JAM', '2M/2M 3M/3M 2M/2M 200/187', 1, 0, 0, NULL),
('*5', 'V-2000-4h', '2M/2M 3M/3M 2M/2M 200/187', 1, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `hotspot_users`
--

CREATE TABLE `hotspot_users` (
  `id` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `profile` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT 0,
  `last_sync_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `hotspot_users`
--

INSERT INTO `hotspot_users` (`id`, `name`, `password`, `profile`, `comment`, `disabled`, `last_sync_at`) VALUES
('*0', 'default-trial', NULL, NULL, 'counters and limits for trial users', 0, '2025-11-21 06:40:26'),
('*148', 'hzmb2', 'hzmb2', 'PAKET-4JAM', 'vc-864-06.21.25-', 0, '2025-11-21 06:40:26'),
('*14A', 'zgm4p', 'zgm4p', 'PAKET-4JAM', 'vc-864-06.21.25-', 0, '2025-11-21 06:40:26'),
('*14B', 'zyas7', 'zyas7', 'PAKET-4JAM', 'vc-864-06.21.25-', 0, '2025-11-21 06:40:26'),
('*14C', '2rm79', '2rm79', 'PAKET-4JAM', 'vc-864-06.21.25-', 0, '2025-11-21 06:40:26'),
('*155', 'ze5fi', 'ze5fi', 'PAKET-4JAM', 'vc-864-06.21.25-', 0, '2025-11-21 06:40:26'),
('*157', '3e3yx', '3e3yx', 'PAKET-4JAM', 'vc-864-06.21.25-', 0, '2025-11-21 06:40:26'),
('*161', '8t99g', '8t99g', 'PAKET-4JAM', 'vc-864-06.21.25-', 0, '2025-11-21 06:40:26'),
('*1E', 'gatp7', 'gatp7', 'PAKET-4JAM', 'vc-755-06.21.25-', 0, '2025-11-21 06:40:26'),
('*1E2', 'bx6', 'bx6', 'V-2000-4h', 'vc-525-07.31.25-', 0, '2025-11-21 06:40:26'),
('*1E3', 'k7v', 'k7v', 'V-2000-4h', 'vc-525-07.31.25-', 0, '2025-11-21 06:40:26'),
('*1E4', '9d5', '9d5', 'V-2000-4h', 'vc-525-07.31.25-', 0, '2025-11-21 06:40:26'),
('*1E5', 'gdv', 'gdv', 'V-2000-4h', 'vc-525-07.31.25-', 0, '2025-11-21 06:40:26'),
('*2', 'narti', 'narti990', 'HP', '', 0, '2025-11-21 06:40:26'),
('*299', 'xzxyr', 'xzxyr', 'PAKET-4JAM', 'vc-995-08.01.25-', 0, '2025-11-21 06:40:26'),
('*3', 'anwar', 'anwar880', 'HP', '', 0, '2025-11-21 06:40:26'),
('*313', 'test', '08081995', 'default', '', 0, '2025-11-21 06:40:26'),
('*4', 'hassan', 'hassan123', 'HP', '', 0, '2025-11-21 06:40:26'),
('*496', '8wg5p', '8wg5p', 'PAKET-4JAM', 'vc-167-09.12.25-', 0, '2025-11-21 06:40:26'),
('*4B2', 'sfg2a', 'sfg2a', 'PAKET-4JAM', 'vc-167-09.12.25-', 0, '2025-11-21 06:40:26'),
('*4E9', 'yzhj8', 'yzhj8', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*5', 'husen', 'husen123', 'HP', '', 0, '2025-11-21 06:40:26'),
('*52D', 'zjwxx', 'zjwxx', 'PAKET-4JAM', '2025-11-21 14:30:55', 0, '2025-11-21 06:40:26'),
('*52E', 'theuu', 'theuu', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*52F', 'zifnk', 'zifnk', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*530', '3z9i4', '3z9i4', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*531', '7gxph', '7gxph', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*532', '86rjn', '86rjn', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*533', 'f35hn', 'f35hn', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*534', 'y33vk', 'y33vk', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*535', 'ckaw6', 'ckaw6', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*536', 'ze8tc', 'ze8tc', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*537', '9f6gf', '9f6gf', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*538', '8p496', '8p496', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*539', 'm2csi', 'm2csi', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*53A', 'yhwz6', 'yhwz6', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*53B', 'bdnjb', 'bdnjb', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*53C', 'bt7ut', 'bt7ut', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*53D', 'r844s', 'r844s', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*53E', 'c4bzv', 'c4bzv', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*53F', '48cb8', '48cb8', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*540', 'asj92', 'asj92', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*541', 'r9w7j', 'r9w7j', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*542', 'xag9s', 'xag9s', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*543', 'encti', 'encti', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*544', 'pg3nw', 'pg3nw', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*545', 'dkmt2', 'dkmt2', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*546', '2symm', '2symm', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*547', 'r4bh8', 'r4bh8', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*548', 'jewsy', 'jewsy', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*549', 'sds8v', 'sds8v', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*54A', 'epsjs', 'epsjs', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*54B', 'y8ffm', 'y8ffm', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*54C', 'edxn7', 'edxn7', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*54D', 'i4688', 'i4688', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*54E', 'crfzw', 'crfzw', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*54F', 'hcb8n', 'hcb8n', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*550', '9vc37', '9vc37', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*551', 'wp85p', 'wp85p', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*552', 'k2zac', 'k2zac', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*553', '896ts', '896ts', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*554', 'ms24x', 'ms24x', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*555', 'huvmh', 'huvmh', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*556', 'h8ybw', 'h8ybw', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*557', 'j8kru', 'j8kru', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*558', 'mf7dy', 'mf7dy', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*559', 'ggh5b', 'ggh5b', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*55A', 'uhdit', 'uhdit', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*55B', 'f2t3a', 'f2t3a', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*55C', 'puk5b', 'puk5b', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*55D', 'g63b8', 'g63b8', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*55E', 'ugsuw', 'ugsuw', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*55F', '9yeby', '9yeby', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*560', 'xckyi', 'xckyi', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*561', 'nwwhx', 'nwwhx', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*562', 'ac7md', 'ac7md', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*563', 'wtjhc', 'wtjhc', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*564', 'uvy3n', 'uvy3n', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*565', 'paxgj', 'paxgj', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*566', 'gs6u5', 'gs6u5', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*567', 'suz8b', 'suz8b', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*568', 'eux47', 'eux47', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*569', 'sakhu', 'sakhu', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*56A', '8vnuc', '8vnuc', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*56B', 'tusea', 'tusea', 'PAKET-4JAM', 'vc-397-10.15.25-', 0, '2025-11-21 06:40:26'),
('*577', '8sedt', '8sedt', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*581', 'jvbcv', 'jvbcv', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*5AE', '8irn5', '8irn5', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*6', 'nyai', 'nyai123', 'HP', '', 0, '2025-11-21 06:40:26'),
('*67D', 'xxmfd', 'xxmfd', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*689', 'iu5yz', 'iu5yz', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*68E', '2snpd', '2snpd', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*68F', 'ynn9y', 'ynn9y', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*690', 'g7y9y', 'g7y9y', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*692', 'zyj8b', 'zyj8b', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*693', 'xw4u9', 'xw4u9', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*695', 'jg3di', 'jg3di', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*696', 'sh546', 'sh546', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*697', 'cp7xb', 'cp7xb', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*698', '36isb', '36isb', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*699', '72ne3', '72ne3', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*69A', 'niwgw', 'niwgw', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*69B', 'p98xp', 'p98xp', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*69C', 'td2ic', 'td2ic', 'PAKET-4JAM', 'vc-770-10.16.25-', 0, '2025-11-21 06:40:26'),
('*7', 'lisna', 'lisna123', 'HP', '', 0, '2025-11-21 06:40:26'),
('*8', 'haris', 'haris123', 'default', '', 0, '2025-11-21 06:40:26'),
('*9', 'lalas', 'lalas1', 'HP', '', 0, '2025-11-21 06:40:26'),
('*A', 'aan', 'aan2', 'HP', '', 0, '2025-11-21 06:40:26'),
('*B', 'aliya', 'aliya3', 'HP', '', 0, '2025-11-21 06:40:26'),
('*C', 'zakia', 'zakia4', 'HP', '', 0, '2025-11-21 06:40:26'),
('*D', 'hasan', 'hasan', 'default', '', 0, '2025-11-21 06:40:26'),
('*E', 'admin', 'TGSAdmin123$', 'default', '', 0, '2025-11-21 06:40:26');

-- --------------------------------------------------------

--
-- Struktur dari tabel `hotspot_vouchers`
--

CREATE TABLE `hotspot_vouchers` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile` varchar(255) NOT NULL,
  `duration_minutes` int(11) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `mikrotik_id` varchar(50) DEFAULT NULL,
  `first_used_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `sold_by_user_id` varchar(255) DEFAULT NULL,
  `sold_by_customer_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `invoices`
--

CREATE TABLE `invoices` (
  `id` varchar(255) NOT NULL,
  `customerId` varchar(255) DEFAULT NULL,
  `issueDate` date DEFAULT NULL,
  `dueDate` date DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `billingPeriodStart` date DEFAULT NULL,
  `billingPeriodEnd` date DEFAULT NULL,
  `tripayReference` varchar(255) DEFAULT NULL,
  `paymentUrl` varchar(255) DEFAULT NULL,
  `discount_amount` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `odcs`
--

CREATE TABLE `odcs` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `location` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`location`)),
  `parentId` varchar(255) DEFAULT NULL,
  `lineColor` varchar(20) DEFAULT NULL,
  `powerInput` decimal(5,2) DEFAULT NULL,
  `powerOutput` decimal(5,2) DEFAULT NULL,
  `totalPorts` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `odcs`
--

INSERT INTO `odcs` (`id`, `name`, `address`, `location`, `parentId`, `lineColor`, `powerInput`, `powerOutput`, `totalPorts`) VALUES
('ODC-1763687645981', 'ODC1CMS', 'CIOMAS', '{\"lat\":-6.7200281,\"lng\":107.8709868}', '', '#3b82f6', 4.00, 2.00, 16);

-- --------------------------------------------------------

--
-- Struktur dari tabel `odps`
--

CREATE TABLE `odps` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `location` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`location`)),
  `parentId` varchar(255) DEFAULT NULL,
  `lineColor` varchar(20) DEFAULT NULL,
  `powerInput` decimal(5,2) DEFAULT NULL,
  `powerOutput` decimal(5,2) DEFAULT NULL,
  `totalPorts` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `packages`
--

CREATE TABLE `packages` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `speed` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `pppoeProfile` varchar(255) DEFAULT NULL,
  `useTax` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `packages`
--

INSERT INTO `packages` (`id`, `name`, `speed`, `price`, `pppoeProfile`, `useTax`) VALUES
(1, 'FAMILY', 10, 150000, 'FAMILY', 1),
(2, 'Paket Silver', 20, 167000, 'Paket Silver', 1),
(3, 'GOLD', 30, 249000, 'GOLD', 1),
(5, 'Pelajar', 10, 150000, 'PELAJAR', 0),
(6, 'PAKET MINI', 3, 100000, 'PAKET_MINI', 0),
(7, 'KELUARGA_SILVER', 20, 250000, 'KELUARGA_SILVER', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `package_changes`
--

CREATE TABLE `package_changes` (
  `id` int(11) NOT NULL,
  `customer_id` varchar(255) NOT NULL,
  `new_package_id` int(10) UNSIGNED NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `processed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `payments`
--

CREATE TABLE `payments` (
  `id` varchar(255) NOT NULL,
  `invoiceId` varchar(255) DEFAULT NULL,
  `customerId` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `method` varchar(100) DEFAULT NULL,
  `sold_by_user_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pppoe_profiles`
--

CREATE TABLE `pppoe_profiles` (
  `id` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `localAddress` varchar(255) DEFAULT NULL,
  `remoteAddressPool` varchar(255) DEFAULT NULL,
  `rateLimit` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pppoe_users`
--

CREATE TABLE `pppoe_users` (
  `id` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `service` varchar(50) DEFAULT NULL,
  `profile` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT 0,
  `last_sync_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `settings`
--

CREATE TABLE `settings` (
  `settings_key` varchar(50) NOT NULL,
  `settings_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`settings_value`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `settings`
--

INSERT INTO `settings` (`settings_key`, `settings_value`) VALUES
('main', '{\"mikrotik\":{\"host\":\"103.156.15.238\",\"user\":\"hasan\",\"password\":\"TGSAdmin123$\",\"port\":1613,\"remoteAccessUrl\":\"\",\"natOntPort\":80,\"natPublicPort\":7777,\"enableDynamicNat\":false,\"natInInterface\":\"\"},\"tripay\":{\"apiKey\":\"DEV-dHWvVJlasfgVbtLXE27DgetIm934Cp8UMgxVMc0k\",\"privateKey\":\"OMlfN-NA757-zsXAJ-MDmPH-yOzns\",\"merchantCode\":\"T29940\",\"sandboxMode\":true,\"enabledMethods\":[\"MANDIRIVA\"]},\"billing\":{\"taxRate\":11,\"dueDays\":10,\"fixedBillDueDays\":3,\"generationDay\":1,\"suspensionDays\":3,\"suspensionProfileName\":\"ISOLIR-CLIENT\",\"whatsappNotificationsEnabled\":true,\"reminderDaysBeforeDue\":3,\"sendInvoiceOnCreate\":true},\"app\":{\"baseUrl\":\"https://techso.rizkitechbill.com\",\"appName\":\"RIZKITECH DEMO\",\"appLogoUrl\":\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMAAAACzCAYAAADfahNoAAAQAElEQVR4Aex9B4CVxfH47O5XX7tOVWPUGBOjxha7gvTePKooNow99sT8TC5/TYzRRGONoIh0OClSLSDYC9h7o0m//trXd/+z73h6HHdwVA+9jzdvtszuzs7OzM7ud3dQaHlaJPATlkCLAfyEF79l6gAtBtCiBT9pCbQYwE96+Vsm32IALTrwk5bAT9gAftLr3jL5rRJoMYCtgtjvSAhS/MknWp8VK0KdX1iR0+uVD/N6vfJKXqfFbxVI3GHpe7myvMPSpQaCst/5+4kM2GIA+3Chr1m4UB/6zPPtil9888QBc1/pfcHSDy8f+sJHJYOXr3zg7He/eHwlCU1cHWo9Y1O79tNXFxSVrs4/YubGtu0R/7y0olXBjIo2RVPswsMm+ZFDxnRdseq/PV/96h/9l31+S6/575zf95k3Ow6YtvjI4ZPn5+3DKfzou24xgL2wxKNXrFC7PP9uu54ffHlKz09Wjer2wdf3nvv2Z7OW5xyy4Is2By/8Ipo/e2279hM/j+Q8uCaW99dvhH7NJhG6uMxRBscd1ivhQrfKhNsp7dOOCZt0TLtKp0SadYm7Ws9yRx1UTkIXbQD92g165E9rwtG/b27V6uH1rdpOWHfwETM/a3vorDNe+mxWp9dXju/y6ld/6/Xa10N7vvbJbzssXVG4F6b2o++ixQB2c4l7oeft/fzbnfq/ufYf7yZyX1xVkP/6e6AsWO65939jGFetETDANkKdfKIch7fNB/uc5/qCqx54ANxJh3xenmd73+akk1/kxGveL3Tdt6KJxKu5tvVmxEq9E3bt9yO++0nEc74xfGe9GnhVVLhpyn2FCy8mwD8ooOI3em5Rh2olNKA8FLtwrRn5y5dG+IkvjZzFm/Nav/+bN758pfMrX/y1/6L3OgyYtbhgN6f6o27WYgBNXF4Zh3d9662fd/70mytOen/l4m8O//U3n+e2ee4jVf1TeWHszLih/8whpEAhSg6Jp4w2AbUOsYOVR9aknzmyquYfh9dUjGgX33L6QckNRxxWue7QQzavO+x4e82RA1/4xa8HLv3liR+d9YtTPzzziLOOWv/umUete+eU4hcOO3HAokOO7f/coUf+Ym3qsCPSKw853K449LD0+l/8vHrzqUckNg8/LF5ekr9544y2nvMxJCsTAbGhhtmhOBUFKVe0d5TwmaupUfJZbu7SL9v97ItT3vxiyVlLPrii+KUPft7Eaf/oyVoMYCdLPHLWc626LH79Kiuv9VtrwvkrP3fJI9+60EnosTwaUKaCC4ZVBTkVW1YfmkyNOay6ekjbyk2HvXb6L0Nzz/jF4TO7HNf/6a4n/nlWl1OmzO98yhtzOp3xTWnPs8vm9jszMb5jR7ukhHAJWTZKBw8OJMiyLJQOPtot7dgxWXr2CWWlHU//ema3096a0fX0qU93O/lvC3v8dsjiDkce88GZR8YKytceWVi16fw2yaqxhenkN3mBD7oG4GkUEmGzYL1hnLs5P++R1Wbeyo4LPn1ryJyPL71o3MKi7Ng/RdxiAPVWfeRzz4U7v/LKIX3eWzXqtJc+nfNF0ZGby8IHPZSA/BOAhyFPaEGrhFN2VE169a+2lN1zZNk3vU9NbWj71dnH/fzd039z+WvnnDjj5W7nrKrX7X7JvtX1nK8+7Xja5A/POnb0u+f86hdtNn/VpnXlhp65VRv+FUtVf4Vh1SbiOWlHoVBVFPvdqqKcsSsP//Xqs577ZE6f178Z1nPp221KSkp+Ujrxk5rsjrTwildeyev60uunf17Q9r6ywp+teN8JniyL5vezwznA9LBFE6n1bbzglfap+M2Hprac8kyHQ37+TL/jb5nb/dwF6Mk37ajvH6SOEDG3X+fNL3Y7bdG7nU+79eNTf3Nk4aYtpxzk2H/Ks9PLTHA2etR3E6FQqCa/qN8nnE9Zn1P09osDhj3Y9cU3Trly6dLID8L3fh70J28Aw1/58LDeH6y7YIXaevzmaPvFll54WTwJRXmRXIiA2KC4lc/lelUlvySJbq2+eaPjs2f++r55fX8YD7+nuvFa37PWLjnrmAc6Ouu7HBWv6Xw4t27XvdQ8TvxvQ7EcqAng4I0kdOXKSMHS143WEwZ/vO7Coc+9ffCejtuc2/9kDeAPS5ceOvLND/+4MhSdtpLpT1Vp4b5c0U2SdNy2frC8qLr6joNrqgb1PeXwnktOOeJfM8/87ScyNm/Oi9lU3ko6dvSf7HzCp0+f8et/dXv+0P5t7LLBre3E/wslk29qnuDMiJg1SmTAR6lgfHl++9Lez396y6jZbxza1P6bM1193n5yBjD0pY8O7vPJutteyzls7ltq7K51ACen3CQYYLtmTdmcXxF7+K9TyT5LzjziL/M6/vrNEkJ4faH9mPLyoL34zOPeXPK7w/96usmLf24lL4+Wx5+NBarvcR1Wecopq2J5d39U2GraoBVrbyhe8HabH9P8fzIGMHrpisJRn6/7/YckePYzx/t/X9UkjhFUgxjnTmvXnnA4D84uSBhDZ5z6q5mPdz5m849pkZs6l8dPPW7d/DN//XiHgtzz2icTPQvt1MyYgrdIioBERD/layruWR8JLezz/LvDrp/xutnUfpsz3Y/eAIpff90c8O5X53ydmzf/rYrqR73c3F8T4bFf6wwO2bRuzDHVW47/rZK69JmTjnxrUc9fOM15sfYXb/ce1ya1sPORL3QHev4RyXUn5ce/nWI41ZC0kzSVk3v8pvy2E5fFimb3e2PTKSAE2V987YtxftQGUPzs6/mVkbYPfcm0ZasDOEXNzQOaqOF51RVTfl5ddvSSHr+7fHqX0z4bc9JJ3r4Q7oHeZ0nHn9ul5574zpvnnjKivZs8Ot91XvDjCfAoZUGrom6rVf2NM5eXP9x/9nu5B+pcf5QGcPGrn0f7vPF1j3WRNp9sSsDFVooDUw0Iqspf+00yffrbnU4bMbnn2Z8eqIv2Q/C96OxTPz0+wnsdI3g/deO691Qv7qfdBKkCccU3BQXv9npnbbdrFn6l/xC87cmYPzoDGP7Kl4d94sB/1wljYVILt9F1E9qb5jcFieorTvYqO8u3qHsisJ9y2zG4U0475+i5R4fouUV25d+KiPUtCTzwQ+bPvwj4s69H0w+Pev7NXxxIMvrRGEDxCy/k9F/+zbCVHlkgzNyL0g6AAlCp2cnxRtnqHm+eefT/xnfsaB9Ii9NceR3f8fjqZ8/57Z1H+dV9CvyaWYqfqNI0Dl44fMmXRu4zF3yw5bzipZ9Emiv/dfmidTMHarr4ubd+7hx07APrFOPJKuBHUSKgrUaX51dtufDNMw6/+IWup351oM6tOfM97qxTPmjFqs9v51VfpyWqPuCcQ7UW/tW7cXtsMrfoTnnl3Jz5l7wd8AbQZennJ60pPGTCl/HkBVVWXA/lGnZIJP7bJrlu0JJux8wHgtYgZ9oC+0QCpaefbj131gkTD3P4QCORfhgHqU4SnlspxHVrfPb4gBe/OA7Lmu3ngDWAkqVLlcGvfTlogx6Zvc52zwx8DrkgVuUmqodwZ/1N07r97ltoefabBGZ1PnnlCUn/lsKaqqtbCb7KsixI6WbXtYLO6PfqqiElJaJZ6lqzZGpnqzZ63orQR4XH3/WlGpnsqsFBUeZBjm/POyRV02vpOcfNXdaxo7+zPn5S9ftpsmP6nJR+uduxk49MJc7LZ8obaRBQo5MjP/XtCa/1Lb9n5HMfhPcTK00e5oAzgCvxcLWqVf6T71dV31Rh23qOn4aiyo3/+vnm8uGz8U6/yTNvIdxnEpjU/bh3Y8l1A9oqYpoAH2henvZp0rrhK6NwzPD5Hzar32E+oAzggiWvt/+G8UWVPh8sTAoHxfSg9Za1l7za86xbSwd3TO6zFW3peJclMLfzqZt/VVZ1SRsm/pyqqk6buip3g+GfRbXZ/Ze+12x+sO6AMYBhz6046lsSeboalDM914Y2xFsPqz8/e0G/buN2eXVaGuwXCciQqMtzR/3zYNe5lFWVbVDxPiJpGuds1iOloxasOGa/MLGTQQ4IAxiy6L2T19DwFDdWdKofCGhN+CcHb1rb/Y3+nV7fyfxaqn9gCcifNn2j63FTf+E5A8I18a9JtQ0eDZ/0TSj/sQtf/PDEH5i95v/HcYfPf+fEylDsCUvVj0/Ea6C1Aq8UOFU9pvfu+PEPLbyW8Zsugfl9Tn770MAfdKiqvOPFE5DWzdO+csWYa+a9/Lum97LrlDtr0ax3gAueef/4DWbOxDIOx5h6AIVe1fyD7PXnT+t2TssV585WthnWT+1xzIcFyS3nt2Pei65VCW4054RPzbZjLnj2/R/MCJqtAVy2+LMjV1HyVIXgvwISQMxOzGsnvNFjunRZ2wzXtoWlJkpgap/TPy8S/hVFKiwB34eEFj7uC1cZe9mL7x/dxC72KlmzNID+s9849GPHfd7JiRyTl2tA1K5cXFiZvHxS97M37tXZt3T2g0hgQufffvnztP37nHT8de6kQCksOPZdJ5g5cMG7P9vfDDU7Axi2+M3WZdHwM1ZO9GeW/EnD8vXvtgmskZMGtSj//laOfTneE91P/PpQIi7Mpf7njmeDHy36ZUVe/sKRsz5otS/Hrd93szKAEQvfjG0wC5/eRNRjE54LeRpZfYSX7lvaq+Om+oy35A98CUgjaMvTA5VkfLNwBVTY7NcfMvrE6Be+ydlfs2s2BnDxq69G10aiD5eDeiYXDAooxNX13/aa0KfT+t0TRkurA0ECE7uc+FmeVd0jVwQVjBCgha16rwmp/7lyxtII7IenWRiA/GtkVepBv0+y2PmJtAOtDTXVvmJT9yWDO7f81tZ+UIIfeohF553zXrRm8+iQk0wlKrdAme1evKHdz0ftD76ahQF8dHav7qur0n+w0i4UECK0zetHzx7Y4Y39IYCWMZqHBBYMPG1WmyB5W+uwDi6ytDId3Nr7+S86YXKffn5wA+iD119fufpdQtHbFTECRZVbbn950JlT9umsWzpvlhI4jsPjEdcaK1wfiBk6qCyg/7z8+U/36a9Y/qAGMHre0sLywLhTzW19rJuqAVa9YVKRW/Pg/lidUbOX5p734oqnznth+aODX3j7vsHPv/3fwUuWPzBs8Yr7hzy//N9DFr99L+K7By9e/k8Jw55ffrfMD39uxT1DX1hxD9LdO+SF5fedv+Sd/wxbshUvXv7v4S+885+hS5b/R+Jhi5f/O0OHfQ17/u17cZx7ZPshL7z1rxEvLP8X1mfwkMXL7x72/PK7hy5e/s/hCBKPeOHtu4YtQXh+xT+GLl7xDyz/+1b8z2EvLL8T4c/DFr9z+bCFH/e5YOH7x49a9MahIyc8F94fsttXY5T0OSmd71i3x0TwXE28ClKMnVRjFPxl9IwV++xQ/IMaQFU47wJOcvrblTYUaWJFG6fs9snn94zvKwHX7fereCK2VqgXrNPzfr/GLPrDWrPVtWv0wmtW6YXXrQkV3rBGb3Uj4lvW6kW3e3aDzAAAEABJREFUrjUKb11tFt0i86tChTchvmmNUXTj2lDRH77RCq7HNrXYKLxhlVFw/Wq98HqJV2E+Q2e2unE1wlqz6KZMe7PVzasQsE/ERTdjOfaN/ZtFt642im5dgxjr/7jaaPVHHOtPa8zCP2H5bVvxratDRX9eYxbducbI+9+6/PDcr3JDyz/La/XRF0cc9v4pr3017qyln5zX+4UVhxTPmMHqzvlASE/td+rmtpTclq+RjwMF4ONkcnBVfn6XfcX7D2YAw+a+evT6pPM3y3LAsO3NrXj69mnDBqzeVxOt32+sqED1IrlQpRhQwUyoZAZU0Vpc2RCmBmTKEVcRpNuKK4gOFcRAaBhXIp2sl7hS9ot5iWU7iWtBh0qGQBHqYclfleQN+cziyq10FYoOZVSBdQFhm6keqYkUHfEtNy/aEm5VWpl/2JryVr9bPGjRZ91Gr1ih1p9/c87P6var90Ju8l+BndycDGytXKGPXLLgtX3ykuwHMQD0TNoWos6MeyQSIi5vS+xHS3ud9ez+XBSLhILqtAcCKAgCwBuBAARIyNJkMJbxrQCUgUBoDAcCsD0BDmQ77AuO5aK2HDsOkIbvAPuyLw7f0+N1cdJRQJAoaGBCujIBUaqBFU9DpcWhXI11+IxGnv3G//mW7s9/MUD+Lzf7U8a7PRYh4ohQsrQVhafbx1SotiuL3rfFI6g3e31Ho7vN5B409PRDb6/ylV/GcvPA9OMvm97G/RL312VZo0pgmBHghIIQAjhsBY4pzMsyCdk2GSPAcoklyDqJM0qMbWQ6W9Z0LI1CZMZvrH22f4mz/cq/viDzARqDHgoBpSp4jg8m7hLU5xA15LwI1Pg+1JgmfEtZ7rpwZJZQD13R//l3O+GAaO7ZmTVPPL5jRztaXXYfiVd8FNIN4OH8nvHwLy/a29zudwPoNu3Z4zYxer2NYYNTk6o2rc03lw7uXrm3J7az/nzfo74bABUU/S46FsToytEM0CDgewBMNwTScGrLAdsAcDSO+oAOGwBf7uwIBAHYEQAljdZzwiGVigNlAWgKRSOwwdRMCFDxBfcgHNFANQNI8hpIURs2+KnjUjm5iwe98tkjI59r/v9P2KKhnb4pouTGVGW8nDoEfB56sHjSm7+GvfjQvdjXTrsqnrGwKBGJPFQlIKygo80P+D9/98Xyd3facB8QaJRg9I6Kjm5UoAdvDKS33RFIr4weFVCPtwNZXheyY9QtA44KjsbTGBYBIDmaEtJJPrJ5iZFtUFUVPFR423PBRG8fR4NgeJ1MgIODacFdUCgBD7tQc/Lg25QD33rK77doubOKF71/5j4Q7V7tUkmtfelnqj5H4zxwiWLE9dx/X/zMq9HGBtnV8v1qABVG+MKUmXOmH1DI5/47uaLif/gWmO8q03uD3vcCTlFxKEcNQyMgXIAEKgAkMCAgQabrgqSpC5RTkEACAjsDSSdB0oEPIEGgZkplzqSRlUwdKrvEslxi2JonuEtl8wzjf4YcBlgmiAKgqOByH1RdQ4MJQMFtRScqaC4DxVNAxTOCnRbA1SgkVAM2UvLbDWqkFA/JFyInzfZTOniw29pL/CWiiJVVVgosUzk3CbkD9xbDdG91tLN+Bsxa+psyj1yetHzI1TQr14tj6NOlZmft9lU95RiwbPW8UrGyiikVTIJUyAxG5ZMKmAVJK+G7/FbDwWhkqwERoAIQanG2vD6mqKAEAAhiGpAMZmhMwAFkXuL6+Wx5FjPkTQ0ESFB8HBR5CSDApqjoINAQBPZLsT8GzGeIVQzVGPhCBYswqGFqmwoz9vh5S768adSTSw1ops+YQWdvZPHqPxTEQpCw0tqGRPzm0bNXHL432KV7o5Od9iEEqfHC1+l66yMU2wdv47dj5ww986WdttuHBIIogYveH1kD1BioVVDIYEClkvkMRsUidYAGUkEBpPJJkHS1QDJtCSolQSUmTcCZviQdGgEgBmwHu4Cl0odtAVGbg447CUO+0azBIwIcWgsBpuUEKdbJehYQoFygMRAQOFY8bSlxTu/hh7S6FJrx8+zwMxaJsk0zQhoDPSf/6CTh18JeePaLAfSd8crpnlk4wLYEhCx3/dGmcQeQzMrshSnsXhee4uMxkYOM4aVy1CperWJIBSE+AJGhEWKZp1sVR5bXzWfSUqHQmGSaBH5tO8QyL0OsurhuvewfZDtUzgxdA1jSS/5kPfE5Km+Ayot8ynY4roqA5ylgQQBMAGKBhoj1si8EdPmo/wJwoplygvSZueB8CGcQMAUSSFfOlQeHL3pnr4UWsLcfQkQhsW7RgiCedCzYnPYGXTTz5RP2dJh9bgB4d2vWhHKv3JIMCrykD20A/j51eMfyPWV8T9t7vkJ9kGFCAERwAIyfM1gG3hwNA/MiwDpUNKmopA4GH5UN6xgaiExn6jFdH++oLktLcSyCfUlcF2SZBFmWxTJdFwTy7eEK+ghSHgx3KhMzYbwxCbkisyuoWEZR6eXOIOfLAT0/IThngk0wPNJ0qMbdY0ugwQYIjRsy/51fYUWz/Mwa0WkNsRL/cVwPbM1sX8HCv8cz5NbZ7x7Le9S4KUMmWe4JScF6CiGgyNTfaeckpjel3a7T7GILwvGcyIGjAkoQqEyyB4kF8gpoHLV7lDQSCRydqEDFQRXCegHZPKaED3wrCAiwZeMAhIOELB2gwcl0XSz7qpvP1st2dcszaeQFewQAVGY8EAOGNZJvglh6eoLKL41NGoEEgvTILGCEhG0AHNcHqofAM2JgGbk5WxT9P6PnrQhlKpvhV4ETPBKmdGXc41Dhsf5vH3zOHu0C+9QArpwxIxKoeb93bC/XJK4d8mrufOLS/X/n39A6MuLr6AiBS3UVgJgARgIgsDALUrGy6Szm6EElSNoAlckHaQAEdaphEKiYWeDie5psWRbXraufljTZMpnOAqDCy7BHQWZEhhdUaAJ4wCXgEIpnAQICDUEepmWYpOBuwLwA5M4lthq+lI1qhqCqxoKypAeWGuleBvQCWd4cofTis8tiDO4XhPIEZ0U0v+3Fe7IL7FMDWOvEjkzbtLeOC58D1tsF6cSrzUWoTPGpJlygeBKgqMREcIyhBRBUJAlZbykFJPMMyyVIWorKUwsC20CtSYhaDBwT6NWzmGCWoHnJvMTZfBZnyjG8qosp8pLNSzqZbxBjvwTHErjrcJxDkAGCF1i1gCwDRdlTNBCGII1AYrkjAIZscgwfr4KtVDrzDkHTTUi6ALYaufb6ma8cBs300ZOJeTHNXO1xBSpc3v+Tw7vuNq9yfffJNEc/9phqm3mXgdBz1bRVE01Xjpt6+Q8f+2cnG04FPBS4oGE8qbgOqPgiSYLme6DjAVbHM4CByqUFmMe0LJN1EmRagoblCtZreCZoDFTPx759qFuvo/LVh7r12bRsK9MSS5DpbDuZJ54HnKPGMlRaz0ZzEACMgo+HZQXfDXCPgFR2GQZRNAB5kKZIRaSBobHIXUPHQzDI+eNchONgcx2qrOBXNWbu0Kysmhv+7RpYRxKp8Yaicp+rbS2iFe8uj/vMAKryfntQwlMHyBc9eQr9OAeSy3aXyX3SjsfTMTsFRcSDVuBmoIi4mHehEBwoErVQEFggIV9ibkMRQgHHMoT8APOBA4W8cSjCXaY+NEZfl64VeMiTB3XLZLpu21zsW0f+Xasa8iM6BFYaRNoCHXchL5GGHPTozCcglR+wTCp8XZC7R4DKrwGASQAYGlSAZwKBB+MvK6tHXjpz6UFY1ew+JSUd/cIgPVPzvK/kDpYOyEWjJz7bdncY3WcGUJ50RgFRWit4bSVqqp6ZcumgNbvD4L5qY4K1KT9Zc25+9cazC6s2nl5QueH0gur1v8uvXH9iQfm3JxSUrT0+r+LbE9qkyjLQNllxkoTWEttlv2uTqjilvb35tLZu1elt09VntLUqzzjIqjztILv8NInbWlWntk1XnNo6VXFqW6vylHbpytPapcpPq4/bOuWnt7fKzmztVJ0p8UHp6rPbWZXntLPLz2nnlHdob1ee2capOqMt0rV2yjL9tbHKzmqbqhheYJc/HAkSX+fhkdWp3AwFqMlRDKeieKsT4wSc8hpQMp5fZEK7WuWvDZQAdzeCdQZTQe4kQToJmtwZbA8EXo+KWN5RG33RdV/Jf0/7feaisz7Lp+78sEpdj4sj4i7s1hXuPjGA4odnRHxCL2X4ZlP1rXWtNPbMnk54b7fHV+zB3BG9lz4zsvsrsy/s/IaEWed3Xj5rZKd3Z17Y5b3Si7q+L/G0Yee8J2HKiLPeycLkoR2WTxlx9tuTh3Z8c+rgM96YNuz01yVMHnrmm1mYNuy0t6YNOwvhtLemDD4daU/dWrctlu0nDzn7tRlDTntN4knDTnllypAzXpYwdfDZL03G8mnFp78u6aadV9vf1MFnvTp1+OlT5xafeXVBxbentnGTPVvx9HNKTQWEMawjThqVWUDUNICgQQB6f0BMMlhkdgSKaYKHBIHhG0cgGPaFNQMMqoBtu+BSBkEocom8yNjbst8r/REiQm5iGrUTW5imEocao3en331iADYxOxPVaEdxMTQ//sqE0Z2/3B3mWtrsXAKzLxxYMafnaYsOTvj9D1KCPypujaXrAnzFh4SfgoAKwHNw5rAuD8FaQEFBx6RIHAD4GPaE8BpUIJHnOHigB5DnhwDfJ9Sk/NNTtN3PoJk+0cD7uNBkK7jvQkpoRw18eO7Ju8oq3dUGO6MvKSmhthn9U0rGkp5VHuLpaTtr01K/5xIYf1FHe0bxGXfngjsYktUbwU2DqgAIgSGPEIgFyJ1Aen75fiCDMUwiAlWAKVjFwHLwUhd3AwWNQREMdCMHalzeC5rpI+dsV20erzO10mdhzWeRm3aVVZz9rjbZMf07bU88spLrv+OKBioTq81wYvmOW7TU7k0JzB561vyDQ/pNrTQ9QdM2yJsfQCNAM8D7HwEBKrc8C1D0/lgA8iVg2nLwBKyBFgqDIAwcywa7Jg2+5UNZwulU3Ix/t7iVrr9EBF8bUA3iDvS97v6xrXdFnnvdAGw1egHRQuBZ6UCxk5MnXnBBalcYaqHdcwkEwVfTY679RAxXFy8h8Bwgd4AA3xYEQESQOQMITkAagoGHYOG5GUMIAjQTvNY1DQ3CuoGMKBDKaXWmlyraaz9/j53u1Q/uAtWGl3rety3PyMk1Kkhun10ZAEW0K+Q7pi3+zwzTCbQRDsaSERJ4ejo1d8ct9l5tn8fmhXo/teR3/R57+dLBE965pdvYNy/q/tjSM5vjj/kWP7WkfZcnX+zZbcobl547/pWLuk96sdOAR2fttT8KWzp4cBBJxu8xHedz+d5A3vIA3vMzwfGq0wfF9zOCl96f4zWogZE/QyOgEtBAZEydqQsIeC4NMaK2zzRopl85Ts3EHI3zOPK/Sc0fJcPwprK6Vw3AgeBoH+jBOt4kWFs2vrzgDwNXNZWRPaEb+uTsQyuMwoc2G+3nVBceMtDH7l4AABAASURBVHYlhO6ujhU9kcw7aN46ljO+34MLmsX/R9XjgYX6uWOWjFoD0adrQm2eXuuHxlZFisZtorGZicJ2Y7s/Nmuv/YbWuEvO3BAjwRgNvbqM90He+kjA2x6BxiCBYJ4FIhMmEbwlAqyTZYDlEssdIpVMg+t6P9+T9dnXbe3N6S+VwP6S41kniOT/+oN2Zx7R1DH3qgGoZu5IfDFB7OoqaJsTmQh4VdVURnaXrnjcy0VblMPGe1qrixIebVuBuw8PKWDxFHqEeG7cYEM2mcbYgY/MP2x3x9gb7WQcbeeErg3yix5zgZ2arEmaETx8Qjot8GVVju2bfV2z3WMDxy3uvDfGk31EnPQcheBVEKBbQm8OPsWwhwDnHCgedlnAMyERQcXJKryskyCVX0I0GgVVZcfK/porlJYMdgMn+ZQKHFzbi9Wk3J5N5XWvGUCfksdC6SDoDeg9wgoRGiRebCoTe0JX7tOrNzrknGo8uIV1dUvYr7o6ZH37WzW18bwIdb5OuzYEsaJTqnOK/nTiY4+pezLWnrStTrU/ppKrt1UkLU0BwWNeanasZmOX9iI1KCjbPN/1hJOmocPWO+SaAQ/NKtiTsbJtH7/snFUK8b7C4VDhARQ0Auno5RoxTDAfQyFcL6noEqQRABoDFYAIv7DOtm0QXnBIts/mig3Xm0vx5st3XGaEo8Pkj+I0hVfaFKKm0BT87LDDLa7kA3oWjbsvzb1m2IamtNsTmmH3TikkEe1yX/Mhlm9aNLnu0rcuOPXhV0ee+8E7l3abUxCv6FOkh6rstICNcXFWKHpWr7OmfHRsx4lvHdfr8dd+0+N/i3/d87HXj+k25tWjM/h/rxzXTcITrxzX+fHXj++B0PuJt47LQr8nVxwjYcCE5b+RINPFT75+jIReE177Ta8JS3/T/anFx/Z46qXj+z7x6kl9sX3PJ946qfOT73WoFuZVqpqTSzkDmqoed6ySHL3kys6L51941uwTc+iFxEovcAkAzck50daU3+yJXOq2VcH/iKJnxF0GGOo7wUqp6BRDIyZ3gqBW0VHjsQaAYjaTRkOQdARLGaN77XyC3e2TT0VVZFWOrq5UcVd1fXZERaLg8KYMRJtC1BSapAudhBoKSRdrcre0KW32jAbAJl6+y4PWrmdDOlm9iLv2y3X7NPKsr+IbN4+huB/F8todXuOrT3+bFiuq1IL3Nwjtowol75PNSvjDLTT28bck8uF6Gnl/HUTfX+eH39/Iw++u5ea733ja+yt99f3VvoFY+XB1YHy40tM/WuOFPloX6O99G4TeXxuE3tvoI/YiH8q26xzl3W9tdTnCuxsDY/mqGnepx6KXVldZYDLdaxcOjR1zeZ/vfilI/oh4WNX+7gciXeO6rV1FParuPPYkLUSwWgQclZ8DRY8ulR7woEuwTOYzyo7lUtkzaawDmRcAUvl1VQMrZZvQzJ9lJR19v7piukooBFyJhiJFZzSF5b1mAE6gdOKcaApKMkSChU0ZfI9pcDwHLS9EdSB+kD4sDzWsTqfyNiQvEitXcCnthMPA5bxAU7lmJ5J6AFUGZT4Tfopg5Iihgq2A5yrMdxXqeyr1AwRuqMJHCHRd+LoqPF3hrq4IR0WsaUJoOhGmJiDEOIni5EOKIXTF5KrOQNVIoAgfCnJyIBG3ITenEHQfEoFjp+qwmUmGBN7Mc6JrIVMRjO7WD3ZlOqr3RQOelDqNWgEMlZ4IDwgPUNcJcA4IHPOo7VLpfY4FAvMBkMBHg0E6xOGwodXrtllmf1YYm5uoqoRAUNUCpUNTmNwrBnDx3VPbAdGPYEQDxfc+nnP9gNVNGXxPaQzVKYsZIZcFRFCPHVdlH77Ntlf8wMKitEMGoEYB9d1ETNhPRxObHoxVrf9fNLlhXCS+7sGc1KbHEB7NS296rMAu+1++s+WxPLv8sXy3bEy+UzamwNnyeL5TPibPlukKzG8eU2BvGZvvbHks39k8NpbcOCac2vBYrrXh0ZzUlkdyU+UP56UrH821yx/NdcvHFAbVT0bd6um5OtnopJJAKDU8nxxfd+7FMz7RKn3RX1FNzXXdlPDdlXXr9yQtfBomqNcElR5VHigEAGiUHEMcji/FCCcgfzkmuxug/8J6aQQCgAuQu4edtvBN2Z5wsX/alldVfRAzjGpKKVSn3aOG3zU/b2cj7xUD4Gb0cEHU1oHtopfxXtnZoHur3uc5cWqlXzHBIJREj64IIv8586kPO589+b1fdBy34pSNodZ/T7Po6YDLTq2KN5XkyiuXXdXx5sXX9775hZv63bTwD71veOG6Xjcuva73DS9e1+sPS67tdd3Sq3teu+yante8eGX3K1+8qucVi6/sfsXiK7pdufj3Xa567vLOVy+6vMs1GRjd6doFl3W5cv4V3a9ccEWvq+b/vs/Vi67see3zV3a59oWrO1/9/NXdr5Sw6MpOFy8ZfcqwQpr4i64GdlKQ0BYt5y8dJrw5tM+Mt37e+8k3f7E5mb4obcQu5VRRwHJXRQL1nb0lIwGsrXQABM8BwndAwRddMu2jfvsoF3njk7EJuTvgDpAJjfBcQKTBCA4Etw8GfMve4mef9nMQuCoP3uEeHnao2jbQxE4P73vFAAKqHu87QW5IkTuAvV9uf6QgS28YbOVC/DY1Xb6auGnq+qR7JadPodLPq4bwjCQ3L+MuB9VO1bTXg/uWXT+gWrbb70CIMBObns4PkstQCTkYkV+UuXD/JlebVW5EpqfV0B1e4B8EVjKVx+0J8y7rttf+a6ggUI4nAYNaz+4DoPenqNxyB5C/0ol7J4Y66CLQ28sDMEHll7sBQwOhmBauL9vu8wuNvbEmMuRVwV9MBRouVXI8Ab/YWb97xQA8qh1rWRYh6GE05r+/s0H3Zn3pFX3ebm9W/jGX1qzSvUqIUbcdT1X90k9bh4QJhVYK1OS7VTfOvarjfv3r0/XniGFh9SF+9Q1mqnKxGVh2Udho7SSrf+tZyePteEVRoebU5Lll98SczY8BGkz99tvkm5gZef/cQ/yA/YpgmAMiAOnNpSHIK88sEFR0guFQBksjkICKT3A3oJjWmALccQ+Yn+Y1qXhRJ8LzHNcQoO7074jusQFcfPczUYG3FqZpgmenV8d8Z7972dLL+k8v4GWd2+vJP4dTW17Ndau/PjhKPjDSm+4yk9+eOu8P5zzRRJ3Zp2SPX9X7s5/p1lCx7vPLxObVC9tq3mcxP/5JAY+PVTd/011sevkfi649P763mLBpuG8Q0LD05NK7Ayq02Br3Zzw87gRSyRmv3QGkcUgQ3EdjwcLAx90hACuR/GZv8bTP+7H5KjteVamraLmEHbmz8fbYACDKiiyHHJZKJSCkkk+py1M7G3Rf1M+6ctDKeZd0/ke+iPeI2etOLtjy0RlLrutw27ybun2+L8bb3T6nXNm76vU/D5kUomsHhjZ9eVZu+cZzQmLlNYtvHPTmspISf3f7rd9uwD3PtbKpeTXqOCox1uIuIJVfcAXDIAUUvALS0CBoEIA0DKn4JOBAMkqP24LPATDvO27Qql2rL7CHA+NjJJNhjWzgnoPTCg674E8PFeyI8T02ANtXCj0Q0UQ6Aaou3h9fMsrZ0YD7uq70qsHJOddfVD3x5gt+EENs6vwWXXutM/u2qytm33ZhhUw3tV2T6FDT1Vj0TwlH/DLAcEagIsvfzgNOwc8YAuBlRQBq4KFxBAgiYwSoMRks6QENRGLf8VbbBTUVTRq3GRDJc6EigvdkuKdp2sEQje5bAwj8oG0ilY4UFhaAY6XeAtw8oeX5QSUw4MFFF1kBu9hyA9Rj9OR4KASp+JyBDwwCDIMYbg0MDUCGQoA7QWYHwHMCCAEynSnDNPeDD+Xh8ged0C4Ozl3rVQUCsFKpGPd56x013+MdIO3Rn/GAYvyfBJ1463Y0WEvdvpVA8YwZbOh/FgxPe8aDm8sTMVXVgaMnJ6jsAhVCKnbmPBCQjJJTVHwQuAMAxzxi3CEkTdYIGIZHEYPtn5eaTRRNU8jCjH7mO3agKlqMKzlFO2qzZwYgBLG5hldNFFTHroZ0er8fgKHlyUjggv/MaK9+G729Iq0+4bp6iFETd2QfModf+fZXyMjUBgWvQRW5Iwi83QEEz4OQpoA0BgUIUKqA4zigK5j20lXhmopFcIA93K7crBKSwNdS4NOcHf4U8B4ZQPF9pQZTIz/z8MUDC9wtuaawDzBZHdDsjv7nYzlD75xw0pB/z/9zWcJYuDkBf7UDzfA8ChxDnogZAunhCXp5gcGPxAqeB2ggsFyg1ydgaDpUlVcAl2uIBuA5PoS1EARpGzTuvZpXVnVgvASrs5IB5zbOsdoPAN8rkl90KFmq1KneJrlHBgBxMC072T6k6xAE/pbEppoDygDOv33ipYNvn/77QX95+rLi22ePHvK3mZcPLnnm90PumH3FkP8398oh/2/OlUPueAbTtbj4/82+uviOZ647728zbzzvb7NvPP+vEwdvI03MjCp5MrfHX6aN6H77zNED/zimwb9ScEnJ490H/m3SjX3vfPqGgXfO/kP/O2dfnYVBd8y+btAdc64fdOczN0gYfNfCGwf/Y/5N590596Yh9zx3c/E/F/2x79+e+euQu597PKUf9RwL/2pRdVXoTk1ve6zrh4CADozhiy8MedKpGgDuog2gJvgcb3hE5maHYuhTe/sTQDqZhrzcfMADI8h3A6rcFSwfDII9cXfsmDGXezitA+rDLOZwwSvw/AKRUOgw2PKp0dgEaGMVTSlnEBiMiFzPtUGnbBO2sRAOiE/xrf/M8ZTcsSmW/0iSFY2JK/mP1ZCi/yVY/qNxKHwkzvIfjrPCh1Nqq0eSaquHk0rRIyml1YNJWnB/krW6N8EK702T2HX1J7tFbXWoHznirzzU7r40xBr8k301vnJRihbcmWCt/hGnhfckaeG9CP9G+A/m743TgnvjpPDfErY4IRyr6J4EK7pnfVz5V5zn38Ujh5RstkOXbEkZp5TX0EJfhKA67gFlGjieC57vgMYoMECFR2VHzUZvT2shoGgUWC4EGgtANBSF6mp89YB0dtoCjTCQ2pLHlKVRqu23H2upL8c9yuc4LnBRzjkH13VbH3JQW72x/lAajVXtvDxgTMcYKFdBQfuuu670vhsOGAMAt5DVJANUGEIcX4AE2+PwHThY53JII7YQZ8HG9+sSHMSej1pUT0yOzc1E2o8lLQhZHmvwCk6QEPM5MxxX6NiP4iH2HaEhqJiWeRo4AiSgA8cXUQ4kq9MQNmMQuAGUb6kAVSq740HKskEzQ4AhPRhhHTSN4mo44AcWKrg82AqgqPSMK0B9FTI4YIgpGoQAx3IhbIRBhj454Qj4VhoiKhVgVY4ZX/ID/ehIPZnucrbGCSghZTgL4H6QX4nxYWN90MYqmlJOA67ywNOlAegM9nGs2BSOmk6Ttk3hcQboJBD4dxDgzYcE6T0k9vCQ6Ps+SJB5WS5DhcZGCum2t6A2AAAQAElEQVSGMBUGCgehAbCG6BQsDlwv46VlXxKQHO9iBDrrWghQjSXI9oqigK7r4KKySx5MjNslP7JONRgabRo4HnSrqssAiAcqHmABX2iphAIRFCgC4JkgA2izBL094NvezD0/zk2WG4oOAg+/USZA8ROzo8yfDwfok5cK+wRYGkA6A6rFciI6NPLQRsqbVMzBVxglquyEUnpAGUBKdwVlqgC8ImR4H059Fz1kLcg8BC4Q7gGVGEMKibPAsJygaybcE/UFpaXKhWHFQXPTGE179aszeeH6IkR8EHYciHAxWve+A46pWvCAAyqzyaCsajNw6oMPLqScBFC0LM+3wA/S4PMEBCIBpilA1zgQ5Iu7DmD3yDuqAF55glR+ieVhGA1DII0EQCwNSv4lOD9lg0glwRTpbzWv8u5HSgYnM8wegF/t2m3E2YpKaeCpRFIxWEhtbBpSdxur22k52peBnkwJhwzcQt34Ths0MwLf9dFHAMgfBGOcZrD0mDKvCIaeE0BFNVbQk8o8A4JlFAh6UIoiBo7aCts+NOCCEYKRtCBKwLet3JrjGMboeN2oCAFU9pUBgmkCuAVkIFvuYzibn5MLHMMdFbmN6Ca4KQv5omCqCpYECD5YSTQCRQPhclACBUJqCFC/Qc6FCA5AOHYdgECjAuHjGBI4mJoJTjoFOboKuTpxTR5/eMLfR7wNB/BTUvJXIbhIESFA13WWqE6wxqZDG6toSjn3qKJQRnFrDnQKuOU0pVXzoFHSrqAU1RhjY8JVIBiwUAlcA5kHHwM7CR6GSQgyD4GKtyjfg+CM1J9NilMScIYqp4EdoG7WJ8A80RTiBAQEjsU8BXcLNQO6p0EWVF8DCZqrgmIz0AMdmMNAQTC5AaqrALUBlZ0BwZheEzr4SQJqEALFN4G4DDSCbYEAYLjDfVwe7gAOjXkXGAgsDkAamEkpKF4Sd4Atc1IKuQ8O+IcIO51OaYoKwg9Q3DjdRuZEGylvUjGjXJeEBN0KAerDAfSoKScTGQN6CYLKiEE0KhIqC+aB12K6FTNJieUyT9BbEyyXGFCx6k9Z7gABQQMgsg+pffUpAIhgHFA5UV1BwbWpBQIMAyoJdCuWaewl04nEshxlje0hA5RToMi7PORSNE6Knl9BzDgDggd7yadnO6BQAoauAcdQz0qlASMhbMfApCroOJcgnUCcXKZDzTWlJYNd+BE8hqLa8uegACjzUQKNTWmPDAAI0QgqhBDCRzigBOeFdUK571OM5yl6xiywwIG6kC3PYoa0WSANGIAUNBWCIQABCGS+PgjhURmfosyAYx+BPAfUAR9cCISdAQ4O8CwQB22zDmD3IqCo7AoQxApCrUGgBaHBQuAjDxyNRaCnx3MGhkcxMxeYr4EbF0BxN9GRxgiSL5ssfvHEe684oM5x9eVaN6+oqqvKn4jGaRKCnqJuZZ00rZPe5ST3OYaxOIKgOARHqe9yFz9Yg5BfzUXgK4RzAMIxVuEgIACC7rEulu6SCx/qY4GKiwq2nfwIF4IK36fg+wqVVyyw3SO4E1DPE8QLQPaTBWkMErBfNAwOAfdAjv0dcB94HZDtgAugAQDjOAzyTkDy6mMZz8wljFekyeo4ni8oRIwIpKuSYBINQuj9AWN/xY+/GuE1Ix6/84L98lf8kMv98nEd3wvwRg93zYAGci9teNjtFrBhsoZLAywW6GkkYPLA+/BMQIGKTyEQJIOlKYiMOeARX2Isl2UcsaSR59rvMGBhvVkbwucanq41bqHYPVGvOpNVfY8z38F43QOK7x7kjQ3qLqD9ZUCgUUoADE+2B+yS1wIam+QQvTyuBAkw7WHaRsBbIHAAeAA2hjyxcAwMpoOHb30NjPedeDUYxAVDWFNygqqBkx+87Ef3Q4yaogtD1QAEugi53WYkv/3XHhmAXDDUf4mAc0q27775lniOiTsjspxRMgFUoChQscjWPKA6ZcwDywmWS0VEbwISZ/NIi422nSMXWMrR9YiAYBiEmrptfSaH1RQJKadAcTwa4PgYyzOOo+J4imBQCwQ9O0UABApyfMknw14Ztq3lD/Dh6O09XGsPILNb+SAQExFg9MuA43nAtdMQMXWgQRIKIiTl1qz7c2Xrjy988sGL8eUBdvEj+/i+q+K7EoEC4XjMChqb3nYL2BhhQ+WEBPgClQPuAAyXnTVE06zLOOD2SIBJ5dsBKKhsEiRdFss0EdvvAEGgiICqnKMSIwho4EFVFVy+usVbJ8AbHJQdKibJgFRsirwQQaExoFiXBZS9lD86IB+48IBzF/MeQu3QqATA0FLCIR1U6oDwK94VYnOPeeMv+ceykhIffoRPSUkJVeX1pLyIQAugPq8VRgNzpQ2UNbmIBwRPczgChhLoyIwmN2wGhJ6Lh2B00gxFIxUOPXKtl0VZ1Sqh2KqQAPhWF+u2x+ixsfW2k2GCcMEJumIaoJbTbWtrc6i0gqPiSwBUdpQjAI4rd5cszvCEdfI8ABh3kcAHshULxIA+TSBQNAYcERWeYB8IQoDAcwJBY2CITSRkbsK1K9d85cfXXp2j2h2n3XfZAfMzPrUS2/VvDmC6rotOBHwOFLMN99HgAjVMun0pCaw0LoJgTNXilm1uT9GcS6pARQcu8CAKqCh4IEYF8hFQqzAvy7IgfNRnWYZKmClDTHDiDYmVS212faHjvQDwhs8APsNdwsU9AHcBjoagqGFwPBcCDFukAfiuhy8WPQzCGCiCI/jAEDOsZxjbMxGAVHyG7y80pHItG1QwgYGOQ/qAt1t4vvAhJLwkTVZ+VEDSJUVKzRmzH73y4ckPXhuHH/mzDIB6AQkTqhKVoCvxnKCxKe+RAYAIXFww4Ts+0Q091tggzbFc1UKC8gCPhCC9BMgHIwWJMnmZrgWeyQNHGWa89PdYyLJMi++/KL4JppxyEqCf9/E0+33VdynuWRzwIAyo6BxF6NhxiEZCQHFAgeeDsGmCKe/t8RKpNgzCpqj8IAG3WuCQ4YlgInBsyAlHwE3b4FsB4Nna0qn+qXCdJ7lVNVjR4qc/+cD5dz354LU/ylgfGniO3NCWcOBRXAGglPqcUvRgDRBi0R4ZgGJoHg6Q9P2AurbIw/4OmI/npgnHRzKMelerUAK2wyCwsA4IqdPZfIBxBmz7+D4Xwg+A+4JjqIKNt62XOTtV4YQULlRIcUNJJxmPB6macvTykBk/Xl0DvmehQQQgOAOB5wmCQxERYBikAEHPn0njuwLAct9NA8MlNzUDwlpB0k0p/543ZsTFT4+9ZFHpI1cl4Sf2uO02MpR9BJ0zeLaV1sJs3xhAsjrl+66bMI0wUKa161BSosAB8uhpQYU0AC5AoEIThAZxtn4rljcxhBCQGIsaFKwI0P0HnBKOFLD9E9Hdezx7Yx/il/WFoGxExPRvVoRTraKCM/TyrfLzUMkFoHNB3oKtgHyi9xdoDIAvvATuHALfE0hgyI/KKDgWbsiuUkS5dkGPi8bt8Hdht+fqx1PiVeRrGDHmQRBA4LuVVWVrncZmt0c7QFFESzPCamz5nygIKNSSYb2xgZpjOeEClVSAVH7pLRrC6Ekyyp7ZJbikBWB4004lcDxh1puYwn0C3GdoXBjoC1qvOpOdPfauL+dOuu7ZWU+NWrBg3Oi5sx8afn+IBY8HVoKb6EIS8UpwMZxRiY6j4NqhokOAFQjCB5BKD2gsEgTuNhSpbCsFwnNBuBwUopxtCPVGpCSZAX9iX67iKyiXtrgGgIei6qLcPBRiw0KgDRc3rdSzg7STTlRG8UWLQo02agrfsTetaROo9i1JSjWEVG4pJOJzgIDjrY8AgkpO8V4+i6WAmADIYultFVQ4iRvikCt4dSONIJBvyRlpiGb7MiJqKlb/XQX7RcJtMBQGBTm5kMBQSPIojTMTCqHnl0pPUPkJ8itfoDFCwU6nQSMMdFUFTcE1d12iK+ZlAy/871nwE3wsC0wUURuClxXCczYlVn27bwwALc3LicTW11RXAzqiVqFIG/1AkbeiOgKViEhlB4EajiCNIZv+DqNBZLw/kkhFlCDzGRxwtJxtZyww8iGCqBgiUQJ8u/ptqb/PLZtTUk39qtu9dPpbN2FDOl4FYV0BxlGjAw21GvcdDIHw4I5pgYZKECiCAhRvk0J6CFxbhvspYNSFVI2bH9JaPXDxxXdHvx/lp5GiVEcDEPmAawfgri87GhpdB7onIpG/AulZqS8MVQFVNfMTHhh70t9+bVuFo3H0EygkaQQSGIpJ4izIvCIIKiFsA9l6NBJsAds81BeUCMGIwKA8UMg2lTvJzJp845vEt/4T0pSUoaH5+C4qO8GxGdAAgAhAZUfA2yeC16ckYxxYJyikcRcwdBUoKj/g1hCN5mEYpRxnB7n/gJ/YwwMWJpzkoLPwGfdWLisp8RsTAW2soqnlKoNVOqPcc4OY6pFwU9v90HSRiE0oGgAC7AgYKh3uFCCxgqFP3XRDfoXjDuA5QBVigucp2i7PU0+PT9RsWuzbKQFyC8eYHlD5QYY8mMc7IRCY15mO8b4AQpArNABGKQiO64whFCUcfA+AkRgejGPDi4c+0GuX+TiAG7CAtWeE6iLwPcHdLTuayh4bgEa8ddzz0rFwxHQ5O3RHgzWnumTSEIQLIZWfBKhIdYByQKMAkOUYyoAEpIUsZJSRC0BFE1Dv4TxBdFT7eEUcdBb95YAB/2jwF+PrNfsuO2f89dWGaZcw4a0heDbB07S8ysODLQGFMeAeB7kD+a4PKsOBkA/gBGp3B4E7BgIaC2A5Dwj2G8tXlFYPjxp13wGzNsj0bn9KSkooF+zXNCAMfD9hKLDD9x97bAAqiM2BFa8MfB/PX+xEycBuc78fG6qqjWcAwQgqGRECFWh7kMLJKn1DOOOZ6/EcMtObXatis0ZUIH70ZFU76PFhw+7f4d+nrNcFzJly/fvcS9wR2Fac4g2QTgLA7Rzkr0K6tgeGaqB3J4A3HSD5osAz9RR3BhqoaARYEjgQBB64DgcRxH62qVy9Z/Tox0L1x/qx5T/5BH0FV08GdAC4Da73eGrf7gCq4pVFdH0D4wCC0JMkAweCUD3PIHjoDaTnlMKS/GexLJN5iaW3FehRJZZ5WS7zGcMJMi52m+lOe/L/vtVp+k++U7XKUDTVc81uvh/9X/Gof7XZhnAnmaot5RMUas0P8C2x8B2Qr3gjhg4RPQyu7YOVSoGqEGBovJI3yZfcqRhnuEMQICLA6QQQCoUhmfJBY0U9q2rIZfBjf4qKNBDslwTlIoS72XSc8h1Nme6osil1qdVrKoMg9SUlAlKJ1JFQBLgvN6XlD0sT8W3CAoHuUYBUHNSWDMZpbIMBBSm9rMQMULGQbZnnASpYbYyBJdt+Zs24frGhx0dZyc1rNWqaOivsEeZtnxi1C0awbFmJr9GaPynEX2OqKnDPhkS8GmSYr+MOEA4Z6OHT6HVwd8BpUPR4FO0xC3I+RHgQT1SBrhuga7khwWM3DxlxhPeyKwAAEABJREFUf4N/rW7bGRy4OT8pdFzD9gg+A/Ht5Mkl8R3NZo8NoLS0xA0c61NVVf1IJNLKtfD6YUcjNpO6pGII3AEwUESlFrVModBQzzGDypQpQSzQAJCuthzTHG82ZT6DfcB4I0O53desWVe/TGnZqGRy0zpNNVQrTc8lou2Dw4bdW7gdcSMFpaV/XCtE8pKaqs0pPNSBTtG34G7kOy6GQAEQZJhllJ+A3AWkERDkOaP8iLEaYhEDfNcCJINU0msPfviOSy75Tz78SB+qskOA0Bil1FYU9uXOprnHBiAH0FX2aaK6skJVtJBw3FNlWXMHuQOgcssPelEBRDKMCg5bQSq5BKlEUqE4vuioCwIVkaDHlc0ag7kLblzaulUwrLxqZVkoFGKpZNCN8ei/rrzy4UhjbeqXz5lz45L2B+U95iZ9MFhO5ofmgDpg2UkAHiAIkMoPPgXJE3AXdzAPCBqA3A2S8TiEQxoqfxXkxXKA8cg5qRpycf1xfjR5H84CgeoPkNII/Xhn89orBqAEzucM6BYiFJ0YsS47G7Q51Hu+TlBBFCYAZAgklSijNJiXOAuyTqblzY88dEosQZbRJkxk3MTLX83N986vrNiwJhrO1bkfGlRTzu4eNarEaELzDMlK/s2fDY29jcbpJ2tqUIk5GoOKio+84+2VNFCChktR6QUemiVk+MbDcU44BOlkDUTDJhoLwbMEM8A1Lh815K5mGQplJrwHX+gOTsN18VUiqnUGX++sK6TdGcnO6z22aaPOSTnxVHCcEO4A+PZo581+UApVcYQqmGC+ADwLZCDziy+oUNm8xMLzQRqJBKlglKASobJxPAOAQOImzGLChGsXRyL8WjuV3qCxSIQGeSPc6qKHiovlTiBIcfF/zFqDaFhuy8aX2LqRvMh3E1vw3AsqVcHCt8VKQJFvApIvJnz0+gFQNGAJsDXv40sJjSpYJ0Ae3BnRQGd5hxOn9R3Dh9+VBz+ip7h4BtOYeQLxvEAjwUolWLfT33XeKwZQ+khJ0kklPoUAnLzC9r/pfv5/d/q/8/3Qcpc7ABEQSMXOKL4AVCY0Bo54K2A9ENTxuiB3Cpat34VJTJ5+zSIQqZt9x17nWl6U++YQg5tTh/Z9bCykzGftLQc/O7LfxPsvHjThpIaukn9x9KbPwyHvH76TqOSOB23yipA3yCi2NACBIRnuEJl8dkcAgQYh+UeDpVvPLkTS4RtqHoQ7aencq+FH9FBzy+F2KmjNCDjVlRs/GI+OY2fT2ysGIAeJhENLBPftjeu/JZqqnCvLmjtgGCOkkkuP+R1gGEERpDJJLIGgAmVB5iXIdkhDdmWOk2ddOpPz1P+ZhvYtBU1J1QRdiTDPF1w/3dRbnemk1NHJ6mDa52/k/bm4uARPvN/3XlJSwv3E1xMNPXiOgOvikQsySs8JoLOvDW/wTEJwVwAsIwGA5FMusOSVcDQGwZFlkQH8UnigXHH+ef88/ftRDuyUZ/t95K8Cp61UPByDpU2ZjZRPU+h2SmN7Fe8FvpXMy8uDdIr33WmDH5hAhkCAii6VBA0h4znrYunpMyBQkdCLZtJ1sPSkMkTatWkQNKVgUTqZXOmnBTfUUOC4qSqm8HcSqbL3NJ1WaarRWmHhSzTbuLx+35MXlcRVNf4vO131pUoDDGUo7gIceZc8ElR4kjEEikZABdZximWAIRzHt9YECCAtGgHNYMB2alsvSf89okdJDA7wBx0ExfBykMpMPRYxayy3/IOmTIk2hagpNNWrN6+DIPGl8ASEQ4Vn9Cj+R1FT2v2QNOj1WcYI6io2GkXGEDBUkEou00gHWZB5CVsNh+wq/4Eb/63w+UEq1QLPsdYbEesSRas4LxapGeKRLX8G6q4nguZaSXHJ6OJ/5tTvf3zp9e/riv2QSoIKz8L3AMgvenNUZorGwIBxBYHWAhoBE4Bp7IXjDoDzlLzLOeP1F85JgYje7lTG8v6NFAf0Z/Xq1odUV1rHqEyBdLLy67lT/7G5KROiTSFqCs0yfHGja04pLm7aTZEo4eGOTWn3Pc0PkEJ/nFEQqSQIUjmkp5eHRYmlosh4X6azkMkjrcSoeJjaRb456a5TrchOW0RR4ZopM29cOHnWrevGzbp+5fT5V4/ngfUkAE0YSrRNyuYN/jx/tOyrcSl7yzICjkvx1kfyBmgItfwTYKj4BMMhyaOsyxgyGjSGqGgkPshbLGnAAmmsuAe+xQYWn/uXAXAAP9WVdo/CvLYa9900Ic7Upk5lrxmAHDDtbH4OhV6DWxFoWl6zvmtWE4ZA5ZAAUnkkUFRnqURETgaNQypJRnkwLYMXKaxaIMAIlWEFh114RvcpCaVrnLaew7mi0FWFNF0vTiWiMCf6tpt23MAV6KHprxvqfsw7Yzwz6t/qeNXruXBASCPgHK9FsY2M/fGdAMuEPwTkHCiGPfKFGRFYiZCZHxoM4FkhrIXAoNH8iN72kZFd7/g5HKAPJZGRgKtSVbk5GTHV15s6DbmeTaXdKd2CKSUrfc/6XF7TcZ+dWnzBo+132ugHJCAA8lITpOLLnUAqv0xLY0BDBiLge+PgkMlTIICXihlQCQbi0PQn5VcoebFcRggxVCpCjqKz+q2rqhMRjUaAMZ0Ah1T9+mz+qTm3f8M0+2+C2KjGjhD4AkwaKaCxApZQ5Jf5BBS8WZUgDUCWSd7l3BTBMnXCc0G4AQhbbxPW2z9W//CdHa854/797ziccfWodDJBQmHy9aRJ129sKr+0qYRNphOpMa6d8ihRwwTUzk1ut58JvcBG9UXXmAkNUFsQZ5QHFUgaAUF+JJYCkoYglUtIGvScFEjGGAKOGaRr6mfyogfjfuCsZYpw0paVY1t8aN22o/rfl0v98HCdRdpTIVVUf61uff301Of/+lTS2vIMZZ4fcFswtGLJq0YZMLkDoMMHBLmLUeSd+QHwrZB9qed7NuDNCQiHAXGNc8yK2GgchyAcMB8SaEOFoAaFwCEiMX5XGKe7QtwUWp14SxhN1ygMl5lrlxSXbHud15Q+9gdNWEc/KdAJomLImF8glrGxBKkwEgvOM4qOevUdlmkpNAlsNxjVY8q8tFW9ORIxTFWN3n1+hwf/emnfR469oNM/TmNp5X+uFZyjKFQ4XvL9qGCf7WyIUD6Mrklt/kY3gQSBBWFTg2Q8keFXenuKB18ZBjGJ0d6ZECDnQLgACWEzVLubgQpBmmgmyblxVJd/HbezcZtLfQ+8wSLCHBgKmWYiVZ7w+Ppd+r/N5Dru1bmUll5b5nub55u6IlwXfuF9GWowjt2rg+5mZ6gYBOG7MIegkkiQIZCEjPJgWWYnEABZLOukp6V81wfWWn/8ZijHf5ooIum53CAQusaNq8/pSus56RR0102amw7Kvslrpd/24KJrnZ2NMHVeSXkkSm+xnaqEpgPE49VoBDrIXcB3A5Dzy8wDFV6mpSEwfIstjUCCZ9kQ4NtuU2MgHYEXF4eGeOwvozqU5O5s7OZQH9MLzlCVyCEV5ZuEofsvzJ79cMWu8LXXDUAOHg3DQ7ZVHc8J5+ZE1FYXyLLmBq5vEPSARCqyVIQsSIEoGOJkgSDjWcWXWCo/lUaBAGgUWL1LnzFjxniunbyb09Q/LS++kqpCYaqIWY4VMiOqxZX4ElWNXzlm1uXvNbXjic//3zwjDGNtpyYIhRQwNA3i1TUQ1gygeNOD84QM39IIkG9pCHIOsjzw0Yo5B4YTJTyAvGgBUM/opIvQyOLiYgbN+JE/QuI57BIe0DxFDarNcPDArrIr13tX2+yUfsqUm97hPLncc1zmuazL6NGPHbLTRvuZIIxnAFR6IZUBcSYsyGDUByqVpA7IQ2MWJP13EBBUm11nvHRZSXLioqv+Gy4SQ0CvuEqNpv5l5Fq3C61sBGPxi59Y+IeXsVeB0ORPmll3eTz1mu2muGWnID8nF5KJBMjQjvgABEM86eEBjaAWkHU8LEfMGODLN0jEKyES0iBeiQ7U4zGV5NySHz/xN9CMH4OrR2ta5HeWZTGmOR9Om/l/K3aV3X1iAJIJUxdjLSuVJGAcnEzS/rKsOYHGDAGBoFIpsiCVBVBRJEjvKA/FWWWXxkEwfs7mJcb8HnhIIsbPvObzp+bfOrndsTV3PD7n5vufnHf7i08uuq1sd+QkQyE9zP4YcLfcdW3g6NUVpgHyCHIu0qgBlV8agpyf5B9PQZBIpMB1fdB1HWwrBVE8Q0TkzuErB9G08dDIrveEd4effd2muHgGcz0x2PdIK0ppEi/MHtudMenuNGpKG8cpX6gysV4lWjTw2ICLLmpeb4ZTii1QwRWpFFLxJUglkSAVJqMkW3cBSSOBYF6CTGcggD0wgO+liK/xcd/5Pr+7qXHP/ulNRuFxhvGMY9vA5AYle0bDxbmCNAYqAND3g5yjBF0x8BZIBVMzwcXzACUcBIZCvuWBoeaeqXvKDdAMnzBffRj31e6ez3VCxTo1UT5vd9jcZwZQWlqSVDV7Ag9cVwX9dyKtd9gdBvdVG1ajqYA34LJ/KYQsyLw8F1AgILFA5ZFKkwWpNFL50VAwgABN0jcfIIIb1sNUS7/ESRp8vBXCOeI8cDb4PoDi1ajkH3kHgkoudwF51iE+QLIqAbkRPPfiDigNIWJEgTsAih/6y1XdHjphX81xd/t1XOhOmXIUrqJNqT2mdNkjyd3pi+5Oo6a20bRNk7hbsRLvmVUe5P7+iuGP5DW17b6m81XCXSF1GDASQK+HGs7R+xHEElBDQAKjKCI0AkAgAEDRq0olwnxAhC+wqFl9xr1w6wZX23ynGrU3+ZDCc7qH0xAgD8NS8RkHUDAUUmWIxH2gvo/nHw4hPQQB3hpBoIBCjIxrYD4Dw9cUq9KeemUH+bsLzWOq5w+8rS0R0ZEq1VTfL/smonuTd5czursNm9Ju/PiSTQD2+MD1vEQNP9XherPZBcyITlzfQicfcNT5WiVBdZZpBgSyIPMSMkqP3pHjlSF3PfAd10PAFtDsnnFL7lxcXr1hEmh+yuced9Hbe8hpgPbOUfnRliHAHUHubjhxnC06ABGAzNcFOWdGKKhCPdL14v8r6VCiQDN4Ajfai4nQMb4j0poaPDVx9s27dW6SU9mnBiAH0E0yh1C+JmxEQ1aS3D68113NYheI22VMD3OfEe5hKBBHhU8ohKYRXAQHwVIpsxFnAOultSTRGCoRyhGk7iTkHJsjRKJ5d1uB84HLeNpTSMJnrNpVtKSnGilX0VOeqqcCVU8TlaaZKiymCZsiEF1YeDWbpopIElXU4PVsIhyN+NFozuD1Guv+Q891WN+/t+Z+5Frf1Q3B6edMYzOQJzRv/N6Nzz43gPFTrv3aD9LTVY3Zjs1/A0xvHu8FnK9rPKP6OlevvMwyK6+xjYrrLKMccfnVll52jaVXXJfWyq+1a8uuccyKa71Q5Q1eqOZWP4wQrb5GhNOP7obM90uTMctuKmem9Xua41xBY6nf01zrGpKfvJLkJh2dYOoAABAASURBVK5gOckrITd1Bc1L/d43Ki53zcpLHbPyEscov9jTKi6y9QpMV1xqa1WXK7nO6ITYMspTkiM9LbVbcfbenLCXUK6KaK2ONDQjxag/acqsm9bsSf/73AAAiDAizrREvGyl8EFVoeimi4ofKIIf+Cn9tNR96q27nnz4rdsmPvL2Hyc89NatTz74xi3j/vv6zWNr4UbEN469/7WbHs+CLH/gzZsef/CtW8Y9/Nafxj3+2l0Lf+Bp7HD48S//5aPHl/xh0pil10x5dMmVk/73wtUTH0Z4cPFVEx5+YfTEB54bPfEhrH9o8Q1TJDz44k1T/7vsxukPLLth2n+X/WH6QwgPLLlu2thlf5r80Pxbpo+f/89lOxxwH1eO7HXfrxSef4mV4JrvWh9zbj29p0PuBwMAGDfpD19Q1ZoUiZpxKwmtt2xI3wGwp6y3tP+JSYC4SeVfkXBha4XRisCvGjft+au+3VMZ7BcDkEyGw87jtr1llcp0khc+dMjwrveeKMtboEUCTZHAJX0e7ye8cAc7bYmqmvUfe7Y9sSntdkaz3wzgydLbyhTDLQm4XeE5QD3HeLAY3+btjMGW+hYJ/KH/fbmb1lXfQwgz03ZFVW4hlJS+cYO1NySz3wxAMjt13q1zOFS/4vG4rzDzCCW55hpZ3gItEmhMAiUlJXR1WeqO3Nyc9rZX7Qmlev7ERTe81Bj9rpbvVwOQzKk51vWCVpUpWqAxJv44bNjVR8nyFmiRQEMS+Pi1VOdWrQvP93jSVPRUWVRP39wQ3e6W7XcDkL8ArprlNwit/AlOE5O5kzx3d5k/YNu1MN4kCYwePVo1wuzIsupVTzGz+hHNrL5kwpK7KprUuIlE+90AJF8znr1n4aS5t904Ze4dN06fNf4RWdYCLRKoLwH5uxOT5vzzodkv3v2Hqc/+7aqpz//rhfo0e5r/QQxgT5luad8igb0lgRYD2FuSbOnngJRAiwEckMvWwvTekkCLAewtSbb00yQJNDeiFgNobivSws9+lUCLAexXcbcM1twk0GIAzW1FWvjZrxJoMYD9Ku6WwZqbBFoMoLmtSAs/+1UC+9EA9uu8WgZrkUCTJNAUAyB1eqqbrlPctGTfvn2jPXqMOKhzcXFO01o0japr167hPgNHnNpv0OA+fQYN2u0fruvQoTjSteuAVh06jDLqjSznXQslJbS4uJhJ6NChgyIBsEz+1KIEbCfpEG3zaahsG4L9mTmjc+9DuvYZdm7Hrv1OyfC/54PL+REpEymDLN6Tbnv1Gp7Xu3dx+1GjtlsL6FZcnD9o8OU9Bwy46Nz+/UflNjTOkBGXnTx4xOgLzxtyWY+G+si2adQA+hRfem7vQRe/3XvQZa/2GHjJK30GX/5qr+LLXuk/7MqXewy6dGm/4suWDhh22fN9Bl8wv9/QkU8OHHHJ8F7Dhzf6C+/FqPSBCC3SQso3mqPK/xhCCi3Lxx5hFinK81z3v1zQma7Nh8lF2NUOu3cfeqiq8emCsDcVLfH/sn307Xtxu+69h7zQpdfgV3r0H/72gM/WLd9SGbxl89ibeuSgt83cn73V66NVb73y9pdvvfjaJ2/2Ou+SN87tNfzVjj2HLevYY9jSDt2Ll57bs/ilc7sMGIcy0HaVr31Br6lq56qaqgkcyFMA0QYVqKnjSmfWvdfwKT36jVq0qUrMf/2drxeUxZUFb3/w7aKzug5edG6P8xec22PYgi59LpjfqeeQuV17DB3TudvgQegIY42N0aNfv1+nrdTLHJQVW7ZY2/3IvOKyoysrK58SlD1OKTmsfj89elyjexxG2Y4/XtON++OeUlifJptv1AAIIYdyTk4WAk5XFe1M3wvOCDic4fv+WbqmdbA9twNhrIuq6b0CAaMoUSaYJPbpoMEXD84qT3YQiX3fVAzDzA98oWmq8Uv0sros3xuAyk9BoUwIoapMMWE3HtNEtjS1yAyH2imq8bNPPvkk8ydAfJaKaJp2mhkyT1cU5STXdU6IxKIn4lgnGaZ5PCH0BKQ/yQxHTgpHYyerqn5yJBI7zTTNUyLRyCmIT8B2x0ZjsSMcx9lrc96NKX7XBJWGIO8qUxUT59OoDnzXYAcJ4rCwakY7MEXrZoai3SnTuzNF7Za27K66GcY864ly6em4bi9VDfUCRb9MNczpRGUv9et30SkNdW0aUcOMhFurutZGEDhYKnRdOvnHrUOhiKYoGjpcvv16HwHAeaADJYDtcxk11Lrt66YbnTwhQmA3EIqEIJGML1YNdQIR/gRCvKd8zxoXMrVxqUTNWNtOTwVBlwtBkrbltmFaaPJ7H6+5oe4gMm3bZV5NTbyGc+7btr2lqCjlyfK9BQpTOFAF5F+3QQMUu9pvWbwcfO6mPc8tB+LHsX2AALbHU66bmu3YyWkIU2w3NdlykpOsdHxSKpWY6vPgdcuyIJ1O1qC85lbFy8d7fvoJz7PHp1M1T3quPUlwd2IyVbUoHo/vld9iknztCVTVVHMA4aNBBjk58q+e7n5vHEiQsNLEExw84b/qBM4jrrDvoyq5z3JS96Wd5H+qa6r/Ewrp9yZTNU+hnD5UVNXxOP8tJ/zR3r1HbveHk13XC4TgNY7tpVRV9Q4+2OH1OfQ5VyzHAcE4qV8n8xxoQIChIUBKDZA5aPhp1ACo8AlQD9JWtRXLDd07d+qjFy6a9eSF82Y8OWr+009eMnvq2Euee2bq6IVPTx5uivQ5juVcSindYNu2Ahzu6dt32LFQ51m0aFE8ZKiDCCfHGhG1c2lpaUbB6pDsdjIciQj0MIDjA3pbsTsdvbpk4Vc5YTaQBMFJKklfl+Xvxfml65+dP+v85+bNHP78/FkjliyYdf6LC2eOXPLs0yMXL5w2PODWOMECQPvbbHvx215aMOOSRTMnjH5h7pQrliyYcdVihBfmz7xmybNz71q2bJm/O7zt7TaarnHF0APEOF3Ukz0YIPB9oug0CMBLg3BnL5036apXFs644cV5k2547dkZN7z+wswbX3lu+o3Pzn7q5lcXz7pYj4XPragun2aGjWpO4DeqTs6rP7yp8I+1sHmuqSknBB6/U/5YdF0azgO0C9zAVJV4DUg0smmTQOcfUIqqKIhFqefWbV833agBcOJjHQfD0InrpneoVKgs1vxZTz7NA/4nRlU/8wcDNfW6ugPJ9Ny50zYsWDDxsznTn/pG5vcWBIFPwqYBuq4Co2h+6N52o2+B86hcuLB007x589JNbS+EzxWFgWFqBq2deVOb/mB0RsggLnpPz/XRAIwGPWhTmQuCgBAFA0GKGsMzK7/DpktmT6hAR/i3VDr5MWGgxuOJPng22iaMwXUInpn25LezZ0/4csGCKVX1OzTCOrMctDcIGtTLvLw83EAYpxRVWAgvCMztdpBsn0iRTW6LqcBTACHgew5oGtrTttUN5hTB56bSicrMwIR0xImxBgkbKJS//YP0poz3EGsSZBrPCkbXkSPDffteHJW3SBIkbd0uFMaoCAQRAfohx21QKHXo5W2FJm8GcIwm81en/TZJXdeJ53nCcZ0gFAqRbSp3ksHxzXN7F7fvW3z+EZ17Fx/Sv5EbjZ10AyeeOFrt0GdY4dld+x18bu/e7c/s1Qtj48Zb2SlHxXONEopElAD5r0uJPEU6derbum/foe369OkTqlvXUNrQNZJKpQI/8GxKRAP+ePtWVRvzNvqB+yFFx4Fnq7bJpNZojL59awDOOdUNlXIIKONiO+WuqqrijDJBEYAQzhhpXM8bGkCWEaagCaBnM0IBNGlaAHPmjK+ORKJf2uhdXN8rSmpaWPaVhX4Dh11+4YWXTxoxYtRd2TKJi4svaF+d8O8XWmxSKM+a6JDIxGpbm6jkWBOiRWQyJLzJtrAmCz1vMgvlTVmzruIpXKg6ymsDZYB+SIARCjc62T7DhhV27T3obmCRqVXJYLZQI73l+BKG4w1Wjz59bu1/3pAH+g4c3FGWNQXSjiNUTRcRMwrJZNP+cFqnTgMK+g258KIaT51oGOH5wIznIpG8BbZwp/cZOPy2Tr0Gbnez0RAvv+vUqaBD90Hn57dPjA08d7KimaUUwjMZ15/qMWDo37v1HtDg//UVMiOKxjBu8b3vZNWxe/Evz+k28PaNlf6EWFHbORYnsx2ITuncY/BlXbuO3GYd6/KSttKgaQYxNEO4liXq1jWWjka/FEiPnhm9FqUYz+jbtOtRXFzUr3jUv7r3HTHxvKGXdqjfj48K6fsu6rYAwQSpX19WdjQhFD8Uv4AQR2ncKX4ngPqdyJ4pUcG1fBIKRbcbZDv6rQUOSkHTFRSKJtREYpuJaTrrUlG5ZWg6nfhO8WQzIyc/Form9vIDGKjoZrFimINj+fmDBdDBPtCBTA33w8Xtw4H2SVteb6LoxXirlCvbSlAxFlSYQnwfReM6DfLap8/oEPXIbQV5BTcEhA6kTPtCA+Nl2V4CepVINFIwNPDhcgLsV9DEx9QilFKN+LiWphGjO2s2oHjkmWrYnO/Y8IDCQoNQ+Y92A3IQzvM3jh901UPRv+fE8pZ07j5gYI8ePfTG+uvUve+xBbFWs0KR6MNph18YyynsqmihU6hmnhKL5fRJpe0bVT00uVufAf8sLi7W6vajapog+DgeB4WCdvLZPYYQhT0dzcm9IRTJ6We7/qnRWOHvmGr2i8Ty/p0WyXGjR49u0EvTaEwoTAfH9iAayyV1x2kszVisANfxKIXoJODBl7qecOrS6jQUSzlWX7yXG+757i/r1sl04ASQk5Mjd16Z3Q6OPHIDzo4CfgGhILYjqFNA66S3TaJLJVSBcDjKbMtTtq1sOIeCNtEmfy0V0fO8srlz527jEnFPctFDB67vbzMu86tXJSqqzzMMtaPn2F0C3+tipa2uqNTdKKP98DAzqKh1wb1BEDiaospJra2qWou3Lt/z4QY+c30OVDXq7Ay19TKMYqZzA1P1qzFKZWkrVWLHQ7dOmfJonfjSBNcPPAclLgir/yKstqMGvrnPBSUKUJQXasIO5dSjR/E5VsqdGApFTkEnkRDc+z/q20enktUHBbZ1BGPqNZVVVR87nntoTn7e4wGYfRoYEs7t1vt3eMU4SwA5Gw03pOKVYiKZuNS1nNMC2+maTqb+rGv6x4SQI6Oh8NUpm/+zbj+4Psg2p+FwmABlFxcWFdyvUGJXVpb9hTHvjCBInVFTXX6j69rvuL4Xzs/LH7R6Y/IiaODhvk+E5zNNM1BP3G3WVZLXB7yho8yIdi/KLzxHCOFQIGNLS0vdunSOUwOGrnOmMUoYo3XrZJqi/abtNNbhhzEuyxoEbMkJgK5p+N0gBSBJwxUe9wC9AiRcF1jIZA1TbVtamdau1HSzPUejw5P6eKwVCN994ilH8anC9FB4G0UZP368PXPmuBXTxv9v2awpYxc/g7Cw9PEX5kx+5PkF08bOzdfIq1VlW04k3NU9O4ERI+m/rM6NSpBCn8508AUD3Lolr9tMOJzvXcwT8KsKAAAQAElEQVSB/pEoGnUd909RNbhr0aIHne8Yw4RLHWoHggaUEcd1VSxq0gcP3pwSPH+gvBjf/rou24l8qymA3aXq2qGOl/7YtqrPXTT7qb/Pnzn+q1cWlZYtmvPUN4vnTnoI++olRPC8F/h5RFXGyjei2T4klnE+08y7maYf7vmeZ8XjNyybP6XjywumPLFs0eQ3lyyc+gLePv0j1+BnQeA+lUgmPQaiHbb9TiaoeHIHwKubwNAV+gcnGZ+Xo/tnvL543oOLZk1+8/lnpr2O/fwHo5O+npf6zHHTAYrulrp9YDrz0XlAmCqYF9gURZd7Rt++0dO6Fed37lycI192ZTGmD8JzzplvvPvlA2ZE/28iWaMJ4T5KeGRZpqO6X7oOHAKCIHgD+q0AA1RsnzAW+JSKuk2zaUF86vEAOGr4jm40sDrbZFtMheACRaaZRoCHHHIiboEdOpRIxZWHSCbTEtDrM/RsRf0Gj/57NC/njpRtgcroZhpm/4V6T05OroqdMpcDr1fVaFYeVr8tL7uZENER3z0kUDkuf6Z08kfbNEB/bdtpUDQDCPv+VqOkpIR27TP0WlU3/hmJ5ShVFVUlGqT+U1q6rcep7ctgRMElVBQdqGg09Kil/f6bIGMUp0MI2k4jiyGpBVF7KaZ2Go7hgeA3PD9v5ueyvD4snl+6FreU64WADYqm5qbc+J/r0oRDRm/02qc7jgsE6L9eWjznQQD0OPhV94NztHw7cXUsL3LyvHmzhmLdd4qCd/IMdw7UDU6sVPzds0874fdI7yLNNp8X8NaOgv8QTlEG0a26DBqOr5i2IQGfuXj55cr+FLSEa5XA+CJs6p8r0fA33FDXhPJy12nR8CaukVX5+a1eysnNuwp3FT0nL3qNQdK3zZs3Zjv9JAmXOY6lopIQXG9E247JuTz4ElQl9Hmcb1f/Zbt2qLpYTWqnzFzJ/rZ9ZHONGgDHWUsiy7I0pip//FkimJNXtHJJ8bBRL8VTwcttD93yaiT/6zdD0dYf62HjE91Qb7OSKTNkaJUMeP9FkyfLl0myi+8glU5ATiwC3A2+K9tZYmPcHljYKv9KQbhfnUqUPLfwmakNtYmEooC8gu/ack5CKv8bKz65JhoK/V1lLF1VUXE3bxW6t6GFzvaXSlmKruvKdhLNEjSCpRGgDnKpBQ2RyNsUQcQIWed6zkJbWO/JdGOwqHTyp5aVmq9pGnpe9ULpZCStPBxyIXphOd7LkZU2T/5bljcG+O7FKZ006ev69cmaKl+hyJEIhKpod6CsGp8yU94AwgJKCKE+b1O/L4WFaUCwVlEFUOagEXAA6quq6iqMOYHgKdTGuKYbNZZjxysqK2vMcIx6AVxY5bBzcW5a/T71aBQMM0QwVAOM1Wq1uA4RZXgBBOh1cBzKpDHUqcwmhXxQz7a3jyxFBktlySTqfxGUNHbBGWOeZ9sn4Px7xqLhswPXPquwsOB0VLZTCKUnbti44SjTNOWfO9/gB+4c4fNT5uE2Wr8/mVcpC7Ad10M6kfmdQc+hI09hinqf4zs6xqOT83XlCWyznUB4Os1tJ+0ZmgJEBEqHUaOMN9/74rLcnJx7FYVG7FTyZcU37142fryN7Rv8+J5LI5Ewl0I3zfB2YzTYKFNIgQBDf0GAK43ZTiSEsjwcZQlCwBssFbHlAfdE3FVRARgqIJW4Q4cOCmJNYgL0DTzzpHVdL6yoSB4K+Fg16daUqb/BcrBsa9qrCxbUOcMgQRM/TFMEyosF3E851Nt2N63XBxWQxKIABYIbkzAxve3HtsH3OHUdnxEK/02n0uei5p7j2tbZvuucSURwFvfds0Tgn+b6/pmhiH7llvLNL3m+czKec6bGPXU0driNPjiuA4HvYxnFqu0/BE0RBPWA47Wrt309LAMQ0i6k8gs0P2j8aXiErfRCBDTwHFfV1Ek8CP4vkYzfqSrqP33P/XdYNx7UNO3L3NxcsD1fpNPJ/zu4QB82t/SJr7c23x7xABRUEoJqun3ltiU9h1xwJPf8J3SNtaKcvE6J9lf03tscfOu2cD2P4AOU0mhOmozWFfaw7zmKbaVAVdgxxPAPrkvfUNqxfVBUHeLxuGiofnfLXOLnoqxM13UF56K70K1/21S9L7Z2w33JtHf/W++8f3/a4/ebuUX3VbnkPiO3/X/D0chgz/MADZIb0ZzMD3NpphnDOcawL19R1Dd2lx9URhINh6gIAm76eJ+4g46QhGO14ASEr2CqgY9paoA7P00n4pVvL5n95Qvzp3z13NxJX0uQZ5wsPDfzqU/mTRs/RVfUkalk4qlEIh7VNPX/de0zaLubHlUx5Fo2MFptESquwJTA9ZYYk9t+SMAJ5z7wjM7tRggUQIBWVNs3WvL02dOf/PusGZNvnz594p+mT33qJtcqvx4X4jpgNIVDEz8QXSoqNOQLc5lPw19BEAhUBNZwbW3psGGjCwPHHR8yzKNFABs917l54awpO/yfQKKRCGDfoKrq6WgMd6KiAIb0T5i6WiYEP4oy/hf5k4u1IzT8raJndF0XNGW7XbnhBplSPKphCC6EyOQa+tJ1AMf3JH92KBw6VlG0/oYeHpyfX1isGuYQypRhTDVGRGK5F4SM0MhINHxBIh4/PRwOpw3DSKmmmunWdfCgCYJIHm3HcjKFu/ElDUv24XkuSSToDtci4AHBueGRUFBUiO1MgHNOfMfmrpPmKgOcKez0WTJ36uZoSH80GjY34prlUapcXLeRrungei64rofFFGHbD8mwJLgQhPuUbid4eQ3KUU7INwgZKW3bfJvc9r1vrUYFwgsJADwKMMZUDKZgmwe9cZCi9muE0Ol4RoBwLNqXRPgZ2xDVy2iqBo7jkECAHJfUq85ke/S4Rq+KVz6cEwqfJlzf1YlyxcKZ097OVDbyFQoVCMu2mKqqgAI9nDAawVusv8RrvBvSjv1gNCfGDTM0IMqiwxrpAuRCorSIpmmAIQJvjK5+OfoZVA6cEe66Pq5G/XqZj6dSSRSi0EzNTNTUjGUa7cldu5OVTnVjCuuC16JdUM86p63UubianVKO0z0nJ7dXOu30c9JON7eGfyb7CWm67eGDa4Mv3clBsmx3QFMNhjsI0XWTK4UqDrmDXvRMHa4VAeKz7YxFUwOiEA4qFRylv52BZFo38BUkq1YlqipXB4EHRsg8uaSkROpEhjKZSqHf45kdQAhKMoV1vlBWQqC8saLRdZIVQhDg2N73d+MaFOdEpQXJhfM8C8eqw8HW5Nxx4xJEJQ9ourEKt+qwahgP9BgxIra1ejuUtB1QVJ2aZoRhrPvdhOsQkmhu8jrdMAY7lgueE9zPvZr5WI/zxe9GPjJkURQ8JgQ+3gRpCYwfr01VbvrXokWT45SHHqyJ1yxAwzCB0b/2H35pg/8xh4p34jgHLofg6PYkbgpIOSEdQVlRRv2G5gRKOGwB8ArOOWiGEQniFZ88N3/2BwvnlL4/e/qkD0qnjH9//qxJ7y4onfLOvOnjly+a8dRrsyY/8drCmRPfenZ+6RtyHjgGKDqtpkxs4ag04ZDeU54jZPmuAiq+4vo+VRSFQDU05cnIBee4nR5QVnteQj+M1ahxTektQxMBTTepdDipVMpEA8iMIatM0xQ6vlmmlAJlGIrIwjrAMI3job/CWJpjcIb5up+qqqrMssgOkWGhOI0beYMLJjsTnOMYAaD9Uc6DRummj3vsA5cHDxCmuKqqH6Xy0J9l+4YAJ0sFzippW7wMX1fXp+nTf1g/LuB2N+Bgu84L7dqE/6+0CT81iv1iM/wICqjET2tBYlz2PYH88QxK2W2U0jVBwNugEv63ePTonPpjK+hWGGPACEUyHtSvbywviE8D7jHsX/U8V67NdqRVeXnplJV8XqEEmEJ6cSV3u+tEqPd06FB75Qx1nvxweB0eOJfifIFQ1tVmxlF1qpucDAJBTCNCUMwMcmGHj+AqAULQGXIcUpD6xOm0FRBFRzVU8Cjc4PTrN8nkhQFHoMzaM6aCqijrMoVbvwTgq150QoQQwfDiZGvxd4hT/Me5HEzxQUj8XV1t4iBcSUCecQcAGlT7cV5bvv033b6otoQyYJ7niSDweTQU2m7itVS137izT9F1fblt20AovaZ4xOhjamu2/Q44EN/3wTB0CrAM6j59Bo44mejqQw7nEaYqqyAUHTpmzBivLk1jacaYSFsOOn4ffB4kTjzxRLsu7ezpEz+uqa65wxc8jW7q9FRl6jbcgbYRHA8UItcZ2/k4aY64SR+GjVRKwfMcBT1Xg3J6B+dRkBMahzdZm/BkdrAg3nXyarSxAboNGNZdz/lkeY/e/e+pSzN+/HhbV+l0Ivi3kbAZUagyttOAAQV1aeqmu/QcOLJT9z7Le/QvvgLLv+NNxUNJTU1Czhdy8R/s4NGxjhICCqEEpFrBtk84EhEcMPJRNE718LaVjeR6DBxxkOWJ21TdbIc6ZlFCxjVAKnRFEY2tBeobwYf5PrD6bQ2jnEYiEXTcHDzHEUWt2jS6nqiI9ZvX5hVd9TTGiI4uS6B915Y2/D3xf/duoYL/BcnjSG4qOpszcuTIBqWBTAP3fJr10LLH4pGjD/EY3G/7XnsfBK9OJ0dTiLOuI0e26oMHYrnI3YovyR8w4IKCvsMubd136NB2ffqM/u4nFR2miGg0KmKxGAS+62Pf283LjOXNUVV1LlCMWDnckvLhXDn2d4ArrTLgCgUlGg1lXvZBEx7bsojr2YB9k6qqZK2SNdAuXVPzKWHikSAIqgzdHOHR8MNSEU4rLjY7dOignIhXoqd165bfa9CICyPh0JMKY78ljGWuP+t2d9JxR78OQox1XTeZk5NzgsH1Zeec2wejoRExaVQSuvQd2u6sLgP+puqhfyuaeZLw4QYMTaPZfrAtxbZCZQoqRnW2uEFspdOqgEDBhzgpu/Y0XofSYqpvuz5Gq8gV1dp16DXkNx17Dznu7B6Djj+rW+8Tzu1d/LuOPfudgnM9tdt5F/Trdt6FdxPNeD4cK+hteYGH4c+rJvW++5ks2TUe/OU6ekA4eNzfLvyllNupVBzLeSszbIzsgAY18PzRbbFtRv62Xchd7selrhmmedTmDRtPLi6+MoJOz0SabT7bKUq21kqmhefJq1Yu3+9sN/EsXRZPffx+3JrZdBQU4NZ2mO3DLdm6LEbvS33HAR54yHy2FCBux88xQ/rpiqZCIHyaX1g4iyqhleCSb4DyL8PRws90g3xGYvpnqgEfGWb0A4ikbs/2oKuKgqcdVWBsXJCXJ9AAgmxdFs+e8HCFBvz2wHVWR8JhyM/NnyANKlufufchgEYleOB6vCmhl2wby40pnPvAfc/PycHmsrABkC+lqKE9xBhMIURYkUh4FHryFa2JOd/Iaf1o+7g97qDWh7whQDyeSsTb4A3EsrBGr67fVUlJCRdO4t+pePV/U4nkGvSER0XzYlPNHOMdh4QXOiz2YiQWfT83N+cvuqnn43q8q5vawEV1G2iL2wAABd5JREFUXky6dpprChOeYwPuA6z+GHXzeXl5XASceniFm5cXyyhY3XqZxtsqUHHxCFUuUYzwy5ywl41w5BUzWvCmqofeyMlv+2YA7I1wJDpHAL2FEHakpmnVrm0/W1RYeCnKWr5rkF1lAI0Od1PkkAAxNVXNFNb5Ugxlo6Zr5bjzM+76l+UaxttOsvrT4cNHZX76tbT0PosJ9mIoFLIE93EzMGekvMoPPa48VaebTJJmvhv4wgGq8CZiI3q2bw1TSzRAUr9ICC8oUQi8C8CTuqaNGDVqVJu6ROGQUZGbE61WBd+wbXm4Ek1+k6qQ8lg0vJER4UXDEScWDqV1VbF0hdmaQi0EW2OKw6jw0UOSbB+Kn3AURjdEwqGNrp3aiEryXV2WRuLSSU98bZj6db7nrnVtK0dRnKtkuQQ/sNKM8PXoy9ZyEJWyrCmQxMtsXVfXAAlWun6wQzktmDKlyqTiLxTELYnqmlcL8/JDqqadi+0vRWd3PhFwaNg0PiOU3K0KdTgqxqaGeJg3b15aOMn/ZyjsOsez5uCuW82Ff0huXu45OTnRU3gQxJhCVzqONVZVg8H1f3QkFjWrUtVVa3C+X4V8Hw/oDY1SW+Ykkg4a40rKYGVNVcV2/zsLq6zxcNdc66bj30Dgrgqb+nqV0XWGpm/CHWa9qrBvMYxZlxMJr4lXVnytK/RtKvh0q7rqcjUMF5ROHLO2dqTvv3MMw3Ida6OiKGsoI1Xf19SmmOetU1TlH4HnrKLA/ZBp5pu6hpGUp9ZSAODW8qZjJfEqXavAOjU/L6d1OKSZ2fosbtwAYsaLyaqabm7aGehSvsNX99nOpo17aIOTTg5ViXauZoQG4Va7zV214PyOwLE7hHTj4mwbiU3ffoX60JOJoBvhXk8nleqUTia6CN/rTiDo5dRU9xOWPcB1Uv2J5/d3Xd5HccRjsq2EX/7yl2We715LuNs1APcpNAAuyxuCynVfLcyJhnv6jnOOpilPZ2nyTBMNj1wpKOkXov68bPnOsC78uTh2D879i8MKX70zelTqmtkzJo8L5ZuDqqri/dNW8hLN0G5xHO+qdDp5XkVF5QCrasv/zZo1aeOO+sJdzp/99OT5LLAvxjPhMNdJX5pMxq+zrNTVtmuNINzrvbkgcu2c6dO/qd8PbsMLwobaXzXpJdKY6tfXzYfDbF1Ag2LuukNoxHinbp1ML1kyu8KLl5+flxsaobJgRDJRPsRkbHBgWf19P91bgNfbS6d7phPJ3lEz0jcI4v0Sm/xLnpszacaiOruS7CsLv/jFLzZElNClKTvR2wrcpdnyLEYZujUbV01UdaMfOr4LK7ZsuQAdb7/KysoPv6d5ojJHdW/201b/mqrq8x0rNdi107dm67O4UQMoHTOmZuEzkz+aOXXsJ3PGj99xoJjtDfHMKeO/Gj/2v8vHPfbgB1PQ42HRd5/SiY+vmj5p3AdTp47//LtCTEyePDk+c9qE92ZNmvRu6fjx7y8snfL+XMzPnPDEe6Xjx74/d+a097L1U556/J2ZE8etKC2duAqbZj5S4edMG7964hP/+3je1KnlmcJGvpYtW+Y/NfbhT2bNmr4cx/00SyYP3JL3eVOf+gQF3OQdYM6cOdULpk//bF5p6Sps52b72xmePXHilnmzJ764YOa0caUTxt3z7DNTH5k/c+q8FxfN+UbyuLP22fq5c+cmZpdOeAOvVCcunDnlgfkzJj783MypM/Hg/9k7ePjO0tXFkueZM6d8JXmuW95QuhRv4Z6fOfPzRc+Ufrq4tLSmIZoX5s/86pnJT376/Mypny9Bunn4xnfB7IkfIx+fLMALCKlHMj97+uOfLSwt3bRs2fhtLinq9ynXc/r0p77BtfxE7pr162VeyuiZyWM+mjN13Izn5s2YMW3apGUyzJR1WZg4cWKqdOqYV5GfmaXTJi3AuXy33lmaRg0gS9CCWySwKxI40GhbDOBAW7EWfveqBFoMYK+Ks6WzA00CLQZwoK1YC797VQL/HwAA//+VKo0SAAAABklEQVQDACx59QkXsYVrAAAAAElFTkSuQmCC\",\"companyPhone\":\"082112568864\",\"companyAddress\":\"Kantor Layanan Rancamaya - Bogor Selatan\",\"customerIdPrefix\":\"177011\",\"apiKey\":\"451565ee-9718-4dc9-ae52-bf05d40446a6\",\"timezone\":\"Asia/Jakarta\",\"odpLineColor\":\"#1a50bc\"},\"otp\":{\"enabled\":false,\"whatsappTemplate\":\"Your OTP code for ISP Billing Pro is: {{otpCode}}. This code expires in 5 minutes.\"},\"whatsapp\":{\"invoiceCreated\":\"Yth. Bapak/Ibu {{customerName}} (ID: {{customerId}}),\\n\\nTagihan internet Anda untuk layanan *{{packageName}}* periode *{{billingPeriod}}* dengan invoice #{{invoiceId}} telah dibuat sebesar {{amount}}.\\n\\nJatuh tempo pada: {{dueDate}}.\\n\\nSilakan lakukan pembayaran melalui link berikut:\\n{{paymentLink}}\\n\\nTerima kasih.\",\"invoiceReminder\":\"Yth. Bapak/Ibu {{customerName}} (ID: {{customerId}}),\\n\\nIni adalah pengingat bahwa tagihan internet Anda untuk layanan *{{packageName}}* periode *{{billingPeriod}}* (invoice #{{invoiceId}}) sebesar {{amount}} akan jatuh tempo besok, {{dueDate}}.\\n\\nUntuk menghindari gangguan layanan, mohon segera lakukan pembayaran melalui link berikut:\\n{{paymentLink}}\\n\\nTerima kasih.\",\"paymentSuccess\":\"Salam, Kak *{{customerName}}* \\n\\nPembayaran Invoice dengan rincian :\\nNama : *{{customerName}}* \\nId Pelanggan : {{customerId}}\\nLayanan : *{{packageName}}*\\nPeriode : {{billingPeriod}}\\nInvoice : #{{invoiceId}} \\nTotal : *{{amount}}* \\nStatus : *PAID | LUNAS*\\nMetode : *{{paymentMethod}}*\\n\\nTerimakasih sudah menggunakan layanan kami, \\nSelamat menikmati koneksi internet tanpa batas!\\n\\nSalam Rizkitech By Lintas Jaringan Nusantara\",\"suspensionWarning\":\"PERINGATAN PENANGGUHAN LAYANAN\\n\\nYth. Bapak/Ibu {{customerName}} (ID: {{customerId}}),\\n\\nTagihan Anda untuk layanan *{{packageName}}* periode *{{billingPeriod}}* (invoice #{{invoiceId}}) sebesar {{amount}} telah melewati jatuh tempo pada {{dueDate}}.\\n\\nLayanan internet Anda akan ditangguhkan (diisolir) besok jika pembayaran belum kami terima. Mohon segera selesaikan pembayaran Anda untuk menghindari pemutusan.\\n\\nTerima kasih atas perhatiannya.\",\"adminPhoneNumber\":\"6282214165522\",\"newComplaintNotification\":\"KELUHAN BARU DITERIMA\\n\\nPelanggan: {{customerName}}\\nID Pelanggan: {{customerId}}\\nNo. HP: {{customerPhone}}\\nPaket: {{packageName}}\\nJenis Keluhan: {{complaintType}}\\n\\nDeskripsi:\\n{{description}}\",\"accountSuspended\":\"LAYANAN DIISOLIR\\n\\nYth. Bapak/Ibu {{customerName}} (ID: {{customerId}}),\\n\\nLayanan internet Anda untuk paket *{{packageName}}* telah kami isolir karena tagihan yang telah melewati batas waktu pembayaran atau perubahan status manual oleh admin.\\n\\nMohon segera selesaikan pembayaran Anda atau hubungi admin untuk mengaktifkan kembali layanan.\\n\\nTerima kasih.\",\"accountReactivated\":\"LAYANAN DIAKTIFKAN KEMBALI\\n\\nYth. Bapak/Ibu {{customerName}} (ID: {{customerId}}),\\n\\nLayanan internet Anda untuk paket *{{packageName}}* telah berhasil diaktifkan kembali.\\n\\nSelamat menikmati koneksi internet tanpa batas!\",\"accountDeactivated\":\"LAYANAN DINONAKTIFKAN\\n\\nYth. Bapak/Ibu {{customerName}} (ID: {{customerId}}),\\n\\nDengan ini kami informasikan bahwa status layanan internet Anda telah diubah menjadi TIDAK AKTIF oleh administrator.\\n\\nUntuk informasi lebih lanjut, silakan hubungi layanan pelanggan kami.\\n\\nTerima kasih.\",\"resellerBalanceAdded\":\"Saldo Anda telah ditambahkan sebesar {{amountAdded}}. Saldo Anda sekarang adalah {{newBalance}}. Terima kasih.\",\"technicianTaskAssignment\":\"TUGAS BARU DITERIMA\\n\\nHalo {{technicianName}},\\n\\nAnda telah ditugaskan untuk menangani keluhan baru:\\n\\nTiket: #{{ticketId}}\\nPelanggan: {{customerName}}\\nAlamat: {{customerAddress}}\\nKeluhan: {{complaintType}}\\n\\nDeskripsi:\\n\\\"{{complaintDescription}}\\\"\\n\\nSilakan periksa dasbor teknisi Anda untuk detail lebih lanjut dan untuk memulai tugas. Terima kasih.\",\"packageChanged\":\"PERUBAHAN PAKET BERHASIL\\n\\nYth. Bapak/Ibu {{customerName}},\\n\\nSesuai permintaan Anda, paket internet Anda telah berhasil diubah ke *{{newPackageName}}*.\\n\\nPerubahan ini aktif mulai hari ini dan tagihan Anda berikutnya akan disesuaikan dengan harga paket baru.\\n\\nTerima kasih.\",\"chatbotEnabled\":true,\"affiliateTopupSuccess\":\"\"},\"acs\":{\"apiUrl\":\"http://aksester.us:7557\",\"username\":\"Adminacs\",\"password\":\"Admincms*\"}}');

-- --------------------------------------------------------

--
-- Struktur dari tabel `system_flags`
--

CREATE TABLE `system_flags` (
  `flag` varchar(50) NOT NULL,
  `date_value` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `system_flags`
--

INSERT INTO `system_flags` (`flag`, `date_value`, `created_at`) VALUES
('daily_overdue_check', '2025-11-18', '2025-11-18 02:02:37'),
('daily_overdue_check', '2025-11-21', '2025-11-21 09:36:20'),
('daily_reminders', '2025-11-18', '2025-11-18 02:02:37'),
('daily_reminders', '2025-11-21', '2025-11-21 09:36:20'),
('daily_suspension_check', '2025-11-18', '2025-11-18 02:02:38'),
('daily_suspension_check', '2025-11-21', '2025-11-21 09:36:20'),
('fixed_gen', '2025-11-21', '2025-11-21 09:36:19'),
('hotspot_expire_check', '2025-11-17', '2025-11-17 06:52:45'),
('hotspot_expire_check', '2025-11-18', '2025-11-18 01:03:37'),
('hotspot_expire_check', '2025-11-21', '2025-11-21 01:10:03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `topup_requests`
--

CREATE TABLE `topup_requests` (
  `id` varchar(255) NOT NULL,
  `customer_id` varchar(255) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `status` enum('pending','paid','failed') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `paid_at` timestamp NULL DEFAULT NULL,
  `tripay_reference` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  `balance` decimal(15,2) DEFAULT 0.00,
  `phone` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `balance`, `phone`) VALUES
('user-demo-1763358793608', 'demo', '$2a$10$ASNjUzLH16bBn60Y6FCtDuTX3gTS9xrBUH.unHqSURc8Cs24lWtLi', 'admin', 0.00, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `whatsapp_logs`
--

CREATE TABLE `whatsapp_logs` (
  `id` int(11) NOT NULL,
  `recipient_number` varchar(50) NOT NULL,
  `customer_id` varchar(255) DEFAULT NULL,
  `message_body` text NOT NULL,
  `status` varchar(20) NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `error_message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `whatsapp_logs`
--

INSERT INTO `whatsapp_logs` (`id`, `recipient_number`, `customer_id`, `message_body`, `status`, `type`, `error_message`, `created_at`) VALUES
(1, '082214165522', '31089019313', 'Your OTP code for ISP Billing Pro is: 686928. This code expires in 5 minutes.', 'failed', 'OTP Login', 'WhatsApp service is not connected.', '2025-11-21 04:16:08');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `acs_devices`
--
ALTER TABLE `acs_devices`
  ADD PRIMARY KEY (`serialNumber`);

--
-- Indeks untuk tabel `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_complaints_customerId` (`customerId`),
  ADD KEY `idx_complaints_assignedTo` (`assignedTo`);

--
-- Indeks untuk tabel `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone` (`phone`),
  ADD KEY `idx_customers_packageId` (`packageId`);

--
-- Indeks untuk tabel `customer_commissions`
--
ALTER TABLE `customer_commissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_customer_commissions_customer_id` (`customer_id`),
  ADD KEY `idx_customer_commissions_voucher_id` (`voucher_id`),
  ADD KEY `idx_customer_commissions_applied_to_invoice_id` (`applied_to_invoice_id`);

--
-- Indeks untuk tabel `hotspot_profiles`
--
ALTER TABLE `hotspot_profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `hotspot_users`
--
ALTER TABLE `hotspot_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeks untuk tabel `hotspot_vouchers`
--
ALTER TABLE `hotspot_vouchers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `idx_hotspot_vouchers_sold_by_user_id` (`sold_by_user_id`),
  ADD KEY `idx_hotspot_vouchers_sold_by_customer_id` (`sold_by_customer_id`);

--
-- Indeks untuk tabel `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_invoices_customerId` (`customerId`);

--
-- Indeks untuk tabel `odcs`
--
ALTER TABLE `odcs`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `odps`
--
ALTER TABLE `odps`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeks untuk tabel `package_changes`
--
ALTER TABLE `package_changes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_pending_customer` (`customer_id`,`status`),
  ADD KEY `idx_package_changes_customer_id` (`customer_id`),
  ADD KEY `idx_package_changes_new_package_id` (`new_package_id`);

--
-- Indeks untuk tabel `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_payments_customerId` (`customerId`),
  ADD KEY `idx_payments_sold_by_user_id` (`sold_by_user_id`);

--
-- Indeks untuk tabel `pppoe_profiles`
--
ALTER TABLE `pppoe_profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pppoe_users`
--
ALTER TABLE `pppoe_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeks untuk tabel `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`settings_key`);

--
-- Indeks untuk tabel `system_flags`
--
ALTER TABLE `system_flags`
  ADD PRIMARY KEY (`flag`,`date_value`);

--
-- Indeks untuk tabel `topup_requests`
--
ALTER TABLE `topup_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_topup_requests_customer_id` (`customer_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeks untuk tabel `whatsapp_logs`
--
ALTER TABLE `whatsapp_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_whatsapp_logs_customer_id` (`customer_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admin_notifications`
--
ALTER TABLE `admin_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `customer_commissions`
--
ALTER TABLE `customer_commissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `hotspot_vouchers`
--
ALTER TABLE `hotspot_vouchers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `packages`
--
ALTER TABLE `packages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `package_changes`
--
ALTER TABLE `package_changes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `whatsapp_logs`
--
ALTER TABLE `whatsapp_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `fk_complaints_assignedTo` FOREIGN KEY (`assignedTo`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_complaints_customerId` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `fk_customers_packageId` FOREIGN KEY (`packageId`) REFERENCES `packages` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `customer_commissions`
--
ALTER TABLE `customer_commissions`
  ADD CONSTRAINT `fk_customer_commissions_applied_to_invoice_id` FOREIGN KEY (`applied_to_invoice_id`) REFERENCES `invoices` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_customer_commissions_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_customer_commissions_voucher_id` FOREIGN KEY (`voucher_id`) REFERENCES `hotspot_vouchers` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `hotspot_vouchers`
--
ALTER TABLE `hotspot_vouchers`
  ADD CONSTRAINT `fk_hotspot_vouchers_sold_by_customer_id` FOREIGN KEY (`sold_by_customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_hotspot_vouchers_sold_by_user_id` FOREIGN KEY (`sold_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `fk_invoices_customerId` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `package_changes`
--
ALTER TABLE `package_changes`
  ADD CONSTRAINT `fk_package_changes_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_package_changes_new_package_id` FOREIGN KEY (`new_package_id`) REFERENCES `packages` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_customerId` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_payments_sold_by_user_id` FOREIGN KEY (`sold_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `topup_requests`
--
ALTER TABLE `topup_requests`
  ADD CONSTRAINT `fk_topup_requests_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `whatsapp_logs`
--
ALTER TABLE `whatsapp_logs`
  ADD CONSTRAINT `fk_whatsapp_logs_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
