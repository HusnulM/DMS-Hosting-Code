-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2022 at 08:53 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ipd_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `t_ageing`
--

CREATE TABLE `t_ageing` (
  `kepi_lot` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(15,3) NOT NULL,
  `manpower_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ageing_result` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failure_remark` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `defect_quantity` decimal(15,3) DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `t_ft_process`
--

CREATE TABLE `t_ft_process` (
  `kepi_lot` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `manpower_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ft_jig_no` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ft_result` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ft_quantity` decimal(15,3) NOT NULL,
  `failure_remark` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `t_handwork_process`
--

CREATE TABLE `t_handwork_process` (
  `id` int(11) NOT NULL,
  `assy_code` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kepi_lot` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `part_lot` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hw_line` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hw_shift` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `t_menugroups`
--

CREATE TABLE `t_menugroups` (
  `menugroup` int(11) NOT NULL,
  `description` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `_index` int(11) DEFAULT NULL,
  `icon` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdon` timestamp NOT NULL DEFAULT current_timestamp(),
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `t_menugroups`
--

INSERT INTO `t_menugroups` (`menugroup`, `description`, `_index`, `icon`, `createdon`, `createdby`) VALUES
(1, 'MASTER DATA', 1, 'storage', '2021-08-06 14:01:33', 'sys-admin'),
(2, 'TRANSACTION', 2, 'storage', '2021-08-06 14:01:33', ''),
(3, 'REPORTS', 5, 'library_books', '2021-08-06 14:02:16', 'sys-admin'),
(4, 'SETTINGS', 99, 'settings', '2021-08-06 14:02:16', 'sys-admin'),
(5, 'PRODUCTION', 3, 'storage', '2021-08-06 14:01:33', ''),
(6, 'CRITICAL PART CONTROL', 4, 'storage', '2021-08-06 14:01:33', '');

-- --------------------------------------------------------

--
-- Table structure for table `t_menus`
--

CREATE TABLE `t_menus` (
  `id` int(11) NOT NULL,
  `menu` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `route` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menugroup` int(11) NOT NULL,
  `grouping` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Application Menus';

--
-- Dumping data for table `t_menus`
--

INSERT INTO `t_menus` (`id`, `menu`, `route`, `type`, `icon`, `menugroup`, `grouping`, `createdon`, `createdby`) VALUES
(1, 'Material Master', 'material', 'parent', '', 1, NULL, '2021-08-07 00:00:00', 'sys-admin'),
(2, 'Material Type', 'material', 'parent', '', 1, NULL, '2021-08-07 00:00:00', 'sys-admin'),
(3, 'Generate Process Form', 'transaction/form', 'parent', '', 2, NULL, '2021-08-07 00:00:00', 'sys-admin'),
(4, 'Transaction Process', 'transaction/process', 'parent', '', 2, NULL, '2021-08-07 00:00:00', 'sys-admin'),
(5, 'Transaction Report', 'reports/transaction', 'parent', '', 3, NULL, '2021-08-07 00:00:00', 'sys-admin'),
(6, 'Maintain User', 'user', 'parent', '', 4, NULL, '2021-08-07 00:00:00', 'sys-admin'),
(7, 'Maintain System Menu', 'menu', 'parent', '', 4, NULL, '2021-08-07 00:00:00', 'sys-admin'),
(8, 'Maintain Role', 'role', 'parent', '', 4, NULL, '2021-08-07 00:00:00', 'sys-admin'),
(9, 'Maintain Menu Role', 'menurole', 'parent', '', 4, NULL, '2021-08-07 00:00:00', 'sys-admin'),
(10, 'Maintain User Role', 'userrole', 'parent', '', 4, NULL, '2021-08-07 00:00:00', 'sys-admin'),
(11, 'General Setting', 'generalsetting', 'parent', '', 4, 'setting', '2021-08-07 00:00:00', 'sys-admin'),
(12, 'Transaction Repair', 'transaction/repair', 'parent', '', 2, NULL, '2021-08-07 00:00:00', 'sys-admin'),
(13, 'Defect List', 'master/defect', 'parent', '', 1, NULL, '2021-08-08 00:00:00', 'sys-admin'),
(14, 'Location', 'master/location', 'parent', '', 1, NULL, '2021-08-08 00:00:00', 'sys-admin'),
(15, 'Cause List', 'master/cause', 'parent', '', 1, NULL, '2021-08-08 00:00:00', 'sys-admin'),
(16, 'Action List', 'master/action', 'parent', '', 1, NULL, '2021-08-08 00:00:00', 'sys-admin'),
(17, 'Process Flow', 'processflow', 'parent', '', 4, NULL, '2021-08-09 00:00:00', 'sys-admin'),
(18, 'Create Purchase Request', 'pr', 'parent', '', 2, NULL, '2021-08-14 00:00:00', 'sys-admin'),
(19, 'Department List', 'department', 'parent', '', 1, NULL, '2021-08-14 00:00:00', 'sys-admin'),
(20, 'Budget Allocation', 'budgeting', 'parent', '', 1, NULL, '2021-08-14 00:00:00', 'sys-admin'),
(21, 'Approve Purchase Request', 'approvepr', 'parent', '', 2, NULL, '2021-08-14 00:00:00', 'sys-admin'),
(22, 'Mapping Approval', 'approval', 'parent', '', 4, NULL, '2021-08-14 00:00:00', 'sys-admin'),
(23, 'Report Purchase Request', 'reports/reportpr', 'parent', '', 3, NULL, '2021-08-14 00:00:00', 'sys-admin'),
(24, 'Input Planning', 'production', 'parent', '', 5, NULL, '2021-09-15 00:00:00', 'sys-admin'),
(25, 'Maintain Menu Groups', 'menugroup', 'parent', '', 4, NULL, '2021-09-16 00:00:00', 'sys-admin'),
(26, 'Production Lines', 'productionlines', 'parent', '', 1, NULL, '2021-09-18 00:00:00', 'sys-admin'),
(27, 'Actual Output', 'production/inputactualqty', 'parent', '', 5, NULL, '2021-09-18 00:00:00', 'sys-admin'),
(28, 'Planning Report', 'planningreport', 'parent', '', 5, NULL, '2021-09-20 00:00:00', 'sys-admin'),
(29, 'Production View', 'production/productionview', 'parent', '', 5, NULL, '2021-10-02 00:00:00', 'sys-admin'),
(30, 'Warehouse Issuance', 'warehouseissuance', 'parent', '', 2, NULL, '2022-06-01 00:00:00', 'sys-admin'),
(31, 'Part Location', 'partlocation', 'parent', '', 1, NULL, '2022-06-12 00:00:00', 'sys-admin'),
(32, 'Report Warehouse Issuance', 'rwarehouseissuance', 'parent', '', 3, NULL, '2022-06-16 00:00:00', 'sys-admin'),
(33, 'SMT LINE Process', 'smtprocess', 'parent', '', 6, NULL, '2022-06-18 00:00:00', 'sys-admin'),
(34, 'HANDWORK LINE Process', 'handworkprocess', 'parent', '', 6, NULL, '2022-06-18 00:00:00', 'sys-admin'),
(35, 'AGEING Process', 'ageingprocess', 'parent', '', 6, NULL, '2022-06-18 00:00:00', 'sys-admin'),
(36, 'FT Process', 'ftprocess', 'parent', '', 6, NULL, '2022-06-18 00:00:00', 'sys-admin'),
(37, 'QA Inspection', 'qainspection', 'parent', '', 6, NULL, '2022-06-18 00:00:00', 'sys-admin');

-- --------------------------------------------------------

--
-- Table structure for table `t_part_location`
--

CREATE TABLE `t_part_location` (
  `part_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `assy_location` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uniq_id` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `t_qa_inspection`
--

CREATE TABLE `t_qa_inspection` (
  `kepi_lot` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lot_qty_inspected` decimal(15,3) NOT NULL,
  `critcal_part_list` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qa_operator` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qa_date` date NOT NULL,
  `qa_result` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `t_rolemenu`
--

CREATE TABLE `t_rolemenu` (
  `roleid` int(11) NOT NULL,
  `menuid` int(11) NOT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Role Menu';

--
-- Dumping data for table `t_rolemenu`
--

INSERT INTO `t_rolemenu` (`roleid`, `menuid`, `createdon`, `createdby`) VALUES
(1, 1, '2021-08-07 00:00:00', 'sys-admin'),
(1, 5, '2021-09-07 00:00:00', 'sys-admin'),
(1, 6, '2021-08-07 00:00:00', 'sys-admin'),
(1, 7, '2021-08-07 00:00:00', 'sys-admin'),
(1, 8, '2021-08-07 00:00:00', 'sys-admin'),
(1, 9, '2021-08-07 00:00:00', 'sys-admin'),
(1, 10, '2021-08-07 00:00:00', 'sys-admin'),
(1, 11, '2021-08-07 00:00:00', 'sys-admin'),
(1, 12, '2021-09-07 00:00:00', 'sys-admin'),
(1, 17, '2021-09-07 00:00:00', 'sys-admin'),
(1, 19, '2021-08-14 00:00:00', 'sys-admin'),
(1, 20, '2021-08-14 00:00:00', 'sys-admin'),
(1, 24, '2021-09-15 00:00:00', 'sys-admin'),
(1, 25, '2021-09-16 00:00:00', 'sys-admin'),
(1, 26, '2021-09-18 00:00:00', 'sys-admin'),
(1, 27, '2021-09-18 00:00:00', 'sys-admin'),
(1, 28, '2021-09-20 00:00:00', 'sys-admin'),
(1, 29, '2021-10-02 00:00:00', 'sys-admin'),
(1, 30, '2022-06-01 00:00:00', 'sys-admin'),
(1, 31, '2022-06-12 00:00:00', 'sys-admin'),
(1, 32, '2022-06-16 00:00:00', 'sys-admin'),
(1, 33, '2022-06-18 00:00:00', 'sys-admin'),
(1, 34, '2022-06-19 00:00:00', 'sys-admin'),
(1, 35, '2022-06-19 00:00:00', 'sys-admin'),
(1, 36, '2022-06-19 00:00:00', 'sys-admin'),
(1, 37, '2022-06-19 00:00:00', 'sys-admin'),
(2, 4, '2021-08-20 00:00:00', 'sys-admin'),
(2, 5, '2021-08-20 00:00:00', 'sys-admin'),
(3, 12, '2021-08-20 00:00:00', 'sys-admin');

-- --------------------------------------------------------

--
-- Table structure for table `t_role_avtivity`
--

CREATE TABLE `t_role_avtivity` (
  `roleid` int(11) NOT NULL,
  `menuid` int(11) NOT NULL,
  `activity` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `createdon` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Activity Auth';

--
-- Dumping data for table `t_role_avtivity`
--

INSERT INTO `t_role_avtivity` (`roleid`, `menuid`, `activity`, `status`, `createdon`) VALUES
(1, 1, 'Create', 1, '2021-08-07'),
(1, 1, 'Delete', 1, '2021-08-07'),
(1, 1, 'Read', 1, '2021-08-07'),
(1, 1, 'Update', 1, '2021-08-07'),
(1, 5, 'Create', 0, '2021-09-07'),
(1, 5, 'Delete', 0, '2021-09-07'),
(1, 5, 'Read', 1, '2021-09-07'),
(1, 5, 'Update', 0, '2021-09-07'),
(1, 6, 'Create', 1, '2021-08-07'),
(1, 6, 'Delete', 1, '2021-08-07'),
(1, 6, 'Edit', 1, '2021-08-07'),
(1, 6, 'Read', 1, '2021-08-07'),
(1, 6, 'Update', 1, '2021-08-07'),
(1, 7, 'Create', 1, '2021-08-07'),
(1, 7, 'Delete', 1, '2021-08-07'),
(1, 7, 'Read', 1, '2021-08-07'),
(1, 7, 'Update', 1, '2021-08-07'),
(1, 8, 'Create', 1, '2021-08-07'),
(1, 8, 'Delete', 1, '2021-08-07'),
(1, 8, 'Read', 1, '2021-08-07'),
(1, 8, 'Update', 1, '2021-08-07'),
(1, 9, 'Create', 1, '2021-08-07'),
(1, 9, 'Delete', 1, '2021-08-07'),
(1, 9, 'Read', 1, '2021-08-07'),
(1, 9, 'Update', 1, '2021-08-07'),
(1, 10, 'Create', 1, '2021-08-07'),
(1, 10, 'Delete', 1, '2021-08-07'),
(1, 10, 'Read', 1, '2021-08-07'),
(1, 10, 'Update', 1, '2021-08-07'),
(1, 11, 'Create', 1, '2021-08-07'),
(1, 11, 'Delete', 1, '2021-08-07'),
(1, 11, 'Read', 1, '2021-08-07'),
(1, 11, 'Update', 1, '2021-08-07'),
(1, 12, 'Create', 1, '2021-09-07'),
(1, 12, 'Delete', 1, '2021-09-07'),
(1, 12, 'Read', 1, '2021-09-07'),
(1, 12, 'Update', 1, '2021-09-07'),
(1, 17, 'Create', 1, '2021-09-07'),
(1, 17, 'Delete', 1, '2021-09-07'),
(1, 17, 'Read', 1, '2021-09-07'),
(1, 17, 'Update', 1, '2021-09-07'),
(1, 19, 'Create', 1, '2021-08-14'),
(1, 19, 'Delete', 1, '2021-08-14'),
(1, 19, 'Read', 1, '2021-08-14'),
(1, 19, 'Update', 1, '2021-08-14'),
(1, 20, 'Create', 1, '2021-08-14'),
(1, 20, 'Delete', 1, '2021-08-14'),
(1, 20, 'Read', 1, '2021-08-14'),
(1, 20, 'Update', 1, '2021-08-14'),
(1, 24, 'Create', 1, '2021-09-19'),
(1, 24, 'Delete', 1, '2021-09-19'),
(1, 24, 'Read', 1, '2021-09-19'),
(1, 24, 'Update', 1, '2021-09-19'),
(1, 25, 'Create', 1, '2021-09-16'),
(1, 25, 'Delete', 1, '2021-09-16'),
(1, 25, 'Read', 1, '2021-09-16'),
(1, 25, 'Update', 1, '2021-09-16'),
(1, 26, 'Create', 1, '2021-09-18'),
(1, 26, 'Delete', 1, '2021-09-18'),
(1, 26, 'Read', 1, '2021-09-18'),
(1, 26, 'Update', 1, '2021-09-18'),
(1, 27, 'Create', 1, '2021-09-18'),
(1, 27, 'Delete', 1, '2021-09-18'),
(1, 27, 'Read', 1, '2021-09-18'),
(1, 27, 'Update', 1, '2021-09-18'),
(1, 28, 'Create', 0, '2021-09-20'),
(1, 28, 'Delete', 0, '2021-09-20'),
(1, 28, 'Read', 1, '2021-09-20'),
(1, 28, 'Update', 0, '2021-09-20'),
(1, 30, 'Create', 1, '2022-06-04'),
(1, 30, 'Delete', 1, '2022-06-04'),
(1, 30, 'Read', 1, '2022-06-04'),
(1, 30, 'Update', 1, '2022-06-04'),
(1, 31, 'Create', 1, '2022-06-12'),
(1, 31, 'Delete', 1, '2022-06-12'),
(1, 31, 'Read', 1, '2022-06-12'),
(1, 31, 'Update', 1, '2022-06-12'),
(1, 32, 'Create', 0, '2022-06-16'),
(1, 32, 'Delete', 0, '2022-06-16'),
(1, 32, 'Read', 1, '2022-06-16'),
(1, 32, 'Update', 0, '2022-06-16'),
(1, 33, 'Create', 1, '2022-06-18'),
(1, 33, 'Delete', 1, '2022-06-18'),
(1, 33, 'Read', 1, '2022-06-18'),
(1, 33, 'Update', 1, '2022-06-18'),
(1, 34, 'Create', 1, '2022-06-19'),
(1, 34, 'Delete', 1, '2022-06-19'),
(1, 34, 'Read', 1, '2022-06-19'),
(1, 34, 'Update', 1, '2022-06-19'),
(1, 35, 'Create', 1, '2022-06-19'),
(1, 35, 'Delete', 1, '2022-06-19'),
(1, 35, 'Read', 1, '2022-06-19'),
(1, 35, 'Update', 1, '2022-06-19'),
(1, 36, 'Create', 1, '2022-06-19'),
(1, 36, 'Delete', 1, '2022-06-19'),
(1, 36, 'Read', 1, '2022-06-19'),
(1, 36, 'Update', 1, '2022-06-19'),
(1, 37, 'Create', 1, '2022-06-19'),
(1, 37, 'Delete', 1, '2022-06-19'),
(1, 37, 'Read', 1, '2022-06-19'),
(1, 37, 'Update', 1, '2022-06-19'),
(2, 4, 'Create', 1, '2021-08-20'),
(2, 4, 'Delete', 1, '2021-08-20'),
(2, 4, 'Read', 1, '2021-08-20'),
(2, 4, 'Update', 1, '2021-08-20'),
(2, 5, 'Create', 0, '2021-08-20'),
(2, 5, 'Delete', 0, '2021-08-20'),
(2, 5, 'Read', 1, '2021-08-20'),
(2, 5, 'Update', 0, '2021-08-20'),
(3, 12, 'Create', 1, '2021-08-20'),
(3, 12, 'Delete', 0, '2021-08-20'),
(3, 12, 'Read', 1, '2021-08-20'),
(3, 12, 'Update', 1, '2021-08-20');

-- --------------------------------------------------------

--
-- Table structure for table `t_smt_line_process`
--

CREATE TABLE `t_smt_line_process` (
  `id` int(11) NOT NULL,
  `assy_code` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kepi_lot` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `part_lot` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `smt_line` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smt_shift` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `t_warehouse_issuance`
--

CREATE TABLE `t_warehouse_issuance` (
  `issuance_number` int(11) NOT NULL,
  `part_number` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `part_lot` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` decimal(15,3) DEFAULT NULL,
  `location` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issueance_date` date DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `t_ageing`
--
ALTER TABLE `t_ageing`
  ADD PRIMARY KEY (`kepi_lot`);

--
-- Indexes for table `t_ft_process`
--
ALTER TABLE `t_ft_process`
  ADD PRIMARY KEY (`kepi_lot`,`manpower_name`,`ft_jig_no`);

--
-- Indexes for table `t_handwork_process`
--
ALTER TABLE `t_handwork_process`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_menugroups`
--
ALTER TABLE `t_menugroups`
  ADD PRIMARY KEY (`menugroup`);

--
-- Indexes for table `t_menus`
--
ALTER TABLE `t_menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_part_location`
--
ALTER TABLE `t_part_location`
  ADD PRIMARY KEY (`part_number`,`assy_location`);

--
-- Indexes for table `t_qa_inspection`
--
ALTER TABLE `t_qa_inspection`
  ADD PRIMARY KEY (`kepi_lot`);

--
-- Indexes for table `t_rolemenu`
--
ALTER TABLE `t_rolemenu`
  ADD PRIMARY KEY (`roleid`,`menuid`),
  ADD KEY `roleid` (`roleid`),
  ADD KEY `menuid` (`menuid`);

--
-- Indexes for table `t_role_avtivity`
--
ALTER TABLE `t_role_avtivity`
  ADD PRIMARY KEY (`roleid`,`menuid`,`activity`);

--
-- Indexes for table `t_smt_line_process`
--
ALTER TABLE `t_smt_line_process`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_warehouse_issuance`
--
ALTER TABLE `t_warehouse_issuance`
  ADD PRIMARY KEY (`issuance_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `t_handwork_process`
--
ALTER TABLE `t_handwork_process`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `t_menugroups`
--
ALTER TABLE `t_menugroups`
  MODIFY `menugroup` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `t_menus`
--
ALTER TABLE `t_menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `t_smt_line_process`
--
ALTER TABLE `t_smt_line_process`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `t_warehouse_issuance`
--
ALTER TABLE `t_warehouse_issuance`
  MODIFY `issuance_number` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `t_rolemenu`
--
ALTER TABLE `t_rolemenu`
  ADD CONSTRAINT `t_rolemenu_ibfk_1` FOREIGN KEY (`roleid`) REFERENCES `t_role` (`roleid`),
  ADD CONSTRAINT `t_rolemenu_ibfk_2` FOREIGN KEY (`menuid`) REFERENCES `t_menus` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
