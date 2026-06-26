-- ==========================================================================================
-- Skrip Setup Database untuk ISP Billing Management System
-- Versi: 1.1 (Kompatibilitas Ditingkatkan)
--
-- Petunjuk:
-- 1. Buat database baru di MySQL (contoh: CREATE DATABASE rizkitechbill;).
-- 2. Pilih database tersebut (contoh: USE rizkitechbill;).
-- 3. Jalankan seluruh skrip di bawah ini.
-- ==========================================================================================


-- ----------------------------
-- Tabel: users (Untuk login admin)
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_unique` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data Awal untuk users
INSERT INTO `users` VALUES ('user-001', 'admin', 'password123');


-- ----------------------------
-- Tabel: settings (Konfigurasi aplikasi)
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `settings_key` varchar(255) NOT NULL,
  `settings_value` json NOT NULL,
  PRIMARY KEY (`settings_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data Awal untuk settings
INSERT INTO `settings` VALUES ('main', JSON_OBJECT('app', JSON_OBJECT('appName', 'RIZKITECH PRO', 'baseUrl', 'http://localhost:5173', 'odpLineColor', '#f97316'), 'billing', JSON_OBJECT('dueDays', 9, 'taxRate', 11, 'generationDay', 1, 'suspensionDays', 3, 'suspensionProfileName', 'ISOLIRNA', 'whatsappNotificationsEnabled', true), 'mikrotik', JSON_OBJECT('host', '103.155.199.106', 'user', 'app', 'port', 8989, 'password', 'app'), 'tripay', JSON_OBJECT('apiKey', 'DEV-dHWvVJlasfgVbtLXE27DgetIm934Cp8UMgxVMc0k', 'enabledMethods', JSON_ARRAY('QRIS', 'BCAVA', 'BNIVA', 'ALFAMART'), 'merchantCode', 'T29940', 'privateKey', 'OMlfN-NA757-zsXAJ-MDmPH-yOzns', 'sandboxMode', true), 'whatsapp', JSON_OBJECT('invoiceCreated', 'Yth. Bapak/Ibu {{customerName}} (ID: {{customerId}}),\n\nTagihan internet Anda untuk invoice #{{invoiceId}} telah dibuat sebesar {{amount}}.\n\nJatuh tempo pada: {{dueDate}}.\n\nSilakan lakukan pembayaran melalui link berikut:\n{{paymentLink}}\n\nTerima kasih.', 'paymentSuccess', 'Terima kasih, Bapak/Ibu {{customerName}} (ID: {{customerId}}).\n\nPembayaran Anda untuk invoice #{{invoiceId}} sebesar {{amount}} telah kami terima.\n\nLayanan internet Anda telah diperpanjang. Selamat menikmati koneksi internet tanpa batas!', 'invoiceReminder', 'Yth. Bapak/Ibu {{customerName}} (ID: {{customerId}}),\n\nIni adalah pengingat bahwa tagihan internet Anda untuk invoice #{{invoiceId}} sebesar {{amount}} akan jatuh tempo besok, {{dueDate}}.\n\nUntuk menghindari gangguan layanan, mohon segera lakukan pembayaran melalui link berikut:\n{{paymentLink}}\n\nTerima kasih.', 'adminPhoneNumber', '6282214165522', 'suspensionWarning', 'PERINGATAN PENANGGUHAN LAYANAN\n\nYth. Bapak/Ibu {{customerName}} (ID: {{customerId}}),\n\nTagihan Anda untuk invoice #{{invoiceId}} sebesar {{amount}} telah melewati jatuh tempo pada {{dueDate}}.\n\nLayanan internet Anda akan ditangguhkan (diisolir) besok jika pembayaran belum kami terima. Mohon segera selesaikan pembayaran Anda untuk menghindari pemutusan.\n\nTerima kasih atas perhatiannya.', 'newComplaintNotification', 'KELUHAN BARU DITERIMA\n\nPelanggan: {{customerName}}\nID Pelanggan: {{customerId}}\nNo. HP: {{customerPhone}}\nJenis Keluhan: {{complaintType}}\n\nDeskripsi:\n{{description}}')));


-- ----------------------------
-- Tabel: packages (Paket internet)
-- ----------------------------
DROP TABLE IF EXISTS `packages`;
CREATE TABLE `packages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `speed` int NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `pppoeProfile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data Awal untuk packages
INSERT INTO `packages` VALUES (1, 'Basic 30', 30, 29990, 'Basic 30'), (2, 'Standard 50', 50, 49990, 'Standard 50'), (3, 'Premium 100', 100, 79990, 'Premium 100'), (4, 'Ultimate 250', 250, 99990, 'Ultimate 250');


-- ----------------------------
-- Tabel: odps (Optical Distribution Point)
-- ----------------------------
DROP TABLE IF EXISTS `odps`;
CREATE TABLE `odps` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text,
  `location` json DEFAULT NULL,
  `parentId` varchar(255) DEFAULT NULL,
  `lineColor` varchar(50) DEFAULT NULL,
  `powerInput` decimal(5,2) DEFAULT NULL,
  `powerOutput` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data Awal untuk odps
INSERT INTO `odps` VALUES ('ODP-001', 'ODP-JLN-MAWAR-01', 'Near 150 Maple St, Springfield', JSON_OBJECT('lat', 34.055, 'lng', -118.245), null, '#3b82f6', -19.50, -20.10), ('ODP-002', 'ODP-OAK-AVENUE-05', 'Corner of Oak Ave, Shelbyville', JSON_OBJECT('lat', 39.95, 'lng', -75.16), 'ODP-001', '#f97316', -20.20, -21.80), ('ODP-003', 'ODP-WONDER-RD-12', 'Pole A-102, Wonder Rd, Themyscira', JSON_OBJECT('lat', 38.8925, 'lng', -77.0352), 'ODP-002', '#22c55e', -22.00, null);


-- ----------------------------
-- Tabel: customers (Pelanggan)
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `packageId` int NOT NULL,
  `status` varchar(50) NOT NULL,
  `location` json DEFAULT NULL,
  `odpId` varchar(255) DEFAULT NULL,
  `pppoeUsername` varchar(255) DEFAULT NULL,
  `activeDate` datetime DEFAULT NULL,
  `nextBillingStart` date DEFAULT NULL,
  `previousPppoeProfile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data Awal untuk customers
INSERT INTO `customers` VALUES ('CUST-001', 'Alice Johnson', '123 Elm St, Springfield', '081234567890', 'alice.j@example.com', 2, 'Active', JSON_OBJECT('lat', 34.0522, 'lng', -118.2437), 'ODP-001', 'alice001', '2024-05-20 10:00:00', NULL, null), ('CUST-002', 'Bob Smith', '456 Oak Ave, Shelbyville', '081234567891', 'bob.s@example.com', 1, 'Suspended', JSON_OBJECT('lat', 39.9526, 'lng', -75.1652), 'ODP-002', 'bob002', '2024-06-15 14:30:00', NULL, 'Basic 30'), ('CUST-003', 'Charlie Brown', '789 Pine Ln, Metropolis', '081234567892', 'charlie.b@example.com', 3, 'Inactive', JSON_OBJECT('lat', 40.7128, 'lng', -74.006), 'ODP-002', 'charlie003', '2024-01-10 09:00:00', NULL, null), ('CUST-004', 'Diana Prince', '123 Wonder Rd, Themyscira', '081234567893', 'diana.p@example.com', 4, 'Active', JSON_OBJECT('lat', 38.8977, 'lng', -77.0365), 'ODP-003', 'diana004', '2024-07-01 11:00:00', NULL, null);


-- ----------------------------
-- Tabel: invoices
-- ----------------------------
DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices` (
  `id` varchar(255) NOT NULL,
  `customerId` varchar(255) NOT NULL,
  `issueDate` date NOT NULL,
  `dueDate` date NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `status` varchar(50) NOT NULL,
  `notes` text,
  `billingPeriodStart` date DEFAULT NULL,
  `billingPeriodEnd` date DEFAULT NULL,
  `tripayReference` varchar(255) DEFAULT NULL,
  `paymentUrl` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data Awal untuk invoices
INSERT INTO `invoices` VALUES ('INV-001', 'CUST-001', '2024-07-01', '2024-07-10', 55489, 'Paid', 'Monthly service for July', '2024-07-01', '2024-07-31', null, null), ('INV-002', 'CUST-002', '2024-07-01', '2024-07-10', 33289, 'Overdue', 'Monthly service for July', '2024-07-01', '2024-07-31', null, null), ('INV-003', 'CUST-004', '2024-07-01', '2024-07-10', 110989, 'Unpaid', 'Monthly service for July', '2024-07-01', '2024-07-31', null, null), ('INV-004', 'CUST-001', '2024-06-01', '2024-06-10', 55489, 'Paid', 'Monthly service for June', '2024-06-01', '2024-06-30', null, null);


-- ----------------------------
-- Tabel: payments
-- ----------------------------
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `id` varchar(255) NOT NULL,
  `invoiceId` varchar(255) NOT NULL,
  `customerId` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `method` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data Awal untuk payments
INSERT INTO `payments` VALUES ('PAY-001', 'INV-001', 'CUST-001', '2024-07-05 10:00:00', 55489, 'Bank Transfer'), ('PAY-002', 'INV-004', 'CUST-001', '2024-06-08 11:30:00', 55489, 'Payment Gateway');


-- ----------------------------
-- Tabel: cash_mutations
-- ----------------------------
DROP TABLE IF EXISTS `cash_mutations`;
CREATE TABLE `cash_mutations` (
  `id` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `direction` enum('in','out') NOT NULL,
  `category` varchar(100) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `method` varchar(100) DEFAULT NULL,
  `description` text,
  `reference_type` varchar(50) DEFAULT NULL,
  `reference_id` varchar(255) DEFAULT NULL,
  `customer_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `source` enum('system','manual') NOT NULL DEFAULT 'system',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data Awal untuk cash_mutations
INSERT INTO `cash_mutations` (`id`, `date`, `direction`, `category`, `amount`, `method`, `description`, `reference_type`, `reference_id`, `customer_id`, `user_id`, `created_by`, `source`)
VALUES
('CM-001', '2024-07-05 10:00:00', 'in', 'invoice_payment', 55489.00, 'Bank Transfer', 'Pembayaran invoice INV-001', 'payment', 'PAY-001', 'CUST-001', NULL, NULL, 'system'),
('CM-002', '2024-06-08 11:30:00', 'in', 'invoice_payment', 55489.00, 'Payment Gateway', 'Pembayaran invoice INV-004', 'payment', 'PAY-002', 'CUST-001', NULL, NULL, 'system');


-- ----------------------------
-- Tabel: complaints
-- ----------------------------
DROP TABLE IF EXISTS `complaints`;
CREATE TABLE `complaints` (
  `id` varchar(255) NOT NULL,
  `customerId` varchar(255) NOT NULL,
  `customerName` varchar(255) NOT NULL,
  `dateSubmitted` datetime NOT NULL,
  `type` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data Awal untuk complaints (kosong)


-- ----------------------------------------------------
-- Tabel Cache MikroTik (dikelola oleh aplikasi/sync)
-- ----------------------------------------------------

DROP TABLE IF EXISTS `pppoe_users`;
CREATE TABLE `pppoe_users` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `service` varchar(255) DEFAULT NULL,
  `profile` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `pppoe_profiles`;
CREATE TABLE `pppoe_profiles` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `localAddress` varchar(255) DEFAULT NULL,
  `remoteAddressPool` varchar(255) DEFAULT NULL,
  `rateLimit` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `hotspot_users`;
CREATE TABLE `hotspot_users` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `profile` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `hotspot_profiles`;
CREATE TABLE `hotspot_profiles` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `rateLimit` varchar(255) DEFAULT NULL,
  `sharedUsers` int DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- ----------------------------
-- Tabel: hotspot_vouchers (Untuk manajemen voucher)
-- ----------------------------
DROP TABLE IF EXISTS `hotspot_vouchers`;
CREATE TABLE `hotspot_vouchers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile` varchar(255) NOT NULL,
  `duration_minutes` int NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'new',
  `created_at` datetime NOT NULL,
  `mikrotik_id` varchar(255) NOT NULL,
  `first_used_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_unique` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- ==========================================================================================
-- Akhir dari Skrip
-- ==========================================================================================
