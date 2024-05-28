-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `post_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(1,'abc','abc@test.com1',NULL,NULL,15,NULL,'user',NULL,NULL,0),
(2,'ccc','ddd',NULL,NULL,10,NULL,'user',NULL,'2024-05-20 10:43:41',0),
(3,'joon','tjswns531@gmail.com','5438','home',30,NULL,'user',NULL,NULL,0),
(4,'choi','choi@gmail.com',NULL,'amsadong',25,NULL,'user',NULL,NULL,0),
(6,'hongildong2','hong@naver.com2',NULL,NULL,45,NULL,'user',NULL,NULL,0),
(7,'hongildong3','hong@naver.com3',NULL,NULL,60,NULL,'user',NULL,NULL,0),
(9,'hongildong5','hong@naver.com5',NULL,NULL,5,NULL,'user',NULL,NULL,0),
(10,'hongildong10','hong@naver.com10',NULL,NULL,127,NULL,'user',NULL,NULL,0),
(15,NULL,'user@gmail.com',NULL,NULL,20,NULL,'admin',NULL,NULL,0),
(18,NULL,'a@b.c',NULL,NULL,35,NULL,'user','1990-05-31',NULL,0),
(19,NULL,'d',NULL,NULL,NULL,NULL,'user',NULL,'2024-05-17 12:22:22',0),
(21,NULL,'e',NULL,NULL,NULL,NULL,'user',NULL,'2023-05-17 12:34:29',0),
(22,'kim','kim@naver.com',NULL,NULL,NULL,NULL,'user',NULL,'2022-05-20 15:38:56',0),
(25,'kdim','kim@navaer.com',NULL,NULL,NULL,NULL,'user',NULL,'2021-05-20 15:40:53',0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) NOT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `user_id` char(36) DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'hello','hello world java',1,NULL,NULL,'0b1c6e85-141f-11ef-9a75-8cb0e9d9c4fd'),
(3,'adfs','faszxcv',2,NULL,NULL,'7029d659-164a-11ef-9a75-8cb0e9d9c4fd'),
(4,'hello4','hello word4',4,NULL,NULL,'0b1c6fee-141f-11ef-9a75-8cb0e9d9c4fd'),
(5,'hello5','hello word5',NULL,NULL,NULL,'0b1c7073-141f-11ef-9a75-8cb0e9d9c4fd'),
(6,'hello2','hello word2',6,1234.100,NULL,'0b1c70b3-141f-11ef-9a75-8cb0e9d9c4fd'),
(7,'hello3','hello word3',7,NULL,NULL,'0b1c70d5-141f-11ef-9a75-8cb0e9d9c4fd'),
(9,'ERAWE','2231',2,NULL,NULL,'92a1f0dd-1667-11ef-9a75-8cb0e9d9c4fd'),
(10,'title','contents',10,NULL,'2024-05-17 12:22:22','0b1c711e-141f-11ef-9a75-8cb0e9d9c4fd'),
(11,'abc','def',NULL,NULL,NULL,'0b1c713b-141f-11ef-9a75-8cb0e9d9c4fd'),
(12,'ghi','jkl',NULL,NULL,NULL,'28d267c1-141f-11ef-9a75-8cb0e9d9c4fd'),
(13,'hello world java','hello',4,NULL,NULL,'e7b19f86-165b-11ef-9a75-8cb0e9d9c4fd');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 17:23:05
