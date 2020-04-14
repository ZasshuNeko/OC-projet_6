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
-- Table structure for table `adresses`
--

DROP TABLE IF EXISTS `adresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adresses` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `numero` smallint NOT NULL,
  `nom_rue` text NOT NULL,
  `code_postal` int unsigned DEFAULT NULL,
  `id_utilisateur` smallint unsigned NOT NULL,
  `id_adresse_statut` smallint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_utilisateur_adresse_id` (`id_utilisateur`),
  KEY `fk_adresse_id` (`id_adresse_statut`),
  CONSTRAINT `fk_adresse_id` FOREIGN KEY (`id_adresse_statut`) REFERENCES `ref_adresse_statut` (`id`),
  CONSTRAINT `fk_utilisateur_adresse_id` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commandes`
--

DROP TABLE IF EXISTS `commandes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commandes` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `date_ajout` datetime NOT NULL,
  `id_statut` smallint unsigned DEFAULT NULL,
  `id_utilisateur` smallint unsigned DEFAULT NULL,
  `statut_paiement` tinyint(1) NOT NULL,
  `id_pizzeria` smallint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_statut_id` (`id_statut`),
  KEY `fk_utilisateur_commandes_id` (`id_utilisateur`),
  CONSTRAINT `fk_statut_id` FOREIGN KEY (`id_statut`) REFERENCES `ref_commande_statut` (`id`),
  CONSTRAINT `fk_utilisateur_commandes_id` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
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
-- Table structure for table `comptes`
--

DROP TABLE IF EXISTS `comptes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comptes` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `login` text NOT NULL,
  `password` text NOT NULL,
  `mail` text NOT NULL,
  `date_ajout` date NOT NULL,
  `id_type` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_type_id` (`id_type`),
  CONSTRAINT `fk_type_id` FOREIGN KEY (`id_type`) REFERENCES `type_compte` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jointure_pizzeria_produit`
--

DROP TABLE IF EXISTS `jointure_pizzeria_produit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jointure_pizzeria_produit` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `id_pizzeria` smallint unsigned DEFAULT NULL,
  `id_produit` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pizzeria_produit_id` (`id_pizzeria`),
  KEY `fk_produit_pizzeria_id` (`id_produit`),
  CONSTRAINT `fk_pizzeria_produit_id` FOREIGN KEY (`id_pizzeria`) REFERENCES `pizzeria` (`id`),
  CONSTRAINT `fk_produit_pizzeria_id` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `livraison`
--

DROP TABLE IF EXISTS `livraison`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livraison` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `id_commande` smallint NOT NULL,
  `statut_livraison` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `localisations`
--

DROP TABLE IF EXISTS `localisations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `localisations` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `piece` text NOT NULL,
  `rayon` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_commande`
--

DROP TABLE IF EXISTS `log_commande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_commande` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `id_utilisateur` smallint unsigned DEFAULT NULL,
  `id_commande` smallint unsigned DEFAULT NULL,
  `date_modification` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_utilisateur_log_id` (`id_utilisateur`),
  KEY `fk_commande_id` (`id_commande`),
  CONSTRAINT `fk_commande_id` FOREIGN KEY (`id_commande`) REFERENCES `commandes` (`id`),
  CONSTRAINT `fk_utilisateur_log_id` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pizzeria`
--

DROP TABLE IF EXISTS `pizzeria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pizzeria` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nom` text NOT NULL,
  `adresse` text NOT NULL,
  `telephone` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `produits`
--

DROP TABLE IF EXISTS `produits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produits` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nom` text NOT NULL,
  `description` text NOT NULL,
  `prix` decimal(5,2) unsigned NOT NULL,
  `date_ajout` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ref_adresse_statut`
--

DROP TABLE IF EXISTS `ref_adresse_statut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_adresse_statut` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nom` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ref_commande_statut`
--

DROP TABLE IF EXISTS `ref_commande_statut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_commande_statut` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nom` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statut_paiement`
--

DROP TABLE IF EXISTS `statut_paiement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statut_paiement` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nom` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nom` text NOT NULL,
  `quantite` smallint NOT NULL,
  `date_ajout` date NOT NULL,
  `date_peremption` date NOT NULL,
  `id_localisation` smallint unsigned DEFAULT NULL,
  `prix` smallint unsigned DEFAULT NULL,
  `id_pizzeria` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_localisation_stock_id` (`id_localisation`),
  KEY `fk_localisation_pizzeria_id` (`id_pizzeria`),
  CONSTRAINT `fk_localisation_pizzeria_id` FOREIGN KEY (`id_pizzeria`) REFERENCES `pizzeria` (`id`),
  CONSTRAINT `fk_localisation_stock_id` FOREIGN KEY (`id_localisation`) REFERENCES `localisations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_commande_produits`
--

DROP TABLE IF EXISTS `tbl_commande_produits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_commande_produits` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `id_commande` smallint unsigned DEFAULT NULL,
  `id_produit` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_produit_commande_id` (`id_commande`),
  KEY `fk_commande_produit_id` (`id_produit`),
  CONSTRAINT `fk_commande_produit_id` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id`),
  CONSTRAINT `fk_produit_commande_id` FOREIGN KEY (`id_commande`) REFERENCES `commandes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_preparation`
--

DROP TABLE IF EXISTS `tbl_preparation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_preparation` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `id_produit` smallint unsigned DEFAULT NULL,
  `id_stock` smallint unsigned DEFAULT NULL,
  `quantite` float unsigned DEFAULT NULL,
  `prix_preparation` float unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_produit_preparation_id` (`id_produit`),
  KEY `fk_stock_preparation_id` (`id_stock`),
  CONSTRAINT `fk_produit_preparation_id` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id`),
  CONSTRAINT `fk_stock_preparation_id` FOREIGN KEY (`id_stock`) REFERENCES `stock` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `type_compte`
--

DROP TABLE IF EXISTS `type_compte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_compte` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nom` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilisateurs` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nom` text NOT NULL,
  `prenom` text NOT NULL,
  `id_compte` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_compte_id` (`id_compte`),
  CONSTRAINT `fk_compte_id` FOREIGN KEY (`id_compte`) REFERENCES `comptes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'ocprojetsix'
--

--
-- Dumping routines for database 'ocprojetsix'
--
/*!50003 DROP PROCEDURE IF EXISTS `afficher_menu_pizzeria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_menu_pizzeria`(IN p_pizzeria_id INT)
BEGIN

SELECT DISTINCT pizzeria.nom, produits.nom, produits.prix
FROM produits, pizzeria, jointure_pizzeria_produit,stock,tbl_preparation
WHERE pizzeria.id = jointure_pizzeria_produit.id_pizzeria
AND jointure_pizzeria_produit.id_produit = produits.id
AND produits.id NOT IN (
SELECT DISTINCT tbl_preparation.id_produit
FROM tbl_preparation, stock, pizzeria
WHERE tbl_preparation.id_stock = stock.id
AND tbl_preparation.quantite > stock.quantite
AND stock.id_pizzeria = pizzeria.id
AND stock.id_pizzeria = p_pizzeria_id
)
AND pizzeria.id = p_pizzeria_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `afficher_panier_commande` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_panier_commande`(IN p_utilisateur INT)
BEGIN
SELECT utilisateurs.nom, comptes.login, commandes.id as numero_commande, DATE(commandes.date_ajout) as date_commande, GROUP_CONCAT(DISTINCT produits.nom) as panier
FROM utilisateurs, commandes, tbl_commande_produits, produits, comptes
WHERE utilisateurs.id = commandes.id_utilisateur
AND commandes.id = tbl_commande_produits.id_commande
AND tbl_commande_produits.id_produit = produits.id
AND utilisateurs.id_compte = comptes.id
AND utilisateurs.id = p_utilisateur
GROUP BY commandes.id
ORDER BY commandes.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `afficher_panier_commande_all` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_panier_commande_all`()
BEGIN
SELECT utilisateurs.nom, comptes.login, commandes.id as numero_commande, DATE(commandes.date_ajout) as date_commande, GROUP_CONCAT(DISTINCT produits.nom) as panier
FROM utilisateurs, commandes, tbl_commande_produits, produits, comptes
WHERE utilisateurs.id = commandes.id_utilisateur
AND commandes.id = tbl_commande_produits.id_commande
AND tbl_commande_produits.id_produit = produits.id
AND utilisateurs.id_compte = comptes.id
GROUP BY commandes.id
ORDER BY utilisateurs.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `afficher_produits_perime` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_produits_perime`(IN pizzeria_id INT)
BEGIN
SELECT pizzeria.nom, stock.nom as aliment, stock.quantite as quantite, stock.date_peremption
FROM pizzeria, stock
WHERE pizzeria.id = stock.id_pizzeria
AND stock.date_peremption < DATE(NOW())
ORDER BY pizzeria.nom;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `afficher_produits_pizzeria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_produits_pizzeria`(IN p_pizzeria_id INT)
BEGIN
SELECT pizzeria.nom, stock.nom as aliment, stock.quantite as quantite, stock.date_peremption
FROM pizzeria, stock
WHERE pizzeria.id = stock.id_pizzeria
AND stock.date_peremption > DATE(NOW())
ORDER BY pizzeria.nom;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `afficher_recette_ALL` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_recette_ALL`()
BEGIN

SELECT produits.nom, GROUP_CONCAT(DISTINCT stock.nom,' (',tbl_preparation.quantite,')')
FROM produits, stock, tbl_preparation
WHERE produits.id = tbl_preparation.id_produit
AND tbl_preparation.id_stock = stock.id

GROUP BY produits.nom;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `afficher_recette_finance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_recette_finance`()
BEGIN

SELECT DISTINCT pizzeria.nom, SUM(produits.prix)
FROM pizzeria, commandes, utilisateurs, ref_commande_statut, statut_paiement, produits, tbl_commande_produits
WHERE pizzeria.id = commandes.id_pizzeria
AND commandes.id_statut = ref_commande_statut.id
AND commandes.id_statut = 4
AND commandes.id = tbl_commande_produits.id_commande
AND tbl_commande_produits.id_produit = produits.id

GROUP BY pizzeria.nom;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `afficher_recette_spe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_recette_spe`(IN p_produit_id INT)
BEGIN

SELECT produits.nom, GROUP_CONCAT(DISTINCT stock.nom,' (',tbl_preparation.quantite,')') as liste_ingredient
FROM produits, stock, tbl_preparation
WHERE produits.id = tbl_preparation.id_produit
AND tbl_preparation.id_stock = stock.id
AND produits.id = p_produit_id

GROUP BY produits.nom;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `afficher_rupture_pizzeria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_rupture_pizzeria`()
BEGIN
SELECT DISTINCT pizzeria.nom, produits.nom
FROM pizzeria, stock,tbl_preparation,produits, jointure_pizzeria_produit
WHERE stock.id_pizzeria in (
SELECT stock.id_pizzeria 
FROM tbl_preparation,stock 
WHERE tbl_preparation.quantite > stock.quantite 
AND stock.id = tbl_preparation.id_stock
)
AND stock.id_pizzeria = pizzeria.id
AND pizzeria.id = jointure_pizzeria_produit.id_pizzeria
AND jointure_pizzeria_produit.id_produit = produits.id
AND produits.id in (
SELECT DISTINCT tbl_preparation.id_produit 
FROM tbl_preparation, stock, produits 
WHERE tbl_preparation.quantite > stock.quantite 
AND stock.id = tbl_preparation.id_stock
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `afficher_statut_commande` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_statut_commande`(IN p_statut_id INT)
BEGIN

SELECT pizzeria.nom, commandes.id, commandes.date_ajout, utilisateurs.nom, ref_commande_statut.nom
FROM pizzeria, commandes, utilisateurs, ref_commande_statut
WHERE pizzeria.id = commandes.id_pizzeria
AND utilisateurs.id = commandes.id_utilisateur
AND ref_commande_statut.id = commandes.id_statut
AND commandes.id_statut = p_statut_id

ORDER BY ref_commande_statut.id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `creation_commande` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `creation_commande`(IN p_paiement INT)
BEGIN
set @utilisateur_id = ROUND(RAND()*4)+1;
set @pizzeria_id = ROUND(RAND()*2)+1;
INSERT INTO commandes(date_ajout,id_statut,id_utilisateur,statut_paiement,id_pizzeria) VALUES (DATE(NOW()),1,@utilisateur_id,p_paiement,@pizzeria_id);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upadate_statut_commande` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `upadate_statut_commande`(IN p_statut_id INT, IN p_commande_id INT)
BEGIN
IF p_statut_id != 5 THEN 
	SET @utilisateur_id = 3;
END IF;
IF p_statut_id = 5 THEN
	SET @utilisateur_id = 1;
END IF; 

DROP TEMPORARY TABLE IF EXISTS tempo_commandes;

INSERT INTO log_commande(id_utilisateur,id_commande,date_modification) VALUES (@utilisateur_id,p_commande_id,NOW());

UPDATE commandes
SET id_statut = p_statut_id
WHERE id = p_commande_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-14  8:53:11
