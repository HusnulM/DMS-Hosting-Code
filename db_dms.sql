-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 11 Feb 2025 pada 03.26
-- Versi server: 8.0.29
-- Versi PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_dms`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReset` ()  BEGIN
TRUNCATE documents;
TRUNCATE document_versions;
TRUNCATE document_historys;
TRUNCATE document_attachments;
TRUNCATE document_approvals;
TRUNCATE document_affected_areas;
TRUNCATE document_wi;
TRUNCATE dcn_nriv;
TRUNCATE approval_attachments;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fGetDatabaseLocalDatetime` () RETURNS DATETIME BEGIN
DECLARE _return datetime;
SET _return = (SELECT now());
return (_return);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fGetEmail` (`pUserid` INT) RETURNS VARCHAR(80) CHARSET utf8mb4 COLLATE utf8mb4_general_ci BEGIN
    DECLARE hasil VARCHAR(80);
	
    SET hasil = (SELECT email from users where id = pUserid);
    	-- return the customer level
	RETURN (hasil);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fGetMaxVersion` (`pDcn` VARCHAR(30)) RETURNS INT BEGIN
	DECLARE result int;
    
    set result = (SELECT max(doc_version) FROM document_versions WHERE dcn_number = pDcn);
    
    return result;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fGetUserName` (`pUserid` INT) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci BEGIN
    DECLARE hasil VARCHAR(50);
	
    SET hasil = (SELECT name from users where id = pUserid);
    	-- return the customer level
	RETURN (hasil);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fGetUserSignature` (`pUserName` VARCHAR(50)) RETURNS TEXT CHARSET utf8mb4 COLLATE utf8mb4_general_ci BEGIN
	DECLARE hasil text;
    
     SET hasil = (SELECT s_signfile from users where username = pUserName);
    
    RETURN (hasil);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fGetWfCtgrName` (`pWfgroup` INT, `pWflevel` INT, `pApprover` INT, `pCreator` INT) RETURNS VARCHAR(80) CHARSET utf8mb4 COLLATE utf8mb4_general_ci BEGIN
    DECLARE hasil VARCHAR(80);
	
    SET hasil = (SELECT wf_categoryname from v_workflow_assignments where workflow_group = pWfgroup and approval_level = pWflevel and approverid = pApprover and creatorid = pCreator);
    	-- return the customer level
	RETURN (hasil);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `activities`
--

CREATE TABLE `activities` (
  `id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `activity` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `document_id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `approval_attachments`
--

CREATE TABLE `approval_attachments` (
  `id` int NOT NULL,
  `dcn_number` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `doc_version` int NOT NULL,
  `efile` text COLLATE utf8mb4_general_ci,
  `filename` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `isactive` varchar(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Y',
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `createdon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `customers`
--

CREATE TABLE `customers` (
  `customerid` int NOT NULL,
  `customer_name` varchar(80) COLLATE utf8mb4_general_ci NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `createdon` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `customers`
--

INSERT INTO `customers` (`customerid`, `customer_name`, `createdby`, `createdon`) VALUES
(1, 'Customer 1 Update', 'husnulmub@gmail.com', '2022-09-14'),
(2, 'Customer 2', 'husnulmub@gmail.com', '2022-09-14');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dcn_nriv`
--

CREATE TABLE `dcn_nriv` (
  `year` int NOT NULL,
  `object` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `current_number` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `createdon` date NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dcn_nriv`
--

INSERT INTO `dcn_nriv` (`year`, `object`, `current_number`, `createdon`, `createdby`) VALUES
(2022, 'CP', '3', '2022-09-28', 'husnulmub@gmail.com'),
(2022, 'WI', '3', '2022-09-29', 'husnulmub@gmail.com'),
(2022, 'WS', '2', '2022-10-03', 'husnulmub@gmail.com'),
(2023, 'CP', '1', '2023-01-20', 'husnulmub@gmail.com'),
(2024, 'CP', '1', '2024-05-21', 'husnulmub@gmail.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `docareas`
--

CREATE TABLE `docareas` (
  `id` int NOT NULL,
  `docarea` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `mail` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `createdon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `docareas`
--

INSERT INTO `docareas` (`id`, `docarea`, `mail`, `createdby`, `createdon`) VALUES
(1, 'Compliance - Internal Procedure', NULL, 'husnulmub@gmail.com', '2022-08-11 14:22:51'),
(2, 'IT Dept', NULL, 'husnulmub@gmail.com', '2022-08-11 14:38:51'),
(3, 'Test', NULL, 'husnulmub@gmail.com', '2022-09-15 08:58:48');

-- --------------------------------------------------------

--
-- Struktur dari tabel `docarea_emails`
--

CREATE TABLE `docarea_emails` (
  `id` int NOT NULL,
  `docareaid` int NOT NULL,
  `email` varchar(80) COLLATE utf8mb4_general_ci NOT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `docarea_emails`
--

INSERT INTO `docarea_emails` (`id`, `docareaid`, `email`, `createdon`, `createdby`) VALUES
(1, 1, 'husnulmub@gmail.com', '2022-08-11 14:22:51', 'husnulmub@gmail.com'),
(3, 2, 'husnulmub@gmail.com', '2022-08-11 14:38:51', 'husnulmub@gmail.com'),
(4, 2, 'husnulm15@gmail.com', '2022-08-11 14:38:51', 'husnulmub@gmail.com'),
(5, 3, 'husnulmub@gmail.com', '2022-09-15 08:58:48', 'husnulmub@gmail.com'),
(6, 3, 'husnulm15@gmail.com', '2022-09-15 08:58:48', 'husnulmub@gmail.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `doclevels`
--

CREATE TABLE `doclevels` (
  `id` int NOT NULL,
  `doclevel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `doclevels`
--

INSERT INTO `doclevels` (`id`, `doclevel`, `createdon`, `createdby`) VALUES
(1, 'Level 1', '2022-08-03 06:08:01', 'husnulmub@gmail.com'),
(2, 'Level 2', '2022-08-03 06:08:12', 'husnulmub@gmail.com'),
(4, 'Level 3', '2022-08-03 06:08:47', 'husnulmub@gmail.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `doctypes`
--

CREATE TABLE `doctypes` (
  `id` int NOT NULL,
  `doctype` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `workflow_group` int DEFAULT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `doctypes`
--

INSERT INTO `doctypes` (`id`, `doctype`, `workflow_group`, `createdon`, `createdby`) VALUES
(1, 'Corporate Procedure', 3, '2022-08-01 23:08:05', 'husnulmub@gmail.com'),
(2, 'Work Instruction', 3, '2022-08-01 23:08:24', 'husnulmub@gmail.com'),
(3, 'Work Standard', 3, '2022-08-01 23:08:24', 'husnulmub@gmail.com'),
(4, 'External Procedure', 3, '2022-08-11 14:08:20', 'husnulmub@gmail.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `documents`
--

CREATE TABLE `documents` (
  `id` int UNSIGNED NOT NULL,
  `dcn_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `document_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `document_level` int DEFAULT NULL,
  `document_number` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `document_title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `workflow_group` int DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Open',
  `revision_number` int NOT NULL DEFAULT '0',
  `effectivity_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `updatedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `documents`
--

INSERT INTO `documents` (`id`, `dcn_number`, `document_type`, `document_level`, `document_number`, `document_title`, `description`, `workflow_group`, `status`, `revision_number`, `effectivity_date`, `created_at`, `updated_at`, `createdby`, `updatedby`) VALUES
(1, 'DCN-CP-22-000001', '1', 1, 'DK-AB-1', 'Technical Service Procedure tests', '<p>Teest update document</p>', 3, 'Open', 0, '2022-09-29', '2022-09-28 15:05:44', '2022-09-28 23:24:40', 'sys-admin', 'sys-admin'),
(2, 'DCN-CP-22-000002', '1', 1, 'DK-AB-2', 'Delivery Schedules', '<p>tes</p>', 3, 'Open', 0, '2022-09-29', '2022-09-28 16:04:40', '2022-09-29 00:04:06', 'sys-admin', NULL),
(3, 'DCN-WI-22-000001', '2', NULL, NULL, 'Test WI Doc update', NULL, 3, 'Open', 0, NULL, '2022-09-29 00:02:41', '2022-09-28 23:38:33', 'sys-admin', NULL),
(4, 'DCN-WS-22-000001', '3', NULL, NULL, 'Test Update WS Doc', NULL, 3, 'Open', 0, NULL, '2022-10-03 01:38:36', '2022-10-03 02:50:15', 'sys-admin', 'sys-admin'),
(5, 'DCN-WI-22-000002', '2', NULL, NULL, 'Test WI Doc Update', NULL, 3, 'Open', 0, NULL, '2022-10-03 02:56:33', '2022-10-03 01:39:40', 'sys-admin', NULL),
(6, 'KEPI-WI-22-000003', '2', NULL, NULL, 'test', NULL, 3, 'Open', 1, NULL, '2022-10-07 01:54:15', '2022-10-10 04:23:47', 'sys-admin', 'sys-admin'),
(7, 'KEPI-WS-22-000002', '3', NULL, NULL, 'Test', NULL, 3, 'Open', 1, NULL, '2022-10-07 01:54:56', '2022-10-10 07:43:12', 'sys-admin', 'sys-admin'),
(8, 'DCN-CP-22-000003', '1', 1, 'DK-AB-1', 'Technical Service Procedure', '<p>Tst</p>', 3, 'Open', 0, '2022-11-08', '2022-11-08 03:31:09', NULL, 'sys-admin', NULL),
(9, 'DCN-CP-23-000001', '1', 1, '12345678', 'Testing Document', '<p>Testing Document</p>', 3, 'Open', 1, '2023-01-20', '2023-01-20 01:01:12', '2023-01-20 01:07:08', 'sys-admin', 'sys-admin'),
(10, 'DCN-CP-24-000001', '1', 1, '2024/05/001', 'Technical Service Procedure XX', '<p>Testing</p>', 3, 'Open', 0, '2024-05-21', '2024-05-21 09:50:43', '2024-05-21 09:51:07', 'sys-admin', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `document_affected_areas`
--

CREATE TABLE `document_affected_areas` (
  `dcn_number` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `docarea` int NOT NULL,
  `doc_version` int NOT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `document_affected_areas`
--

INSERT INTO `document_affected_areas` (`dcn_number`, `docarea`, `doc_version`, `createdon`, `createdby`) VALUES
('DCN-CP-22-000001', 2, 0, '2022-09-29 06:24:40', 'sys-admin'),
('DCN-CP-22-000001', 2, 1, '2022-09-28 23:17:24', 'sys-admin'),
('DCN-CP-22-000001', 3, 0, '2022-09-29 06:24:40', 'sys-admin'),
('DCN-CP-22-000001', 3, 1, '2022-09-28 23:17:24', 'sys-admin'),
('DCN-CP-22-000002', 1, 0, '2022-09-28 23:04:41', 'sys-admin'),
('DCN-CP-22-000003', 2, 0, '2022-11-08 10:31:09', 'sys-admin'),
('DCN-CP-23-000001', 1, 0, '2023-01-20 08:01:12', 'sys-admin'),
('DCN-CP-23-000001', 1, 1, '2023-01-20 08:05:10', 'sys-admin'),
('DCN-CP-23-000001', 2, 0, '2023-01-20 08:01:12', 'sys-admin'),
('DCN-CP-23-000001', 2, 1, '2023-01-20 08:05:10', 'sys-admin'),
('DCN-CP-24-000001', 2, 0, '2024-05-21 16:50:43', 'sys-admin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `document_approvals`
--

CREATE TABLE `document_approvals` (
  `id` int NOT NULL,
  `dcn_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `approval_version` int NOT NULL,
  `workflow_group` int NOT NULL,
  `approver_level` int NOT NULL,
  `approver_id` int NOT NULL,
  `creator_id` int NOT NULL,
  `is_active` varchar(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N',
  `approval_status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N',
  `approval_remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `approved_by` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `approval_date` datetime DEFAULT NULL,
  `createdon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `document_approvals`
--

INSERT INTO `document_approvals` (`id`, `dcn_number`, `approval_version`, `workflow_group`, `approver_level`, `approver_id`, `creator_id`, `is_active`, `approval_status`, `approval_remark`, `approved_by`, `approval_date`, `createdon`) VALUES
(4, 'DCN-CP-22-000002', 0, 3, 1, 1, 1, 'Y', 'A', 'ok', 'sys-admin', '2022-09-29 07:04:06', '2022-09-28 23:04:41'),
(5, 'DCN-CP-22-000002', 0, 3, 2, 3, 1, 'Y', 'N', NULL, NULL, NULL, '2022-09-28 23:04:41'),
(6, 'DCN-CP-22-000002', 0, 3, 2, 5, 1, 'Y', 'N', NULL, NULL, NULL, '2022-09-28 23:04:41'),
(16, 'DCN-CP-22-000001', 1, 3, 1, 1, 1, 'Y', 'N', NULL, NULL, NULL, '2022-09-28 23:17:24'),
(17, 'DCN-CP-22-000001', 1, 3, 2, 3, 1, 'N', 'N', NULL, NULL, NULL, '2022-09-28 23:17:24'),
(18, 'DCN-CP-22-000001', 1, 3, 2, 5, 1, 'N', 'N', NULL, NULL, NULL, '2022-09-28 23:17:24'),
(19, 'DCN-CP-22-000001', 0, 3, 1, 1, 1, 'Y', 'N', NULL, NULL, NULL, '2022-09-29 06:24:40'),
(20, 'DCN-CP-22-000001', 0, 3, 2, 3, 1, 'N', 'N', NULL, NULL, NULL, '2022-09-29 06:24:40'),
(21, 'DCN-CP-22-000001', 0, 3, 2, 5, 1, 'N', 'N', NULL, NULL, NULL, '2022-09-29 06:24:40'),
(25, 'DCN-WI-22-000001', 0, 3, 1, 1, 1, 'Y', 'N', NULL, NULL, NULL, '2022-09-29 07:02:41'),
(26, 'DCN-WI-22-000001', 0, 3, 2, 3, 1, 'N', 'N', NULL, NULL, NULL, '2022-09-29 07:02:41'),
(27, 'DCN-WI-22-000001', 0, 3, 2, 5, 1, 'N', 'N', NULL, NULL, NULL, '2022-09-29 07:02:41'),
(34, 'DCN-WS-22-000001', 0, 3, 1, 1, 1, 'Y', 'N', NULL, NULL, NULL, '2022-10-03 09:50:15'),
(35, 'DCN-WS-22-000001', 0, 3, 2, 3, 1, 'N', 'N', NULL, NULL, NULL, '2022-10-03 09:50:15'),
(36, 'DCN-WS-22-000001', 0, 3, 2, 5, 1, 'N', 'N', NULL, NULL, NULL, '2022-10-03 09:50:15'),
(37, 'DCN-WI-22-000002', 0, 3, 1, 1, 1, 'Y', 'N', NULL, NULL, NULL, '2022-10-03 09:56:33'),
(38, 'DCN-WI-22-000002', 0, 3, 2, 3, 1, 'N', 'N', NULL, NULL, NULL, '2022-10-03 09:56:33'),
(39, 'DCN-WI-22-000002', 0, 3, 2, 5, 1, 'N', 'N', NULL, NULL, NULL, '2022-10-03 09:56:33'),
(40, 'KEPI-WI-22-000003', 0, 3, 1, 1, 1, 'N', 'C', 'Auto Closed by New Version', NULL, '2022-10-10 11:23:47', '2022-10-07 08:54:15'),
(41, 'KEPI-WI-22-000003', 0, 3, 2, 3, 1, 'N', 'C', 'Auto Closed by New Version', NULL, '2022-10-10 11:23:47', '2022-10-07 08:54:15'),
(42, 'KEPI-WI-22-000003', 0, 3, 2, 5, 1, 'N', 'C', 'Auto Closed by New Version', NULL, '2022-10-10 11:23:47', '2022-10-07 08:54:15'),
(43, 'KEPI-WS-22-000002', 0, 3, 1, 1, 1, 'N', 'C', 'Auto Closed by New Version', NULL, '2022-10-10 14:43:12', '2022-10-07 08:54:56'),
(44, 'KEPI-WS-22-000002', 0, 3, 2, 3, 1, 'N', 'C', 'Auto Closed by New Version', NULL, '2022-10-10 14:43:12', '2022-10-07 08:54:56'),
(45, 'KEPI-WS-22-000002', 0, 3, 2, 5, 1, 'N', 'C', 'Auto Closed by New Version', NULL, '2022-10-10 14:43:12', '2022-10-07 08:54:56'),
(46, 'KEPI-WI-22-000003', 1, 3, 1, 1, 1, 'Y', 'N', NULL, NULL, NULL, '2022-10-10 11:23:47'),
(47, 'KEPI-WI-22-000003', 1, 3, 2, 3, 1, 'N', 'N', NULL, NULL, NULL, '2022-10-10 11:23:47'),
(48, 'KEPI-WI-22-000003', 1, 3, 2, 5, 1, 'N', 'N', NULL, NULL, NULL, '2022-10-10 11:23:47'),
(49, 'KEPI-WS-22-000002', 1, 3, 1, 1, 1, 'Y', 'N', NULL, NULL, NULL, '2022-10-10 14:43:12'),
(50, 'KEPI-WS-22-000002', 1, 3, 2, 3, 1, 'N', 'N', NULL, NULL, NULL, '2022-10-10 14:43:12'),
(51, 'KEPI-WS-22-000002', 1, 3, 2, 5, 1, 'N', 'N', NULL, NULL, NULL, '2022-10-10 14:43:12'),
(52, 'DCN-CP-22-000003', 0, 3, 1, 1, 1, 'Y', 'N', NULL, NULL, NULL, '2022-11-08 10:31:09'),
(53, 'DCN-CP-22-000003', 0, 3, 2, 3, 1, 'N', 'N', NULL, NULL, NULL, '2022-11-08 10:31:09'),
(54, 'DCN-CP-22-000003', 0, 3, 2, 5, 1, 'N', 'N', NULL, NULL, NULL, '2022-11-08 10:31:09'),
(55, 'DCN-CP-23-000001', 0, 3, 1, 1, 1, 'N', 'C', 'Auto Closed by New Version', 'sys-admin', '2023-01-20 08:05:10', '2023-01-20 08:01:12'),
(56, 'DCN-CP-23-000001', 0, 3, 2, 3, 1, 'N', 'C', 'Auto Closed by New Version', 'approval1', '2023-01-20 08:05:10', '2023-01-20 08:01:12'),
(57, 'DCN-CP-23-000001', 0, 3, 2, 5, 1, 'N', 'C', 'Auto Closed by New Version', 'approval1', '2023-01-20 08:05:10', '2023-01-20 08:01:12'),
(58, 'DCN-CP-23-000001', 1, 3, 1, 1, 1, 'Y', 'A', 'Ok', 'sys-admin', '2023-01-20 08:05:53', '2023-01-20 08:05:10'),
(59, 'DCN-CP-23-000001', 1, 3, 2, 3, 1, 'Y', 'A', 'Ok', 'approval1', '2023-01-20 08:07:08', '2023-01-20 08:05:10'),
(60, 'DCN-CP-23-000001', 1, 3, 2, 5, 1, 'Y', 'A', 'Ok', 'approval1', '2023-01-20 08:07:08', '2023-01-20 08:05:10'),
(61, 'DCN-CP-24-000001', 0, 3, 1, 1, 1, 'Y', 'A', 'OK', 'sys-admin', '2024-05-21 16:51:07', '2024-05-21 16:50:43'),
(62, 'DCN-CP-24-000001', 0, 3, 2, 3, 1, 'Y', 'N', NULL, NULL, NULL, '2024-05-21 16:50:43'),
(63, 'DCN-CP-24-000001', 0, 3, 2, 5, 1, 'Y', 'N', NULL, NULL, NULL, '2024-05-21 16:50:43');

-- --------------------------------------------------------

--
-- Struktur dari tabel `document_attachments`
--

CREATE TABLE `document_attachments` (
  `id` bigint UNSIGNED NOT NULL,
  `dcn_number` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `doc_version` int NOT NULL,
  `efile` text COLLATE utf8mb4_general_ci,
  `pathfile` text COLLATE utf8mb4_general_ci,
  `remark` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `updatedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `document_attachments`
--

INSERT INTO `document_attachments` (`id`, `dcn_number`, `doc_version`, `efile`, `pathfile`, `remark`, `created_at`, `updated_at`, `createdby`, `updatedby`) VALUES
(1, 'DCN-CP-22-000001', 0, 'DCN-CP-22-000001-1661939504396.gif', 'storage/files/DCN-CP-22-000001-1661939504396.gif', NULL, '2022-09-28 15:05:44', NULL, 'sys-admin', NULL),
(2, 'DCN-CP-22-000002', 0, 'DCN-CP-22-000002-1661939504396.gif', 'storage/files/DCN-CP-22-000002-1661939504396.gif', NULL, '2022-09-28 16:04:40', NULL, 'sys-admin', NULL),
(3, 'DCN-CP-22-000001', 1, 'DCN-CP-22-000001-sample-logo.jpg', 'storage/files/DCN-CP-22-000001-sample-logo.jpg', NULL, '2022-09-28 16:11:16', NULL, 'sys-admin', NULL),
(4, 'DCN-CP-22-000001', 1, 'DCN-CP-22-000001-sample-logo.jpg', 'storage/files/DCN-CP-22-000001-sample-logo.jpg', NULL, '2022-09-28 16:12:34', NULL, 'sys-admin', NULL),
(5, 'DCN-CP-22-000001', 1, 'DCN-CP-22-000001-esign1.png', 'storage/files/DCN-CP-22-000001-esign1.png', NULL, '2022-09-28 16:14:25', NULL, 'sys-admin', NULL),
(6, 'DCN-CP-22-000001', 1, 'DCN-CP-22-000001-sample-logo.jpg', 'storage/files/DCN-CP-22-000001-sample-logo.jpg', NULL, '2022-09-28 16:17:24', NULL, 'sys-admin', NULL),
(7, 'DCN-CP-22-000001', 0, 'DCN-CP-22-000001-esign1.png', 'storage/files/DCN-CP-22-000001-esign1.png', NULL, '2022-09-28 23:24:40', NULL, 'sys-admin', NULL),
(8, 'DCN-WI-22-000001', 0, 'DCN-WI-22-000001-esign3.png', 'storage/files/DCN-WI-22-000001-esign3.png', NULL, '2022-09-28 23:38:14', NULL, 'sys-admin', NULL),
(9, 'DCN-WI-22-000001', 0, 'DCN-WI-22-000001-esign1.png', 'storage/files/DCN-WI-22-000001-esign1.png', NULL, '2022-09-29 00:02:41', NULL, 'sys-admin', NULL),
(10, 'DCN-WS-22-000001', 0, 'DCN-WS-22-000001-export.pdf', 'storage/files/DCN-WS-22-000001-export.pdf', NULL, '2022-10-03 01:38:36', NULL, 'sys-admin', NULL),
(11, 'DCN-WI-22-000002', 0, 'DCN-WI-22-000002-export.pdf', 'storage/files/DCN-WI-22-000002-export.pdf', NULL, '2022-10-03 01:39:12', NULL, 'sys-admin', NULL),
(12, 'DCN-WS-22-000001', 0, 'DCN-WS-22-000001-1662609778829.pdf', 'storage/files/DCN-WS-22-000001-1662609778829.pdf', NULL, '2022-10-03 02:50:15', NULL, 'sys-admin', NULL),
(13, 'DCN-WI-22-000002', 0, 'DCN-WI-22-000002-1662609778829.pdf', 'storage/files/DCN-WI-22-000002-1662609778829.pdf', NULL, '2022-10-03 02:56:33', NULL, 'sys-admin', NULL),
(14, 'KEPI-WI-22-000003', 0, 'KEPI-WI-22-000003-export.pdf', 'storage/files/KEPI-WI-22-000003-export.pdf', NULL, '2022-10-07 01:54:15', NULL, 'sys-admin', NULL),
(15, 'KEPI-WS-22-000002', 0, 'KEPI-WS-22-000002-export.pdf', 'storage/files/KEPI-WS-22-000002-export.pdf', NULL, '2022-10-07 01:54:56', NULL, 'sys-admin', NULL),
(16, 'KEPI-WI-22-000003', 1, 'KEPI-WI-22-000003V1-export.pdf', 'storage/files/KEPI-WI-22-000003V1-export.pdf', NULL, '2022-10-10 04:23:47', NULL, 'sys-admin', NULL),
(17, 'KEPI-WS-22-000002', 1, 'KEPI-WS-22-000002-export.pdf', 'storage/files/KEPI-WS-22-000002-export.pdf', NULL, '2022-10-10 07:43:12', NULL, 'sys-admin', NULL),
(18, 'DCN-CP-22-000003', 0, 'DCN-CP-22-000003-invoice.pdf', 'storage/files/DCN-CP-22-000003-invoice.pdf', NULL, '2022-11-08 03:31:09', NULL, 'sys-admin', NULL),
(19, 'DCN-CP-23-000001', 0, 'DCN-CP-23-000001-MF02.png', 'storage/files/DCN-CP-23-000001-MF02.png', NULL, '2023-01-20 01:01:12', NULL, 'sys-admin', NULL),
(20, 'DCN-CP-23-000001', 0, 'DCN-CP-23-000001-MF06.png', 'storage/files/DCN-CP-23-000001-MF06.png', NULL, '2023-01-20 01:01:12', NULL, 'sys-admin', NULL),
(21, 'DCN-CP-23-000001', 1, 'DCN-CP-23-000001V1-1630702 - Extend the length of field MAKT-MAKTX (Material Description) in the Material Master.pdf', 'storage/files/DCN-CP-23-000001V1-1630702 - Extend the length of field MAKT-MAKTX (Material Description) in the Material Master.pdf', NULL, '2023-01-20 01:05:10', NULL, 'sys-admin', NULL),
(22, 'DCN-CP-24-000001', 0, 'DCN-CP-24-000001-Attachment1.pdf', 'storage/files/DCN-CP-24-000001-Attachment1.pdf', NULL, '2024-05-21 09:50:43', NULL, 'sys-admin', NULL),
(23, 'DCN-CP-24-000001', 0, 'DCN-CP-24-000001-Attachment2.pdf', 'storage/files/DCN-CP-24-000001-Attachment2.pdf', NULL, '2024-05-21 09:50:43', NULL, 'sys-admin', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `document_historys`
--

CREATE TABLE `document_historys` (
  `id` int NOT NULL,
  `dcn_number` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `doc_version` int NOT NULL,
  `activity` longtext COLLATE utf8mb4_general_ci,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `createdon` datetime NOT NULL,
  `updatedon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `document_historys`
--

INSERT INTO `document_historys` (`id`, `dcn_number`, `doc_version`, `activity`, `createdby`, `createdon`, `updatedon`) VALUES
(1, 'DCN-CP-22-000001', 0, 'Document Created : Technical Service Procedure', 'sys-admin', '2022-09-28 22:05:44', '2022-09-28 22:05:44'),
(2, 'DCN-CP-22-000001', 0, 'Document Attachment Created : DCN-CP-22-000001-1661939504396.gif', 'sys-admin', '2022-09-28 22:05:44', '2022-09-28 22:05:44'),
(3, 'DCN-CP-22-000001', 0, 'Document Approved', 'husnulmub@gmail.com', '2022-09-28 22:06:47', '2022-09-28 22:06:47'),
(4, 'DCN-CP-22-000001', 0, 'Document Rejected', 'approval1@mail.com', '2022-09-28 22:07:36', '2022-09-28 22:07:36'),
(5, 'DCN-CP-22-000002', 0, 'Document Created : Delivery Schedules', 'sys-admin', '2022-09-28 23:04:40', '2022-09-28 23:04:40'),
(6, 'DCN-CP-22-000002', 0, 'Document Attachment Created : DCN-CP-22-000002-1661939504396.gif', 'sys-admin', '2022-09-28 23:04:41', '2022-09-28 23:04:41'),
(7, 'DCN-CP-22-000001', 1, 'Document Updated : Technical Service Procedure', 'sys-admin', '2022-09-28 23:11:16', '2022-09-28 23:11:16'),
(8, 'DCN-CP-22-000001', 1, 'Document Attachment Created : DCN-CP-22-000001-sample-logo.jpg', 'sys-admin', '2022-09-28 23:11:16', '2022-09-28 23:11:16'),
(9, 'DCN-CP-22-000001', 1, 'Document Updated : Technical Service Procedure', 'sys-admin', '2022-09-28 23:12:34', '2022-09-28 23:12:34'),
(10, 'DCN-CP-22-000001', 1, 'Document Attachment Created : DCN-CP-22-000001-sample-logo.jpg', 'sys-admin', '2022-09-28 23:12:34', '2022-09-28 23:12:34'),
(11, 'DCN-CP-22-000001', 1, 'Document Updated : Technical Service Procedure', 'sys-admin', '2022-09-28 23:14:25', '2022-09-28 23:14:25'),
(12, 'DCN-CP-22-000001', 1, 'Document Attachment Created : DCN-CP-22-000001-esign1.png', 'sys-admin', '2022-09-28 23:14:25', '2022-09-28 23:14:25'),
(13, 'DCN-CP-22-000001', 1, 'Document Updated : Technical Service Procedure tests', 'sys-admin', '2022-09-28 23:17:24', '2022-09-28 23:17:24'),
(14, 'DCN-CP-22-000001', 1, 'Document Attachment Created : DCN-CP-22-000001-sample-logo.jpg', 'sys-admin', '2022-09-28 23:17:24', '2022-09-28 23:17:24'),
(15, 'DCN-CP-22-000001', 0, 'Document Updated : Technical Service Procedure tests', 'sys-admin', '2022-09-29 06:24:40', '2022-09-29 06:24:40'),
(16, 'DCN-CP-22-000001', 0, 'Document Attachment Created : DCN-CP-22-000001-esign1.png', 'sys-admin', '2022-09-29 06:24:40', '2022-09-29 06:24:40'),
(17, 'DCN-WI-22-000001', 0, 'Document Created : Test WI Doc', 'sys-admin', '2022-09-29 06:38:14', '2022-09-29 06:38:14'),
(18, 'DCN-WI-22-000001', 0, 'Document Attachment Created : DCN-WI-22-000001-esign3.png', 'sys-admin', '2022-09-29 06:38:14', '2022-09-29 06:38:14'),
(19, 'DCN-WI-22-000001', 0, 'Document Rejected', 'husnulmub@gmail.com', '2022-09-29 06:38:33', '2022-09-29 06:38:33'),
(20, 'DCN-WI-22-000001', 0, 'Document Updated : Test WI Doc update', 'sys-admin', '2022-09-29 07:02:41', '2022-09-29 07:02:41'),
(21, 'DCN-WI-22-000001', 0, 'Document Attachment Created : DCN-WI-22-000001-esign1.png', 'sys-admin', '2022-09-29 07:02:41', '2022-09-29 07:02:41'),
(22, 'DCN-CP-22-000002', 0, 'Document Approved', 'husnulmub@gmail.com', '2022-09-29 07:04:06', '2022-09-29 07:04:06'),
(23, 'DCN-WS-22-000001', 0, 'Document Created : Technical Service Procedure', 'sys-admin', '2022-10-03 08:38:36', '2022-10-03 08:38:36'),
(24, 'DCN-WS-22-000001', 0, 'Document Attachment Created : DCN-WS-22-000001-export.pdf', 'sys-admin', '2022-10-03 08:38:36', '2022-10-03 08:38:36'),
(25, 'DCN-WI-22-000002', 0, 'Document Created : Test WI Doc', 'sys-admin', '2022-10-03 08:39:12', '2022-10-03 08:39:12'),
(26, 'DCN-WI-22-000002', 0, 'Document Attachment Created : DCN-WI-22-000002-export.pdf', 'sys-admin', '2022-10-03 08:39:12', '2022-10-03 08:39:12'),
(27, 'DCN-WI-22-000002', 0, 'Document Rejected', 'husnulmub@gmail.com', '2022-10-03 08:39:40', '2022-10-03 08:39:40'),
(28, 'DCN-WS-22-000001', 0, 'Document Rejected', 'husnulmub@gmail.com', '2022-10-03 08:41:20', '2022-10-03 08:41:20'),
(29, 'DCN-WS-22-000001', 0, 'Document Updated : Test Update WS Doc', 'sys-admin', '2022-10-03 09:50:15', '2022-10-03 09:50:15'),
(30, 'DCN-WS-22-000001', 0, 'Document Attachment Created : DCN-WS-22-000001-1662609778829.pdf', 'sys-admin', '2022-10-03 09:50:15', '2022-10-03 09:50:15'),
(31, 'DCN-WI-22-000002', 0, 'Document Updated : Test WI Doc Update', 'sys-admin', '2022-10-03 09:56:33', '2022-10-03 09:56:33'),
(32, 'DCN-WI-22-000002', 0, 'Document Attachment Created : DCN-WI-22-000002-1662609778829.pdf', 'sys-admin', '2022-10-03 09:56:33', '2022-10-03 09:56:33'),
(33, 'KEPI-WI-22-000003', 0, 'Document Created : test', 'sys-admin', '2022-10-07 08:54:15', '2022-10-07 08:54:15'),
(34, 'KEPI-WI-22-000003', 0, 'Document Attachment Created : KEPI-WI-22-000003-export.pdf', 'sys-admin', '2022-10-07 08:54:15', '2022-10-07 08:54:15'),
(35, 'KEPI-WS-22-000002', 0, 'Document Created : Test', 'sys-admin', '2022-10-07 08:54:56', '2022-10-07 08:54:56'),
(36, 'KEPI-WS-22-000002', 0, 'Document Attachment Created : KEPI-WS-22-000002-export.pdf', 'sys-admin', '2022-10-07 08:54:56', '2022-10-07 08:54:56'),
(37, 'KEPI-WI-22-000003', 1, 'New Document Revision Created : test', 'sys-admin', '2022-10-10 11:23:47', '2022-10-10 11:23:47'),
(38, 'KEPI-WI-22-000003', 1, 'Document Attachment Created : KEPI-WI-22-000003V1-export.pdf', 'sys-admin', '2022-10-10 11:23:47', '2022-10-10 11:23:47'),
(39, 'KEPI-WS-22-000002', 1, 'Document Created : Test', 'sys-admin', '2022-10-10 14:43:12', '2022-10-10 14:43:12'),
(40, 'KEPI-WS-22-000002', 1, 'Document Attachment Created : KEPI-WS-22-000002-export.pdf', 'sys-admin', '2022-10-10 14:43:12', '2022-10-10 14:43:12'),
(41, 'DCN-CP-22-000003', 0, 'Document Created : Technical Service Procedure', 'sys-admin', '2022-11-08 10:31:09', '2022-11-08 10:31:09'),
(42, 'DCN-CP-22-000003', 0, 'Document Attachment Created : DCN-CP-22-000003-invoice.pdf', 'sys-admin', '2022-11-08 10:31:09', '2022-11-08 10:31:09'),
(43, 'DCN-CP-23-000001', 0, 'Document Created : Testing Document', 'sys-admin', '2023-01-20 08:01:12', '2023-01-20 08:01:12'),
(44, 'DCN-CP-23-000001', 0, 'Document Attachment Created : DCN-CP-23-000001-MF02.png', 'sys-admin', '2023-01-20 08:01:12', '2023-01-20 08:01:12'),
(45, 'DCN-CP-23-000001', 0, 'Document Attachment Created : DCN-CP-23-000001-MF06.png', 'sys-admin', '2023-01-20 08:01:12', '2023-01-20 08:01:12'),
(46, 'DCN-CP-23-000001', 0, 'Document Approved', 'husnulmub@gmail.com', '2023-01-20 08:02:11', '2023-01-20 08:02:11'),
(47, 'DCN-CP-23-000001', 0, 'Document Approved', 'approval1@mail.com', '2023-01-20 08:03:01', '2023-01-20 08:03:01'),
(48, 'DCN-CP-23-000001', 1, 'New Document Version Created : Testing Document', 'sys-admin', '2023-01-20 08:05:10', '2023-01-20 08:05:10'),
(49, 'DCN-CP-23-000001', 1, 'Document Attachment Created : DCN-CP-23-000001V1-1630702 - Extend the length of field MAKT-MAKTX (Material Description) in the Material Master.pdf', 'sys-admin', '2023-01-20 08:05:10', '2023-01-20 08:05:10'),
(50, 'DCN-CP-23-000001', 1, 'Document Approved', 'husnulmub@gmail.com', '2023-01-20 08:05:53', '2023-01-20 08:05:53'),
(51, 'DCN-CP-23-000001', 1, 'Document Approved', 'approval1@mail.com', '2023-01-20 08:07:08', '2023-01-20 08:07:08'),
(52, 'DCN-CP-24-000001', 0, 'Document Created : Technical Service Procedure XX', 'sys-admin', '2024-05-21 16:50:43', '2024-05-21 16:50:43'),
(53, 'DCN-CP-24-000001', 0, 'Document Attachment Created : DCN-CP-24-000001-Attachment1.pdf', 'sys-admin', '2024-05-21 16:50:43', '2024-05-21 16:50:43'),
(54, 'DCN-CP-24-000001', 0, 'Document Attachment Created : DCN-CP-24-000001-Attachment2.pdf', 'sys-admin', '2024-05-21 16:50:43', '2024-05-21 16:50:43'),
(55, 'DCN-CP-24-000001', 0, 'Document Approved', 'husnulmub@gmail.com', '2024-05-21 16:51:07', '2024-05-21 16:51:07');

-- --------------------------------------------------------

--
-- Struktur dari tabel `document_versions`
--

CREATE TABLE `document_versions` (
  `dcn_number` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `doc_version` int NOT NULL,
  `remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `effectivity_date` date DEFAULT NULL,
  `established_date` date DEFAULT NULL,
  `validity_date` date DEFAULT NULL,
  `createdon` datetime NOT NULL,
  `changeon` datetime DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Open'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `document_versions`
--

INSERT INTO `document_versions` (`dcn_number`, `doc_version`, `remark`, `effectivity_date`, `established_date`, `validity_date`, `createdon`, `changeon`, `createdby`, `status`) VALUES
('DCN-CP-22-000001', 0, '<p>Teest update document</p>', '2022-09-29', NULL, NULL, '2022-09-28 22:05:44', '2022-09-29 06:24:40', 'sys-admin', 'Open'),
('DCN-CP-22-000002', 0, '<p>tes</p>', '2022-09-29', NULL, NULL, '2022-09-28 23:04:40', NULL, 'sys-admin', 'Open'),
('DCN-CP-22-000003', 0, '<p>Tst</p>', '2022-11-08', NULL, NULL, '2022-11-08 10:31:09', NULL, 'sys-admin', 'Open'),
('DCN-CP-23-000001', 0, '<p>Testing Document</p>', '2023-01-20', NULL, NULL, '2023-01-20 08:01:12', NULL, 'sys-admin', 'Obsolete'),
('DCN-CP-23-000001', 1, '<p>Testing document revision</p>', '2023-01-24', NULL, NULL, '2023-01-20 08:05:10', NULL, 'sys-admin', 'Approved'),
('DCN-CP-24-000001', 0, '<p>Testing</p>', '2024-05-21', NULL, NULL, '2024-05-21 16:50:43', NULL, 'sys-admin', 'Open'),
('DCN-WI-22-000001', 0, NULL, NULL, '2022-09-30', '2022-10-03', '2022-09-29 06:38:14', '2022-09-29 07:02:41', 'sys-admin', 'Open'),
('DCN-WI-22-000002', 0, NULL, NULL, '2022-10-04', '2022-10-14', '2022-10-03 08:39:12', '2022-10-03 09:56:33', 'sys-admin', 'Open'),
('DCN-WS-22-000001', 0, NULL, '2022-10-19', '2022-10-05', NULL, '2022-10-03 08:38:36', '2022-10-03 09:50:15', 'sys-admin', 'Open'),
('KEPI-WI-22-000003', 0, NULL, NULL, '2022-10-07', '2022-10-17', '2022-10-07 08:54:15', NULL, 'sys-admin', 'Obsolete'),
('KEPI-WI-22-000003', 1, NULL, NULL, '2022-10-07', '2022-10-25', '2022-10-10 11:23:47', NULL, 'sys-admin', 'Open'),
('KEPI-WS-22-000002', 0, NULL, '2022-10-31', '2022-10-07', NULL, '2022-10-07 08:54:56', NULL, 'sys-admin', 'Obsolete'),
('KEPI-WS-22-000002', 1, 'Test Update', '2022-10-31', '2022-10-19', NULL, '2022-10-10 14:43:12', NULL, 'sys-admin', 'Open');

-- --------------------------------------------------------

--
-- Struktur dari tabel `document_wi`
--

CREATE TABLE `document_wi` (
  `dcn_number` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `doc_version` int NOT NULL,
  `assy_code` varchar(70) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `model_name` varchar(70) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `scope` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `implementation` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reason` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `customer` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `section` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `process_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `createdon` datetime DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `document_wi`
--

INSERT INTO `document_wi` (`dcn_number`, `doc_version`, `assy_code`, `model_name`, `scope`, `implementation`, `reason`, `customer`, `product_name`, `section`, `process_name`, `createdon`, `createdby`) VALUES
('DCN-WI-22-000001', 0, '1122334-01', 'U776A', 'Scope test', 'YYN', 'YNYN', NULL, NULL, NULL, NULL, '2022-09-29 06:38:14', 'sys-admin'),
('DCN-WI-22-000002', 0, '2424241-01', 'U778C', 'Scope Update', 'YYN', 'YNYN', NULL, NULL, NULL, NULL, '2022-10-03 08:39:12', 'sys-admin'),
('DCN-WS-22-000001', 0, '2233441-02', 'U778B', NULL, NULL, NULL, 'Customer 1 Update', 'Testing', 'SMT Update', 'Cutting', '2022-10-03 08:38:36', 'sys-admin'),
('KEPI-WI-22-000003', 0, '2233441-02', 'U778B', 'Scope', 'YNN', 'YNNN', NULL, NULL, NULL, NULL, '2022-10-07 08:54:15', 'sys-admin'),
('KEPI-WI-22-000003', 1, '1122334-01', 'U776A', 'Scope', 'NYN', 'NYYN', NULL, NULL, NULL, NULL, '2022-10-10 11:23:47', 'sys-admin'),
('KEPI-WS-22-000002', 0, '2233441-02', 'U778B', NULL, NULL, NULL, 'Customer 2', 'Testing', 'SMT', 'Test', '2022-10-07 08:54:56', 'sys-admin'),
('KEPI-WS-22-000002', 1, '1122334-01', 'U776A', NULL, NULL, NULL, 'Customer 1 Update', 'Testing Update', 'SMT process', 'Test Update', '2022-10-10 14:43:12', 'sys-admin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `connection` text COLLATE utf8mb4_general_ci NOT NULL,
  `queue` text COLLATE utf8mb4_general_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `file_types`
--

CREATE TABLE `file_types` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `no_of_files` int NOT NULL,
  `labels` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `file_validations` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `file_maxsize` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `updatedby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `general_setting`
--

CREATE TABLE `general_setting` (
  `id` int NOT NULL,
  `setting_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `setting_value` text COLLATE utf8mb4_general_ci,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `createdon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `general_setting`
--

INSERT INTO `general_setting` (`id`, `setting_name`, `setting_value`, `createdby`, `createdon`) VALUES
(1, 'COMPANY_LOGO', '/storage/files/companylogo/sample-logo.jpg', 'sys-admin', '2022-08-17 22:19:52'),
(2, 'IPD_MODEL_API', 'http://192.168.88.1:8181/ipd-system/ipdfordms/searchAssycode', 'sys-admin', '2022-08-17 22:19:52');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(129, 'default', '{\"uuid\":\"d3955bfa-e977-43ef-b772-b68e62f4c21f\",\"displayName\":\"App\\\\Mail\\\\MailNotif\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":13:{s:8:\\\"mailable\\\";O:18:\\\"App\\\\Mail\\\\MailNotif\\\":29:{s:4:\\\"data\\\";a:10:{s:5:\\\"email\\\";s:19:\\\"husnulmub@gmail.com\\\";s:5:\\\"docID\\\";i:10;s:7:\\\"subject\\\";s:33:\\\"Approval Request DCN-CP-24-000001\\\";s:7:\\\"version\\\";i:0;s:7:\\\"dcnNumb\\\";s:16:\\\"DCN-CP-24-000001\\\";s:8:\\\"docTitle\\\";s:30:\\\"Technical Service Procedure XX\\\";s:7:\\\"docCrdt\\\";s:10:\\\"21-05-2024\\\";s:7:\\\"docCrby\\\";s:13:\\\"Administrator\\\";s:4:\\\"body\\\";s:60:\\\"A New document has been created for your review and approval\\\";s:6:\\\"mailto\\\";a:1:{i:0;O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;s:19:\\\"husnulmub@gmail.com\\\";}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}}}s:6:\\\"locale\\\";N;s:4:\\\"from\\\";a:0:{}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:19:\\\"husnulmub@gmail.com\\\";}}s:2:\\\"cc\\\";a:0:{}s:3:\\\"bcc\\\";a:0:{}s:7:\\\"replyTo\\\";a:0:{}s:7:\\\"subject\\\";N;s:8:\\\"markdown\\\";N;s:7:\\\"\\u0000*\\u0000html\\\";N;s:4:\\\"view\\\";N;s:8:\\\"textView\\\";N;s:8:\\\"viewData\\\";a:0:{}s:11:\\\"attachments\\\";a:0:{}s:14:\\\"rawAttachments\\\";a:0:{}s:15:\\\"diskAttachments\\\";a:0:{}s:9:\\\"callbacks\\\";a:0:{}s:5:\\\"theme\\\";N;s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";s:29:\\\"\\u0000*\\u0000assertionableRenderStrings\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1716285044, 1716285044),
(130, 'default', '{\"uuid\":\"4d806601-ced6-4081-9d15-64f07b9b1863\",\"displayName\":\"App\\\\Mail\\\\MailNotif\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":13:{s:8:\\\"mailable\\\";O:18:\\\"App\\\\Mail\\\\MailNotif\\\":29:{s:4:\\\"data\\\";a:9:{s:5:\\\"email\\\";s:19:\\\"husnulmub@gmail.com\\\";s:5:\\\"docID\\\";i:10;s:7:\\\"version\\\";s:1:\\\"0\\\";s:7:\\\"dcnNumb\\\";s:16:\\\"DCN-CP-24-000001\\\";s:8:\\\"docTitle\\\";s:30:\\\"Technical Service Procedure XX\\\";s:7:\\\"docCrdt\\\";s:10:\\\"21-05-2024\\\";s:7:\\\"docCrby\\\";s:9:\\\"sys-admin\\\";s:7:\\\"subject\\\";s:33:\\\"Approval Request DCN-CP-24-000001\\\";s:4:\\\"body\\\";s:36:\\\"This is for testing email using smtp\\\";}s:6:\\\"locale\\\";N;s:4:\\\"from\\\";a:0:{}s:2:\\\"to\\\";a:2:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:18:\\\"approval1@mail.com\\\";}i:1;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:19:\\\"husnulm15@gmail.com\\\";}}s:2:\\\"cc\\\";a:0:{}s:3:\\\"bcc\\\";a:0:{}s:7:\\\"replyTo\\\";a:0:{}s:7:\\\"subject\\\";N;s:8:\\\"markdown\\\";N;s:7:\\\"\\u0000*\\u0000html\\\";N;s:4:\\\"view\\\";N;s:8:\\\"textView\\\";N;s:8:\\\"viewData\\\";a:0:{}s:11:\\\"attachments\\\";a:0:{}s:14:\\\"rawAttachments\\\";a:0:{}s:15:\\\"diskAttachments\\\";a:0:{}s:9:\\\"callbacks\\\";a:0:{}s:5:\\\"theme\\\";N;s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";s:29:\\\"\\u0000*\\u0000assertionableRenderStrings\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1716285068, 1716285068);

-- --------------------------------------------------------

--
-- Struktur dari tabel `menugroups`
--

CREATE TABLE `menugroups` (
  `id` bigint UNSIGNED NOT NULL,
  `menugroup` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `groupicon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `_index` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `updatedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `menugroups`
--

INSERT INTO `menugroups` (`id`, `menugroup`, `groupicon`, `_index`, `created_at`, `updated_at`, `createdby`, `updatedby`) VALUES
(1, 'MASTER', 'fa fa-database', 1, '2022-07-26 02:12:00', NULL, 'sys-admin', ''),
(2, 'SETTINGS', 'fa fa-gear', 5, '2022-07-26 02:12:09', NULL, 'sys-admin', 'husnulmub@gmail.com'),
(3, 'TRANSACTION', 'fa fa-list', 2, '2022-07-26 02:12:09', NULL, 'sys-admin', ''),
(5, 'REPORTS', NULL, 4, '2022-07-26 23:07:03', NULL, 'husnulmub@gmail.com', 'husnulmub@gmail.com'),
(6, 'DOCUMENT', NULL, 3, '2022-08-26 06:08:52', NULL, 'husnulmub@gmail.com', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `menuroles`
--

CREATE TABLE `menuroles` (
  `menuid` int NOT NULL,
  `roleid` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `updatedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `menuroles`
--

INSERT INTO `menuroles` (`menuid`, `roleid`, `created_at`, `updated_at`, `createdby`, `updatedby`) VALUES
(1, 1, '2022-07-26 02:20:34', NULL, 'sys-admin', ''),
(1, 2, '2022-07-26 03:07:15', NULL, 'husnulmub@gmail.com', NULL),
(2, 1, '2022-07-26 02:20:34', NULL, 'sys-admin', ''),
(2, 2, '2022-07-26 03:07:19', NULL, 'husnulmub@gmail.com', NULL),
(3, 1, '2022-07-26 02:21:08', NULL, 'sys-admin', ''),
(4, 1, '2022-07-26 02:21:32', NULL, 'sys-admin', ''),
(5, 1, '2022-07-26 02:21:32', NULL, 'sys-admin', ''),
(6, 2, '2022-07-26 03:07:26', NULL, 'husnulmub@gmail.com', NULL),
(6, 3, '2022-08-05 01:08:21', NULL, 'husnulmub@gmail.com', NULL),
(7, 1, '2022-07-26 18:07:53', NULL, 'husnulmub@gmail.com', NULL),
(15, 1, '2022-08-02 19:08:40', NULL, 'husnulmub@gmail.com', NULL),
(16, 1, '2022-08-03 21:08:42', NULL, 'husnulmub@gmail.com', NULL),
(16, 2, '2022-08-07 06:08:39', NULL, 'husnulmub@gmail.com', NULL),
(16, 3, '2022-08-05 01:08:21', NULL, 'husnulmub@gmail.com', NULL),
(17, 1, '2022-08-07 09:08:31', NULL, 'husnulmub@gmail.com', NULL),
(17, 2, '2022-08-07 09:08:44', NULL, 'husnulmub@gmail.com', NULL),
(17, 3, '2022-08-07 09:08:56', NULL, 'husnulmub@gmail.com', NULL),
(19, 1, '2022-08-17 14:08:31', NULL, 'husnulmub@gmail.com', NULL),
(20, 1, '2022-08-17 14:08:34', NULL, 'husnulmub@gmail.com', NULL),
(21, 1, '2022-08-26 06:08:24', NULL, 'husnulmub@gmail.com', NULL),
(21, 2, '2022-09-28 14:09:38', NULL, 'husnulmub@gmail.com', NULL),
(22, 1, '2022-08-26 06:08:28', NULL, 'husnulmub@gmail.com', NULL),
(22, 2, '2022-09-28 14:09:45', NULL, 'husnulmub@gmail.com', NULL),
(23, 1, '2022-08-26 06:08:31', NULL, 'husnulmub@gmail.com', NULL),
(23, 2, '2022-09-28 14:09:53', NULL, 'husnulmub@gmail.com', NULL),
(24, 1, '2022-08-26 06:08:34', NULL, 'husnulmub@gmail.com', NULL),
(24, 2, '2022-09-28 14:09:49', NULL, 'husnulmub@gmail.com', NULL),
(26, 1, '2022-09-20 06:09:12', NULL, 'husnulmub@gmail.com', NULL),
(27, 1, '2022-09-28 14:09:57', NULL, 'husnulmub@gmail.com', NULL),
(27, 2, '2022-09-28 14:09:20', NULL, 'husnulmub@gmail.com', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `menus`
--

CREATE TABLE `menus` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `route` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `menugroup` int DEFAULT NULL,
  `menu_idx` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `updatedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `menus`
--

INSERT INTO `menus` (`id`, `name`, `route`, `menugroup`, `menu_idx`, `created_at`, `updated_at`, `createdby`, `updatedby`) VALUES
(1, 'Workflow Approval', 'config/workflow', 2, 4, '2022-07-26 02:12:52', NULL, 'sys-admin', 'husnulmub@gmail.com'),
(2, 'Document Type', 'master/doctype', 1, 1, '2022-07-26 02:12:52', NULL, 'sys-admin', ''),
(3, 'Document Area', 'master/docarea', 1, 2, '2022-07-26 02:12:52', NULL, 'sys-admin', ''),
(4, 'Users', 'config/users', 2, 1, '2022-07-26 02:12:52', NULL, 'sys-admin', ''),
(5, 'Roles', 'config/roles', 2, 3, '2022-07-26 02:12:52', NULL, 'sys-admin', ''),
(6, 'Create Document', 'transaction/document', 3, 1, '2022-07-26 02:12:52', NULL, 'sys-admin', 'husnulmub@gmail.com'),
(7, 'Menus', 'config/menus', 2, 2, '2022-07-26 02:12:52', NULL, 'sys-admin', 'husnulmub@gmail.com'),
(15, 'Document Level', 'master/doclevel', 1, 3, '2022-08-02 19:08:22', NULL, 'husnulmub@gmail.com', NULL),
(16, 'Document Approval', 'transaction/docapproval', 3, 2, '2022-08-03 21:08:28', NULL, 'husnulmub@gmail.com', NULL),
(17, 'Document List', 'transaction/doclist', 3, 3, '2022-08-07 09:08:05', NULL, 'husnulmub@gmail.com', 'husnulmub@gmail.com'),
(18, 'Document Revision', 'transaction/docrevision', 3, 4, '2022-08-09 03:08:19', NULL, 'husnulmub@gmail.com', NULL),
(19, 'Report Document List', 'reports/documentlist', 5, 3, '2022-08-17 14:08:07', NULL, 'husnulmub@gmail.com', NULL),
(20, 'General Setting', 'general/setting', 2, 5, '2022-08-17 14:08:21', NULL, 'husnulmub@gmail.com', NULL),
(21, 'Corporate Procedure', 'document/v1', 6, 1, '2022-08-26 06:08:46', NULL, 'husnulmub@gmail.com', NULL),
(22, 'Work Instuction', 'document/v2', 6, 2, '2022-08-26 06:08:46', NULL, 'husnulmub@gmail.com', NULL),
(23, 'Work Standard', 'document/v3', 6, 3, '2022-08-26 06:08:46', NULL, 'husnulmub@gmail.com', NULL),
(24, 'External Procedure', 'document/v4', 6, 4, '2022-08-26 06:08:46', NULL, 'husnulmub@gmail.com', NULL),
(25, 'Customer', 'master/customer', 1, 4, '2022-09-13 15:09:55', NULL, 'husnulmub@gmail.com', NULL),
(26, 'Object Authorization', 'config/objectauth', 2, 6, '2022-09-20 06:09:00', NULL, 'husnulmub@gmail.com', 'husnulmub@gmail.com'),
(27, 'Rejected Document', 'document/rejectedlist', 3, 5, '2022-09-28 14:09:42', NULL, 'husnulmub@gmail.com', NULL);

--
-- Trigger `menus`
--
DELIMITER $$
CREATE TRIGGER `deleteMenuAssignment` AFTER DELETE ON `menus` FOR EACH ROW DELETE FROM menuroles WHERE menuid = OLD.id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `setMenuDisIndex` BEFORE INSERT ON `menus` FOR EACH ROW set NEW.menu_idx = (SELECT count(menugroup)+1 from menus WHERE menugroup = NEW.menugroup)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2022_06_27_031456_create_file_types_table', 1),
(5, '2022_06_27_035543_create_roles_table', 1),
(6, '2022_06_27_035921_create_menugroups_table', 1),
(7, '2022_06_27_035945_create_menus_table', 1),
(8, '2022_06_27_040346_create_menuroles_table', 1),
(9, '2022_06_27_040422_create_userroles_table', 1),
(10, '2022_06_27_041244_create_activities_table', 1),
(11, '2022_06_27_041402_update_activities_add_field_document_table', 1),
(12, '2022_06_27_041507_create_documents_table', 1),
(13, '2022_06_27_042159_create_document_attachments_table', 1),
(14, '2022_08_08_114517_create_jobs_table', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `object_auth`
--

CREATE TABLE `object_auth` (
  `object_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `object_description` varchar(80) COLLATE utf8mb4_general_ci NOT NULL,
  `createdon` date NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `object_auth`
--

INSERT INTO `object_auth` (`object_name`, `object_description`, `createdon`, `createdby`) VALUES
('ALLOW_CHANGE_DOC', 'Allow user to change Document', '2022-08-15', 'sys-admin'),
('ALLOW_DISPLAY_ALL_DOC', 'Allow user to display all document', '2022-08-15', 'sys-admin'),
('ALLOW_DISPLAY_APP_DOC', 'Allow Display Approved Document', '2022-08-15', 'sys-admin'),
('ALLOW_DISPLAY_OBS_DOC', 'Allow Display Obsolete Document', '2022-08-15', 'sys-admin'),
('ALLOW_DOWNLOAD_DOC', 'Allow user to download Document Attachment', '2022-08-15', 'sys-admin'),
('ALLOW_DOWNLOAD_ORIGINAL_DOC', 'Allow Download Original Document', '2022-09-18', 'sys-admin'),
('ALLOW_UPLOAD_ORIGINAL_DOC', 'Allow Upload Original Document', '2022-09-18', 'sys-admin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `token` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `rolename` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `rolestatus` int NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `updatedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `rolename`, `rolestatus`, `createdby`, `updatedby`, `created_at`, `updated_at`) VALUES
(1, 'SYS-ADMIN', 1, 'sys-admin', '', '2022-01-26 02:45:03', NULL),
(2, 'APPROVAL1', 1, 'husnulmub@gmail.com', NULL, '2022-07-26 01:07:22', NULL),
(3, 'CREATOR1', 1, 'husnulmub@gmail.com', NULL, '2022-08-05 01:08:49', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `userroles`
--

CREATE TABLE `userroles` (
  `userid` int NOT NULL,
  `roleid` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `updatedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `userroles`
--

INSERT INTO `userroles` (`userid`, `roleid`, `created_at`, `updated_at`, `createdby`, `updatedby`) VALUES
(1, 1, '2022-07-26 02:19:44', NULL, 'sys-admin', ''),
(2, 3, '2022-08-05 01:08:02', NULL, 'husnulmub@gmail.com', NULL),
(3, 2, '2022-07-26 03:07:14', NULL, 'husnulmub@gmail.com', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `s_signfile` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `updatedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `email_verified_at`, `password`, `remember_token`, `s_signfile`, `created_at`, `updated_at`, `createdby`, `updatedby`) VALUES
(1, 'Administrator', 'husnulmub@gmail.com', 'sys-admin', NULL, '$2y$12$gJfHru7EAm5/hO//6vTPy.IHPcCLRSEs7pzu9g1aP5Urjq7Se4VN2', NULL, 'storage/files/e_signature/esign2.png', '2022-07-26 07:36:29', NULL, '', ''),
(2, 'creator1', 'creator1@mail.com', 'creator1', NULL, '$2y$12$tB8SUN5MbAJtZ.j/cIAQ0uwEvmu/o/S/L4UEHMW42fuaBn7RWnSC.', NULL, NULL, NULL, NULL, 'husnulmub@gmail.com', NULL),
(3, 'Approval1 Update', 'approval1@mail.com', 'approval1', NULL, '$2y$12$tB8SUN5MbAJtZ.j/cIAQ0uwEvmu/o/S/L4UEHMW42fuaBn7RWnSC.', NULL, 'storage/files/e_signature/esign3.png', NULL, NULL, 'husnulmub@gmail.com', NULL),
(5, 'Admin2', 'husnulm15@gmail.com', 'admin2', NULL, '$2y$12$tB8SUN5MbAJtZ.j/cIAQ0uwEvmu/o/S/L4UEHMW42fuaBn7RWnSC.', NULL, 'storage/files/e_signature/esign3.png', '2022-08-15 02:08:27', NULL, 'husnulmub@gmail.com', NULL),
(7, 'Test User1', 'user1@gmail.com', 'user1', NULL, '$2y$12$tB8SUN5MbAJtZ.j/cIAQ0uwEvmu/o/S/L4UEHMW42fuaBn7RWnSC.', NULL, 'storage/files/e_signature/esign1.png', '2022-08-16 08:08:50', NULL, 'husnulmub@gmail.com', NULL),
(8, 'testt', 'testmail@mail.com', 'tess', NULL, '$2y$12$YWbmigtH8OxYi4X4cXG/Wu2eHkfND.1.tGVkQY7uqeF8aGGnqCahe', NULL, NULL, '2022-09-14 01:09:23', NULL, 'husnulmub@gmail.com', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_object_auth`
--

CREATE TABLE `user_object_auth` (
  `userid` int NOT NULL,
  `object_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `object_val` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `createdon` date NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user_object_auth`
--

INSERT INTO `user_object_auth` (`userid`, `object_name`, `object_val`, `createdon`, `createdby`) VALUES
(1, 'ALLOW_CHANGE_DOC', 'N', '2022-08-15', 'sys-admin'),
(1, 'ALLOW_DISPLAY_ALL_DOC', 'Y', '2022-08-19', 'sys-admin'),
(1, 'ALLOW_DOWNLOAD_DOC', 'Y', '2022-09-19', 'sys-admin'),
(1, 'ALLOW_DOWNLOAD_ORIGINAL_DOC', 'Y', '2022-09-19', 'sys-admin'),
(1, 'ALLOW_UPLOAD_ORIGINAL_DOC', 'Y', '2022-09-19', 'sys-admin'),
(5, 'ALLOW_CHANGE_DOC', 'Y', '2022-08-15', 'sys-admin'),
(5, 'ALLOW_DOWNLOAD_DOC', 'N', '2022-08-15', 'sys-admin'),
(7, 'ALLOW_DISPLAY_OBS_DOC', 'Y', '2022-08-22', 'sys-admin');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_docarea_affected`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_docarea_affected` (
`dcn_number` varchar(20)
,`doc_version` int
,`docarea` int
,`createdon` datetime
,`createdby` varchar(50)
,`docareaname` varchar(50)
,`mail` varchar(60)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_doctype_wfgroup`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_doctype_wfgroup` (
`id` int
,`doctype` varchar(50)
,`workflow_group` int
,`createdon` datetime
,`createdby` varchar(50)
,`wf_groupname` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_doctype_workflow`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_doctype_workflow` (
`doctypeid` int
,`doctype` varchar(50)
,`workflow_group` int
,`approval_level` int
,`creator` int
,`approver` int
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_documents`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_documents` (
`id` int unsigned
,`dcn_number` varchar(20)
,`document_type` varchar(30)
,`document_level` int
,`document_number` varchar(30)
,`document_title` varchar(150)
,`description` longtext
,`workflow_group` int
,`status` varchar(20)
,`revision_number` int
,`effectivity_date` date
,`created_at` timestamp
,`updated_at` timestamp
,`createdby` varchar(50)
,`updatedby` varchar(50)
,`doctype` varchar(50)
,`crtdate` date
,`latest_version` int
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_document_approvals`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_document_approvals` (
`id` int
,`docid` int unsigned
,`dcn_number` varchar(20)
,`approval_version` int
,`workflow_group` int
,`approver_level` int
,`approver_id` int
,`approval_status` varchar(1)
,`approval_remark` longtext
,`approval_date` datetime
,`createdon` datetime
,`document_type` varchar(30)
,`document_level` int
,`document_title` varchar(150)
,`description` longtext
,`status` varchar(20)
,`revision_number` int
,`effectivity_date` date
,`created_at` timestamp
,`doctype` varchar(50)
,`createdby` varchar(50)
,`is_active` varchar(1)
,`approver_name` varchar(50)
,`workflow_categories` int
,`wf_categoryname` varchar(50)
,`doc_version_status` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_document_approvals_v2`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_document_approvals_v2` (
`id` int
,`docid` int unsigned
,`dcn_number` varchar(20)
,`approval_version` int
,`workflow_group` int
,`approver_level` int
,`approver_id` int
,`creator_id` int
,`approval_status` varchar(1)
,`approval_remark` longtext
,`approval_date` datetime
,`createdon` datetime
,`document_type` varchar(30)
,`document_level` int
,`document_title` varchar(150)
,`description` longtext
,`status` varchar(20)
,`revision_number` int
,`effectivity_date` date
,`created_at` timestamp
,`doctype` varchar(50)
,`createdby` varchar(50)
,`is_active` varchar(1)
,`approver_name` varchar(50)
,`doc_version_status` varchar(20)
,`wf_categoryname` varchar(80)
,`approved_by` varchar(50)
,`esign` text
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_document_historys`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_document_historys` (
`id` int
,`dcn_number` varchar(20)
,`doc_version` int
,`activity` longtext
,`createdby` varchar(50)
,`createdon` datetime
,`updatedon` datetime
,`created_date` date
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_document_latest_version_status`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_document_latest_version_status` (
`id` int unsigned
,`dcn_number` varchar(20)
,`document_type` varchar(30)
,`document_level` int
,`document_number` varchar(30)
,`document_title` varchar(150)
,`description` longtext
,`workflow_group` int
,`status` varchar(20)
,`revision_number` int
,`effectivity_date` date
,`created_at` timestamp
,`updated_at` timestamp
,`createdby` varchar(50)
,`updatedby` varchar(50)
,`doctype` varchar(50)
,`crtdate` date
,`latest_version` int
,`version_status` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_document_report`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_document_report` (
`dcn_number` varchar(20)
,`doctype` varchar(50)
,`document_number` varchar(30)
,`document_title` varchar(150)
,`doc_version` int
,`effectivity_date` date
,`established_date` date
,`validity_date` date
,`createdby` varchar(50)
,`created_at` timestamp
,`crtdate` date
,`version_status` varchar(20)
,`document_type` varchar(30)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_docversion_approval`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_docversion_approval` (
`id` int
,`dcn_number` varchar(20)
,`approval_version` int
,`workflow_group` int
,`approver_level` int
,`approver_id` int
,`is_active` varchar(1)
,`approval_status` varchar(1)
,`approval_remark` longtext
,`approval_date` datetime
,`createdon` datetime
,`remark` longtext
,`effectivity_date` date
,`status` varchar(20)
,`document_type` varchar(30)
,`document_title` varchar(150)
,`created_at` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_doc_approval_list`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_doc_approval_list` (
`docid` int unsigned
,`dcn_number` varchar(20)
,`document_title` varchar(150)
,`document_type` varchar(30)
,`doctype` varchar(50)
,`doc_version` int
,`doc_version_status` varchar(20)
,`remark` longtext
,`approver_level` int
,`approver_id` int
,`creator_id` int
,`is_active` varchar(1)
,`approval_status` varchar(1)
,`approval_remark` longtext
,`approval_date` datetime
,`createdby` varchar(50)
,`created_at` timestamp
,`crtdate` date
,`approval_version` int
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_doc_area_emails`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_doc_area_emails` (
`dcn_number` varchar(20)
,`docarea` int
,`doc_version` int
,`createdon` datetime
,`createdby` varchar(50)
,`email` varchar(80)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_menuroles`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_menuroles` (
`menuid` int
,`roleid` int
,`rolename` varchar(50)
,`name` varchar(100)
,`menugroup` int
,`group` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_report_doclist`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_report_doclist` (
`id` int unsigned
,`dcn_number` varchar(20)
,`document_type` varchar(30)
,`document_level` int
,`document_number` varchar(30)
,`document_title` varchar(150)
,`description` longtext
,`workflow_group` int
,`status` varchar(20)
,`revision_number` int
,`effectivity_date` date
,`created_at` timestamp
,`updated_at` timestamp
,`createdby` varchar(50)
,`updatedby` varchar(50)
,`doctype` varchar(50)
,`crtdate` date
,`doc_version` int
,`version_remark` longtext
,`version_ef_date` date
,`createdon` datetime
,`changeon` datetime
,`version_status` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_usermenus`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_usermenus` (
`id` bigint unsigned
,`menu_desc` varchar(100)
,`route` varchar(100)
,`menugroup` int
,`menu_idx` int
,`groupname` varchar(50)
,`groupicon` varchar(50)
,`group_idx` int
,`roleid` int
,`rolename` varchar(50)
,`userid` int
,`name_of_user` varchar(100)
,`email` varchar(100)
,`username` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_userroles`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_userroles` (
`roleid` int
,`rolename` varchar(50)
,`userid` int
,`name` varchar(100)
,`email` varchar(100)
,`username` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_user_obj_auth`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_user_obj_auth` (
`userid` int
,`object_name` varchar(30)
,`object_val` varchar(10)
,`createdon` date
,`createdby` varchar(50)
,`object_description` varchar(80)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_workflow_assignments`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_workflow_assignments` (
`workflow_group` int
,`wf_groupname` varchar(50)
,`approval_level` int
,`workflow_categories` int
,`wf_categoryname` varchar(50)
,`creator` varchar(50)
,`approver` varchar(50)
,`creatorid` int
,`approverid` int
,`approver_email` varchar(80)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `workflow_assignments`
--

CREATE TABLE `workflow_assignments` (
  `workflow_group` int NOT NULL,
  `approval_level` int NOT NULL,
  `workflow_categories` int NOT NULL,
  `creator` int NOT NULL,
  `approver` int NOT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `workflow_assignments`
--

INSERT INTO `workflow_assignments` (`workflow_group`, `approval_level`, `workflow_categories`, `creator`, `approver`, `createdon`, `createdby`) VALUES
(3, 1, 1, 1, 1, '2022-08-15 10:08:23', 'husnulmub@gmail.com'),
(3, 2, 4, 1, 3, '2022-08-15 10:08:23', 'husnulmub@gmail.com'),
(3, 2, 4, 1, 5, '2022-08-15 10:08:23', 'husnulmub@gmail.com'),
(4, 1, 1, 2, 1, '2022-08-15 10:08:31', 'husnulmub@gmail.com'),
(4, 1, 4, 2, 5, '2022-08-15 10:08:31', 'husnulmub@gmail.com'),
(4, 2, 4, 2, 3, '2022-08-15 10:08:31', 'husnulmub@gmail.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `workflow_categories`
--

CREATE TABLE `workflow_categories` (
  `id` int NOT NULL,
  `workflow_category` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `workflow_categories`
--

INSERT INTO `workflow_categories` (`id`, `workflow_category`, `createdon`, `createdby`) VALUES
(1, 'Reviewer', '2022-08-03 14:08:01', 'husnulmub@gmail.com'),
(4, 'Approver', '2022-08-03 15:08:05', 'husnulmub@gmail.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `workflow_groups`
--

CREATE TABLE `workflow_groups` (
  `id` int NOT NULL,
  `workflow_group` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `createdon` datetime DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `workflow_groups`
--

INSERT INTO `workflow_groups` (`id`, `workflow_group`, `createdon`, `createdby`) VALUES
(3, 'Approval Group 1', '2022-08-03 07:08:33', 'husnulmub@gmail.com'),
(4, 'Approval Group 2', '2022-08-03 07:08:33', 'husnulmub@gmail.com');

-- --------------------------------------------------------

--
-- Struktur untuk view `v_docarea_affected`
--
DROP TABLE IF EXISTS `v_docarea_affected`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_docarea_affected`  AS SELECT `a`.`dcn_number` AS `dcn_number`, `a`.`doc_version` AS `doc_version`, `a`.`docarea` AS `docarea`, `a`.`createdon` AS `createdon`, `a`.`createdby` AS `createdby`, `b`.`docarea` AS `docareaname`, `b`.`mail` AS `mail` FROM (`document_affected_areas` `a` join `docareas` `b` on((`a`.`docarea` = `b`.`id`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_doctype_wfgroup`
--
DROP TABLE IF EXISTS `v_doctype_wfgroup`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_doctype_wfgroup`  AS SELECT `a`.`id` AS `id`, `a`.`doctype` AS `doctype`, `a`.`workflow_group` AS `workflow_group`, `a`.`createdon` AS `createdon`, `a`.`createdby` AS `createdby`, `b`.`workflow_group` AS `wf_groupname` FROM (`doctypes` `a` left join `workflow_groups` `b` on((`a`.`workflow_group` = `b`.`id`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_doctype_workflow`
--
DROP TABLE IF EXISTS `v_doctype_workflow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_doctype_workflow`  AS SELECT DISTINCT `b`.`id` AS `doctypeid`, `b`.`doctype` AS `doctype`, `a`.`workflow_group` AS `workflow_group`, `a`.`approval_level` AS `approval_level`, `a`.`creator` AS `creator`, `a`.`approver` AS `approver` FROM (`workflow_assignments` `a` join `doctypes` `b` on((`a`.`workflow_group` = `b`.`workflow_group`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_documents`
--
DROP TABLE IF EXISTS `v_documents`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_documents`  AS SELECT `a`.`id` AS `id`, `a`.`dcn_number` AS `dcn_number`, `a`.`document_type` AS `document_type`, `a`.`document_level` AS `document_level`, `a`.`document_number` AS `document_number`, `a`.`document_title` AS `document_title`, `a`.`description` AS `description`, `a`.`workflow_group` AS `workflow_group`, `a`.`status` AS `status`, `a`.`revision_number` AS `revision_number`, `a`.`effectivity_date` AS `effectivity_date`, `a`.`created_at` AS `created_at`, `a`.`updated_at` AS `updated_at`, `a`.`createdby` AS `createdby`, `a`.`updatedby` AS `updatedby`, `b`.`doctype` AS `doctype`, cast(`a`.`created_at` as date) AS `crtdate`, `fGetMaxVersion`(`a`.`dcn_number`) AS `latest_version` FROM (`documents` `a` join `doctypes` `b` on((`a`.`document_type` = `b`.`id`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_document_approvals`
--
DROP TABLE IF EXISTS `v_document_approvals`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_document_approvals`  AS SELECT `a`.`id` AS `id`, `b`.`id` AS `docid`, `a`.`dcn_number` AS `dcn_number`, `a`.`approval_version` AS `approval_version`, `a`.`workflow_group` AS `workflow_group`, `a`.`approver_level` AS `approver_level`, `a`.`approver_id` AS `approver_id`, `a`.`approval_status` AS `approval_status`, `a`.`approval_remark` AS `approval_remark`, `a`.`approval_date` AS `approval_date`, `a`.`createdon` AS `createdon`, `b`.`document_type` AS `document_type`, `b`.`document_level` AS `document_level`, `b`.`document_title` AS `document_title`, `b`.`description` AS `description`, `b`.`status` AS `status`, `b`.`revision_number` AS `revision_number`, `b`.`effectivity_date` AS `effectivity_date`, `b`.`created_at` AS `created_at`, `b`.`doctype` AS `doctype`, `b`.`createdby` AS `createdby`, `a`.`is_active` AS `is_active`, `fGetUserName`(`a`.`approver_id`) AS `approver_name`, `c`.`workflow_categories` AS `workflow_categories`, `c`.`wf_categoryname` AS `wf_categoryname`, `d`.`status` AS `doc_version_status` FROM (((`document_approvals` `a` join `v_documents` `b` on((`a`.`dcn_number` = `b`.`dcn_number`))) left join `v_workflow_assignments` `c` on(((`a`.`workflow_group` = `c`.`workflow_group`) and (`a`.`approver_level` = `c`.`approval_level`)))) join `document_versions` `d` on(((`b`.`dcn_number` = `d`.`dcn_number`) and (`a`.`approval_version` = `d`.`doc_version`)))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_document_approvals_v2`
--
DROP TABLE IF EXISTS `v_document_approvals_v2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_document_approvals_v2`  AS SELECT `a`.`id` AS `id`, `b`.`id` AS `docid`, `a`.`dcn_number` AS `dcn_number`, `a`.`approval_version` AS `approval_version`, `a`.`workflow_group` AS `workflow_group`, `a`.`approver_level` AS `approver_level`, `a`.`approver_id` AS `approver_id`, `a`.`creator_id` AS `creator_id`, `a`.`approval_status` AS `approval_status`, `a`.`approval_remark` AS `approval_remark`, `a`.`approval_date` AS `approval_date`, `a`.`createdon` AS `createdon`, `b`.`document_type` AS `document_type`, `b`.`document_level` AS `document_level`, `b`.`document_title` AS `document_title`, `b`.`description` AS `description`, `b`.`status` AS `status`, `b`.`revision_number` AS `revision_number`, `b`.`effectivity_date` AS `effectivity_date`, `b`.`created_at` AS `created_at`, `b`.`doctype` AS `doctype`, `b`.`createdby` AS `createdby`, `a`.`is_active` AS `is_active`, `fGetUserName`(`a`.`approver_id`) AS `approver_name`, `d`.`status` AS `doc_version_status`, `fGetWfCtgrName`(`a`.`workflow_group`,`a`.`approver_level`,`a`.`approver_id`,`a`.`creator_id`) AS `wf_categoryname`, `a`.`approved_by` AS `approved_by`, `fGetUserSignature`(`a`.`approved_by`) AS `esign` FROM ((`document_approvals` `a` join `v_documents` `b` on((`a`.`dcn_number` = `b`.`dcn_number`))) join `document_versions` `d` on(((`b`.`dcn_number` = `d`.`dcn_number`) and (`a`.`approval_version` = `d`.`doc_version`)))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_document_historys`
--
DROP TABLE IF EXISTS `v_document_historys`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_document_historys`  AS SELECT `document_historys`.`id` AS `id`, `document_historys`.`dcn_number` AS `dcn_number`, `document_historys`.`doc_version` AS `doc_version`, `document_historys`.`activity` AS `activity`, `document_historys`.`createdby` AS `createdby`, `document_historys`.`createdon` AS `createdon`, `document_historys`.`updatedon` AS `updatedon`, cast(`document_historys`.`createdon` as date) AS `created_date` FROM `document_historys` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_document_latest_version_status`
--
DROP TABLE IF EXISTS `v_document_latest_version_status`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_document_latest_version_status`  AS SELECT `a`.`id` AS `id`, `a`.`dcn_number` AS `dcn_number`, `a`.`document_type` AS `document_type`, `a`.`document_level` AS `document_level`, `a`.`document_number` AS `document_number`, `a`.`document_title` AS `document_title`, `a`.`description` AS `description`, `a`.`workflow_group` AS `workflow_group`, `a`.`status` AS `status`, `a`.`revision_number` AS `revision_number`, `a`.`effectivity_date` AS `effectivity_date`, `a`.`created_at` AS `created_at`, `a`.`updated_at` AS `updated_at`, `a`.`createdby` AS `createdby`, `a`.`updatedby` AS `updatedby`, `a`.`doctype` AS `doctype`, `a`.`crtdate` AS `crtdate`, `a`.`latest_version` AS `latest_version`, `b`.`status` AS `version_status` FROM (`v_documents` `a` join `document_versions` `b` on(((`a`.`dcn_number` = `b`.`dcn_number`) and (`a`.`latest_version` = `b`.`doc_version`)))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_document_report`
--
DROP TABLE IF EXISTS `v_document_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_document_report`  AS SELECT `a`.`dcn_number` AS `dcn_number`, `c`.`doctype` AS `doctype`, `a`.`document_number` AS `document_number`, `a`.`document_title` AS `document_title`, `b`.`doc_version` AS `doc_version`, `b`.`effectivity_date` AS `effectivity_date`, `b`.`established_date` AS `established_date`, `b`.`validity_date` AS `validity_date`, `a`.`createdby` AS `createdby`, `a`.`created_at` AS `created_at`, cast(`a`.`created_at` as date) AS `crtdate`, `b`.`status` AS `version_status`, `a`.`document_type` AS `document_type` FROM ((`documents` `a` join `document_versions` `b` on((`a`.`dcn_number` = `b`.`dcn_number`))) join `doctypes` `c` on((`a`.`document_type` = `c`.`id`))) ORDER BY `a`.`document_type` ASC, `a`.`dcn_number` ASC, `b`.`doc_version` ASC ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_docversion_approval`
--
DROP TABLE IF EXISTS `v_docversion_approval`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_docversion_approval`  AS SELECT DISTINCT `a`.`id` AS `id`, `a`.`dcn_number` AS `dcn_number`, `a`.`approval_version` AS `approval_version`, `a`.`workflow_group` AS `workflow_group`, `a`.`approver_level` AS `approver_level`, `a`.`approver_id` AS `approver_id`, `a`.`is_active` AS `is_active`, `a`.`approval_status` AS `approval_status`, `a`.`approval_remark` AS `approval_remark`, `a`.`approval_date` AS `approval_date`, `a`.`createdon` AS `createdon`, `b`.`remark` AS `remark`, `b`.`effectivity_date` AS `effectivity_date`, `b`.`status` AS `status`, `c`.`document_type` AS `document_type`, `c`.`document_title` AS `document_title`, `c`.`created_at` AS `created_at` FROM ((`document_approvals` `a` join `document_versions` `b` on(((`a`.`dcn_number` = `b`.`dcn_number`) and (`a`.`approval_version` = `b`.`doc_version`)))) join `documents` `c` on((`a`.`dcn_number` = `c`.`dcn_number`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_doc_approval_list`
--
DROP TABLE IF EXISTS `v_doc_approval_list`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_doc_approval_list`  AS SELECT `a`.`id` AS `docid`, `a`.`dcn_number` AS `dcn_number`, `a`.`document_title` AS `document_title`, `a`.`document_type` AS `document_type`, `a`.`doctype` AS `doctype`, `b`.`doc_version` AS `doc_version`, `b`.`status` AS `doc_version_status`, `b`.`remark` AS `remark`, `c`.`approver_level` AS `approver_level`, `c`.`approver_id` AS `approver_id`, `c`.`creator_id` AS `creator_id`, `c`.`is_active` AS `is_active`, `c`.`approval_status` AS `approval_status`, `c`.`approval_remark` AS `approval_remark`, `c`.`approval_date` AS `approval_date`, `a`.`createdby` AS `createdby`, `a`.`created_at` AS `created_at`, `a`.`crtdate` AS `crtdate`, `c`.`approval_version` AS `approval_version` FROM ((`v_documents` `a` join `document_versions` `b` on((`a`.`dcn_number` = `b`.`dcn_number`))) join `document_approvals` `c` on(((`a`.`dcn_number` = `c`.`dcn_number`) and (`b`.`doc_version` = `c`.`approval_version`)))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_doc_area_emails`
--
DROP TABLE IF EXISTS `v_doc_area_emails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_doc_area_emails`  AS SELECT `a`.`dcn_number` AS `dcn_number`, `a`.`docarea` AS `docarea`, `a`.`doc_version` AS `doc_version`, `a`.`createdon` AS `createdon`, `a`.`createdby` AS `createdby`, `b`.`email` AS `email` FROM (`document_affected_areas` `a` left join `docarea_emails` `b` on((`a`.`docarea` = `b`.`docareaid`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_menuroles`
--
DROP TABLE IF EXISTS `v_menuroles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_menuroles`  AS SELECT `a`.`menuid` AS `menuid`, `a`.`roleid` AS `roleid`, `c`.`rolename` AS `rolename`, `b`.`name` AS `name`, `b`.`menugroup` AS `menugroup`, `d`.`menugroup` AS `group` FROM (((`menuroles` `a` join `menus` `b` on((`a`.`menuid` = `b`.`id`))) join `roles` `c` on((`a`.`roleid` = `c`.`id`))) left join `menugroups` `d` on((`b`.`menugroup` = `d`.`id`))) ORDER BY `a`.`menuid` ASC ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_report_doclist`
--
DROP TABLE IF EXISTS `v_report_doclist`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_report_doclist`  AS SELECT `a`.`id` AS `id`, `a`.`dcn_number` AS `dcn_number`, `a`.`document_type` AS `document_type`, `a`.`document_level` AS `document_level`, `a`.`document_number` AS `document_number`, `a`.`document_title` AS `document_title`, `a`.`description` AS `description`, `a`.`workflow_group` AS `workflow_group`, `a`.`status` AS `status`, `a`.`revision_number` AS `revision_number`, `a`.`effectivity_date` AS `effectivity_date`, `a`.`created_at` AS `created_at`, `a`.`updated_at` AS `updated_at`, `a`.`createdby` AS `createdby`, `a`.`updatedby` AS `updatedby`, `a`.`doctype` AS `doctype`, `a`.`crtdate` AS `crtdate`, `b`.`doc_version` AS `doc_version`, `b`.`remark` AS `version_remark`, `b`.`effectivity_date` AS `version_ef_date`, `b`.`createdon` AS `createdon`, `b`.`changeon` AS `changeon`, `b`.`status` AS `version_status` FROM (`v_documents` `a` join `document_versions` `b` on((`a`.`dcn_number` = `b`.`dcn_number`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_usermenus`
--
DROP TABLE IF EXISTS `v_usermenus`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_usermenus`  AS SELECT `a`.`id` AS `id`, `a`.`name` AS `menu_desc`, `a`.`route` AS `route`, `a`.`menugroup` AS `menugroup`, `a`.`menu_idx` AS `menu_idx`, `g`.`menugroup` AS `groupname`, `g`.`groupicon` AS `groupicon`, `g`.`_index` AS `group_idx`, `b`.`roleid` AS `roleid`, `c`.`rolename` AS `rolename`, `d`.`userid` AS `userid`, `f`.`name` AS `name_of_user`, `f`.`email` AS `email`, `f`.`username` AS `username` FROM (((((`menus` `a` join `menuroles` `b` on((`a`.`id` = `b`.`menuid`))) join `roles` `c` on((`b`.`roleid` = `c`.`id`))) join `userroles` `d` on((`b`.`roleid` = `d`.`roleid`))) join `users` `f` on((`d`.`userid` = `f`.`id`))) left join `menugroups` `g` on((`a`.`menugroup` = `g`.`id`))) ORDER BY `a`.`menu_idx` ASC, `g`.`_index` ASC ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_userroles`
--
DROP TABLE IF EXISTS `v_userroles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_userroles`  AS SELECT `a`.`roleid` AS `roleid`, `c`.`rolename` AS `rolename`, `a`.`userid` AS `userid`, `b`.`name` AS `name`, `b`.`email` AS `email`, `b`.`username` AS `username` FROM ((`userroles` `a` join `users` `b` on((`a`.`userid` = `b`.`id`))) join `roles` `c` on((`a`.`roleid` = `c`.`id`))) ORDER BY `c`.`id` ASC ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_user_obj_auth`
--
DROP TABLE IF EXISTS `v_user_obj_auth`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_user_obj_auth`  AS SELECT `a`.`userid` AS `userid`, `a`.`object_name` AS `object_name`, `a`.`object_val` AS `object_val`, `a`.`createdon` AS `createdon`, `a`.`createdby` AS `createdby`, `b`.`object_description` AS `object_description` FROM (`user_object_auth` `a` join `object_auth` `b` on((`a`.`object_name` = `b`.`object_name`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_workflow_assignments`
--
DROP TABLE IF EXISTS `v_workflow_assignments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_workflow_assignments`  AS SELECT `a`.`workflow_group` AS `workflow_group`, `b`.`workflow_group` AS `wf_groupname`, `a`.`approval_level` AS `approval_level`, `a`.`workflow_categories` AS `workflow_categories`, `c`.`workflow_category` AS `wf_categoryname`, `fGetUserName`(`a`.`creator`) AS `creator`, `fGetUserName`(`a`.`approver`) AS `approver`, `a`.`creator` AS `creatorid`, `a`.`approver` AS `approverid`, `fGetEmail`(`a`.`approver`) AS `approver_email` FROM ((`workflow_assignments` `a` join `workflow_groups` `b` on((`a`.`workflow_group` = `b`.`id`))) join `workflow_categories` `c` on((`a`.`workflow_categories` = `c`.`id`))) ORDER BY `a`.`workflow_group` ASC, `a`.`approval_level` ASC ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activities_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `approval_attachments`
--
ALTER TABLE `approval_attachments`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customerid`);

--
-- Indeks untuk tabel `dcn_nriv`
--
ALTER TABLE `dcn_nriv`
  ADD PRIMARY KEY (`year`,`object`);

--
-- Indeks untuk tabel `docareas`
--
ALTER TABLE `docareas`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `docarea_emails`
--
ALTER TABLE `docarea_emails`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `doclevels`
--
ALTER TABLE `doclevels`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `doctypes`
--
ALTER TABLE `doctypes`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dcn_number` (`dcn_number`);

--
-- Indeks untuk tabel `document_affected_areas`
--
ALTER TABLE `document_affected_areas`
  ADD PRIMARY KEY (`dcn_number`,`docarea`,`doc_version`);

--
-- Indeks untuk tabel `document_approvals`
--
ALTER TABLE `document_approvals`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `document_attachments`
--
ALTER TABLE `document_attachments`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `document_historys`
--
ALTER TABLE `document_historys`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `document_versions`
--
ALTER TABLE `document_versions`
  ADD PRIMARY KEY (`dcn_number`,`doc_version`);

--
-- Indeks untuk tabel `document_wi`
--
ALTER TABLE `document_wi`
  ADD PRIMARY KEY (`dcn_number`,`doc_version`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `file_types`
--
ALTER TABLE `file_types`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `general_setting`
--
ALTER TABLE `general_setting`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `menugroups`
--
ALTER TABLE `menugroups`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `menuroles`
--
ALTER TABLE `menuroles`
  ADD PRIMARY KEY (`menuid`,`roleid`);

--
-- Indeks untuk tabel `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `object_auth`
--
ALTER TABLE `object_auth`
  ADD PRIMARY KEY (`object_name`);

--
-- Indeks untuk tabel `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `userroles`
--
ALTER TABLE `userroles`
  ADD PRIMARY KEY (`userid`,`roleid`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- Indeks untuk tabel `user_object_auth`
--
ALTER TABLE `user_object_auth`
  ADD PRIMARY KEY (`userid`,`object_name`);

--
-- Indeks untuk tabel `workflow_assignments`
--
ALTER TABLE `workflow_assignments`
  ADD PRIMARY KEY (`workflow_group`,`approval_level`,`workflow_categories`,`creator`,`approver`);

--
-- Indeks untuk tabel `workflow_categories`
--
ALTER TABLE `workflow_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `workflow_groups`
--
ALTER TABLE `workflow_groups`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `activities`
--
ALTER TABLE `activities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `approval_attachments`
--
ALTER TABLE `approval_attachments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `customers`
--
ALTER TABLE `customers`
  MODIFY `customerid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `docareas`
--
ALTER TABLE `docareas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `docarea_emails`
--
ALTER TABLE `docarea_emails`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `doclevels`
--
ALTER TABLE `doclevels`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `doctypes`
--
ALTER TABLE `doctypes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `document_approvals`
--
ALTER TABLE `document_approvals`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT untuk tabel `document_attachments`
--
ALTER TABLE `document_attachments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT untuk tabel `document_historys`
--
ALTER TABLE `document_historys`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT untuk tabel `file_types`
--
ALTER TABLE `file_types`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `general_setting`
--
ALTER TABLE `general_setting`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT untuk tabel `menugroups`
--
ALTER TABLE `menugroups`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `workflow_categories`
--
ALTER TABLE `workflow_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `workflow_groups`
--
ALTER TABLE `workflow_groups`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `activities_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
