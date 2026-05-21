/*
MySQL Data Transfer
Source Host: localhost
Source Database: ffxiv_server
Target Host: localhost
Target Database: ffxiv_server
Date: 9/9/2017 2:30:57 PM
*/

-- SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for characters_retainers
-- ----------------------------
CREATE TABLE "characters_retainers" (
  "characterId" bigint NOT NULL,
  "retainerId" bigint NOT NULL,
  "doRename" smallint NOT NULL DEFAULT '0',
  PRIMARY KEY ("characterId","retainerId")
);
