-- MySQL dump 10.19  Distrib 10.3.34-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: ipd_system
-- ------------------------------------------------------
-- Server version	10.3.34-MariaDB-cll-lve
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!40101 SET NAMES utf8mb4 */
;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */
;
/*!40103 SET TIME_ZONE='+00:00' */
;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */
;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */
;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */
;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */
;
--
-- Table structure for table `t_actionlist`
--
DROP TABLE IF EXISTS `t_actionlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_actionlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actionname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` date NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_actionlist`
--
LOCK TABLES `t_actionlist` WRITE;
/*!40000 ALTER TABLE `t_actionlist` DISABLE KEYS */
;
INSERT INTO `t_actionlist`
VALUES (1, 'Retest', '2021-08-08', 'sys-admin'),
  (2, 'Replaced', '2021-08-08', 'sys-admin');
/*!40000 ALTER TABLE `t_actionlist` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_approval`
--
DROP TABLE IF EXISTS `t_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_approval` (
  `object` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `approval` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`object`, `creator`, `approval`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Mapping Approval PR PO';
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_approval`
--
LOCK TABLES `t_approval` WRITE;
/*!40000 ALTER TABLE `t_approval` DISABLE KEYS */
;
/*!40000 ALTER TABLE `t_approval` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_auth_object`
--
DROP TABLE IF EXISTS `t_auth_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_auth_object` (
  `ob_auth` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ob_auth`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Authorization Object';
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_auth_object`
--
LOCK TABLES `t_auth_object` WRITE;
/*!40000 ALTER TABLE `t_auth_object` DISABLE KEYS */
;
/*!40000 ALTER TABLE `t_auth_object` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_causelist`
--
DROP TABLE IF EXISTS `t_causelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_causelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `causename` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` date NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_causelist`
--
LOCK TABLES `t_causelist` WRITE;
/*!40000 ALTER TABLE `t_causelist` DISABLE KEYS */
;
INSERT INTO `t_causelist`
VALUES (
    1,
    'Electrical Defect',
    '2021-08-08',
    'sys-admin'
  ),
  (2, 'Machine Error', '2021-08-08', 'sys-admin');
/*!40000 ALTER TABLE `t_causelist` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_defect_process`
--
DROP TABLE IF EXISTS `t_defect_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_defect_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transactionid` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `counter` int(11) NOT NULL,
  `defect` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cause` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `repairaction` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repairremark` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 34 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_defect_process`
--
LOCK TABLES `t_defect_process` WRITE;
/*!40000 ALTER TABLE `t_defect_process` DISABLE KEYS */
;
INSERT INTO `t_defect_process`
VALUES (
    1,
    '1638074011755',
    1,
    'Component Fail',
    'C222',
    'Part Dmage',
    'Repair',
    'Replace X',
    '',
    'user6',
    '2021-11-28'
  ),
  (
    2,
    '1638074011755',
    1,
    'Voltage Error',
    'C111',
    'Test',
    'Repair',
    'Replace Y',
    '',
    'user6',
    '2021-11-28'
  ),
  (
    3,
    '1638074011755',
    1,
    'Damage Part',
    'D45',
    'Part Dmage',
    'Replace',
    'Replace Z',
    '',
    'user6',
    '2021-11-28'
  ),
  (
    4,
    '1638238567931',
    1,
    'Component Fail',
    'C111',
    'Test',
    'Replace',
    NULL,
    NULL,
    'user3',
    '2021-11-30'
  ),
  (
    5,
    '1638238567931',
    1,
    'Voltage Error',
    'D45',
    'Part Dmage',
    'Repair',
    NULL,
    NULL,
    'user3',
    '2021-11-30'
  ),
  (
    6,
    '1638315062491',
    1,
    'Voltage Error',
    'C111',
    'rejet',
    'for repair',
    'For touch up',
    '',
    'user2',
    '2021-12-01'
  ),
  (
    7,
    '1638315062491',
    1,
    'Damage Part',
    'C222',
    'Machine Error',
    'Trial',
    'For test',
    '',
    'user2',
    '2021-12-01'
  ),
  (
    8,
    '1638315062491',
    2,
    'Component Fail',
    'C111',
    'Electrical Defect',
    'For Testing Purpose',
    'Test',
    '',
    'user5',
    '2021-12-01'
  ),
  (
    9,
    '1638748002034',
    1,
    'Voltage Error',
    'C111',
    'Electrical Defect',
    'For Test',
    '2nd repair',
    '',
    'user5',
    '2021-12-06'
  ),
  (
    10,
    '1638748002034',
    1,
    'Damage Part',
    'C222',
    'poor solder',
    'For Testing Purpose',
    '2nd repair',
    '',
    'user5',
    '2021-12-06'
  ),
  (
    11,
    '1638750013123',
    1,
    'Voltage Error',
    'C111',
    'poor solder',
    'For resolder',
    'Testing 123',
    '',
    'user3',
    '2021-12-06'
  ),
  (
    12,
    '1638750013123',
    1,
    'Damage Part',
    'D45',
    'reject',
    'For Test',
    'Testing 456',
    '',
    'user3',
    '2021-12-06'
  ),
  (
    13,
    '1638750288968',
    1,
    'Damage Part',
    'D45',
    'wala lang',
    'Test01',
    'For test',
    '',
    'user3',
    '2021-12-06'
  ),
  (
    14,
    '1638776443227',
    1,
    'Component Fail',
    'C111',
    'Electrical Defect',
    'For Test',
    'For Test123',
    '',
    'user4',
    '2021-12-06'
  ),
  (
    15,
    '1638776443227',
    1,
    'Component Fail',
    'C222',
    'poor solder',
    'For Testing Purpose',
    'For Test456',
    '',
    'user4',
    '2021-12-06'
  ),
  (
    16,
    '1638776953005',
    1,
    'Voltage Error',
    'C222',
    'Electrical Defect',
    'Test if will add two rows',
    'Test if add two',
    '',
    'user2',
    '2021-12-06'
  ),
  (
    17,
    '1638776953005',
    1,
    'Voltage Error',
    'C222',
    'poor solder',
    'test if will add row again',
    'test again',
    '',
    'user2',
    '2021-12-06'
  ),
  (
    18,
    '1638777167565',
    1,
    'Component Fail',
    'C222',
    'Electrical Defect',
    'Test',
    NULL,
    NULL,
    'user3',
    '2021-12-06'
  ),
  (
    19,
    '1638859998716',
    1,
    'Component Fail',
    'C111',
    'cause defect 1',
    'action defect 1',
    'repair action 1',
    '',
    'user6',
    '2021-12-07'
  ),
  (
    20,
    '1638859998716',
    1,
    'Damage Part',
    'D45',
    'cause defect 2',
    'action defect 2',
    'repair action 2',
    '',
    'user6',
    '2021-12-07'
  ),
  (
    21,
    '1638865511726',
    1,
    'Voltage Error',
    'C111',
    'poor solder',
    'For Test again',
    'Hope OK. Process 1 again',
    '',
    'user3',
    '2021-12-07'
  ),
  (
    22,
    '1638865511726',
    1,
    'Voltage Error',
    'C111',
    'Electrical Defect',
    'Again and Again',
    'Hope ok 2. ',
    '',
    'user3',
    '2021-12-07'
  ),
  (
    23,
    '1638866312362',
    1,
    'Component Fail',
    'C111',
    'Electrical Defect',
    'Trial',
    'OK',
    '',
    'user3',
    '2021-12-07'
  ),
  (
    24,
    '1638866312362',
    1,
    'Component Fail',
    'C111',
    'test',
    'For Test',
    'OK',
    '',
    'user3',
    '2021-12-07'
  ),
  (
    25,
    '1638866312362',
    2,
    'Voltage Error',
    'C222',
    'poor solder',
    'testing',
    'Proceed to After Repair ICT',
    '',
    'user5',
    '2021-12-07'
  ),
  (
    26,
    '1639011418368',
    1,
    'Component Fail',
    'C111',
    'test',
    'For Testing Purpose',
    'Done Repair',
    '',
    'user2',
    '2021-12-09'
  ),
  (
    27,
    '1639011418368',
    1,
    'Component Fail',
    'C111',
    'poor solder',
    'testing',
    'Done Repair',
    '',
    'user2',
    '2021-12-09'
  ),
  (
    28,
    '1639011418368',
    2,
    'Damage Part',
    'C222',
    'poor solder',
    'For Testing Purpose',
    'Test123',
    '',
    'user8',
    '2021-12-09'
  ),
  (
    29,
    '1639011418368',
    2,
    'Voltage Error',
    'D45',
    'test',
    'Trial',
    'Test456',
    '',
    'user8',
    '2021-12-09'
  ),
  (
    30,
    '1641435028312',
    1,
    'Component Fail',
    'C111',
    'Part Dmage',
    'Replace',
    NULL,
    NULL,
    'user3',
    '2022-01-06'
  ),
  (
    31,
    '1641435028312',
    1,
    'Voltage Error',
    'C222',
    'kabel putus',
    'Ganti Kabel',
    NULL,
    NULL,
    'user3',
    '2022-01-06'
  ),
  (
    32,
    '1641438161212',
    1,
    'Component Fail',
    'C111',
    'Part Dmage',
    'Ganti Kabel',
    NULL,
    NULL,
    'user1',
    '2022-01-06'
  ),
  (
    33,
    '1641438161212',
    1,
    'Damage Part',
    'C222',
    'kabel putus',
    'AOI SMT-TOP (2nd) Action',
    NULL,
    NULL,
    'user1',
    '2022-01-06'
  );
/*!40000 ALTER TABLE `t_defect_process` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_defect_repair`
--
DROP TABLE IF EXISTS `t_defect_repair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_defect_repair` (
  `transactionid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `counter` int(11) NOT NULL,
  `defect_process_id` int(11) NOT NULL,
  `repair_counter` int(11) NOT NULL,
  `process_counter` int(11) NOT NULL,
  `defect` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cause` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` date NOT NULL,
  PRIMARY KEY (
    `transactionid`,
    `counter`,
    `defect_process_id`,
    `repair_counter`,
    `process_counter`
  )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_defect_repair`
--
LOCK TABLES `t_defect_repair` WRITE;
/*!40000 ALTER TABLE `t_defect_repair` DISABLE KEYS */
;
INSERT INTO `t_defect_repair`
VALUES (
    '1638776443227',
    1,
    14,
    1,
    1,
    'Component Fail',
    'C111',
    'Electrical Defect',
    'For Test123',
    '',
    'sys-admin',
    '2021-12-06'
  ),
  (
    '1638776443227',
    2,
    15,
    1,
    1,
    'Component Fail',
    'C222',
    'poor solder',
    'For Test456',
    '',
    'sys-admin',
    '2021-12-06'
  ),
  (
    '1638776953005',
    1,
    16,
    1,
    1,
    'Voltage Error',
    'C222',
    'Electrical Defect',
    'Test if add two',
    '',
    'sys-admin',
    '2021-12-06'
  ),
  (
    '1638776953005',
    2,
    17,
    1,
    1,
    'Voltage Error',
    'C222',
    'poor solder',
    'test again',
    '',
    'sys-admin',
    '2021-12-06'
  ),
  (
    '1638859998716',
    1,
    19,
    1,
    1,
    'Component Fail',
    'C111',
    'cause defect 1',
    'repair action 1',
    '',
    'sys-admin',
    '2021-12-07'
  ),
  (
    '1638859998716',
    1,
    19,
    2,
    1,
    'Component Fail',
    'C111',
    'cause defect 1',
    'repair action 1',
    'please re-test again',
    'user2',
    '2021-12-07'
  ),
  (
    '1638859998716',
    2,
    20,
    1,
    1,
    'Damage Part',
    'D45',
    'cause defect 2',
    'repair action 2',
    '',
    'sys-admin',
    '2021-12-07'
  ),
  (
    '1638859998716',
    2,
    20,
    2,
    1,
    'Damage Part',
    'D45',
    'cause defect 2',
    'repair action 2',
    'please re-test again',
    'user2',
    '2021-12-07'
  ),
  (
    '1638865511726',
    1,
    21,
    1,
    1,
    'Voltage Error',
    'C111',
    'poor solder',
    'Hope OK. Process 1 again',
    '',
    'sys-admin',
    '2021-12-07'
  ),
  (
    '1638865511726',
    2,
    22,
    1,
    1,
    'Voltage Error',
    'C111',
    'Electrical Defect',
    'Hope ok 2. ',
    '',
    'sys-admin',
    '2021-12-07'
  ),
  (
    '1638866312362',
    1,
    23,
    1,
    1,
    'Component Fail',
    'C111',
    'Electrical Defect',
    'OK',
    '',
    'sys-admin',
    '2021-12-07'
  ),
  (
    '1638866312362',
    1,
    25,
    2,
    2,
    'Voltage Error',
    'C222',
    'poor solder',
    'Final',
    '',
    'sys-admin',
    '2021-12-07'
  ),
  (
    '1638866312362',
    1,
    25,
    3,
    2,
    'Voltage Error',
    'C222',
    'poor solder',
    'Final',
    'back to repair. for Rework',
    'user5',
    '2021-12-07'
  ),
  (
    '1638866312362',
    1,
    25,
    4,
    2,
    'Voltage Error',
    'C222',
    'poor solder',
    'Proceed to After Repair ICT',
    'Fail',
    'user3',
    '2021-12-07'
  ),
  (
    '1638866312362',
    2,
    24,
    1,
    1,
    'Component Fail',
    'C111',
    'test',
    'OK',
    '',
    'sys-admin',
    '2021-12-07'
  ),
  (
    '1639011418368',
    1,
    26,
    1,
    1,
    'Component Fail',
    'C111',
    'test',
    'Done Repair',
    '',
    'sys-admin',
    '2021-12-09'
  ),
  (
    '1639011418368',
    1,
    28,
    2,
    2,
    'Damage Part',
    'C222',
    'poor solder',
    'Test123',
    '',
    'sys-admin',
    '2021-12-09'
  ),
  (
    '1639011418368',
    2,
    27,
    1,
    1,
    'Component Fail',
    'C111',
    'poor solder',
    'Done Repair',
    '',
    'sys-admin',
    '2021-12-09'
  ),
  (
    '1639011418368',
    2,
    29,
    2,
    2,
    'Voltage Error',
    'D45',
    'test',
    'Test456',
    '',
    'sys-admin',
    '2021-12-09'
  );
/*!40000 ALTER TABLE `t_defect_repair` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_defectlist`
--
DROP TABLE IF EXISTS `t_defectlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_defectlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `defectname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` date NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_defectlist`
--
LOCK TABLES `t_defectlist` WRITE;
/*!40000 ALTER TABLE `t_defectlist` DISABLE KEYS */
;
INSERT INTO `t_defectlist`
VALUES (1, 'Component Fail', '2021-08-08', 'sys-admin'),
  (2, 'Voltage Error', '2021-08-08', 'sys-admin'),
  (3, 'Damage Part', '2021-08-08', 'sys-admin');
/*!40000 ALTER TABLE `t_defectlist` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_ipd_forms`
--
DROP TABLE IF EXISTS `t_ipd_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_ipd_forms` (
  `transactionid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prod_date` datetime NOT NULL,
  `partnumber` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `partmodel` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_no` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lotcode` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdon` date DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`transactionid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_ipd_forms`
--
LOCK TABLES `t_ipd_forms` WRITE;
/*!40000 ALTER TABLE `t_ipd_forms` DISABLE KEYS */
;
INSERT INTO `t_ipd_forms`
VALUES (
    '1638074011755',
    '2021-11-28 00:00:00',
    '1122334-01',
    'U776A',
    'SER001',
    'LOT001',
    '2021-11-28',
    'user1'
  ),
  (
    '1638238567931',
    '2021-11-30 00:00:00',
    '1122334-01',
    'U776A',
    'SER005',
    'LOT005',
    '2021-11-30',
    'user1'
  ),
  (
    '1638315062491',
    '2021-12-01 00:00:00',
    '2233441-02',
    'U778B',
    '1425',
    'kepilt',
    '2021-12-01',
    'user1'
  ),
  (
    '1638748002034',
    '2021-12-06 00:00:00',
    '2233441-02	',
    'U778B',
    '123654',
    '582',
    '2021-12-06',
    'user1'
  ),
  (
    '1638750013123',
    '2021-12-06 00:00:00',
    '2233441-02',
    'U778B',
    '5858',
    '56',
    '2021-12-06',
    'user1'
  ),
  (
    '1638750288968',
    '2021-12-06 00:00:00',
    '2233441-02',
    'U778B',
    '9898',
    '65',
    '2021-12-06',
    'user1'
  ),
  (
    '1638776443227',
    '2021-12-06 00:00:00',
    '2424241-01	',
    'U778C',
    '789',
    '23',
    '2021-12-06',
    'user1'
  ),
  (
    '1638776953005',
    '2021-12-06 00:00:00',
    '2233441-02	',
    'U778B',
    '564',
    '34',
    '2021-12-06',
    'user1'
  ),
  (
    '1638777167565',
    '2021-12-06 00:00:00',
    '2233441-02',
    'U778B',
    '741',
    '34',
    '2021-12-06',
    'user1'
  ),
  (
    '1638859998716',
    '2021-12-07 00:00:00',
    '2424241-01',
    'U778C',
    'SER-TEST-1',
    'LOT-TEST-1',
    '2021-12-07',
    'user1'
  ),
  (
    '1638865511726',
    '2021-12-07 00:00:00',
    '1122334-01	',
    'U776A',
    '963',
    '654',
    '2021-12-07',
    'user1'
  ),
  (
    '1638866312362',
    '2021-12-07 00:00:00',
    '1122334-01	',
    'U776A',
    '654',
    '852',
    '2021-12-07',
    'user1'
  ),
  (
    '1638931023488',
    '2021-12-08 00:00:00',
    '2233441-02	',
    'U778B',
    'SER02',
    'LOT02',
    '2021-12-08',
    'user1'
  ),
  (
    '1639011418368',
    '2021-12-09 00:00:00',
    '1122334-01',
    'U776A',
    '652',
    'LOT1',
    '2021-12-09',
    'user1'
  ),
  (
    '1639014305454',
    '2021-12-09 08:12:09',
    '1122334-01',
    'U776A',
    'SER999',
    'LOT999',
    '2021-12-09',
    'user1'
  ),
  (
    '1639026602707',
    '2021-12-09 12:12:04',
    '1122334-01	',
    'U776A',
    '36',
    '6',
    '2021-12-09',
    'user1'
  ),
  (
    '1639027427637',
    '2021-12-09 12:12:51',
    '1122334-01	',
    'U776A',
    '777',
    '65',
    '2021-12-09',
    'user1'
  ),
  (
    '1639027488067',
    '2021-12-09 12:12:49',
    '1122334-01	',
    'U776A',
    '9',
    '6',
    '2021-12-09',
    'user1'
  ),
  (
    '1641353740863',
    '2022-01-05 10:01:09',
    '2233441-02',
    'U778B',
    '34',
    '12',
    '2022-01-05',
    'user1'
  ),
  (
    '1641434570977',
    '2022-01-06 09:01:18',
    '1122334-01',
    'U776A',
    'SERIAL01',
    'LOT01',
    '2022-01-06',
    'user1'
  ),
  (
    '1641435028312',
    '2022-01-06 09:01:34',
    '1122334-01',
    'U776A',
    'SERIAL02',
    'LOT02',
    '2022-01-06',
    'user1'
  ),
  (
    '1641435230499',
    '2022-01-06 09:01:04',
    '1122334-01',
    'U776A',
    'SERIAL03',
    'LOT03',
    '2022-01-06',
    'user1'
  ),
  (
    '1641437934183',
    '2022-01-06 09:01:15',
    '1122334-01',
    'U776A',
    'SERIAL04',
    'LOT04',
    '2022-01-06',
    'user1'
  ),
  (
    '1641438043669',
    '2022-01-06 10:01:04',
    '1122334-01',
    'U776A',
    'SERIAL06',
    'LOT06',
    '2022-01-06',
    'user1'
  ),
  (
    '1641438161212',
    '2022-01-06 10:01:45',
    '1122334-01',
    'U776A',
    'SERIAL07',
    'LOT07',
    '2022-01-06',
    'user1'
  ),
  (
    '1641780897014',
    '2022-01-10 09:01:06',
    '1122334-01',
    'U776A',
    'SERX11',
    'LOT999',
    '2022-01-10',
    'user1'
  );
/*!40000 ALTER TABLE `t_ipd_forms` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_ipd_process`
--
DROP TABLE IF EXISTS `t_ipd_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_ipd_process` (
  `transactionid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `counter` int(11) NOT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `process1` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process2` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process3` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process4` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process5` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process6` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process7` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process8` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process9` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_process` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `defect_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cause` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastprocess` int(11) DEFAULT NULL,
  PRIMARY KEY (`transactionid`, `counter`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_ipd_process`
--
LOCK TABLES `t_ipd_process` WRITE;
/*!40000 ALTER TABLE `t_ipd_process` DISABLE KEYS */
;
INSERT INTO `t_ipd_process`
VALUES (
    '1638074011755',
    1,
    'Open',
    'Good',
    'Good',
    'Good',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    'AOI HW-TOP',
    NULL,
    NULL,
    NULL,
    NULL,
    6
  ),
  (
    '1638238567931',
    1,
    'Open',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'SMT SI',
    NULL,
    NULL,
    NULL,
    NULL,
    3
  ),
  (
    '1638315062491',
    1,
    'Closed',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'AOI SMT-TOP (2nd)',
    NULL,
    NULL,
    NULL,
    NULL,
    2
  ),
  (
    '1638315062491',
    2,
    'Open',
    'Good',
    'Good',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    'QPIT',
    NULL,
    NULL,
    NULL,
    NULL,
    5
  ),
  (
    '1638748002034',
    1,
    'Open',
    'Good',
    'Good',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    'QPIT',
    NULL,
    NULL,
    NULL,
    NULL,
    5
  ),
  (
    '1638750013123',
    1,
    'Closed',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'SMT SI',
    NULL,
    NULL,
    NULL,
    NULL,
    3
  ),
  (
    '1638750013123',
    2,
    'Open',
    'Good',
    'Good',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    2
  ),
  (
    '1638750288968',
    1,
    'Closed',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'SMT SI',
    NULL,
    NULL,
    NULL,
    NULL,
    3
  ),
  (
    '1638750288968',
    2,
    'Open',
    'Good',
    'Good',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    2
  ),
  (
    '1638776443227',
    1,
    'Closed',
    'Good',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'ICT',
    NULL,
    NULL,
    NULL,
    NULL,
    4
  ),
  (
    '1638776443227',
    2,
    'Closed',
    'Good',
    'Good',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    2
  ),
  (
    '1638776443227',
    3,
    'Open',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    0
  ),
  (
    '1638776953005',
    1,
    'Closed',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'AOI SMT-TOP (2nd)',
    NULL,
    NULL,
    NULL,
    NULL,
    2
  ),
  (
    '1638776953005',
    2,
    'Open',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    0
  ),
  (
    '1638777167565',
    1,
    'Open',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'SMT SI',
    NULL,
    NULL,
    NULL,
    NULL,
    3
  ),
  (
    '1638859998716',
    1,
    'Open',
    'Good',
    'Good',
    'Good',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    'AOI HW-TOP',
    NULL,
    NULL,
    NULL,
    NULL,
    6
  ),
  (
    '1638865511726',
    1,
    'Closed',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'SMT SI',
    NULL,
    NULL,
    NULL,
    NULL,
    3
  ),
  (
    '1638865511726',
    2,
    'Closed',
    'Good',
    'Good',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    2
  ),
  (
    '1638865511726',
    3,
    'Open',
    'Good',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    1
  ),
  (
    '1638866312362',
    1,
    'Closed',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'SMT SI',
    NULL,
    NULL,
    NULL,
    NULL,
    3
  ),
  (
    '1638866312362',
    2,
    'Open',
    'Good',
    'Good',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    'QPIT',
    NULL,
    NULL,
    NULL,
    NULL,
    5
  ),
  (
    '1638931023488',
    1,
    'Open',
    'Good',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    1
  ),
  (
    '1639011418368',
    1,
    'Closed',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'AOI SMT-TOP (2nd)',
    NULL,
    NULL,
    NULL,
    NULL,
    2
  ),
  (
    '1639011418368',
    2,
    'Open',
    'Good',
    'Good',
    'Good',
    'Good',
    'Good',
    'Good',
    'Good',
    'NG',
    NULL,
    'FVI',
    NULL,
    NULL,
    NULL,
    NULL,
    8
  ),
  (
    '1639014305454',
    1,
    'Open',
    'Good',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    1
  ),
  (
    '1639026602707',
    1,
    'Open',
    'Good',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    1
  ),
  (
    '1639027427637',
    1,
    'Open',
    'Good',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    1
  ),
  (
    '1639027488067',
    1,
    'Open',
    'Good',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    1
  ),
  (
    '1641353740863',
    1,
    'Open',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'AOI SMT-BOTTOM (1st)',
    NULL,
    NULL,
    NULL,
    NULL,
    1
  ),
  (
    '1641434570977',
    1,
    'Open',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'AOI SMT-BOTTOM (1st)',
    NULL,
    NULL,
    NULL,
    NULL,
    1
  ),
  (
    '1641435028312',
    1,
    'Open',
    'Good',
    'Good',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'SMT SI',
    NULL,
    NULL,
    NULL,
    NULL,
    3
  ),
  (
    '1641435230499',
    1,
    'Open',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'AOI SMT-BOTTOM (1st)',
    NULL,
    NULL,
    NULL,
    NULL,
    1
  ),
  (
    '1641437934183',
    1,
    'Open',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'AOI SMT-BOTTOM (1st)',
    NULL,
    NULL,
    NULL,
    NULL,
    1
  ),
  (
    '1641438043669',
    1,
    'Open',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'AOI SMT-BOTTOM (1st)',
    NULL,
    NULL,
    NULL,
    NULL,
    1
  ),
  (
    '1641438161212',
    1,
    'Open',
    'NG',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'AOI SMT-BOTTOM (1st)',
    NULL,
    NULL,
    NULL,
    NULL,
    1
  ),
  (
    '1641780897014',
    1,
    'Open',
    'Good',
    'Good',
    'Good',
    'Good',
    'Good',
    'Good',
    'Good',
    'Good',
    'Good',
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    9
  );
/*!40000 ALTER TABLE `t_ipd_process` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_ipd_repair`
--
DROP TABLE IF EXISTS `t_ipd_repair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_ipd_repair` (
  `transactionid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `counter` int(11) NOT NULL,
  `process_counter` int(11) NOT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `process1` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process2` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process3` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process4` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process5` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process6` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process7` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `defect_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastrepair` int(11) DEFAULT NULL,
  PRIMARY KEY (`transactionid`, `counter`, `process_counter`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_ipd_repair`
--
LOCK TABLES `t_ipd_repair` WRITE;
/*!40000 ALTER TABLE `t_ipd_repair` DISABLE KEYS */
;
INSERT INTO `t_ipd_repair`
VALUES (
    '1638074011755',
    1,
    1,
    'Closed',
    'PASS',
    'NOT PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'Please Retest Again',
    2
  ),
  (
    '1638074011755',
    2,
    1,
    'Open',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    '1638238567931',
    1,
    1,
    'Closed',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    '1638315062491',
    1,
    1,
    'Closed',
    'PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    1
  ),
  (
    '1638315062491',
    2,
    2,
    'Open',
    'PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    1
  ),
  (
    '1638748002034',
    1,
    1,
    'Closed',
    'PASS',
    'PASS',
    'NOT PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'For repair',
    3
  ),
  (
    '1638748002034',
    2,
    1,
    'Open',
    'PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    1
  ),
  (
    '1638750013123',
    1,
    1,
    'Closed',
    'PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    1
  ),
  (
    '1638750288968',
    1,
    1,
    'Closed',
    'PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    1
  ),
  (
    '1638776443227',
    1,
    1,
    'Closed',
    'PASS',
    'PASS',
    'PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    3
  ),
  (
    '1638776953005',
    1,
    1,
    'Closed',
    'PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    1
  ),
  (
    '1638777167565',
    1,
    1,
    'Closed',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    '1638859998716',
    1,
    1,
    'Closed',
    'PASS',
    'PASS',
    'NOT PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'please re-test again',
    3
  ),
  (
    '1638859998716',
    2,
    1,
    'Open',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    '1638865511726',
    1,
    1,
    'Closed',
    'PASS',
    'PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    2
  ),
  (
    '1638866312362',
    1,
    1,
    'Closed',
    'PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    1
  ),
  (
    '1638866312362',
    2,
    2,
    'Closed',
    'PASS',
    'PASS',
    'PASS',
    'PASS',
    'PASS',
    'NOT PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    'back to repair. for Rework',
    6
  ),
  (
    '1638866312362',
    3,
    2,
    'Closed',
    'PASS',
    'PASS',
    'PASS',
    'NOT PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'Fail',
    4
  ),
  (
    '1638866312362',
    4,
    2,
    'Open',
    'PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    1
  ),
  (
    '1639011418368',
    1,
    1,
    'Closed',
    'PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    1
  ),
  (
    '1639011418368',
    2,
    2,
    'Open',
    'PASS',
    'PASS',
    'PASS',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '',
    3
  ),
  (
    '1641353740863',
    1,
    1,
    'Closed',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    '1641434570977',
    1,
    1,
    'Closed',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    0
  ),
  (
    '1641435028312',
    1,
    1,
    'Closed',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    '1641435230499',
    1,
    1,
    'Closed',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    '1641437934183',
    1,
    1,
    'Closed',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    '1641438161212',
    1,
    1,
    'Closed',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
/*!40000 ALTER TABLE `t_ipd_repair` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_line_masters`
--
DROP TABLE IF EXISTS `t_line_masters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_line_masters` (
  `lineid` int(11) NOT NULL,
  `linename` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` date NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`lineid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_line_masters`
--
LOCK TABLES `t_line_masters` WRITE;
/*!40000 ALTER TABLE `t_line_masters` DISABLE KEYS */
;
/*!40000 ALTER TABLE `t_line_masters` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_locationlist`
--
DROP TABLE IF EXISTS `t_locationlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_locationlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locationname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` date NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_locationlist`
--
LOCK TABLES `t_locationlist` WRITE;
/*!40000 ALTER TABLE `t_locationlist` DISABLE KEYS */
;
INSERT INTO `t_locationlist`
VALUES (1, 'C111', '2021-08-08', 'sys-admin'),
  (2, 'C222', '2021-08-08', 'sys-admin'),
  (3, 'D45', '2021-08-08', 'sys-admin');
/*!40000 ALTER TABLE `t_locationlist` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_material`
--
DROP TABLE IF EXISTS `t_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_material` (
  `material` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `matdesc` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mattype` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `matgroup` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `partname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `partnumber` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `matunit` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `minstock` decimal(15, 2) DEFAULT NULL,
  `orderunit` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stdprice` decimal(15, 2) DEFAULT NULL,
  `stdpriceusd` decimal(15, 4) DEFAULT 0.0000,
  `active` tinyint(1) DEFAULT NULL,
  `createdon` datetime DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`material`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Material Master';
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_material`
--
LOCK TABLES `t_material` WRITE;
/*!40000 ALTER TABLE `t_material` DISABLE KEYS */
;
INSERT INTO `t_material`
VALUES (
    '1122334-01',
    'U776A',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'PC',
    NULL,
    NULL,
    NULL,
    0.0000,
    NULL,
    '2021-08-07 02:08:06',
    'sys-admin'
  ),
  (
    '2233441-02',
    'U778B',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'PC',
    NULL,
    NULL,
    NULL,
    0.0000,
    NULL,
    '2021-08-07 02:08:11',
    'sys-admin'
  ),
  (
    '2424241-01',
    'U778C',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'PC',
    NULL,
    NULL,
    NULL,
    0.0000,
    NULL,
    '2021-08-07 02:08:33',
    'sys-admin'
  );
/*!40000 ALTER TABLE `t_material` ENABLE KEYS */
;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */
;
/*!50003 SET @saved_cs_results     = @@character_set_results */
;
/*!50003 SET @saved_col_connection = @@collation_connection */
;
/*!50003 SET character_set_client  = latin1 */
;
/*!50003 SET character_set_results = latin1 */
;
/*!50003 SET collation_connection  = latin1_swedish_ci */
;
/*!50003 SET @saved_sql_mode       = @@sql_mode */
;
/*!50003 SET sql_mode              = '' */
;
DELIMITER;
;
/*!50003 CREATE*/
/*!50017 DEFINER=`root`@`localhost`*/
/*!50003 TRIGGER `INSERT_TO_ALT_UOM` AFTER INSERT ON `t_material` FOR EACH ROW INSERT INTO t_material2 VALUES(NEW.material,NEW.matunit,1,NEW.matunit,1,NEW.createdon,NEW.createdby) */
;
;
DELIMITER;
/*!50003 SET sql_mode              = @saved_sql_mode */
;
/*!50003 SET character_set_client  = @saved_cs_client */
;
/*!50003 SET character_set_results = @saved_cs_results */
;
/*!50003 SET collation_connection  = @saved_col_connection */
;
/*!50003 SET @saved_cs_client      = @@character_set_client */
;
/*!50003 SET @saved_cs_results     = @@character_set_results */
;
/*!50003 SET @saved_col_connection = @@collation_connection */
;
/*!50003 SET character_set_client  = latin1 */
;
/*!50003 SET character_set_results = latin1 */
;
/*!50003 SET collation_connection  = latin1_swedish_ci */
;
/*!50003 SET @saved_sql_mode       = @@sql_mode */
;
/*!50003 SET sql_mode              = '' */
;
DELIMITER;
;
/*!50003 CREATE*/
/*!50017 DEFINER=`root`@`localhost`*/
/*!50003 TRIGGER `DELETE_MATERIAL` AFTER DELETE ON `t_material` FOR EACH ROW DELETE FROM t_material2 where material = OLD.material */
;
;
DELIMITER;
/*!50003 SET sql_mode              = @saved_sql_mode */
;
/*!50003 SET character_set_client  = @saved_cs_client */
;
/*!50003 SET character_set_results = @saved_cs_results */
;
/*!50003 SET collation_connection  = @saved_col_connection */
;
--
-- Table structure for table `t_material2`
--
DROP TABLE IF EXISTS `t_material2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_material2` (
  `material` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `altuom` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `convalt` decimal(15, 2) NOT NULL,
  `baseuom` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `convbase` decimal(15, 2) NOT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`material`, `altuom`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Material Alternative UOM';
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_material2`
--
LOCK TABLES `t_material2` WRITE;
/*!40000 ALTER TABLE `t_material2` DISABLE KEYS */
;
INSERT INTO `t_material2`
VALUES (
    '1122334-01',
    'PC',
    1.00,
    'PC',
    1.00,
    '2021-08-07 02:08:06',
    'sys-admin'
  ),
  (
    '2233441-02',
    'PC',
    1.00,
    'PC',
    1.00,
    '2021-08-07 02:08:11',
    'sys-admin'
  ),
  (
    '2424241-01',
    'PC',
    1.00,
    'PC',
    1.00,
    '2021-08-07 02:08:33',
    'sys-admin'
  );
/*!40000 ALTER TABLE `t_material2` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_menugroups`
--
DROP TABLE IF EXISTS `t_menugroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_menugroups` (
  `menugroup` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `_index` int(11) DEFAULT NULL,
  `icon` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdon` timestamp NOT NULL DEFAULT current_timestamp(),
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`menugroup`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_menugroups`
--
LOCK TABLES `t_menugroups` WRITE;
/*!40000 ALTER TABLE `t_menugroups` DISABLE KEYS */
;
INSERT INTO `t_menugroups`
VALUES (
    1,
    'MASTER DATA',
    1,
    'storage',
    '2021-08-06 14:01:33',
    'sys-admin'
  ),
  (
    2,
    'TRANSACTION',
    2,
    'storage',
    '2021-08-06 14:01:33',
    ''
  ),
  (
    3,
    'REPORTS',
    4,
    'library_books',
    '2021-08-06 14:02:16',
    'sys-admin'
  ),
  (
    4,
    'SETTINGS',
    99,
    'settings',
    '2021-08-06 14:02:16',
    'sys-admin'
  ),
  (
    5,
    'PRODUCTION',
    3,
    'storage',
    '2021-08-06 14:01:33',
    ''
  );
/*!40000 ALTER TABLE `t_menugroups` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_menus`
--
DROP TABLE IF EXISTS `t_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `route` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menugroup` int(11) NOT NULL,
  `grouping` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 30 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Application Menus';
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_menus`
--
LOCK TABLES `t_menus` WRITE;
/*!40000 ALTER TABLE `t_menus` DISABLE KEYS */
;
INSERT INTO `t_menus`
VALUES (
    1,
    'Material Master',
    'material',
    'parent',
    '',
    1,
    NULL,
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  (
    2,
    'Material Type',
    'material',
    'parent',
    '',
    1,
    NULL,
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  (
    3,
    'Generate Process Form',
    'transaction/form',
    'parent',
    '',
    2,
    NULL,
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  (
    4,
    'Transaction Process',
    'transaction/process',
    'parent',
    '',
    2,
    NULL,
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  (
    5,
    'Transaction Report',
    'reports/transaction',
    'parent',
    '',
    3,
    NULL,
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  (
    6,
    'Maintain User',
    'user',
    'parent',
    '',
    4,
    NULL,
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  (
    7,
    'Maintain System Menu',
    'menu',
    'parent',
    '',
    4,
    NULL,
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  (
    8,
    'Maintain Role',
    'role',
    'parent',
    '',
    4,
    NULL,
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  (
    9,
    'Maintain Menu Role',
    'menurole',
    'parent',
    '',
    4,
    NULL,
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  (
    10,
    'Maintain User Role',
    'userrole',
    'parent',
    '',
    4,
    NULL,
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  (
    11,
    'General Setting',
    'generalsetting',
    'parent',
    '',
    4,
    'setting',
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  (
    12,
    'Transaction Repair',
    'transaction/repair',
    'parent',
    '',
    2,
    NULL,
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  (
    13,
    'Defect List',
    'master/defect',
    'parent',
    '',
    1,
    NULL,
    '2021-08-08 00:00:00',
    'sys-admin'
  ),
  (
    14,
    'Location',
    'master/location',
    'parent',
    '',
    1,
    NULL,
    '2021-08-08 00:00:00',
    'sys-admin'
  ),
  (
    15,
    'Cause List',
    'master/cause',
    'parent',
    '',
    1,
    NULL,
    '2021-08-08 00:00:00',
    'sys-admin'
  ),
  (
    16,
    'Action List',
    'master/action',
    'parent',
    '',
    1,
    NULL,
    '2021-08-08 00:00:00',
    'sys-admin'
  ),
  (
    17,
    'Process Flow',
    'processflow',
    'parent',
    '',
    4,
    NULL,
    '2021-08-09 00:00:00',
    'sys-admin'
  ),
  (
    18,
    'Create Purchase Request',
    'pr',
    'parent',
    '',
    2,
    NULL,
    '2021-08-14 00:00:00',
    'sys-admin'
  ),
  (
    19,
    'Department List',
    'department',
    'parent',
    '',
    1,
    NULL,
    '2021-08-14 00:00:00',
    'sys-admin'
  ),
  (
    20,
    'Budget Allocation',
    'budgeting',
    'parent',
    '',
    1,
    NULL,
    '2021-08-14 00:00:00',
    'sys-admin'
  ),
  (
    21,
    'Approve Purchase Request',
    'approvepr',
    'parent',
    '',
    2,
    NULL,
    '2021-08-14 00:00:00',
    'sys-admin'
  ),
  (
    22,
    'Mapping Approval',
    'approval',
    'parent',
    '',
    4,
    NULL,
    '2021-08-14 00:00:00',
    'sys-admin'
  ),
  (
    23,
    'Report Purchase Request',
    'reports/reportpr',
    'parent',
    '',
    3,
    NULL,
    '2021-08-14 00:00:00',
    'sys-admin'
  ),
  (
    24,
    'Input Planning',
    'production',
    'parent',
    '',
    5,
    NULL,
    '2021-09-15 00:00:00',
    'sys-admin'
  ),
  (
    25,
    'Maintain Menu Groups',
    'menugroup',
    'parent',
    '',
    4,
    NULL,
    '2021-09-16 00:00:00',
    'sys-admin'
  ),
  (
    26,
    'Production Lines',
    'productionlines',
    'parent',
    '',
    1,
    NULL,
    '2021-09-18 00:00:00',
    'sys-admin'
  ),
  (
    27,
    'Actual Output',
    'production/inputactualqty',
    'parent',
    '',
    5,
    NULL,
    '2021-09-18 00:00:00',
    'sys-admin'
  ),
  (
    28,
    'Planning Report',
    'planningreport',
    'parent',
    '',
    5,
    NULL,
    '2021-09-20 00:00:00',
    'sys-admin'
  ),
  (
    29,
    'Production View',
    'production/productionview',
    'parent',
    '',
    5,
    NULL,
    '2021-10-02 00:00:00',
    'sys-admin'
  );
/*!40000 ALTER TABLE `t_menus` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_nriv`
--
DROP TABLE IF EXISTS `t_nriv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_nriv` (
  `object` varchar(15) NOT NULL,
  `fromnum` varchar(15) NOT NULL,
  `tonumber` varchar(15) NOT NULL,
  `currentnum` varchar(15) NOT NULL,
  PRIMARY KEY (`object`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_nriv`
--
LOCK TABLES `t_nriv` WRITE;
/*!40000 ALTER TABLE `t_nriv` DISABLE KEYS */
;
/*!40000 ALTER TABLE `t_nriv` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_planning`
--
DROP TABLE IF EXISTS `t_planning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_planning` (
  `plandate` date NOT NULL,
  `productionline` int(11) NOT NULL,
  `shift` int(11) NOT NULL,
  `model` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `partnumber` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `lot_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `plan_qty` int(11) NOT NULL,
  `createdon` date NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (
    `plandate`,
    `productionline`,
    `shift`,
    `model`,
    `partnumber`,
    `lot_number`
  )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_planning`
--
LOCK TABLES `t_planning` WRITE;
/*!40000 ALTER TABLE `t_planning` DISABLE KEYS */
;
INSERT INTO `t_planning`
VALUES (
    '2021-10-04',
    1,
    1,
    'U776A',
    '1122334-01',
    '10000001',
    1000,
    '2021-10-04',
    'sys-admin'
  ),
  (
    '2021-10-04',
    1,
    1,
    'U778B',
    '2233441-02',
    '10000002',
    1500,
    '2021-10-04',
    'sys-admin'
  ),
  (
    '2021-10-04',
    1,
    2,
    'U778B',
    '2233441-02',
    '10000003',
    500,
    '2021-10-04',
    'sys-admin'
  ),
  (
    '2021-10-04',
    1,
    2,
    'U778C',
    '2424241-01',
    '10000004',
    1000,
    '2021-10-04',
    'sys-admin'
  ),
  (
    '2021-10-13',
    1,
    2,
    'U778B',
    '2233441-02',
    '10000004',
    500,
    '2021-10-14',
    'sys-admin'
  ),
  (
    '2021-10-14',
    1,
    1,
    'U776A',
    '1122334-01',
    '10000000',
    1000,
    '2021-10-14',
    'sys-admin'
  ),
  (
    '2021-10-14',
    1,
    1,
    'U778B',
    '2233441-02',
    '10000001',
    1500,
    '2021-10-14',
    'sys-admin'
  ),
  (
    '2021-10-14',
    1,
    2,
    'U778C',
    '2424241-01',
    '10000002',
    1000,
    '2021-10-14',
    'sys-admin'
  ),
  (
    '2021-10-15',
    1,
    1,
    'U776A',
    '1122334-01',
    'LOT12345',
    1000,
    '2021-10-14',
    'sys-admin'
  ),
  (
    '2021-10-16',
    4,
    1,
    'U778C',
    '2424241-01',
    '10000002',
    600,
    '2021-10-14',
    'sys-admin'
  );
/*!40000 ALTER TABLE `t_planning` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_planning_output`
--
DROP TABLE IF EXISTS `t_planning_output`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_planning_output` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plandate` date NOT NULL,
  `productionline` int(11) NOT NULL,
  `shift` int(11) NOT NULL,
  `model` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `partnumber` varchar(70) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lot_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `output_qty` int(11) NOT NULL,
  `createdon` date NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 12 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_planning_output`
--
LOCK TABLES `t_planning_output` WRITE;
/*!40000 ALTER TABLE `t_planning_output` DISABLE KEYS */
;
INSERT INTO `t_planning_output`
VALUES (
    6,
    '2021-10-04',
    1,
    1,
    'U776A',
    '',
    '10000001',
    500,
    '2021-10-04',
    'sys-admin'
  ),
  (
    7,
    '2021-10-04',
    1,
    1,
    'U778B',
    '',
    '10000002',
    600,
    '2021-10-04',
    'sys-admin'
  ),
  (
    8,
    '2021-10-04',
    1,
    1,
    'U776A',
    '',
    '10000001',
    600,
    '2021-10-04',
    'sys-admin'
  ),
  (
    9,
    '2021-10-04',
    1,
    1,
    'U778B',
    '',
    '10000002',
    1000,
    '2021-10-04',
    'sys-admin'
  ),
  (
    10,
    '2021-10-04',
    1,
    2,
    'U778B',
    '',
    '10000003',
    600,
    '2021-10-04',
    'sys-admin'
  ),
  (
    11,
    '2021-10-04',
    1,
    2,
    'U778C',
    '',
    '10000004',
    900,
    '2021-10-04',
    'sys-admin'
  );
/*!40000 ALTER TABLE `t_planning_output` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_process_sequence`
--
DROP TABLE IF EXISTS `t_process_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_process_sequence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transtype` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `processname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sequence` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 17 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_process_sequence`
--
LOCK TABLES `t_process_sequence` WRITE;
/*!40000 ALTER TABLE `t_process_sequence` DISABLE KEYS */
;
INSERT INTO `t_process_sequence`
VALUES (1, 'process', 'AOI SMT-BOTTOM (1st)', 1, 'user1'),
  (2, 'process', 'AOI SMT-TOP (2nd)', 2, 'user2'),
  (3, 'process', 'SMT SI', 3, 'user3'),
  (4, 'process', 'ICT', 4, 'user4'),
  (5, 'process', 'QPIT', 5, 'user5'),
  (6, 'process', 'AOI HW-TOP', 6, 'user6'),
  (7, 'process', 'AOI HW-BOTTOM', 7, 'user7'),
  (8, 'process', 'FVI', 8, 'user8'),
  (9, 'repair', 'AFTER REPAIR-ICT', 2, 'user1'),
  (10, 'repair', 'AFTER REPAIR-QPIT', 3, 'user2'),
  (11, 'repair', 'AFTER REPAIR-AOI TOP', 4, 'user3'),
  (12, 'repair', 'AFTER REPAIR-BOT', 5, 'user4'),
  (13, 'repair', 'AFTER REPAIR-FVI', 6, 'user5'),
  (14, 'repair', 'OQA', 7, 'user6'),
  (15, 'process', 'QQA', 9, 'user9'),
  (16, 'repair', 'Action', 1, 'sys-admin');
/*!40000 ALTER TABLE `t_process_sequence` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_production_lines`
--
DROP TABLE IF EXISTS `t_production_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_production_lines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` date NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_production_lines`
--
LOCK TABLES `t_production_lines` WRITE;
/*!40000 ALTER TABLE `t_production_lines` DISABLE KEYS */
;
INSERT INTO `t_production_lines`
VALUES (1, 'LINE 1', '2021-09-18', 'sys-admin'),
  (2, 'LINE 2', '2021-09-18', 'sys-admin'),
  (4, 'LINE 3', '2021-09-18', 'sys-admin'),
  (5, 'LINE 4', '2021-09-20', 'sys-admin');
/*!40000 ALTER TABLE `t_production_lines` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_role`
--
DROP TABLE IF EXISTS `t_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_role` (
  `roleid` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`roleid`),
  KEY `idxrolename` (`rolename`),
  KEY `roleid` (`roleid`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Role Master';
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_role`
--
LOCK TABLES `t_role` WRITE;
/*!40000 ALTER TABLE `t_role` DISABLE KEYS */
;
INSERT INTO `t_role`
VALUES (
    1,
    'SYS-ADMIN',
    '2021-08-06 00:00:00',
    'sys-admin'
  ),
  (2, 'ROLE01', '2021-08-08 00:00:00', 'sys-admin'),
  (3, 'ROLE02', '2021-08-08 00:00:00', 'sys-admin');
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_role_avtivity`
--
DROP TABLE IF EXISTS `t_role_avtivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_role_avtivity` (
  `roleid` int(11) NOT NULL,
  `menuid` int(11) NOT NULL,
  `activity` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `createdon` date NOT NULL,
  PRIMARY KEY (`roleid`, `menuid`, `activity`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Activity Auth';
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_role_avtivity`
--
LOCK TABLES `t_role_avtivity` WRITE;
/*!40000 ALTER TABLE `t_role_avtivity` DISABLE KEYS */
;
INSERT INTO `t_role_avtivity`
VALUES (1, 1, 'Create', 1, '2021-08-07'),
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
/*!40000 ALTER TABLE `t_role_avtivity` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_rolemenu`
--
DROP TABLE IF EXISTS `t_rolemenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_rolemenu` (
  `roleid` int(11) NOT NULL,
  `menuid` int(11) NOT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`roleid`, `menuid`),
  KEY `roleid` (`roleid`),
  KEY `menuid` (`menuid`),
  CONSTRAINT `t_rolemenu_ibfk_1` FOREIGN KEY (`roleid`) REFERENCES `t_role` (`roleid`),
  CONSTRAINT `t_rolemenu_ibfk_2` FOREIGN KEY (`menuid`) REFERENCES `t_menus` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Role Menu';
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_rolemenu`
--
LOCK TABLES `t_rolemenu` WRITE;
/*!40000 ALTER TABLE `t_rolemenu` DISABLE KEYS */
;
INSERT INTO `t_rolemenu`
VALUES (1, 1, '2021-08-07 00:00:00', 'sys-admin'),
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
  (2, 4, '2021-08-20 00:00:00', 'sys-admin'),
  (2, 5, '2021-08-20 00:00:00', 'sys-admin'),
  (3, 12, '2021-08-20 00:00:00', 'sys-admin');
/*!40000 ALTER TABLE `t_rolemenu` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_user`
--
DROP TABLE IF EXISTS `t_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_user` (
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `userlevel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` int(11) DEFAULT NULL,
  `jabatan` int(11) DEFAULT NULL,
  `section` varchar(50) DEFAULT NULL,
  `approval` varchar(50) DEFAULT NULL,
  `reffid` varchar(30) DEFAULT NULL,
  `cust_id` int(11) DEFAULT NULL,
  `createdby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdon` date DEFAULT NULL,
  PRIMARY KEY (`username`),
  KEY `username` (`username`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_user`
--
LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */
;
INSERT INTO `t_user`
VALUES (
    'Repairer',
    '$2y$12$FIiBfGhdlXb82TcRIPRQHuyh48vv8A1YKsLtYzvxQ/yj3drPPy.ry',
    'REPAIRER',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'sys-admin',
    '2021-12-01'
  ),
  (
    'sys-admin',
    '$2y$12$YCj4abvz4tMxEoYys4/9sul.FX.9lyhoQzRdl8rI8LWxg1rQb7l/W',
    'Administrator',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '2021-08-07'
  ),
  (
    'user1',
    '$2y$12$SRZKODU0plLDEMZAaYI.fui6/KDGc6.E4Yqs94VJOlQM/4wFhhl0C',
    'User Demo 1',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'sys-admin',
    '2021-08-08'
  ),
  (
    'user2',
    '$2y$12$TxnC2JmAeAJF0g1q9PoY/uc3lPj8MUvHC.pd3pQ.lryIQtLCIxlTC',
    'User Demo 2',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'sys-admin',
    '2021-08-08'
  ),
  (
    'user3',
    '$2y$12$fIf3TTIpwRY3dUXBhUqZ6uJcmrH./LAYduoY8wk948txHdADT4s4.',
    'User Demo 3',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'sys-admin',
    '2021-08-08'
  ),
  (
    'user4',
    '$2y$12$vzXwT1.rWf8RxCRN1xsjYORke32hDwzbmG3KWtiuw9DRSX3Gg0In2',
    'User Demo 4',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'sys-admin',
    '2021-08-08'
  ),
  (
    'user5',
    '$2y$12$ELa9pJc.Y9WziGtEWUhNa.KmTr.1uYMV7kEjojLuUZ5fgKFhT5H4.',
    'User Demo 5',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'sys-admin',
    '2021-08-08'
  ),
  (
    'user6',
    '$2y$12$.MG0aufoFg4Aynxv.IKdGex1BEtBKcTi5xJAtuMoRFAf2GcnIxtQW',
    'User Demo 6',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'sys-admin',
    '2021-08-08'
  ),
  (
    'user7',
    '$2y$12$9fIVcRmeSqLiK2HUyyB2Xe7ix6XO/o0N.5.RliGAoCQZet9AAXM4W',
    'User Demo 7',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'sys-admin',
    '2021-08-08'
  ),
  (
    'user8',
    '$2y$12$n7s3vxO9AcnB.cR8d00.hOUP0M9tX/0smmg.a9ww0h7b6IuEp84JW',
    'User Demo 8',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'sys-admin',
    '2021-08-08'
  ),
  (
    'user9',
    '$2y$12$n7s3vxO9AcnB.cR8d00.hOUP0M9tX/0smmg.a9ww0h7b6IuEp84JW',
    'User QQA',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'sys-admin',
    '2021-08-08'
  );
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_user_object_auth`
--
DROP TABLE IF EXISTS `t_user_object_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_user_object_auth` (
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ob_auth` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ob_value` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`username`, `ob_auth`, `ob_value`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'User Object Authorization';
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_user_object_auth`
--
LOCK TABLES `t_user_object_auth` WRITE;
/*!40000 ALTER TABLE `t_user_object_auth` DISABLE KEYS */
;
/*!40000 ALTER TABLE `t_user_object_auth` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `t_user_role`
--
DROP TABLE IF EXISTS `t_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `t_user_role` (
  `username` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roleid` int(11) NOT NULL,
  `createdon` datetime NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`username`, `roleid`),
  KEY `roleid` (`roleid`),
  CONSTRAINT `t_user_role_ibfk_1` FOREIGN KEY (`username`) REFERENCES `t_user` (`username`),
  CONSTRAINT `t_user_role_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `t_role` (`roleid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'User Role';
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `t_user_role`
--
LOCK TABLES `t_user_role` WRITE;
/*!40000 ALTER TABLE `t_user_role` DISABLE KEYS */
;
INSERT INTO `t_user_role`
VALUES (
    'sys-admin',
    1,
    '2021-08-07 00:00:00',
    'sys-admin'
  ),
  ('user1', 2, '2021-08-08 00:00:00', 'sys-admin'),
  ('user1', 3, '2021-08-08 00:00:00', 'sys-admin'),
  ('user2', 2, '2021-08-08 00:00:00', 'sys-admin'),
  ('user2', 3, '2021-08-08 00:00:00', 'sys-admin'),
  ('user3', 2, '2021-08-08 00:00:00', 'sys-admin'),
  ('user3', 3, '2021-08-08 00:00:00', 'sys-admin'),
  ('user4', 2, '2021-08-08 00:00:00', 'sys-admin'),
  ('user4', 3, '2021-08-08 00:00:00', 'sys-admin'),
  ('user5', 2, '2021-08-08 00:00:00', 'sys-admin'),
  ('user5', 3, '2021-08-08 00:00:00', 'sys-admin'),
  ('user6', 2, '2021-08-08 00:00:00', 'sys-admin'),
  ('user6', 3, '2021-08-08 00:00:00', 'sys-admin'),
  ('user7', 2, '2021-08-08 00:00:00', 'sys-admin'),
  ('user8', 2, '2021-08-08 00:00:00', 'sys-admin'),
  ('user9', 2, '2022-01-10 00:00:00', 'sys-admin'),
  ('user9', 3, '2022-01-10 00:00:00', 'sys-admin');
/*!40000 ALTER TABLE `t_user_role` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `tblsetting`
--
DROP TABLE IF EXISTS `tblsetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `tblsetting` (
  `id` int(11) NOT NULL,
  `company` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `tblsetting`
--
LOCK TABLES `tblsetting` WRITE;
/*!40000 ALTER TABLE `tblsetting` DISABLE KEYS */
;
INSERT INTO `tblsetting`
VALUES (1, 'IPD - System', 'Company Address', '');
/*!40000 ALTER TABLE `tblsetting` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Temporary table structure for view `v_defect_process`
--
DROP TABLE IF EXISTS `v_defect_process`;
/*!50001 DROP VIEW IF EXISTS `v_defect_process`*/
;
SET @saved_cs_client = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_defect_process` (
 `id` tinyint NOT NULL,
 `transactionid` tinyint NOT NULL,
 `counter` tinyint NOT NULL,
 `repair_counter` tinyint NOT NULL,
 `process_defect` tinyint NOT NULL,
 `process_location` tinyint NOT NULL,
 `process_cause` tinyint NOT NULL,
 `process_action` tinyint NOT NULL,
 `process_remark` tinyint NOT NULL,
 `repair_defect` tinyint NOT NULL,
 `repair_location` tinyint NOT NULL,
 `repair_cause` tinyint NOT NULL,
 `repair_action` tinyint NOT NULL,
 `repair_remark` tinyint NOT NULL
 ) ENGINE=MyISAM */
;
SET character_set_client = @saved_cs_client;
--
-- Temporary table structure for view `v_productionview`
--
DROP TABLE IF EXISTS `v_productionview`;
/*!50001 DROP VIEW IF EXISTS `v_productionview`*/
;
SET @saved_cs_client = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_productionview` (
 `plandate` tinyint NOT NULL,
 `productionline` tinyint NOT NULL,
 `model` tinyint NOT NULL,
 `lot_number` tinyint NOT NULL,
 `shift` tinyint NOT NULL,
 `plan_qty` tinyint NOT NULL,
 `linename` tinyint NOT NULL,
 `outputqty` tinyint NOT NULL
 ) ENGINE=MyISAM */
;
SET character_set_client = @saved_cs_client;
--
-- Temporary table structure for view `v_productionview_shift1`
--
DROP TABLE IF EXISTS `v_productionview_shift1`;
/*!50001 DROP VIEW IF EXISTS `v_productionview_shift1`*/
;
SET @saved_cs_client = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_productionview_shift1` (
 `plandate` tinyint NOT NULL,
 `productionline` tinyint NOT NULL,
 `model` tinyint NOT NULL,
 `shift` tinyint NOT NULL,
 `plan_qty` tinyint NOT NULL,
 `linename` tinyint NOT NULL,
 `outputqty` tinyint NOT NULL
 ) ENGINE=MyISAM */
;
SET character_set_client = @saved_cs_client;
--
-- Temporary table structure for view `v_productionview_shift2`
--
DROP TABLE IF EXISTS `v_productionview_shift2`;
/*!50001 DROP VIEW IF EXISTS `v_productionview_shift2`*/
;
SET @saved_cs_client = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_productionview_shift2` (
 `plandate` tinyint NOT NULL,
 `productionline` tinyint NOT NULL,
 `model` tinyint NOT NULL,
 `shift` tinyint NOT NULL,
 `plan_qty` tinyint NOT NULL,
 `linename` tinyint NOT NULL,
 `outputqty` tinyint NOT NULL
 ) ENGINE=MyISAM */
;
SET character_set_client = @saved_cs_client;
--
-- Temporary table structure for view `v_report_transaction`
--
DROP TABLE IF EXISTS `v_report_transaction`;
/*!50001 DROP VIEW IF EXISTS `v_report_transaction`*/
;
SET @saved_cs_client = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_report_transaction` (
 `transactionid` tinyint NOT NULL,
 `process_counter` tinyint NOT NULL,
 `prod_date` tinyint NOT NULL,
 `partnumber` tinyint NOT NULL,
 `partmodel` tinyint NOT NULL,
 `lotcode` tinyint NOT NULL,
 `serial_no` tinyint NOT NULL,
 `createdon` tinyint NOT NULL,
 `process1` tinyint NOT NULL,
 `process2` tinyint NOT NULL,
 `process3` tinyint NOT NULL,
 `process4` tinyint NOT NULL,
 `process5` tinyint NOT NULL,
 `process6` tinyint NOT NULL,
 `process7` tinyint NOT NULL,
 `process8` tinyint NOT NULL,
 `process9` tinyint NOT NULL,
 `lastprocess` tinyint NOT NULL,
 `error_process` tinyint NOT NULL,
 `defect_name` tinyint NOT NULL,
 `location` tinyint NOT NULL,
 `cause` tinyint NOT NULL,
 `action` tinyint NOT NULL,
 `repair_counter` tinyint NOT NULL,
 `repair1` tinyint NOT NULL,
 `repair2` tinyint NOT NULL,
 `repair3` tinyint NOT NULL,
 `repair4` tinyint NOT NULL,
 `repair5` tinyint NOT NULL,
 `repair6` tinyint NOT NULL,
 `repair7` tinyint NOT NULL,
 `remark` tinyint NOT NULL,
 `repair_defect` tinyint NOT NULL,
 `repair_location` tinyint NOT NULL,
 `repair_action` tinyint NOT NULL,
 `lastrepair` tinyint NOT NULL
 ) ENGINE=MyISAM */
;
SET character_set_client = @saved_cs_client;
--
-- Temporary table structure for view `v_user_menu`
--
DROP TABLE IF EXISTS `v_user_menu`;
/*!50001 DROP VIEW IF EXISTS `v_user_menu`*/
;
SET @saved_cs_client = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_user_menu` (
 `username` tinyint NOT NULL,
 `roleid` tinyint NOT NULL,
 `rolename` tinyint NOT NULL,
 `menuid` tinyint NOT NULL,
 `id` tinyint NOT NULL,
 `menu` tinyint NOT NULL,
 `route` tinyint NOT NULL,
 `type` tinyint NOT NULL,
 `menugroup` tinyint NOT NULL,
 `grouping` tinyint NOT NULL,
 `icon` tinyint NOT NULL,
 `createdon` tinyint NOT NULL,
 `createdby` tinyint NOT NULL
 ) ENGINE=MyISAM */
;
SET character_set_client = @saved_cs_client;
--
-- Temporary table structure for view `v_user_menugroup`
--
DROP TABLE IF EXISTS `v_user_menugroup`;
/*!50001 DROP VIEW IF EXISTS `v_user_menugroup`*/
;
SET @saved_cs_client = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_user_menugroup` (
 `menugroup` tinyint NOT NULL,
 `description` tinyint NOT NULL,
 `icon` tinyint NOT NULL,
 `createdon` tinyint NOT NULL,
 `createdby` tinyint NOT NULL,
 `username` tinyint NOT NULL,
 `_index` tinyint NOT NULL
 ) ENGINE=MyISAM */
;
SET character_set_client = @saved_cs_client;
--
-- Temporary table structure for view `v_user_role_avtivity`
--
DROP TABLE IF EXISTS `v_user_role_avtivity`;
/*!50001 DROP VIEW IF EXISTS `v_user_role_avtivity`*/
;
SET @saved_cs_client = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_user_role_avtivity` (
 `roleid` tinyint NOT NULL,
 `menuid` tinyint NOT NULL,
 `activity` tinyint NOT NULL,
 `status` tinyint NOT NULL,
 `createdon` tinyint NOT NULL,
 `route` tinyint NOT NULL,
 `menu` tinyint NOT NULL,
 `username` tinyint NOT NULL,
 `rolename` tinyint NOT NULL
 ) ENGINE=MyISAM */
;
SET character_set_client = @saved_cs_client;
--
-- Dumping events for database 'ipd_system'
--
--
-- Dumping routines for database 'ipd_system'
--
/*!50003 DROP FUNCTION IF EXISTS `fGetProdPlanQty` */
;
/*!50003 SET @saved_cs_client      = @@character_set_client */
;
/*!50003 SET @saved_cs_results     = @@character_set_results */
;
/*!50003 SET @saved_col_connection = @@collation_connection */
;
/*!50003 SET character_set_client  = latin1 */
;
/*!50003 SET character_set_results = latin1 */
;
/*!50003 SET collation_connection  = latin1_swedish_ci */
;
/*!50003 SET @saved_sql_mode       = @@sql_mode */
;
/*!50003 SET sql_mode              = '' */
;
DELIMITER;
;
CREATE DEFINER = `root` @`localhost` FUNCTION `fGetProdPlanQty`(
  `pPlandate` DATE,
  `pLine` INT,
  `pShift` INT,
  `pModel` VARCHAR(70),
  `pLotnum` VARCHAR(50)
) RETURNS bigint(20) BEGIN
DECLARE hasil bigint;
SET hasil = (
    SELECT sum(plan_qty)
    from t_planning
    where plandate = pPlandate
      and productionline = pLine
      and shift = pShift
      and model = pModel
      and lot_number = pLotnum
  );
-- return the customer level
if hasil is null THEN
set hasil = 0;
end if;
RETURN (hasil);
END;
;
DELIMITER;
/*!50003 SET sql_mode              = @saved_sql_mode */
;
/*!50003 SET character_set_client  = @saved_cs_client */
;
/*!50003 SET character_set_results = @saved_cs_results */
;
/*!50003 SET collation_connection  = @saved_col_connection */
;
/*!50003 DROP FUNCTION IF EXISTS `fGetProdTotalQtyOutput` */
;
/*!50003 SET @saved_cs_client      = @@character_set_client */
;
/*!50003 SET @saved_cs_results     = @@character_set_results */
;
/*!50003 SET @saved_col_connection = @@collation_connection */
;
/*!50003 SET character_set_client  = latin1 */
;
/*!50003 SET character_set_results = latin1 */
;
/*!50003 SET collation_connection  = latin1_swedish_ci */
;
/*!50003 SET @saved_sql_mode       = @@sql_mode */
;
/*!50003 SET sql_mode              = '' */
;
DELIMITER;
;
CREATE DEFINER = `root` @`localhost` FUNCTION `fGetProdTotalQtyOutput`(
  `pPlandate` DATE,
  `pLine` INT,
  `pShift` INT,
  `pModel` VARCHAR(70),
  `pLotnum` VARCHAR(50)
) RETURNS bigint(20) BEGIN
DECLARE hasil bigint;
SET hasil = (
    SELECT sum(output_qty)
    from t_planning_output
    where plandate = pPlandate
      and productionline = pLine
      and shift = pShift
      and model = pModel
      and lot_number = pLotnum
  );
-- return the customer level
if hasil is null THEN
set hasil = 0;
end if;
RETURN (hasil);
END;
;
DELIMITER;
/*!50003 SET sql_mode              = @saved_sql_mode */
;
/*!50003 SET character_set_client  = @saved_cs_client */
;
/*!50003 SET character_set_results = @saved_cs_results */
;
/*!50003 SET collation_connection  = @saved_col_connection */
;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ProductionView` */
;
/*!50003 SET @saved_cs_client      = @@character_set_client */
;
/*!50003 SET @saved_cs_results     = @@character_set_results */
;
/*!50003 SET @saved_col_connection = @@collation_connection */
;
/*!50003 SET character_set_client  = latin1 */
;
/*!50003 SET character_set_results = latin1 */
;
/*!50003 SET collation_connection  = latin1_swedish_ci */
;
/*!50003 SET @saved_sql_mode       = @@sql_mode */
;
/*!50003 SET sql_mode              = '' */
;
DELIMITER;
;
CREATE DEFINER = `root` @`localhost` PROCEDURE `sp_ProductionView`() BEGIN
DECLARE date1 date;
DECLARE date2 date;
DECLARE date3 date;
set date1 = date(now());
set date2 = date(DATE_ADD(now(), INTERVAL 1 DAY));
set date3 = date(DATE_ADD(now(), INTERVAL 3 DAY));
select DISTINCT productionline,
  linename,
  model,
  lot_number,
  fGetProdPlanQty(date1, productionline, '1', model, lot_number) as 'planqtyd1s1',
  fGetProdTotalQtyOutput(date1, productionline, '1', model, lot_number) as 'qtyoutd1s1',
  fGetProdPlanQty(date1, productionline, '2', model, lot_number) as 'planqtyd1s2',
  fGetProdTotalQtyOutput(date1, productionline, '2', model, lot_number) as 'qtyoutd1s2',
  fGetProdPlanQty(date2, productionline, '1', model, lot_number) as 'planqtyd2s1',
  fGetProdTotalQtyOutput(date2, productionline, '1', model, lot_number) as 'qtyoutd2s1',
  fGetProdPlanQty(date2, productionline, '2', model, lot_number) as 'planqtyd2s2',
  fGetProdTotalQtyOutput(date2, productionline, '2', model, lot_number) as 'qtyoutd2s2',
  fGetProdPlanQty(date3, productionline, '1', model, lot_number) as 'planqtyd3s1',
  fGetProdTotalQtyOutput(date3, productionline, '1', model, lot_number) as 'qtyoutd3s1',
  fGetProdPlanQty(date3, productionline, '2', model, lot_number) as 'planqtyd3s2',
  fGetProdTotalQtyOutput(date3, productionline, '2', model, lot_number) as 'qtyoutd3s2'
FROM v_productionview
WHERE plandate BETWEEN date(now())
  and date(DATE_ADD(now(), INTERVAL 2 DAY))
order by productionline,
  model,
  lot_number;
END;
;
DELIMITER;
/*!50003 SET sql_mode              = @saved_sql_mode */
;
/*!50003 SET character_set_client  = @saved_cs_client */
;
/*!50003 SET character_set_results = @saved_cs_results */
;
/*!50003 SET collation_connection  = @saved_col_connection */
;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ProductionView1` */
;
/*!50003 SET @saved_cs_client      = @@character_set_client */
;
/*!50003 SET @saved_cs_results     = @@character_set_results */
;
/*!50003 SET @saved_col_connection = @@collation_connection */
;
/*!50003 SET character_set_client  = latin1 */
;
/*!50003 SET character_set_results = latin1 */
;
/*!50003 SET collation_connection  = latin1_swedish_ci */
;
/*!50003 SET @saved_sql_mode       = @@sql_mode */
;
/*!50003 SET sql_mode              = '' */
;
DELIMITER;
;
CREATE DEFINER = `root` @`localhost` PROCEDURE `sp_ProductionView1`() BEGIN
DECLARE date1 date;
set date1 = date(now());
select DISTINCT productionline,
  linename,
  model,
  lot_number,
  fGetProdPlanQty(date1, productionline, '1', model, lot_number) as 'planqtyd1s1',
  fGetProdTotalQtyOutput(date1, productionline, '1', model, lot_number) as 'qtyoutd1s1',
  fGetProdPlanQty(date1, productionline, '2', model, lot_number) as 'planqtyd1s2',
  fGetProdTotalQtyOutput(date1, productionline, '2', model, lot_number) as 'qtyoutd1s2'
FROM v_productionview
WHERE plandate = date1
order by productionline,
  model,
  lot_number;
END;
;
DELIMITER;
/*!50003 SET sql_mode              = @saved_sql_mode */
;
/*!50003 SET character_set_client  = @saved_cs_client */
;
/*!50003 SET character_set_results = @saved_cs_results */
;
/*!50003 SET collation_connection  = @saved_col_connection */
;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ProductionView2` */
;
/*!50003 SET @saved_cs_client      = @@character_set_client */
;
/*!50003 SET @saved_cs_results     = @@character_set_results */
;
/*!50003 SET @saved_col_connection = @@collation_connection */
;
/*!50003 SET character_set_client  = latin1 */
;
/*!50003 SET character_set_results = latin1 */
;
/*!50003 SET collation_connection  = latin1_swedish_ci */
;
/*!50003 SET @saved_sql_mode       = @@sql_mode */
;
/*!50003 SET sql_mode              = '' */
;
DELIMITER;
;
CREATE DEFINER = `root` @`localhost` PROCEDURE `sp_ProductionView2`() BEGIN
DECLARE date1 date;
set date1 = date(DATE_ADD(now(), INTERVAL 1 DAY));
select DISTINCT productionline,
  linename,
  model,
  lot_number,
  fGetProdPlanQty(date1, productionline, '1', model, lot_number) as 'planqtyd2s1',
  fGetProdTotalQtyOutput(date1, productionline, '1', model, lot_number) as 'qtyoutd2s1',
  fGetProdPlanQty(date1, productionline, '2', model, lot_number) as 'planqtyd2s2',
  fGetProdTotalQtyOutput(date1, productionline, '2', model, lot_number) as 'qtyoutd2s2'
FROM v_productionview
WHERE plandate = date1
order by productionline,
  model,
  lot_number;
END;
;
DELIMITER;
/*!50003 SET sql_mode              = @saved_sql_mode */
;
/*!50003 SET character_set_client  = @saved_cs_client */
;
/*!50003 SET character_set_results = @saved_cs_results */
;
/*!50003 SET collation_connection  = @saved_col_connection */
;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ProductionView3` */
;
/*!50003 SET @saved_cs_client      = @@character_set_client */
;
/*!50003 SET @saved_cs_results     = @@character_set_results */
;
/*!50003 SET @saved_col_connection = @@collation_connection */
;
/*!50003 SET character_set_client  = latin1 */
;
/*!50003 SET character_set_results = latin1 */
;
/*!50003 SET collation_connection  = latin1_swedish_ci */
;
/*!50003 SET @saved_sql_mode       = @@sql_mode */
;
/*!50003 SET sql_mode              = '' */
;
DELIMITER;
;
CREATE DEFINER = `root` @`localhost` PROCEDURE `sp_ProductionView3`() BEGIN
DECLARE date1 date;
set date1 = date(DATE_ADD(now(), INTERVAL 2 DAY));
select DISTINCT productionline,
  linename,
  model,
  lot_number,
  fGetProdPlanQty(date1, productionline, '1', model, lot_number) as 'planqtyd3s1',
  fGetProdTotalQtyOutput(date1, productionline, '1', model, lot_number) as 'qtyoutd3s1',
  fGetProdPlanQty(date1, productionline, '2', model, lot_number) as 'planqtyd3s2',
  fGetProdTotalQtyOutput(date1, productionline, '2', model, lot_number) as 'qtyoutd3s2'
FROM v_productionview
WHERE plandate = date1
order by productionline,
  model,
  lot_number;
END;
;
DELIMITER;
/*!50003 SET sql_mode              = @saved_sql_mode */
;
/*!50003 SET character_set_client  = @saved_cs_client */
;
/*!50003 SET character_set_results = @saved_cs_results */
;
/*!50003 SET collation_connection  = @saved_col_connection */
;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ProductionViewDate` */
;
/*!50003 SET @saved_cs_client      = @@character_set_client */
;
/*!50003 SET @saved_cs_results     = @@character_set_results */
;
/*!50003 SET @saved_col_connection = @@collation_connection */
;
/*!50003 SET character_set_client  = latin1 */
;
/*!50003 SET character_set_results = latin1 */
;
/*!50003 SET collation_connection  = latin1_swedish_ci */
;
/*!50003 SET @saved_sql_mode       = @@sql_mode */
;
/*!50003 SET sql_mode              = '' */
;
DELIMITER;
;
CREATE DEFINER = `root` @`localhost` PROCEDURE `sp_ProductionViewDate`() BEGIN
DECLARE date1 date;
DECLARE date2 date;
DECLARE date3 date;
set date1 = date(now());
set date2 = date(DATE_ADD(now(), INTERVAL 1 DAY));
set date3 = date(DATE_ADD(now(), INTERVAL 2 DAY));
select date1,
  date2,
  date3;
END;
;
DELIMITER;
/*!50003 SET sql_mode              = @saved_sql_mode */
;
/*!50003 SET character_set_client  = @saved_cs_client */
;
/*!50003 SET character_set_results = @saved_cs_results */
;
/*!50003 SET collation_connection  = @saved_col_connection */
;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ProductionViewDay1` */
;
/*!50003 SET @saved_cs_client      = @@character_set_client */
;
/*!50003 SET @saved_cs_results     = @@character_set_results */
;
/*!50003 SET @saved_col_connection = @@collation_connection */
;
/*!50003 SET character_set_client  = latin1 */
;
/*!50003 SET character_set_results = latin1 */
;
/*!50003 SET collation_connection  = latin1_swedish_ci */
;
/*!50003 SET @saved_sql_mode       = @@sql_mode */
;
/*!50003 SET sql_mode              = '' */
;
DELIMITER;
;
CREATE DEFINER = `root` @`localhost` PROCEDURE `sp_ProductionViewDay1`() BEGIN
DECLARE date1 date;
DECLARE date2 date;
set date2 = DATE_SUB(date(now()), INTERVAL 1 DAY);
set date1 = date(now());
select DISTINCT productionline,
  linename,
  model,
  lot_number,
  fGetProdPlanQty(date1, productionline, '1', model, lot_number) as 'planqtyd1s1',
  fGetProdTotalQtyOutput(date1, productionline, '1', model, lot_number) as 'qtyoutd1s1',
  fGetProdPlanQty(date1, productionline, '2', model, lot_number) as 'planqtyd1s2',
  fGetProdTotalQtyOutput(date1, productionline, '2', model, lot_number) as 'qtyoutd1s2'
FROM v_productionview
WHERE plandate = date1
  or (
    plandate = date2
    AND shift = 2
  )
order by productionline,
  model,
  lot_number;
END;
;
DELIMITER;
/*!50003 SET sql_mode              = @saved_sql_mode */
;
/*!50003 SET character_set_client  = @saved_cs_client */
;
/*!50003 SET character_set_results = @saved_cs_results */
;
/*!50003 SET collation_connection  = @saved_col_connection */
;
--
-- Final view structure for view `v_defect_process`
--
/*!50001 DROP TABLE IF EXISTS `v_defect_process`*/
;
/*!50001 DROP VIEW IF EXISTS `v_defect_process`*/
;
/*!50001 SET @saved_cs_client          = @@character_set_client */
;
/*!50001 SET @saved_cs_results         = @@character_set_results */
;
/*!50001 SET @saved_col_connection     = @@collation_connection */
;
/*!50001 SET character_set_client      = latin1 */
;
/*!50001 SET character_set_results     = latin1 */
;
/*!50001 SET collation_connection      = latin1_swedish_ci */
;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_defect_process` AS select `a`.`id` AS `id`,`a`.`transactionid` AS `transactionid`,`a`.`counter` AS `counter`,`b`.`repair_counter` AS `repair_counter`,`a`.`defect` AS `process_defect`,`a`.`location` AS `process_location`,`a`.`cause` AS `process_cause`,`a`.`action` AS `process_action`,`a`.`repairremark` AS `process_remark`,`b`.`defect` AS `repair_defect`,`b`.`location` AS `repair_location`,`b`.`cause` AS `repair_cause`,`b`.`action` AS `repair_action`,`b`.`remark` AS `repair_remark` from (`t_defect_process` `a` left join `t_defect_repair` `b` on(`a`.`transactionid` = `b`.`transactionid` and `a`.`counter` = `b`.`process_counter` and `a`.`id` = `b`.`defect_process_id`)) order by `a`.`transactionid`,`b`.`repair_counter`,`a`.`id` */
;
/*!50001 SET character_set_client      = @saved_cs_client */
;
/*!50001 SET character_set_results     = @saved_cs_results */
;
/*!50001 SET collation_connection      = @saved_col_connection */
;
--
-- Final view structure for view `v_productionview`
--
/*!50001 DROP TABLE IF EXISTS `v_productionview`*/
;
/*!50001 DROP VIEW IF EXISTS `v_productionview`*/
;
/*!50001 SET @saved_cs_client          = @@character_set_client */
;
/*!50001 SET @saved_cs_results         = @@character_set_results */
;
/*!50001 SET @saved_col_connection     = @@collation_connection */
;
/*!50001 SET character_set_client      = latin1 */
;
/*!50001 SET character_set_results     = latin1 */
;
/*!50001 SET collation_connection      = latin1_swedish_ci */
;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_productionview` AS select `a`.`plandate` AS `plandate`,`a`.`productionline` AS `productionline`,`a`.`model` AS `model`,`a`.`lot_number` AS `lot_number`,`a`.`shift` AS `shift`,`a`.`plan_qty` AS `plan_qty`,`b`.`description` AS `linename`,`fGetProdTotalQtyOutput`(`a`.`plandate`,`a`.`productionline`,`a`.`shift`,`a`.`model`,`a`.`lot_number`) AS `outputqty` from (`t_planning` `a` join `t_production_lines` `b` on(`a`.`productionline` = `b`.`id`)) */
;
/*!50001 SET character_set_client      = @saved_cs_client */
;
/*!50001 SET character_set_results     = @saved_cs_results */
;
/*!50001 SET collation_connection      = @saved_col_connection */
;
--
-- Final view structure for view `v_productionview_shift1`
--
/*!50001 DROP TABLE IF EXISTS `v_productionview_shift1`*/
;
/*!50001 DROP VIEW IF EXISTS `v_productionview_shift1`*/
;
/*!50001 SET @saved_cs_client          = @@character_set_client */
;
/*!50001 SET @saved_cs_results         = @@character_set_results */
;
/*!50001 SET @saved_col_connection     = @@collation_connection */
;
/*!50001 SET character_set_client      = latin1 */
;
/*!50001 SET character_set_results     = latin1 */
;
/*!50001 SET collation_connection      = latin1_swedish_ci */
;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_productionview_shift1` AS select `a`.`plandate` AS `plandate`,`a`.`productionline` AS `productionline`,`a`.`model` AS `model`,`a`.`shift` AS `shift`,`a`.`plan_qty` AS `plan_qty`,`b`.`description` AS `linename`,`fGetProdTotalQtyOutput`(`a`.`plandate`,`a`.`productionline`,`a`.`shift`,`a`.`model`) AS `outputqty` from (`t_planning` `a` join `t_production_lines` `b` on(`a`.`productionline` = `b`.`id`)) where `a`.`shift` = 1 */
;
/*!50001 SET character_set_client      = @saved_cs_client */
;
/*!50001 SET character_set_results     = @saved_cs_results */
;
/*!50001 SET collation_connection      = @saved_col_connection */
;
--
-- Final view structure for view `v_productionview_shift2`
--
/*!50001 DROP TABLE IF EXISTS `v_productionview_shift2`*/
;
/*!50001 DROP VIEW IF EXISTS `v_productionview_shift2`*/
;
/*!50001 SET @saved_cs_client          = @@character_set_client */
;
/*!50001 SET @saved_cs_results         = @@character_set_results */
;
/*!50001 SET @saved_col_connection     = @@collation_connection */
;
/*!50001 SET character_set_client      = latin1 */
;
/*!50001 SET character_set_results     = latin1 */
;
/*!50001 SET collation_connection      = latin1_swedish_ci */
;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_productionview_shift2` AS select `a`.`plandate` AS `plandate`,`a`.`productionline` AS `productionline`,`a`.`model` AS `model`,`a`.`shift` AS `shift`,`a`.`plan_qty` AS `plan_qty`,`b`.`description` AS `linename`,`fGetProdTotalQtyOutput`(`a`.`plandate`,`a`.`productionline`,`a`.`shift`,`a`.`model`) AS `outputqty` from (`t_planning` `a` join `t_production_lines` `b` on(`a`.`productionline` = `b`.`id`)) where `a`.`shift` = 2 */
;
/*!50001 SET character_set_client      = @saved_cs_client */
;
/*!50001 SET character_set_results     = @saved_cs_results */
;
/*!50001 SET collation_connection      = @saved_col_connection */
;
--
-- Final view structure for view `v_report_transaction`
--
/*!50001 DROP TABLE IF EXISTS `v_report_transaction`*/
;
/*!50001 DROP VIEW IF EXISTS `v_report_transaction`*/
;
/*!50001 SET @saved_cs_client          = @@character_set_client */
;
/*!50001 SET @saved_cs_results         = @@character_set_results */
;
/*!50001 SET @saved_col_connection     = @@collation_connection */
;
/*!50001 SET character_set_client      = latin1 */
;
/*!50001 SET character_set_results     = latin1 */
;
/*!50001 SET collation_connection      = latin1_swedish_ci */
;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_report_transaction` AS select `a`.`transactionid` AS `transactionid`,`b`.`counter` AS `process_counter`,`a`.`prod_date` AS `prod_date`,`a`.`partnumber` AS `partnumber`,`a`.`partmodel` AS `partmodel`,`a`.`lotcode` AS `lotcode`,`a`.`serial_no` AS `serial_no`,`a`.`createdon` AS `createdon`,`b`.`process1` AS `process1`,`b`.`process2` AS `process2`,`b`.`process3` AS `process3`,`b`.`process4` AS `process4`,`b`.`process5` AS `process5`,`b`.`process6` AS `process6`,`b`.`process7` AS `process7`,`b`.`process8` AS `process8`,`b`.`process9` AS `process9`,`b`.`lastprocess` AS `lastprocess`,`b`.`error_process` AS `error_process`,`b`.`defect_name` AS `defect_name`,`b`.`location` AS `location`,`b`.`cause` AS `cause`,`b`.`action` AS `action`,`c`.`counter` AS `repair_counter`,`c`.`process1` AS `repair1`,`c`.`process2` AS `repair2`,`c`.`process3` AS `repair3`,`c`.`process4` AS `repair4`,`c`.`process5` AS `repair5`,`c`.`process6` AS `repair6`,`c`.`process7` AS `repair7`,`c`.`remark` AS `remark`,`c`.`defect_name` AS `repair_defect`,`c`.`location` AS `repair_location`,`c`.`action` AS `repair_action`,`c`.`lastrepair` AS `lastrepair` from ((`t_ipd_forms` `a` left join `t_ipd_process` `b` on(`a`.`transactionid` = `b`.`transactionid`)) left join `t_ipd_repair` `c` on(`a`.`transactionid` = `c`.`transactionid` and `b`.`counter` = `c`.`process_counter`)) order by `a`.`transactionid`,`a`.`serial_no`,`a`.`partnumber` */
;
/*!50001 SET character_set_client      = @saved_cs_client */
;
/*!50001 SET character_set_results     = @saved_cs_results */
;
/*!50001 SET collation_connection      = @saved_col_connection */
;
--
-- Final view structure for view `v_user_menu`
--
/*!50001 DROP TABLE IF EXISTS `v_user_menu`*/
;
/*!50001 DROP VIEW IF EXISTS `v_user_menu`*/
;
/*!50001 SET @saved_cs_client          = @@character_set_client */
;
/*!50001 SET @saved_cs_results         = @@character_set_results */
;
/*!50001 SET @saved_col_connection     = @@collation_connection */
;
/*!50001 SET character_set_client      = latin1 */
;
/*!50001 SET character_set_results     = latin1 */
;
/*!50001 SET collation_connection      = latin1_swedish_ci */
;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_menu` AS select `a`.`username` AS `username`,`b`.`roleid` AS `roleid`,`f`.`rolename` AS `rolename`,`c`.`menuid` AS `menuid`,`d`.`id` AS `id`,`d`.`menu` AS `menu`,`d`.`route` AS `route`,`d`.`type` AS `type`,`d`.`menugroup` AS `menugroup`,`d`.`grouping` AS `grouping`,`d`.`icon` AS `icon`,`d`.`createdon` AS `createdon`,`d`.`createdby` AS `createdby` from ((((`t_user` `a` join `t_user_role` `b` on(`a`.`username` = `b`.`username`)) join `t_rolemenu` `c` on(`c`.`roleid` = `b`.`roleid`)) join `t_menus` `d` on(`d`.`id` = `c`.`menuid`)) join `t_role` `f` on(`f`.`roleid` = `b`.`roleid`)) */
;
/*!50001 SET character_set_client      = @saved_cs_client */
;
/*!50001 SET character_set_results     = @saved_cs_results */
;
/*!50001 SET collation_connection      = @saved_col_connection */
;
--
-- Final view structure for view `v_user_menugroup`
--
/*!50001 DROP TABLE IF EXISTS `v_user_menugroup`*/
;
/*!50001 DROP VIEW IF EXISTS `v_user_menugroup`*/
;
/*!50001 SET @saved_cs_client          = @@character_set_client */
;
/*!50001 SET @saved_cs_results         = @@character_set_results */
;
/*!50001 SET @saved_col_connection     = @@collation_connection */
;
/*!50001 SET character_set_client      = latin1 */
;
/*!50001 SET character_set_results     = latin1 */
;
/*!50001 SET collation_connection      = latin1_swedish_ci */
;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_menugroup` AS select `a`.`menugroup` AS `menugroup`,`a`.`description` AS `description`,`a`.`icon` AS `icon`,`a`.`createdon` AS `createdon`,`a`.`createdby` AS `createdby`,`b`.`username` AS `username`,`a`.`_index` AS `_index` from (`t_menugroups` `a` join `v_user_menu` `b` on(`a`.`menugroup` = `b`.`menugroup`)) order by `a`.`_index`,`a`.`menugroup` */
;
/*!50001 SET character_set_client      = @saved_cs_client */
;
/*!50001 SET character_set_results     = @saved_cs_results */
;
/*!50001 SET collation_connection      = @saved_col_connection */
;
--
-- Final view structure for view `v_user_role_avtivity`
--
/*!50001 DROP TABLE IF EXISTS `v_user_role_avtivity`*/
;
/*!50001 DROP VIEW IF EXISTS `v_user_role_avtivity`*/
;
/*!50001 SET @saved_cs_client          = @@character_set_client */
;
/*!50001 SET @saved_cs_results         = @@character_set_results */
;
/*!50001 SET @saved_col_connection     = @@collation_connection */
;
/*!50001 SET character_set_client      = latin1 */
;
/*!50001 SET character_set_results     = latin1 */
;
/*!50001 SET collation_connection      = latin1_swedish_ci */
;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_role_avtivity` AS select `a`.`roleid` AS `roleid`,`a`.`menuid` AS `menuid`,`a`.`activity` AS `activity`,`a`.`status` AS `status`,`a`.`createdon` AS `createdon`,`b`.`route` AS `route`,`b`.`menu` AS `menu`,`c`.`username` AS `username`,`d`.`rolename` AS `rolename` from (((`t_role_avtivity` `a` join `t_menus` `b` on(`a`.`menuid` = `b`.`id`)) join `t_user_role` `c` on(`a`.`roleid` = `c`.`roleid`)) join `t_role` `d` on(`a`.`roleid` = `d`.`roleid`)) order by `c`.`username`,`d`.`rolename` */
;
/*!50001 SET character_set_client      = @saved_cs_client */
;
/*!50001 SET character_set_results     = @saved_cs_results */
;
/*!50001 SET collation_connection      = @saved_col_connection */
;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */
;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */
;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */
;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */
;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */
;
-- Dump completed on 2022-05-30 22:28:07