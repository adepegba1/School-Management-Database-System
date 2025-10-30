-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: school_management
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `Course_Id` int NOT NULL,
  `Title` varchar(50) DEFAULT NULL,
  `Credits` int DEFAULT NULL,
  `Department_Id` int DEFAULT NULL,
  PRIMARY KEY (`Course_Id`),
  KEY `Department_Id` (`Department_Id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`Department_Id`) REFERENCES `department` (`Department_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1001,'Agricultural Economics',2,1),(1002,'Introduction to Computer Electronics 3',3,2),(1003,'Constitutional Law',2,3),(1004,'Pharmaceutics',4,4),(1005,'Anatomy',NULL,5),(1006,'Introduction to Operating System 3',1,2),(1007,'Agribusiness',3,NULL),(1008,'Scientific Programming 3',2,2),(1009,'Contract Law',NULL,NULL),(1010,'Medicinal Chemistry',NULL,4),(1011,'Microbiology',3,NULL);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_instructor`
--

DROP TABLE IF EXISTS `course_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_instructor` (
  `Course_Id` int DEFAULT NULL,
  `Person_Id` int DEFAULT NULL,
  KEY `Course_Id` (`Course_Id`),
  KEY `Person_Id` (`Person_Id`),
  CONSTRAINT `course_instructor_ibfk_1` FOREIGN KEY (`Course_Id`) REFERENCES `course` (`Course_Id`) ON DELETE SET NULL,
  CONSTRAINT `course_instructor_ibfk_2` FOREIGN KEY (`Person_Id`) REFERENCES `person` (`Person_Id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_instructor`
--

LOCK TABLES `course_instructor` WRITE;
/*!40000 ALTER TABLE `course_instructor` DISABLE KEYS */;
INSERT INTO `course_instructor` VALUES (1011,1),(1005,7),(1007,3),(1004,1),(1006,5),(1008,7),(1010,1);
/*!40000 ALTER TABLE `course_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `Department_Id` int NOT NULL,
  `Dep_Name` varchar(50) DEFAULT NULL,
  `Budget` float NOT NULL,
  `Start_Date` date DEFAULT NULL,
  `Administartor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Department_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Agriculture',500,'2021-04-01','Jaime Shen'),(2,'Computer Science',700,'2022-10-22','Glenn Zhang'),(3,'Law',340.5,'2021-05-26','Fernando Butler'),(4,'Pharmaceutical Science',800,'2022-01-29','Devon Pal'),(5,'Biological Sciences',1000,'2023-05-23','Dennis Guo');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `online_course`
--

DROP TABLE IF EXISTS `online_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `online_course` (
  `Course_Id` int DEFAULT NULL,
  `Course_Url` varchar(100) DEFAULT NULL,
  KEY `Course_Id` (`Course_Id`),
  CONSTRAINT `online_course_ibfk_1` FOREIGN KEY (`Course_Id`) REFERENCES `course` (`Course_Id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `online_course`
--

LOCK TABLES `online_course` WRITE;
/*!40000 ALTER TABLE `online_course` DISABLE KEYS */;
INSERT INTO `online_course` VALUES (1004,'https://www.canva.com/design/DAGlMDhjo5Q/H4NhfXpXcskjTpDxksXzUw/edit'),(1003,'https://www.theforage.com/simulations/new-york-jobs-ceo-council/financial-analyst-fko2?reloaded=true'),(1002,'https://ehub.alxafrica.com/'),(1004,'https://reactnative.dev/docs/environment-setup'),(1001,'https://www.thebricks.com/'),(1007,'https://resumeworded.com/linkedin-review/index.php'),(1005,'https://squoosh.app/');
/*!40000 ALTER TABLE `online_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `onsite_course`
--

DROP TABLE IF EXISTS `onsite_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `onsite_course` (
  `Course_Id` int DEFAULT NULL,
  `Location` varchar(20) DEFAULT NULL,
  `Days` varchar(10) DEFAULT NULL,
  `Course_Time` varchar(10) DEFAULT NULL,
  KEY `Course_Id` (`Course_Id`),
  CONSTRAINT `onsite_course_ibfk_1` FOREIGN KEY (`Course_Id`) REFERENCES `course` (`Course_Id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `onsite_course`
--

LOCK TABLES `onsite_course` WRITE;
/*!40000 ALTER TABLE `onsite_course` DISABLE KEYS */;
INSERT INTO `onsite_course` VALUES (1009,'South Africa','Monday','20:00:00'),(1011,'Ghana','Wednesday','16;30:00'),(1005,'Nigeria','Tuesday','12:45:00'),(1002,'Kenya','Monday','10:20:00'),(1008,'Unganda','Thursday','15:00:00');
/*!40000 ALTER TABLE `onsite_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `Person_Id` int NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) DEFAULT NULL,
  `Instructor_Hire_Date` date DEFAULT NULL,
  `Enrollment_Date` date DEFAULT NULL,
  `Discriminator` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Person_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'Brendan','Raje','2020-01-25',NULL,'Instructor'),(2,'Benjamin','Jackson',NULL,'2025-05-12','Student'),(3,'Alejandro','Kumar','2021-01-25',NULL,'Instructor'),(4,'Victoria','Hughes',NULL,'2024-01-24','Student'),(5,'Sydney','Williams','2020-05-27',NULL,'Instructor'),(6,'Russell','Raje',NULL,NULL,'Student'),(7,'Randall','Diaz','2023-01-23',NULL,'Instructor'),(8,'Nathaniel','Howard',NULL,'2023-01-23','Student'),(9,'Nancy','Sanchez',NULL,NULL,'Instructor'),(10,'Meghan','Diaz',NULL,'2024-05-17','Student');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_grade`
--

DROP TABLE IF EXISTS `student_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_grade` (
  `Enrollment_Id` int NOT NULL,
  `Course_Id` int DEFAULT NULL,
  `Person_Id` int DEFAULT NULL,
  `Grade` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`Enrollment_Id`),
  KEY `Course_Id` (`Course_Id`),
  KEY `Person_Id` (`Person_Id`),
  CONSTRAINT `student_grade_ibfk_1` FOREIGN KEY (`Course_Id`) REFERENCES `course` (`Course_Id`) ON DELETE SET NULL,
  CONSTRAINT `student_grade_ibfk_2` FOREIGN KEY (`Person_Id`) REFERENCES `person` (`Person_Id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_grade`
--

LOCK TABLES `student_grade` WRITE;
/*!40000 ALTER TABLE `student_grade` DISABLE KEYS */;
INSERT INTO `student_grade` VALUES (1,1011,2,'A'),(2,1001,6,'F'),(3,1005,2,'E'),(4,1001,4,'A'),(5,1008,2,'B'),(6,1011,6,'A'),(7,1003,2,'F'),(8,1010,2,'E'),(9,1008,4,'C'),(10,1011,8,'A');
/*!40000 ALTER TABLE `student_grade` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-30 16:39:40
