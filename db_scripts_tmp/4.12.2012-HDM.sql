-- MySQL dump 10.13  Distrib 5.5.28, for Linux (x86_64)
--
-- Host: localhost    Database: hdm_db1
-- ------------------------------------------------------
-- Server version	5.5.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

use hdm_db1;
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

LOCK TABLES `QRTZ_PAUSED_TRIGGER_GRPS` WRITE;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SCHEDULER_STATE`
--

LOCK TABLES `QRTZ_SCHEDULER_STATE` WRITE;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brands` (
  `id_brand` int(11) NOT NULL AUTO_INCREMENT,
  `brand_name` char(50) NOT NULL,
  PRIMARY KEY (`id_brand`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'Apple'),(2,'Amazon Kindle'),(3,'Sony Ericsson'),(4,'Samsung'),(5,'NOOK'),(6,'Motorola'),(7,'HTC'),(8,'Blackberry'),(9,'XBox'),(10,'Asus'),(11,'Lenovo'),(12,'Dell');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id_category` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` char(50) NOT NULL,
  `parent_node_id` int(11) DEFAULT NULL,
  `depth_of_category` int(11) DEFAULT NULL,
  `max_period` int(11) NOT NULL,
  `lineage` char(50) DEFAULT NULL,
  PRIMARY KEY (`id_category`),
  KEY `parent_node_id` (`parent_node_id`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_node_id`) REFERENCES `categories` (`id_category`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'FirstCategory',NULL,0,30,'/1/'),(10,'Phones',1,1,90,'/1/10/'),(11,'Tablets',1,1,90,'/1/11/'),(12,'Laptops',1,1,700,'/1/12/'),(13,'Console',1,1,30,'/1/13/');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id_location` int(11) NOT NULL AUTO_INCREMENT,
  `location_name` char(50) NOT NULL,
  PRIMARY KEY (`id_location`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'CLJ'),(2,'TIM');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `models`
--

DROP TABLE IF EXISTS `models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `models` (
  `id_model` int(11) NOT NULL AUTO_INCREMENT,
  `model_name` char(50) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_model`),
  KEY `brand_id` (`brand_id`),
  CONSTRAINT `models_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id_brand`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `models`
--

LOCK TABLES `models` WRITE;
/*!40000 ALTER TABLE `models` DISABLE KEYS */;
INSERT INTO `models` VALUES (1,'iPhone 3G',1),(2,'iPhone 4',1),(3,'iPhone 4S',1),(4,'iPhone 5',1),(5,'iPad 3',1),(6,'iPad 2',1),(7,'iPad 3G',1),(8,'Fire HD',2),(9,'Fire',2),(10,'iPod',1),(11,'Xperia Mini',3),(12,'Admire',4),(13,'Nexus Prime',4),(14,'Galaxy S II',4),(15,'Galaxy Nexus Verizon',4),(16,'Nexus S',4),(17,'Galaxy Nexus',4),(18,'Galaxy Tab',4),(19,'Color',5),(20,'Droidx',6),(21,'HD 7',7),(22,'TV',1),(23,'Desire',7),(24,'Torch',8),(25,'iPad 4',1),(26,'Curve',8),(27,'iPhone 3GS',1),(28,'360s',9),(29,'Galaxy Tab 2',4),(30,'Nexus 7',10),(31,'Omnia',4),(32,'V570',11),(33,'Latitude E6520',12);
/*!40000 ALTER TABLE `models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operating_system_versions`
--

DROP TABLE IF EXISTS `operating_system_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operating_system_versions` (
  `id_operating_system_version` int(11) NOT NULL AUTO_INCREMENT,
  `operating_system_version_name` char(50) NOT NULL,
  `operating_system_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_operating_system_version`),
  KEY `operating_system_id` (`operating_system_id`),
  CONSTRAINT `operating_system_versions_ibfk_1` FOREIGN KEY (`operating_system_id`) REFERENCES `operating_systems` (`id_operating_system`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operating_system_versions`
--

LOCK TABLES `operating_system_versions` WRITE;
/*!40000 ALTER TABLE `operating_system_versions` DISABLE KEYS */;
INSERT INTO `operating_system_versions` VALUES (1,'3.1',1),(2,'4.2',1),(3,'5.1',1),(4,'5.0',1),(5,'6',1),(6,'4.3',1),(7,'7.1.1',2),(8,'6.3.1',2),(9,'2.1.1',2),(10,'2.3.4',2),(11,'4.0.1',2),(12,'4.0.3',2),(13,'4.0.2',2),(14,'2.3.6',2),(15,'2.2',2),(16,'4.1.2',2),(17,'7.5',3),(18,'6.0',4),(19,'6.2.1',2),(20,'4.1.1',2),(21,'7 x64',3);
/*!40000 ALTER TABLE `operating_system_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operating_systems`
--

DROP TABLE IF EXISTS `operating_systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operating_systems` (
  `id_operating_system` int(11) NOT NULL AUTO_INCREMENT,
  `operating_system_name` char(50) NOT NULL,
  PRIMARY KEY (`id_operating_system`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operating_systems`
--

LOCK TABLES `operating_systems` WRITE;
/*!40000 ALTER TABLE `operating_systems` DISABLE KEYS */;
INSERT INTO `operating_systems` VALUES (1,'iOS'),(2,'Android'),(3,'Windows'),(4,'Blackberry');
/*!40000 ALTER TABLE `operating_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_filters`
--

DROP TABLE IF EXISTS `product_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_filters` (
  `id_filter` int(11) NOT NULL AUTO_INCREMENT,
  `fil_name` char(50) DEFAULT NULL,
  `fil_description` tinytext,
  `user_id` int(11) DEFAULT NULL,
  `fil_model` char(50) DEFAULT NULL,
  `fil_brand` char(50) DEFAULT NULL,
  `fil_operating_system` char(50) DEFAULT NULL,
  `fil_operating_system_version` char(50) DEFAULT NULL,
  `fil_serial_number` char(50) DEFAULT NULL,
  `fil_status` char(50) DEFAULT NULL,
  `fil_rental_owner` char(50) DEFAULT NULL,
  `fil_category_id` int(11) DEFAULT NULL,
  `fil_item` char(50) DEFAULT NULL,
  `fil_mode` char(50) DEFAULT NULL,
  `fil_items_per_page` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_filter`),
  UNIQUE KEY `fil_name` (`fil_name`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `product_filters_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_filters`
--

LOCK TABLES `product_filters` WRITE;
/*!40000 ALTER TABLE `product_filters` DISABLE KEYS */;
INSERT INTO `product_filters` VALUES (1,'#%$#$@%^3','@#$%6432',147,'','','','','','','',8,'','',10),(2,'1243','',147,'','','','','','','',8,'','',10),(3,'zzzz','',154,'','','','','','','',10,'model','desc',10),(4,'aaaa','',2,'','','','','','','',10,'model','desc',10),(5,'aaa','',2,'','','','','','','',10,'model','desc',10),(6,'dsdsd','',2,'','','','','','','',10,'model','desc',10),(7,'ffff','',2,'','','','','','','',10,'model','desc',10),(8,'gfgfgfg','',2,'','','','','','','',10,'model','desc',10),(9,'jhhhhh','',2,'','','','','','','',10,'model','desc',10);
/*!40000 ALTER TABLE `product_filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id_product` int(11) NOT NULL AUTO_INCREMENT,
  `description` tinytext,
  `model_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `operating_system_version_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `serial_number` char(50) DEFAULT NULL,
  `qa_code` char(50) DEFAULT NULL,
  PRIMARY KEY (`id_product`),
  UNIQUE KEY `qa_code` (`qa_code`),
  KEY `model_id` (`model_id`),
  KEY `category_id` (`category_id`),
  KEY `operating_system_version_id` (`operating_system_version_id`),
  KEY `status_id` (`status_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`model_id`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id_category`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_3` FOREIGN KEY (`operating_system_version_id`) REFERENCES `operating_system_versions` (`id_operating_system_version`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_4` FOREIGN KEY (`status_id`) REFERENCES `status` (`id_status`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_5` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id_location`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'HDD 3.5 GB',1,10,1,1,1,'7R725HHCVRO','1'),(2,'HDD 15 GB',1,10,2,1,1,'5K9342W4Y7K','2'),(3,'HDD 16 GB, USB Cable, Black.',2,10,2,1,1,'7W105J0BA4S','3'),(4,'HDD 16 GB, Black',3,10,3,1,1,'C39GRLNGDT9Y','4'),(5,'HDD 16 GB, White',3,10,3,1,1,'C39GRCD3DTD1','5'),(6,'HDD 16 GB, White',3,10,4,1,1,'DNQH898QDTD1','6'),(7,'HDD 16 GB',3,10,3,1,1,'DNQH3KH5DT9Y','7'),(8,'HDD 16 GB, White',3,10,4,1,1,'C39GRCSPDTD1','8'),(9,'HDD 16 GB',2,10,3,1,1,'C8WHMDQBDT9Y','9'),(10,'HDD 16 GB, White',3,10,3,1,1,'DNPJ6BTZDTC0','10'),(11,'HDD 16 GB, White',3,10,3,1,1,'DX3J4J5SDTD2','11'),(12,'HDD 16 GB, White',3,10,3,1,1,'C5FJ72LFDT9Y','12'),(13,'HDD 16 GB, Black',4,10,5,1,1,'C34JJTT5DTWD','13'),(14,'HDD 16 GB, Black',4,10,5,1,1,'C34JJTX7DTWD','14'),(15,'HDD 16 GB',5,11,3,1,1,'DLXH2V0YDJ8T','15'),(16,'HDD 16 GB',6,11,4,1,1,'DMPGNW3SDFJ1','16'),(17,'HDD 16GB',7,11,6,1,1,'GB033B8SZ39','17'),(18,'HDD 16 GB',7,11,4,1,1,'GB0219TQA90','18'),(19,'HDD 16 GB',8,11,7,1,1,'D025A0A02376OSA6','19'),(20,'HDD 6 GB',9,11,8,1,1,'D01EC0A0202100N8','20'),(21,'HDD 30 GB',10,10,3,1,1,'C3VDLF5UDCP9','21'),(22,'HDD 1,8 GB',11,10,9,1,1,'CB511TUE2B','22'),(23,'HDD 8 GB',10,10,2,1,1,'DKNDLPLLCP7','23'),(24,'HDD 30 GB',10,10,6,1,1,'C1XDT7HBDCP9','24'),(25,'HDD 8 GB',10,10,1,1,1,'DKMDN5PBDCP7','25'),(26,'HDD 1 GB',12,10,10,1,1,'A000002F5BA18E','26'),(27,'HDD 16 GB',13,10,11,1,1,'0A3C22AF03015019','27'),(28,'HDD 12 GB, Black',14,10,12,5,1,'000906785f6b7f','28'),(30,'HDD 14 GB, Google',16,10,14,1,1,'R3YZC76703R','30'),(31,'HDD 28 GB, Verizon',17,10,13,1,1,'0149C22111101901A','29'),(32,'HDD 16 GB, 10.1\" ',18,11,1,1,1,'004999910640000','31'),(33,'HDD 16 GB, 7\"',18,11,15,1,1,'A0000029010B49','33'),(34,'HDD 5GB',19,11,16,1,1,'2004550006792','34'),(35,'HDD ',20,10,15,1,1,'A000002298C7B6','35'),(36,'HDD 16 GB, T9292',21,10,17,1,1,'HT11ERG01079','36'),(37,'Apple TV 2',22,13,NULL,1,1,'DCYF4HVLDDR5','32'),(38,'HTC Desire A8181',23,10,NULL,1,1,'HT05MPL05125','37'),(39,'BlackBerry 9800 Torch 3G+WIFI',24,10,18,1,1,'353490049297423','39'),(41,'BlackBerry 9300 3G+WIFI',26,10,18,1,1,'358033048383078','41'),(42,'HDD 16 GB',25,11,5,1,1,'DMPJHE6KF182','40'),(43,'HDD 6 GB',9,11,19,1,2,'D01EC0A015250LHP','43'),(44,'HDD 8 GB',27,10,6,1,2,'840525E9EDG','44'),(45,'HDD 13.6 GB, White',3,10,4,1,2,'DNQH8EVZDTD1','42'),(46,'HDD 16GB, Black',4,10,5,1,2,'C34JJTTSDTWD','46'),(47,'A1427',22,13,NULL,1,1,'C0HJJ36VDRHN','47'),(48,'A1378',22,13,NULL,1,2,'DCYGXL4KDDR5','48'),(49,'HDD 14 GB',6,11,4,1,2,'DN6GP4SNDFJ1','49'),(50,'',17,10,13,1,2,'0146B0650F003015','50'),(51,'HDD 14 GB',7,11,4,1,2,'GB0219TQA90','51'),(52,'',8,11,7,1,2,'D025A0A0235406B0','52'),(53,'HDD 13,4 GB',5,11,5,1,2,'DMQHQX4UDJ8T','53'),(54,'HDD 13,6 GB, White',3,10,5,1,2,'DNQH8EVZDTD1','54'),(55,'HDD 13,5 GB, Black',3,10,3,1,2,'DNPJ6ABLDTC0','55'),(56,'Model 1439',28,13,NULL,1,1,'401167220505','56'),(57,'HDD 12 GB',29,11,12,1,2,'RF1C8155D4N','57'),(58,'HDD 6 GB',30,11,20,1,2,'015d15b4d70c0019','58'),(59,'HDD 3 GB, Samsung S7530',31,10,17,1,2,'35215005066699601','59'),(60,'HDD 2GB + SD 12 GB, Black',14,10,12,1,2,'0009d23243537f','60'),(61,'CPU i3 2,3 GHz, RAM 6GB, HDD 750 GB',32,12,21,1,1,'WB04C29WW','61'),(62,'',33,12,21,1,1,'H01D4Q1','62'),(63,'',32,12,21,1,2,'WB04875941','63');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rentals` (
  `id_rental` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_rental`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `rentals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rentals_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals`
--

LOCK TABLES `rentals` WRITE;
/*!40000 ALTER TABLE `rentals` DISABLE KEYS */;
INSERT INTO `rentals` VALUES (1,4,154,'2012-11-23 15:14:13','2012-11-30 16:00:00',0),(3,28,154,'2012-12-04 15:41:31','2012-12-31 16:00:00',1);
/*!40000 ALTER TABLE `rentals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id_role` int(11) NOT NULL AUTO_INCREMENT,
  `role` char(50) NOT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'User'),(2,'Admin');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `id_status` int(11) NOT NULL AUTO_INCREMENT,
  `status_type` char(50) NOT NULL,
  PRIMARY KEY (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'Available'),(2,'Rented'),(3,'Ordered'),(4,'Broken'),(5,'Pending Rent'),(6,'Pending Release');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(50) NOT NULL,
  `password` char(50) NOT NULL,
  `first_name` char(50) NOT NULL,
  `last_name` char(50) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `count_login` int(11) DEFAULT NULL,
  `reset_password_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `username` (`username`),
  KEY `role_id` (`role_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id_role`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id_location`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'hdmadmin@3pillarglobal.com','5f4dcc3b5aa765d61d8327deb882cf99','Admin','Admin',2,1,0,NULL),(2,'alina.perde@3pillarglobal.com','5f4dcc3b5aa765d61d8327deb882cf99','Alina','Perde',2,1,0,NULL),(3,'silvana.albu@3pillarglobal.com','5f4dcc3b5aa765d61d8327deb882cf99','Silvana','Albu',2,1,0,NULL),(4,'flavia.gheorghe@3pillarglobal.com','5f4dcc3b5aa765d61d8327deb882cf99','Flavia','Gheorghe',2,1,0,NULL),(5,'adelin.neacsu@3pillarglobal.com','','Adelin','Neacsu',1,2,0,NULL),(6,'adina.radulescu@3pillarglobal.com','','Adina','Radulescu',1,2,0,NULL),(7,'adrian.somesan@3pillarglobal.com','','Adrian','Somesan',1,2,0,NULL),(8,'adrian.garbe@3pillarglobal.com','','Adrian','Garbe',1,2,0,NULL),(9,'adrian.vornic@3pillarglobal.com','','Adrian','Vornic',1,2,0,NULL),(10,'alexandru.cucu@3pillarglobal.com','','Alexandru','Cucu',1,2,0,NULL),(11,'alin.posorovaschi@3pillarglobal.com','','Alin','Posorovaschi',1,2,0,NULL),(13,'anca.mihalache@3pillarglobal.com','','Anca','Mihalache',1,2,0,NULL),(14,'andrada.rupacici@3pillarglobal.com','','Andrada','Rupacici',1,2,0,NULL),(15,'andreea.marcu@3pillarglobal.com','','Andreea','Marcu',1,2,0,NULL),(16,'andrei.savin@3pillarglobal.com','','Andrei','Savin',1,2,0,NULL),(17,'andrei.secea@3pillarglobal.com','','Andrei','Secea',1,2,0,NULL),(18,'anita.bejan@3pillarglobal.com','','Anita','Bejan',1,2,0,NULL),(19,'bianca.pirte@3pillarglobal.com','','Bianca','Pirte',1,2,0,NULL),(20,'bogdan.hodorog@3pillarglobal.com','','Bogdan','Hodorog',1,2,0,NULL),(21,'bogdan.cornianu@3pillarglobal.com','','Bogdan','Cornianu',1,2,0,NULL),(22,'bogdan.solga@3pillarglobal.com','','Bogdan','Solga',1,2,0,NULL),(23,'calin.balajiu@3pillarglobal.com','','Calin','Balajiu',1,2,0,NULL),(24,'catalin.stef@3pillarglobal.com','','Catalin','Stef',1,2,0,NULL),(25,'cezar.boicu@3pillarglobal.com','','Cezar','Boicu',1,2,0,NULL),(26,'ciprian.mester@3pillarglobal.com','','Ciprian','Mester',1,2,0,NULL),(27,'ciprian.balea@3pillarglobal.com','','Ciprian','Balea',1,2,0,NULL),(28,'claudiu.cosar@3pillarglobal.com','','Claudiu','Cosar',1,2,0,NULL),(29,'corneliu.bogdan@3pillarglobal.com','','Corneliu','Bogdan',1,2,0,NULL),(30,'cristian.lupu@3pillarglobal.com','','Cristian','Lupu',1,2,0,NULL),(31,'dan.suciu@3pillarglobal.com','','Dan','Suciu',1,2,0,NULL),(32,'daniel.ivanescu@3pillarglobal.com','e4d778d0c69ecde1be6a759320bc537a','Daniel','Ivanescu',2,2,0,NULL),(33,'daniel.nistor@3pillarglobal.com','','Daniel','Nistor',1,2,0,NULL),(34,'dorel.macra@3pillarglobal.com','','Dorel','Macra',1,2,0,NULL),(35,'florian.chis@3pillarglobal.com','','Florian','Chis',1,2,0,NULL),(36,'florin.jurcovici@3pillarglobal.com','','Florin','Jurcovici',1,2,0,NULL),(37,'gabriel.kovacs@3pillarglobal.com','','Gabriel','Kovacs',1,2,0,NULL),(38,'gil.eluard@3pillarglobal.com','','Gil','Eluard',1,2,0,NULL),(39,'ioana.cotora@3pillarglobal.com','','Ioana','Cotora',1,2,0,NULL),(40,'ioana.gruia@3pillarglobal.com','','Ioana','Gruia',1,2,0,NULL),(41,'iulia.miron@3pillarglobal.com','','Iulia','Miron',1,2,0,NULL),(42,'karoly.szanto@3pillarglobal.com','','Karoly','Szanto',1,2,0,NULL),(43,'laura.feier@3pillarglobal.com','','Laura','Feier',1,2,0,NULL),(44,'madalin.cosma@3pillarglobal.com','','Madalin','Cosma',1,2,0,NULL),(45,'marcel.anghelescu@3pillarglobal.com','','Marcel','Anghelescu',1,2,0,NULL),(46,'marcel.cojocaru@3pillarglobal.com','','Marcel','Cojocaru',1,2,0,NULL),(47,'maria.grozea@3pillarglobal.com','','Maria','Grozea',1,2,0,NULL),(48,'marius.mazilu@3pillarglobal.com','','Marius','Mazilu',1,2,0,NULL),(49,'marius.banici@3pillarglobal.com','','Marius','Banici',1,2,0,NULL),(50,'mihai.andreica@3pillarglobal.com','','Mihai','Andreica',1,2,0,NULL),(51,'olivera.miatovici@3pillarglobal.com','','Olivera','Miatovici',1,2,0,NULL),(52,'paul.dobra@3pillarglobal.com','','Paul','Dobra',1,2,0,NULL),(53,'petru.dimulescu@3pillarglobal.com','','Petru','Dimulescu',1,2,0,NULL),(54,'petru.cristescu@3pillarglobal.com','','Petru','Cristescu',1,2,0,NULL),(55,'radu.lupascu@3pillarglobal.com','','Radu','Lupascu',1,2,0,NULL),(56,'radu.mihaila@3pillarglobal.com','','Radu','Mihaila',1,2,0,NULL),(57,'radu.ciorba@3pillarglobal.com','','Radu','Ciorba',1,2,0,NULL),(58,'radu.popovici@3pillarglobal.com','','Radu','Popovici',1,2,0,NULL),(59,'raluca.han@3pillarglobal.com','','Raluca','Han',1,2,0,NULL),(60,'razvan.balazs@3pillarglobal.com','','Razvan','Balazs',1,2,0,NULL),(61,'richard.oszlanczi@3pillarglobal.com','','Richard','Oszlanczi',1,2,0,NULL),(62,'stefan.filip@3pillarglobal.com','','Stefan','Filip',1,2,0,NULL),(63,'valentin.floarea@3pillarglobal.com','','Valentin','Floarea',1,2,0,NULL),(64,'adela.ileni@3pillarglobal.com','','Adela','Ileni',1,1,0,NULL),(65,'adina.borsan@3pillarglobal.com','','Adina','Borsan',1,1,0,NULL),(66,'adrian.biris@3pillarglobal.com','','Adrian','Biris',1,1,0,NULL),(67,'adrian.pop@3pillarglobal.com','','Adrian','Pop',1,1,0,NULL),(68,'adrian.buturca@3pillarglobal.com','','Adrian','Buturca',1,1,0,NULL),(69,'adriana.saroz@3pillarglobal.com','','Adriana','Saroz',1,1,0,NULL),(70,'alexandru.brad@3pillarglobal.com','','Alexandru','Brad',1,1,0,NULL),(71,'alexandru.cozmuta@3pillarglobal.com','','Alexandru','Cozmuta',1,1,0,NULL),(72,'alin.baicoci@3pillarglobal.com','','Alin','Baicoci',1,1,0,NULL),(73,'alina.andreica@3pillarglobal.com','','Alina','Andreica',1,1,0,NULL),(74,'amalia.gherasim@3pillarglobal.com','','Amalia','Gherasim',1,1,0,NULL),(75,'anda.laakso@3pillarglobal.com','','Anda','Laakso',1,1,0,NULL),(76,'andreea.costin@3pillarglobal.com','','Andreea','Costin',1,1,0,NULL),(77,'andrei.moldovan@3pillarglobal.com','','Andrei','Moldovan',1,1,0,NULL),(78,'andrei.sfat@3pillarglobal.com','','Andrei','Sfat',1,1,0,NULL),(79,'angel.ramboi@3pillarglobal.com','','Angel','Ramboi',1,1,0,NULL),(80,'anghel.contiu@3pillarglobal.com','','Anghel','Contiu',1,1,0,NULL),(81,'arthur.kirkosa@3pillarglobal.com','','Arthur','Kirkosa',1,1,0,NULL),(82,'bianca.prundus@3pillarglobal.com','','Bianca','Prundus',1,1,0,NULL),(83,'bogdan.mic@3pillarglobal.com','','Bogdan','Mic',1,1,0,NULL),(84,'bogdan.corha@3pillarglobal.com','','Bogdan','Corha',1,1,0,NULL),(85,'bogdan.balc@3pillarglobal.com','','Bogdan','Balc',1,1,0,NULL),(86,'bogdan.muresan@3pillarglobal.com','','Bogdan','Muresan',1,1,0,NULL),(87,'bogdan.flueras@3pillarglobal.com','','Bogdan','Flueras',1,1,0,NULL),(88,'bogdan.matei@3pillarglobal.com','','Bogdan','Matei',1,1,0,NULL),(89,'botond.beres@3pillarglobal.com','','Botond','Beres',1,1,0,NULL),(90,'calin.furau@3pillarglobal.com','','Calin','Furau',1,1,0,NULL),(91,'calin.trif@3pillarglobal.com','','Calin','Trif',1,1,0,NULL),(92,'camelia.turdean@3pillarglobal.com','','Camelia','Turdean',1,1,0,NULL),(93,'christian.nagy@3pillarglobal.com','','Christian','Nagy',1,1,0,NULL),(94,'ciprian.grigor@3pillarglobal.com','','Ciprian','Grigor',1,1,0,NULL),(95,'claudiu.zegrean@3pillarglobal.com','','Claudiu','Zegrean',1,1,0,NULL),(96,'codruta.bunea@3pillarglobal.com','','Codruta','Bunea',1,1,0,NULL),(97,'constantin.scoarta@3pillarglobal.com','','Constantin','Scoarta',1,1,0,NULL),(98,'costin.aniculaesei@3pillarglobal.com','','Costin','Aniculaesei',1,1,0,NULL),(99,'cristian.bodnar@3pillarglobal.com','','Cristian','Bodnar',1,1,0,NULL),(100,'cristina.oltean@3pillarglobal.com','','Cristina','Oltean',1,1,0,NULL),(101,'cristina.nuna@3pillarglobal.com','','Cristina','Nuna',1,1,0,NULL),(102,'csilla.csalanosi@3pillarglobal.com','','Csilla','Csalanosi',1,1,0,NULL),(103,'dan.pop@3pillarglobal.com','','Dan','Pop',1,1,0,NULL),(104,'daniel.burzo@threepillarglobal.com','','Daniel','Burzo@Threepillarglobal',1,1,0,NULL),(105,'diana.ciocoi@3pillarglobal.com','','Diana','Ciocoi',1,1,0,NULL),(106,'diana.ghele@3pillarglobal.com','','Diana','Ghele',1,1,0,NULL),(107,'dorel.matei@3pillarglobal.com','','Dorel','Matei',1,1,0,NULL),(108,'dorin.popovici@3pillarglobal.com','','Dorin','Popovici',1,1,0,NULL),(109,'doru.muresan@3pillarglobal.com','','Doru','Muresan',1,1,0,NULL),(110,'dumitru.apopii@3pillarglobal.com','','Dumitru','Apopii',1,1,0,NULL),(111,'florin.prunea@3pillarglobal.com','','Florin','Prunea',1,1,0,NULL),(112,'florin.pop@3pillarglobal.com','','Florin','Pop',1,1,0,NULL),(113,'franciska.balc@3pillarglobal.com','','Franciska','Balc',1,1,0,NULL),(114,'gratian.marta@3pillarglobal.com','','Gratian','Marta',1,1,0,NULL),(115,'ioan.bercea@3pillarglobal.com','','Ioan','Bercea',1,1,0,NULL),(116,'ioan.badarinza@3pillarglobal.com','','Ioan','Badarinza',1,1,0,NULL),(117,'ion.scerbatiuc@3pillarglobal.com','','Ion','Scerbatiuc',1,1,0,NULL),(118,'ionut.bujor@3pillarglobal.com','','Ionut','Bujor',2,1,0,NULL),(119,'ionut.ion@3pillarglobal.com','','Ionut','Ion',1,1,0,NULL),(120,'istvan.boros@3pillarglobal.com','','Istvan','Boros',1,1,0,NULL),(121,'iulia.rus@3pillarglobal.com','','Iulia','Rus',1,1,0,NULL),(122,'iulia.oltean@3pillarglobal.com','','Iulia','Oltean',1,1,0,NULL),(124,'janos.seichei@3pillarglobal.com','','Janos','Seichei',1,1,0,NULL),(125,'lidia.hirian@3pillarglobal.com','','Lidia','Hirian',1,1,0,NULL),(126,'lucian.rischitor@3pillarglobal.com','','Lucian','Rischitor',1,1,0,NULL),(127,'lucian.craciun@3pillarglobal.com','','Lucian','Craciun',1,1,0,NULL),(128,'marius.cotor@3pillarglobal.com','','Marius','Cotor',1,1,0,NULL),(129,'marius.lazar@3pillarglobal.com','','Marius','Lazar',1,1,0,NULL),(130,'marius.niculas@3pillarglobal.com','9bc7e29a2d8d4518e11bfd67d5cf848a','Marius','Niculas',2,1,0,NULL),(131,'mihai.pricop@3pillarglobal.com','','Mihai','Pricop',1,1,0,NULL),(132,'mihai.mocanu@3pillarglobal.com','','Mihai','Mocanu',1,1,0,NULL),(133,'mihai.man@3pillarglobal.com','','Mihai','Man',1,1,0,NULL),(134,'mihai.costin@3pillarglobal.com','','Mihai','Costin',1,1,0,NULL),(135,'mihai.chereji@3pillarglobal.com','','Mihai','Chereji',1,1,0,NULL),(136,'mircea.zetea@3pillarglobal.com','','Mircea','Zetea',1,1,0,NULL),(137,'mircea.talau@3pillarglobal.com','','Mircea','Talau',1,1,0,NULL),(138,'nadina.muresan@3pillarglobal.com','','Nadina','Muresan',1,1,0,NULL),(139,'nicolae.tiut@3pillarglobal.com','','Nicolae','Tiut',1,1,0,NULL),(140,'oana.beldean@3pillarglobal.com','','Oana','Beldean',1,1,0,NULL),(141,'ovidiu.rauca@3pillarglobal.com','','Ovidiu','Rauca',1,1,0,NULL),(142,'ovidiu.tamasan@3pillarglobal.com','','Ovidiu','Tamasan',1,1,0,NULL),(143,'paul.oprea@3pillarglobal.com','','Paul','Oprea',1,1,0,NULL),(144,'peter.horvath@3pillarglobal.com','','Peter','Horvath',1,1,0,NULL),(145,'rachel.constantinescu@3pillarglobal.com','5f4dcc3b5aa765d61d8327deb882cf99','Rachel','Constantinescu',1,1,0,NULL),(146,'radu.sover@3pillarglobal.com','','Radu','Sover',1,1,0,NULL),(147,'radu.tighineanu@3pillarglobal.com','e10adc3949ba59abbe56e057f20f883e','Radu','Tighineanu',2,1,0,NULL),(148,'raluca.toadere@3pillarglobal.com','','Raluca','Toadere',1,1,0,NULL),(149,'raluca.fleseriu@3pillarglobal.com','','Raluca','Fleseriu',1,1,0,NULL),(150,'ramona.suciu@3pillarglobal.com','','Ramona','Suciu',1,1,0,NULL),(151,'rares.zehan@3pillarglobal.com','','Rares','Zehan',1,1,0,NULL),(152,'rares.irimies@3pillarglobal.com','','Rares','Irimies',1,1,0,NULL),(153,'raul.lepsa@3pillarglobal.com','','Raul','Lepsa',1,1,0,NULL),(154,'remus.tamas@3pillarglobal.com','c62d929e7b7e7b6165923a5dfc60cb56','Remus','Tamas',1,1,0,NULL),(155,'robert.cristian@3pillarglobal.com','','Robert','Cristian',1,1,0,NULL),(156,'rodica.dan@3pillarglobal.com','','Rodica','Dan',1,1,0,NULL),(157,'romina.milea@3pillarglobal.com','','Romina','Milea',1,1,0,NULL),(158,'roxana.pogacian@3pillarglobal.com','','Roxana','Pogacian',1,1,0,NULL),(159,'ruxandra.barbu@3pillarglobal.com','','Ruxandra','Barbu',1,1,0,NULL),(160,'sabin.pilipautanu@3pillarglobal.com','','Sabin','Pilipautanu',1,1,0,NULL),(161,'sergiu.oltean@3pillarglobal.com','','Sergiu','Oltean',1,1,0,NULL),(162,'sever.banesiu@3pillarglobal.com','786b47eea994a146653e793197267a73','Sever','Banesiu',1,1,0,'2012-11-23 18:08:00'),(163,'silvian.cretu@3pillarglobal.com','','Silvian','Cretu',1,1,0,NULL),(164,'stefan.baritchii@3pillarglobal.com','','Stefan','Baritchii',1,1,0,NULL),(165,'test.calendar@3pillarglobal.com','','Test','Calendar',1,1,0,NULL),(166,'tiberiu.cifor@3pillarglobal.com','','Tiberiu','Cifor',1,1,0,NULL),(167,'traian.fratean@3pillarglobal.com','','Traian','Fratean',1,1,0,NULL),(168,'tudor.stanean@3pillarglobal.com','','Tudor','Stanean',1,1,0,NULL),(169,'valentin.stef@3pillarglobal.com','','Valentin','Stef',1,1,0,NULL),(170,'vasile.cotofan@3pillarglobal.com','','Vasile','Cotofan',1,1,0,NULL),(171,'virgil.trif@3pillarglobal.com','','Virgil','Trif',1,1,0,NULL),(172,'zoltan.kertesz@3pillarglobal.com','','Zoltan','Kertesz',1,1,0,NULL),(173,'zoltan.korosi@3pillarglobal.com','','Zoltan','Korosi',1,1,0,NULL),(174,'iulian.boanca@3pillarglobal.com','5f4dcc3b5aa765d61d8327deb882cf99','Iulian','Boanca',2,1,0,NULL),(175,'alina.nicola@3pillarglobal.com','','Alina','Nicola',1,2,0,NULL),(176,'alexandru.topa@3pillarglobal.com','1b788bed47810360ee523c8dad016dbf','Alexandru','Topa',2,1,0,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-12-04 19:09:54
