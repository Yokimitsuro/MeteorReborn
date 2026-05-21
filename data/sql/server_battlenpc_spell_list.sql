/*
MySQL Data Transfer
Source Host: localhost
Source Database: ffxiv_server
Target Host: localhost
Target Database: ffxiv_server
Date: 5/1/2017 10:28:15 PM
*/

-- SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for server_battlenpc_spell_list
-- ----------------------------
DROP TABLE IF EXISTS "server_battlenpc_spell_list";
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
CREATE TABLE "server_battlenpc_spell_list" (
  "spellListId" bigint NOT NULL DEFAULT '0',
  "spellId" bigint NOT NULL DEFAULT '0',
  PRIMARY KEY ("spellListId", "spellId")
);
