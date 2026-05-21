/*
MySQL Data Transfer
Source Host: localhost
Source Database: ffxiv_server
Target Host: localhost
Target Database: ffxiv_server
Date: 4/2/2017 2:27:54 PM
*/

-- SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for characters_quest_scenario
-- ----------------------------
CREATE TABLE "characters_quest_scenario" (
  "characterId" bigint NOT NULL,
  "slot" integer NOT NULL,
  "questId" bigint NOT NULL,
  "currentPhase" bigint NOT NULL DEFAULT '0',
  "questData" text,
  "questFlags" bigint NOT NULL DEFAULT '0',
  PRIMARY KEY ("characterId","slot")
);
