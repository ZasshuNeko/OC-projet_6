-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: ocprojetsix
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ocprojetsix`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ocprojetsix` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ocprojetsix`;

--
-- Dumping data for table `adresses`
--

LOCK TABLES `adresses` WRITE;
/*!40000 ALTER TABLE `adresses` DISABLE KEYS */;
INSERT INTO `adresses` VALUES (1,5,'rue du projet',92230,2,1),(2,5,'rue du projet 2',94000,3,2);
/*!40000 ALTER TABLE `adresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `commandes`
--

LOCK TABLES `commandes` WRITE;
/*!40000 ALTER TABLE `commandes` DISABLE KEYS */;
INSERT INTO `commandes` VALUES (1,'2014-07-04 00:00:00',2,1,1,2),(2,'2014-07-04 00:00:00',2,1,2,1),(3,'2014-07-04 00:00:00',3,2,1,3),(4,'2014-07-04 00:00:00',4,3,1,1),(5,'2014-07-04 00:00:00',5,5,2,2),(6,'2014-07-04 00:00:00',3,2,1,3),(7,'2014-07-04 00:00:00',3,1,1,1),(8,'2014-07-04 00:00:00',4,1,1,2),(9,'2014-07-04 00:00:00',4,2,1,3),(10,'2014-07-04 00:00:00',4,3,1,1),(11,'2014-07-04 00:00:00',3,5,1,2),(12,'2014-07-04 00:00:00',3,2,1,3),(13,'2020-07-03 00:00:00',1,1,1,1),(14,'2020-04-10 00:00:00',1,2,1,2),(17,'2020-04-10 00:00:00',1,3,1,1),(18,'2020-04-10 00:00:00',1,2,1,2),(19,'2020-04-10 00:00:00',1,4,1,3),(20,'2020-04-10 00:00:00',1,4,1,2);
/*!40000 ALTER TABLE `commandes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_commandes` AFTER INSERT ON `commandes` FOR EACH ROW BEGIN
	SET @commande_id = NEW.id;
	SET @nombre_produits = ROUND(RAND()*3)+1;
	WHILE @nombre_produits > 0 DO
		SET @produit_id = ROUND(RAND()*3)+1;
		INSERT INTO tbl_commande_produits(id_commande,id_produit) VALUES (@commande_id,@produit_id);
		SET @nombre_produits = @nombre_produits - 1;
	END WHILE;
	INSERT INTO log_commande(id_utilisateur,id_commande,date_modification) VALUES (NEW.id_utilisateur,NEW.id,NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `comptes`
--

LOCK TABLES `comptes` WRITE;
/*!40000 ALTER TABLE `comptes` DISABLE KEYS */;
INSERT INTO `comptes` VALUES (1,'Utilisateur 1','1234','util@gmail.com','0000-00-00',1),(2,'Utilisateur 2','1234','util2@gmail.com','0000-00-00',1),(3,'Utilisateur 3','1234','util3@gmail.com','0000-00-00',2),(4,'Utilisateur 4','1234','util4@gmail.com','0000-00-00',2),(5,'Utilisateur 5','1234','util5@gmail.com','0000-00-00',3);
/*!40000 ALTER TABLE `comptes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `jointure_pizzeria_produit`
--

LOCK TABLES `jointure_pizzeria_produit` WRITE;
/*!40000 ALTER TABLE `jointure_pizzeria_produit` DISABLE KEYS */;
INSERT INTO `jointure_pizzeria_produit` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,2,1),(6,2,2),(7,2,3),(8,2,4),(9,3,1),(10,3,2),(11,3,3),(12,3,4);
/*!40000 ALTER TABLE `jointure_pizzeria_produit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `livraison`
--

LOCK TABLES `livraison` WRITE;
/*!40000 ALTER TABLE `livraison` DISABLE KEYS */;
INSERT INTO `livraison` VALUES (1,3,0),(2,6,1);
/*!40000 ALTER TABLE `livraison` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `localisations`
--

LOCK TABLES `localisations` WRITE;
/*!40000 ALTER TABLE `localisations` DISABLE KEYS */;
INSERT INTO `localisations` VALUES (1,'Stockage1','Rayon 5'),(2,'Stockage2','Rayon l├®gume'),(3,'Stockage3','Rayon fruits');
/*!40000 ALTER TABLE `localisations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_commande`
--

LOCK TABLES `log_commande` WRITE;
/*!40000 ALTER TABLE `log_commande` DISABLE KEYS */;
INSERT INTO `log_commande` VALUES (1,4,20,'2020-04-10 11:54:12'),(2,3,1,'2020-04-10 15:15:59');
/*!40000 ALTER TABLE `log_commande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pizzeria`
--

LOCK TABLES `pizzeria` WRITE;
/*!40000 ALTER TABLE `pizzeria` DISABLE KEYS */;
INSERT INTO `pizzeria` VALUES (1,'Pizzeria1','5 rue truc machin','01 42 55 78 98'),(2,'Pizzeria2','10 rue truc machin','01 42 55 78 89'),(3,'Pizzeria3','71 rue truc machin','01 42 55 78 52');
/*!40000 ALTER TABLE `pizzeria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `produits`
--

LOCK TABLES `produits` WRITE;
/*!40000 ALTER TABLE `produits` DISABLE KEYS */;
INSERT INTO `produits` VALUES (1,'Pizza1','Description Pizza1',7.50,'2020-07-04 00:00:00'),(2,'Pizza2','Description Pizza2',9.50,'2020-07-04 00:00:00'),(3,'Pizza3','Description Pizza3',15.50,'2020-07-04 00:00:00'),(4,'Pizza4','Description Pizza4',10.50,'2020-07-04 00:00:00');
/*!40000 ALTER TABLE `produits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `ref_adresse_statut`
--

LOCK TABLES `ref_adresse_statut` WRITE;
/*!40000 ALTER TABLE `ref_adresse_statut` DISABLE KEYS */;
INSERT INTO `ref_adresse_statut` VALUES (1,'s├®lectionn├®'),(2,'non_s├®lectionn├®');
/*!40000 ALTER TABLE `ref_adresse_statut` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `ref_commande_statut`
--

LOCK TABLES `ref_commande_statut` WRITE;
/*!40000 ALTER TABLE `ref_commande_statut` DISABLE KEYS */;
INSERT INTO `ref_commande_statut` VALUES (1,'En Attente'),(2,'En pr├®paration'),(3,'En livraison'),(4,'Finalis├®e'),(5,'Annul├®'),(6,'Refus├®e');
/*!40000 ALTER TABLE `ref_commande_statut` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `statut_paiement`
--

LOCK TABLES `statut_paiement` WRITE;
/*!40000 ALTER TABLE `statut_paiement` DISABLE KEYS */;
INSERT INTO `statut_paiement` VALUES (1,'Pay├®'),(2,'Non pay├®');
/*!40000 ALTER TABLE `statut_paiement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,'Concentr├® de tomate',3,'2020-07-03','2020-07-04',1,5,1),(2,'Concentr├® de tomate',6,'2020-07-03','2020-07-04',1,4,2),(3,'Concentr├® de tomate',12,'2020-07-03','2020-07-04',1,6,3),(4,'Champignons',20,'2020-07-03','2020-07-04',2,4,1),(5,'Champignons',10,'2020-07-03','2020-07-04',2,4,2),(6,'Champignons',15,'2020-07-03','2020-07-04',2,4,3),(7,'Ananas',5,'2020-07-03','2020-07-04',3,1,1),(8,'Ananas',10,'2020-07-03','2020-07-04',3,1,2),(9,'Ananas',15,'2020-07-03','2020-07-04',3,1,3),(10,'P├óte fraiche',50,'2020-07-03','2020-07-04',1,1,1),(11,'P├óte fraiche',0,'2020-08-01','2020-10-01',1,1,2),(12,'P├óte fraiche',10,'2020-08-01','2020-10-01',1,1,3),(13,'J├ólopenos',100,'2020-08-01','2020-10-01',1,6,1),(14,'J├ólopenos',20,'2020-08-01','2020-10-01',1,7,2),(15,'J├ólopenos',50,'2020-08-01','2020-10-01',1,8,3);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbl_commande_produits`
--

LOCK TABLES `tbl_commande_produits` WRITE;
/*!40000 ALTER TABLE `tbl_commande_produits` DISABLE KEYS */;
INSERT INTO `tbl_commande_produits` VALUES (1,1,2),(2,1,3),(3,2,1),(4,2,3),(5,6,2),(6,3,1),(7,3,4),(8,3,3),(9,4,4),(10,5,1),(11,7,2),(12,7,3),(13,8,4),(14,8,2),(15,9,3),(16,9,4),(17,9,1),(18,10,3),(19,11,4),(20,11,1),(21,12,2),(22,12,4),(23,17,2),(24,17,2),(25,17,3),(26,18,2),(27,18,2),(28,19,1),(29,19,2),(30,20,2),(31,20,3),(32,20,1);
/*!40000 ALTER TABLE `tbl_commande_produits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbl_preparation`
--

LOCK TABLES `tbl_preparation` WRITE;
/*!40000 ALTER TABLE `tbl_preparation` DISABLE KEYS */;
INSERT INTO `tbl_preparation` VALUES (1,1,1,1,2.25),(2,1,2,1,2.25),(3,1,3,1,2.25),(4,2,1,1,2.25),(5,2,2,1,2.25),(6,2,3,1,2.25),(7,3,1,1,2.25),(8,3,2,1,2.25),(9,3,3,1,2.25),(10,4,1,1,2.25),(11,4,2,1,2.25),(12,4,3,1,2.25),(13,1,10,1,2.25),(14,1,11,1,2.25),(15,1,12,1,2.25),(16,2,10,1,2.25),(17,2,11,1,2.25),(18,2,12,1,2.25),(19,3,10,1,2.25),(20,3,11,1,2.25),(21,3,12,1,2.25),(22,4,10,1,2.25),(23,4,11,1,2.25),(24,4,12,1,2.25),(25,1,4,5,2.25),(26,1,5,5,2.25),(27,1,6,5,2.25),(28,2,4,5,2.25),(29,2,5,5,2.25),(30,2,6,5,2.25),(31,3,4,5,2.25),(32,3,5,5,2.25),(33,3,6,5,2.25),(34,3,7,1,2.25),(35,3,8,1,2.25),(36,3,9,1,2.25),(37,4,7,1,2.25),(38,4,8,1,2.25),(39,4,9,1,2.25),(40,2,13,1,2.25),(41,2,14,1,2.25),(42,2,15,1,2.25);
/*!40000 ALTER TABLE `tbl_preparation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `type_compte`
--

LOCK TABLES `type_compte` WRITE;
/*!40000 ALTER TABLE `type_compte` DISABLE KEYS */;
INSERT INTO `type_compte` VALUES (1,'client'),(2,'employ├®'),(3,'administrateur');
/*!40000 ALTER TABLE `type_compte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `utilisateurs`
--

LOCK TABLES `utilisateurs` WRITE;
/*!40000 ALTER TABLE `utilisateurs` DISABLE KEYS */;
INSERT INTO `utilisateurs` VALUES (1,'Nom1','Prenom1',1),(2,'Nom2','Prenom2',2),(3,'Nom3','Prenom3',3),(4,'Nom4','Prenom4',4),(5,'Nom5','Prenom5',5);
/*!40000 ALTER TABLE `utilisateurs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-14  9:01:51
