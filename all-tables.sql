
CREATE DATABASE IF NOT EXISTS mycompany;
use mycompany;

-- tables db mycompany

-- Table structure for table `articulos`
DROP TABLE IF EXISTS `articulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articulos` (
  `id` int NOT NULL,
  `fabrica` int DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_art_fab` (`fabrica`),
  CONSTRAINT `fk_art_fab` FOREIGN KEY (`fabrica`) REFERENCES `fabricas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Table structure for table `cabeceras`
DROP TABLE IF EXISTS `cabeceras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cabeceras` (
  `id_cliente` int NOT NULL,
  `direccion_envio` int NOT NULL,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  KEY `fk_cab_dir` (`direccion_envio`),
  CONSTRAINT `fk_cab_cli` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`),
  CONSTRAINT `fk_cab_dir` FOREIGN KEY (`direccion_envio`) REFERENCES `direcciones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Table structure for table `clientes`
DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `direccion_envio` int DEFAULT NULL,
  `saldo` decimal(10,2) DEFAULT NULL,
  `descuento` decimal(5,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cli_dir` (`direccion_envio`),
  CONSTRAINT `fk_cli_dir` FOREIGN KEY (`direccion_envio`) REFERENCES `direcciones` (`id`),
  CONSTRAINT `clientes_chk_1` CHECK ((`saldo` <= 3000))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Table structure for table `cuerpos`
DROP TABLE IF EXISTS `cuerpos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuerpos` (
  `id_articulo` int NOT NULL,
  `pedido` varchar(100) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`id_articulo`),
  CONSTRAINT `fk_cue_art` FOREIGN KEY (`id_articulo`) REFERENCES `articulos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Table structure for table `datos_clientes`
DROP TABLE IF EXISTS `datos_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datos_clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `direccion` int NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `edad` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dat_dir` (`direccion`),
  CONSTRAINT `fk_dat_dir` FOREIGN KEY (`direccion`) REFERENCES `direcciones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Table structure for table `direcciones`
DROP TABLE IF EXISTS `direcciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direcciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `calle` varchar(100) NOT NULL,
  `numero` int DEFAULT NULL,
  `comunidad` varchar(100) DEFAULT NULL,
  `ciudad` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Table structure for table `fabricas`
DROP TABLE IF EXISTS `fabricas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fabricas` (
  `id` int NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Table structure for table `pedidos`
DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `cabecera` int DEFAULT NULL,
  `cuerpo` int DEFAULT NULL,
  KEY `fk_ped_cab` (`cabecera`),
  KEY `fk_ped_cue` (`cuerpo`),
  CONSTRAINT `fk_ped_cab` FOREIGN KEY (`cabecera`) REFERENCES `cabeceras` (`id_cliente`),
  CONSTRAINT `fk_ped_cue` FOREIGN KEY (`cuerpo`) REFERENCES `cuerpos` (`id_articulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci; 





