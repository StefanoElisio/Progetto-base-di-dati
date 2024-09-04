-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: market
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `caratteristica`
--

DROP TABLE IF EXISTS `caratteristica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caratteristica` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_categoria` int NOT NULL,
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `caratteristica_unica` (`ID_categoria`,`nome`),
  CONSTRAINT `caratteristica_categoria` FOREIGN KEY (`ID_categoria`) REFERENCES `categoria` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caratteristica`
--

LOCK TABLES `caratteristica` WRITE;
/*!40000 ALTER TABLE `caratteristica` DISABLE KEYS */;
INSERT INTO `caratteristica` VALUES (1,1,'Autonomia'),(6,2,'Genere'),(3,3,'MegaPixel'),(2,3,'Pollici'),(4,4,'CPU'),(5,4,'GPU'),(7,5,'Taglia'),(9,6,'Colore'),(8,6,'Taglia');
/*!40000 ALTER TABLE `caratteristica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_padre` int DEFAULT NULL,
  `nome` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `nome` (`nome`),
  KEY `padre` (`ID_padre`),
  CONSTRAINT `padre` FOREIGN KEY (`ID_padre`) REFERENCES `categoria` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,NULL,'Elettronica'),(2,NULL,'Abbigliamento'),(3,1,'SmartPhone'),(4,1,'PC portatili'),(5,2,'Scarpe'),(6,2,'Giubbetti');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordinante`
--

DROP TABLE IF EXISTS `ordinante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordinante` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `cognome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordinante`
--

LOCK TABLES `ordinante` WRITE;
/*!40000 ALTER TABLE `ordinante` DISABLE KEYS */;
INSERT INTO `ordinante` VALUES (1,'Fragola86',NULL,NULL),(2,'SuperMario','Mario','Rossi'),(3,'Fili_Gio','Filippo','Di giovanni');
/*!40000 ALTER TABLE `ordinante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto_candidato`
--

DROP TABLE IF EXISTS `prodotto_candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto_candidato` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `numero_seriale` varchar(100) DEFAULT NULL,
  `nome` varchar(20) NOT NULL,
  `nome_produttore` varchar(20) NOT NULL,
  `prezzo` decimal(10,2) NOT NULL,
  `url_approfondimento` varchar(250) NOT NULL,
  `note` text,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `numero_seriale` (`numero_seriale`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto_candidato`
--

LOCK TABLES `prodotto_candidato` WRITE;
/*!40000 ALTER TABLE `prodotto_candidato` DISABLE KEYS */;
INSERT INTO `prodotto_candidato` VALUES (1,'16cva8b18sca987h1','MecBook Pro Max','Apple',9999.98,'https://www.apple.com/it/macbook-pro','Costa tanto e non ne vale la pena, ma se non lo fai cadere ti durerà, credo'),(2,'caijbsib1ijscb1jciasbc','AirForce1','Nike',107.89,'https://www.nike.com/it/w/air-force-1',NULL),(3,'ncq91ckihhc918s1xb19','Giacca in pelle','Calvin Klain',599.90,'https://www.calvinklein.it/giubbotti-stile-motociclista-in-pelle',NULL);
/*!40000 ALTER TABLE `prodotto_candidato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `richiesta_acquisto`
--

DROP TABLE IF EXISTS `richiesta_acquisto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `richiesta_acquisto` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_ordinante` int NOT NULL,
  `ID_tecnico` int DEFAULT NULL,
  `ID_categoria` int NOT NULL,
  `tempo` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `note` text,
  `esito` enum('in corso','accettato','respinto perché non conforme','respinto perché non funzionante') NOT NULL DEFAULT 'in corso',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `un_ordinante` (`ID_ordinante`,`tempo`),
  KEY `richiesta_tecnico` (`ID_tecnico`),
  KEY `richiesta_categoria` (`ID_categoria`),
  CONSTRAINT `richiesta_categoria` FOREIGN KEY (`ID_categoria`) REFERENCES `categoria` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `richiesta_ordinante` FOREIGN KEY (`ID_ordinante`) REFERENCES `ordinante` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `richiesta_tecnico` FOREIGN KEY (`ID_tecnico`) REFERENCES `tecnico` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `richiesta_acquisto`
--

LOCK TABLES `richiesta_acquisto` WRITE;
/*!40000 ALTER TABLE `richiesta_acquisto` DISABLE KEYS */;
INSERT INTO `richiesta_acquisto` VALUES (1,2,2,6,'2024-09-04 14:34:05','Costo non maggiore di 1000$','in corso'),(2,3,NULL,6,'2024-05-01 09:05:12','esteticamente piacevole se possibile','in corso'),(3,1,1,1,'2024-06-01 10:34:56','Richiesta urgente','accettato'),(4,1,3,6,'2024-09-01 22:00:00','Costo non maggiore di 1000$','accettato'),(5,3,2,4,'2024-09-04 14:34:05',NULL,'respinto perché non funzionante');
/*!40000 ALTER TABLE `richiesta_acquisto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `richiesta_info_caratteristiche`
--

DROP TABLE IF EXISTS `richiesta_info_caratteristiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `richiesta_info_caratteristiche` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_richiesta_acquisto` int NOT NULL,
  `ID_caratteristica` int NOT NULL,
  `valore` varchar(100) DEFAULT 'indifferente',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `richiesta_caratteristiche_unica` (`ID_richiesta_acquisto`,`ID_caratteristica`),
  KEY `caratteristica_info` (`ID_caratteristica`),
  CONSTRAINT `caratteristica_info` FOREIGN KEY (`ID_caratteristica`) REFERENCES `caratteristica` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `richiesta_info` FOREIGN KEY (`ID_richiesta_acquisto`) REFERENCES `richiesta_acquisto` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `richiesta_info_caratteristiche`
--

LOCK TABLES `richiesta_info_caratteristiche` WRITE;
/*!40000 ALTER TABLE `richiesta_info_caratteristiche` DISABLE KEYS */;
INSERT INTO `richiesta_info_caratteristiche` VALUES (1,1,1,'indifferente'),(2,2,6,'indifferente'),(3,2,8,'indifferente'),(4,3,1,'indifferente'),(5,2,9,'BLU'),(6,3,4,'NVIDIA'),(7,3,5,'i5core');
/*!40000 ALTER TABLE `richiesta_info_caratteristiche` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `richiesta_relativo_prodotto`
--

DROP TABLE IF EXISTS `richiesta_relativo_prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `richiesta_relativo_prodotto` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_richiesta_acquisto` int NOT NULL,
  `ID_prodotto_candidato` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `richiesta_prodotto_unica` (`ID_richiesta_acquisto`,`ID_prodotto_candidato`),
  KEY `prodotto_relativo` (`ID_prodotto_candidato`),
  CONSTRAINT `prodotto_relativo` FOREIGN KEY (`ID_prodotto_candidato`) REFERENCES `prodotto_candidato` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `richiesta_relativa` FOREIGN KEY (`ID_richiesta_acquisto`) REFERENCES `richiesta_acquisto` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `richiesta_relativo_prodotto`
--

LOCK TABLES `richiesta_relativo_prodotto` WRITE;
/*!40000 ALTER TABLE `richiesta_relativo_prodotto` DISABLE KEYS */;
INSERT INTO `richiesta_relativo_prodotto` VALUES (2,1,2),(1,2,1),(4,3,2),(3,4,3);
/*!40000 ALTER TABLE `richiesta_relativo_prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tecnico`
--

DROP TABLE IF EXISTS `tecnico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tecnico` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `cognome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tecnico`
--

LOCK TABLES `tecnico` WRITE;
/*!40000 ALTER TABLE `tecnico` DISABLE KEYS */;
INSERT INTO `tecnico` VALUES (1,'Agente007','James','Bond'),(2,'Alegorico','Alessando','Angelini'),(3,'Tecnico esperto',NULL,NULL);
/*!40000 ALTER TABLE `tecnico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tecnico_scelta_prodotto`
--

DROP TABLE IF EXISTS `tecnico_scelta_prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tecnico_scelta_prodotto` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_tecnico` int NOT NULL,
  `ID_prodotto_candidato` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `tecnico_scelto` (`ID_tecnico`),
  KEY `prodotto_scelto` (`ID_prodotto_candidato`),
  CONSTRAINT `prodotto_scelto` FOREIGN KEY (`ID_prodotto_candidato`) REFERENCES `prodotto_candidato` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tecnico_scelto` FOREIGN KEY (`ID_tecnico`) REFERENCES `tecnico` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tecnico_scelta_prodotto`
--

LOCK TABLES `tecnico_scelta_prodotto` WRITE;
/*!40000 ALTER TABLE `tecnico_scelta_prodotto` DISABLE KEYS */;
INSERT INTO `tecnico_scelta_prodotto` VALUES (1,1,2),(2,2,1),(3,2,3),(4,1,2),(5,3,3);
/*!40000 ALTER TABLE `tecnico_scelta_prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valutazione`
--

DROP TABLE IF EXISTS `valutazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `valutazione` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_prodotto_candidato` int NOT NULL,
  `ID_ordinante` int NOT NULL,
  `ID_richiesta_acquisto` int NOT NULL,
  `tempo` timestamp NULL DEFAULT NULL,
  `decisione` enum('approvato','rifiutato') DEFAULT NULL,
  `ordinazione` bit(1) DEFAULT b'0',
  `motivazione` text,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `una_valutazione` (`ID_prodotto_candidato`,`ID_richiesta_acquisto`),
  KEY `valutazione_ordinante` (`ID_ordinante`),
  KEY `valutazione_richiesta` (`ID_richiesta_acquisto`),
  CONSTRAINT `valutazione_ordinante` FOREIGN KEY (`ID_ordinante`) REFERENCES `ordinante` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `valutazione_prodotto` FOREIGN KEY (`ID_prodotto_candidato`) REFERENCES `prodotto_candidato` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `valutazione_richiesta` FOREIGN KEY (`ID_richiesta_acquisto`) REFERENCES `richiesta_acquisto` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `motivazione_consiste` CHECK ((((`decisione` = _utf8mb4'approvato') and (`motivazione` is null)) or (`decisione` = _utf8mb4'rifiutato'))),
  CONSTRAINT `tempo_ordinazione` CHECK ((((`ordinazione` = 0) and (`tempo` is null)) or ((`ordinazione` = 1) and (`tempo` is not null))))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valutazione`
--

LOCK TABLES `valutazione` WRITE;
/*!40000 ALTER TABLE `valutazione` DISABLE KEYS */;
INSERT INTO `valutazione` VALUES (1,3,2,2,NULL,'rifiutato',_binary '\0','Il prodotto ha superato il budget'),(2,2,1,3,NULL,'approvato',_binary '\0',NULL),(3,3,1,4,NULL,'approvato',_binary '\0',NULL),(4,1,2,4,'2024-09-04 14:34:05','approvato',_binary '',NULL),(5,2,3,1,NULL,NULL,_binary '\0',NULL);
/*!40000 ALTER TABLE `valutazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'market'
--
/*!50003 DROP PROCEDURE IF EXISTS `avrage_time_evasion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `avrage_time_evasion`()
BEGIN
    SELECT AVG(TIMESTAMPDIFF(MINUTE, rc.tempo, val.tempo))
    FROM richiesta_acquisto rc
    JOIN valutazione val ON val.ID_richiesta_acquisto = rc.ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deafult_caratteristiche` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deafult_caratteristiche`(ID_rc INTEGER UNSIGNED)
BEGIN
    DECLARE done BIT DEFAULT NULL;
    DECLARE ID_car INT;
    -- Dichiarazione del cursore
    DECLARE cur CURSOR FOR
    WITH RECURSIVE CTE_Categorie AS (
        -- Seleziona la categoria iniziale
        SELECT ID, ID_padre
        FROM categoria
        WHERE ID = (
			SELECT ID_categoria
			FROM richiesta_acquisto ra
			WHERE ra.ID = ID_rc
		)
        UNION ALL
        -- Ricerca dei padri
        SELECT c.ID, c.ID_padre
        FROM categoria c
        JOIN CTE_Categorie cte ON c.ID = cte.ID_padre
    )
    -- selezione caratteristiche relative alle categorie
    SELECT car.ID
    FROM caratteristica car
    JOIN CTE_Categorie cte ON car.ID_categoria = cte.ID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    -- Loop per iterare su ogni caratteristica trovata
    OPEN cur;
    loop_caratteristiche: LOOP
        FETCH cur INTO ID_car;
        IF done IS NOT NULL THEN
            LEAVE loop_caratteristiche;
        END IF;
        INSERT INTO richiesta_info_caratteristiche(ID_richiesta_acquisto,ID_caratteristica)
        VALUES(ID_rc,ID_car);
    END LOOP;
    CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_richiesta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_richiesta`(ID_rc INTEGER UNSIGNED)
BEGIN
    DELETE FROM richiesta_acquisto
    WHERE ID = ID_rc;
ENd ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_richiesta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_richiesta`(
    ID_ord INTEGER UNSIGNED,
    ID_tec INTEGER UNSIGNED,
    ID_cat INTEGER UNSIGNED,
    testo TEXT,
    OUT new_id INTEGER UNSIGNED
)
BEGIN
    INSERT INTO richiesta_acquisto(ID_ordinante,ID_categoria,note)
    VALUES (ID_ord,ID_tec,ID_cat,testo);
    SET new_id = LAST_INSERT_ID();
    CALL deafult_caratteristiche(new_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_valutazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_valutazione`(
    ID_prod INTEGER UNSIGNED,
    ID_ord INTEGER UNSIGNED,
    ID_rc INTEGER UNSIGNED,
    de ENUM('approvato', 'rifiutato'),
    mot TEXT
)
BEGIN
    -- update se esiste la valutazione e non è approvata 
    IF EXISTS(SELECT ID_val
        FROM valutazione
        WHERE ID_prodotto_candidato = ID_prod
        AND ID_ordinante = ID_ord
        AND ID_richiesta_acquisto = ID_rc
        AND decisione IS NULL
    ) AND de IS NOT NULL THEN
        UPDATE valutazione
        SET decisione = de
        WHERE ID = ID_val;
    -- insert se non esiste già
    ELSEIF EXISTS (SELECT * 
        FROM richiesta_relativo_prodotto 
        WHERE ID_richiesta_acquisto = ID_rc
        AND ID_prodotto_candidato = ID_prod
    ) AND EXISTS (SELECT *
        FROM richiesta_acquisto
        WHERE ID_ordinante = ID_ord
        AND ID = ID_rc
    )THEN
        IF(de = 'approvato') THEN
            INSERT INTO valutazione(ID_prodotto_candidato,ID_ordinante,ID_richiesta_acquisto,decisione)
            VALUES  (ID_prod, ID_ord, ID_rc, de);
        ELSEIF (de = 'rifiutato') THEN
            INSERT INTO valutazione(ID_prodotto_candidato,ID_ordinante,ID_richiesta_acquisto,decisione,motivazione)
            VALUES  (ID_prod, ID_ord, ID_rc, de, mot);
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `list_rc_waiting_for_approve` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_rc_waiting_for_approve`()
BEGIN
    SELECT rc.*
    FROM richiesta_acquisto rc
    JOIN richiesta_relativo_prodotto rcp ON rc.ID = rcp.ID_richiesta_acquisto
    JOIN valutazione val ON rc.ID = val.ID_richiesta_acquisto 
        AND rcp.ID_prodotto_candidato = val.ID_prodotto_candidato
    WHERE rc.esito = 'in corso'
        AND val.decisione IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `num_rc_from_tecnico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `num_rc_from_tecnico`(ID_tc INTEGER UNSIGNED)
BEGIN
    SELECT COUNT(*)
    FROM richiesta_acquisto
    WHERE ID_tecnico = ID_tc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rc_approved_waiting` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rc_approved_waiting`(ID_tc INTEGER UNSIGNED)
BEGIN
    SELECT rc.*
    FROM richiesta_acquisto rc
    JOIN richiesta_relativo_prodotto rcp ON rc.ID = rcp.ID_richiesta_acquisto
    JOIN valutazione val ON rc.ID = val.ID_richiesta_acquisto 
        AND rcp.ID_prodotto_candidato = val.ID_prodotto_candidato
    WHERE rc.ID_tecnico = ID_tc
        AND val.decisione = 'approvato'
        AND ordinazione = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rc_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rc_details`(ID_rc INTEGER UNSIGNED)
BEGIN
    SELECT rc.*, car.ID AS ID_caratteristica, car.nome, rcc.valore, 
        prod.ID AS ID_prodotto, prod.nome, val.decisione, val.motivazione
    FROM richiesta_acquisto rc
    LEFT JOIN richiesta_info_caratteristiche rcc ON rcc.ID_richiesta_acquisto = ID_rc
    LEFT JOIN caratteristica car ON rcc.ID_caratteristica = car.ID
    LEFT JOIN richiesta_relativo_prodotto rcp ON rcp.ID_richiesta_acquisto = ID_rc
    LEFT JOIN prodotto_candidato prod ON prod.ID = rcp.ID_prodotto_candidato
    LEFT JOIN valutazione val ON val.ID_richiesta_acquisto = ID_rc
        AND val.ID_prodotto_candidato = prod.ID
    WHERE rc.ID = ID_rc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rc_without_tecnico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rc_without_tecnico`()
BEGIN
    SELECT rc.*
    FROM richiesta_acquisto rc
    WHERE rc.ID_tecnico IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `set_tecnico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `set_tecnico`(ID_rc INTEGER UNSIGNED, ID_tc INTEGER UNSIGNED)
BEGIN
    IF (SELECT ID_tecnico
    FROM richiesta_acquisto
    WHERE ID = ID_rc) IS NULL THEN
        UPDATE richiesta_acquisto
        SET ID_tecnico = ID_tc
        WHERE ID = ID_rc;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `set_value_caratteristica` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `set_value_caratteristica`(
    ID_rc INTEGER UNSIGNED,
    ID_car INTEGER UNSIGNED,
    val VARCHAR(100)
)
BEGIN
    DECLARE ID_info INT DEFAULT NULL;
    SET ID_info = (
        SELECT ID
        FROM richiesta_info_caratteristiche
        WHERE ID_richiesta_acquisto = ID_rc
        AND ID_caratteristica = ID_car
    );
    -- inserimento della caratteristica
    IF ID_info IS NOT NULL THEN
        UPDATE richiesta_info_caratteristiche
        SET valore = val
        WHERE ID = ID_info;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tot_spesa_ordinante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tot_spesa_ordinante`(
    ID_ord INTEGER UNSIGNED,
    anno INTEGER UNSIGNED
)
BEGIN
    SELECT SUM(prod.prezzo)
    FROM ordinante ord
    JOIN richiesta_acquisto rc ON rc.ID_ordinante = ord.ID
    JOIN richiesta_relativo_prodotto rcp ON rcp.ID_richiesta_acquisto = rc.ID
    JOIN prodotto_candidato prod ON prod.ID = rcp.ID_prodotto_candidato
    JOIN valutazione val ON rc.ID = val.ID_richiesta_acquisto 
        AND rcp.ID_prodotto_candidato = val.ID_prodotto_candidato
    WHERE ord.ID = ID_ord
        AND val.decisione = 'approvato'
        AND YEAR(rc.tempo) = anno
        AND rc.esito = 'accettato';
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

-- Dump completed on 2024-09-04 16:44:40
