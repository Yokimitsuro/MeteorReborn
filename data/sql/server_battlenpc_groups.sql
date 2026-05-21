-- MySQL dump 10.13  Distrib 5.7.18, for Win64 (x86_64)
--
-- Host: localhost    Database: ffxiv_server
-- ------------------------------------------------------
-- Server version	5.7.18-log

-- /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
-- /*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
-- /*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
-- /*!40101 SET NAMES utf8 */;
-- /*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
-- /*!40103 SET TIME_ZONE='+00:00' */;
-- /*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
-- /*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
-- /*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- /*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table "server_battlenpc_groups"
--

DROP TABLE IF EXISTS "server_battlenpc_groups";
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
CREATE TABLE "server_battlenpc_groups" (
  "groupId" bigint NOT NULL DEFAULT '0',
  "poolId" bigint NOT NULL DEFAULT '0',
  "scriptName" varchar(50) NOT NULL,
  "minLevel" smallint NOT NULL DEFAULT '1',
  "maxLevel" smallint NOT NULL DEFAULT '1',
  "respawnTime" bigint NOT NULL DEFAULT '10',
  "hp" bigint NOT NULL DEFAULT '0',
  "mp" bigint NOT NULL DEFAULT '0',
  "dropListId" bigint NOT NULL DEFAULT '0',
  "allegiance" smallint NOT NULL DEFAULT '0',
  "spawnType" integer NOT NULL DEFAULT '0',
  "animationId" bigint NOT NULL DEFAULT '0',
  "actorState" integer NOT NULL DEFAULT '0',
  "privateAreaName" varchar(32) NOT NULL DEFAULT '',
  "privateAreaLevel" integer NOT NULL DEFAULT '0',
  "zoneId" integer NOT NULL,
  PRIMARY KEY ("groupId")
);
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
-- --
-- -- Dumping data for table "server_battlenpc_groups"
-- --
-- 
-- LOCK TABLES "server_battlenpc_groups" WRITE;
-- /*!40000 ALTER TABLE "server_battlenpc_groups" DISABLE KEYS */;
-- SET AUTOCOMMIT=0;
INSERT INTO "server_battlenpc_groups" VALUES (1,1,'wharf_rat',1,1,10,0,0,0,0,0,0,0,'',0,170);
INSERT INTO "server_battlenpc_groups" VALUES (2,2,'bloodthirsty_wolf',1,1,0,0,0,0,0,1,0,0,'',0,166);
INSERT INTO "server_battlenpc_groups" VALUES (3,3,'yda',1,1,0,0,0,0,1,1,0,0,'',0,166);
INSERT INTO "server_battlenpc_groups" VALUES (4,4,'papalymo',1,1,0,0,0,0,1,1,0,0,'',0,166);
-- /*!40000 ALTER TABLE "server_battlenpc_groups" ENABLE KEYS */;
-- UNLOCK TABLES;
-- commit;
-- /*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

-- /*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
-- /*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
-- /*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
-- /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
-- /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
-- /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- /*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
-- 
-- -- Dump completed on 2017-10-11 14:44:48
