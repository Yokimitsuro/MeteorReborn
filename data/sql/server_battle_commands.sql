-- MySQL dump 10.13  Distrib 5.7.23, for Win64 (x86_64)
--
-- Host: localhost    Database: ffxiv_server

-- Server version	5.7.23

--
-- Table structure for table "server_battle_commands"
--

DROP TABLE IF EXISTS "server_battle_commands" CASCADE;
CREATE TABLE "server_battle_commands" (
  "id" integer NOT NULL,
  "name" varchar(255) NOT NULL,
  "classJob" smallint NOT NULL,
  "lvl" smallint NOT NULL,
  "requirements" integer NOT NULL,
  "mainTarget" integer NOT NULL,
  "validTarget" integer NOT NULL,
  "aoeType" smallint NOT NULL,
  "aoeRange" float NOT NULL DEFAULT '0',
  "aoeMinRange" float NOT NULL DEFAULT '0',
  "aoeConeAngle" float NOT NULL DEFAULT '0',
  "aoeRotateAngle" float NOT NULL DEFAULT '0',
  "aoeTarget" smallint NOT NULL,
  "basePotency" integer NOT NULL,
  "numHits" smallint NOT NULL,
  "positionBonus" smallint NOT NULL,
  "procRequirement" smallint NOT NULL,
  "range" bigint NOT NULL,
  "minRange" bigint NOT NULL DEFAULT '0',
  "bestRange" bigint NOT NULL DEFAULT '0',
  "rangeHeight" bigint NOT NULL DEFAULT '10',
  "rangeWidth" bigint NOT NULL DEFAULT '2',
  "statusId" integer NOT NULL,
  "statusDuration" bigint NOT NULL,
  "statusChance" float NOT NULL DEFAULT '0.5',
  "castType" smallint NOT NULL,
  "castTime" bigint NOT NULL,
  "recastTime" bigint NOT NULL,
  "mpCost" integer NOT NULL,
  "tpCost" integer NOT NULL,
  "animationType" smallint NOT NULL,
  "effectAnimation" integer NOT NULL,
  "modelAnimation" integer NOT NULL,
  "animationDuration" integer NOT NULL,
  "battleAnimation" bigint NOT NULL DEFAULT '0',
  "validUser" smallint NOT NULL DEFAULT '0',
  "comboId1" integer NOT NULL DEFAULT '0',
  "comboId2" integer NOT NULL DEFAULT '0',
  "comboStep" smallint NOT NULL DEFAULT '0',
  "accuracyMod" float NOT NULL DEFAULT '1',
  "worldMasterTextId" integer NOT NULL DEFAULT '0',
  "commandType" smallint NOT NULL DEFAULT '0',
  "actionType" smallint NOT NULL DEFAULT '0',
  "actionProperty" smallint NOT NULL DEFAULT '0',
  "isRanged" smallint NOT NULL DEFAULT '0',
  PRIMARY KEY ("id")
) ;

--
-- Dumping data for table "server_battle_commands"
--

-- Monster Abilities (23001-23350)
-- Extracted from FFXIV 1.0 client xtx/command data
-- Auto-generated from command_names_0.csv

INSERT INTO "server_battle_commands" VALUES (23001,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23002,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23003,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23004,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23005,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23006,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23007,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23008,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23009,'nutkick',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23010,'somersault_slash',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23011,'bark_to_arms',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23012,'nutshell',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23013,'regurgitate',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23014,'rancid_belch',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23015,'rancid_belch',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23016,'rancid_belch',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23017,'fowl_stench',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23018,'fowl_stench',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23019,'fowl_stench',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23020,'regurgitate',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23021,'vorpal_roar',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23022,'cold_gaze',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23023,'stone_gaze',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23024,'sand_breath',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23025,'heavy_stomp',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23026,'body_slam',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23027,'wall_of_scales',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23028,'foul_breath',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23029,'ripper_fang',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23030,'foul_breath',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23031,'scythe_tail',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23032,'fireball',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23033,'self_destruct',0,1,0,768,17152,1,12,0,0,0,1,500,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23034,'combustion',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23036,'fast_burn',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23037,'tendril_spines',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23038,'binding_tendrils',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23039,'numbing_tendrils',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23040,'firespit',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23041,'double_smash',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23042,'elbow_drop',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23043,'inferno_drop',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23044,'bone_breaker',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23045,'booming_bellow',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23046,'primal_scream',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23047,'guano_lob',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23048,'ultrasonics',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23049,'blood_drain',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23050,'digestive_ooze',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23051,'mortal_mist',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23052,'gravel_burst',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23055,'breakout',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23056,'spinout',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23057,'cliff_cry',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23058,'backflip',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23059,'tail_chase',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23060,'brine_blast',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23061,'rage_of_the_deep',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23062,'feeding_frenzy',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23063,'shockbreath',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23064,'brundleflight',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23066,'thunderstrike',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23067,'thunderwall',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23068,'thunderstorm',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23069,'prickle',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23070,'hair_ball',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23071,'furfall',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23072,'fursquall',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23073,'reaching_scratch',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23074,'drop_kick',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23075,'deep_scratch',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23076,'soil_smear',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23077,'sneeze',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23078,'stampede',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23079,'hoofkick',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23080,'gale_switch',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23081,'shriek',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23082,'overtone_shriek',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23083,'beak_snap',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23084,'bombardier',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23085,'spoil',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23086,'seedvolley',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23087,'germinate',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23088,'seedspray',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23089,'sough',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23090,'bleat',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23091,'head_butt',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23092,'alpine_fury',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23093,'seismic_scream',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23094,'level_5_petrify',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23095,'aural_vacuum',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23096,'tail_whip',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23097,'caterwaul',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23098,'aqueous_discharge',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23099,'viscous_discharge',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23100,'mucous_discharge',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23101,'tail_strike',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23102,'frenzied_claw',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23103,'forward_kick',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23104,'squawk',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23105,'basilisk_breath',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23106,'stomp',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23113,'mine_dust',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23114,'cluster_geyser',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23115,'sphere_of_cold',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23116,'impish_incantations',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23117,'impish_incantations',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23118,'impish_incantations',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23119,'stardust',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23121,'quickchant',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23122,'frenetic_flurry',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23123,'romp',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23124,'triple_tumble',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23125,'forbidden_magicks',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23127,'dark_cloud',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23128,'curse',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23129,'grave_reel',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23130,'gate_to_oblivion',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23132,'brackish_bubble',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23133,'claw_guard',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23134,'bubble_shower',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23135,'backclip',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23138,'piercing_din',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23139,'corrosive_spit',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23140,'brain_spike',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23141,'vertical_lash',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23142,'midnight_howl',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23143,'threatening_growl',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23144,'foul_bite',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23145,'sanguine_bite',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23146,'needleshot',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23147,'1000_needles',0,1,0,768,17152,1,15,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23148,'tender_thrust',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23149,'sun_spines',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23150,'desert_respite',0,1,0,31,17152,0,0,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23151,'aetherial_wave',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23152,'aetherial_barrier',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23153,'aetherial_torrent',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23154,'snort',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23155,'reckless_charge',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23156,'bristle',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23157,'bellowing_grunt',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23158,'circlespark',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23159,'thundervapor',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23160,'kinetic_pulse',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23161,'kinetic_pulse',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23162,'kinetic_pulse',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23163,'magnetic_pulse',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23164,'magnetic_pulse',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23165,'magnetic_pulse',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23166,'stampede',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23167,'head_butt',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23168,'quickchant',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23169,'quickchant',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23170,'quickchant',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23171,'quickchant',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23172,'quickchant',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23173,'forbidden_magicks',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23174,'forbidden_magicks',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23175,'forbidden_magicks',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23176,'forbidden_magicks',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23177,'forbidden_magicks',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23178,'aetherial_wave',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23179,'aetherial_wave',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23180,'aetherial_wave',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23181,'aetherial_wave',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23182,'aetherial_wave',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23183,'titan_s_flesh',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23184,'titan_s_soul',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23185,'titan_s_anger',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23187,'titan_s_boon',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23188,'ranged_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23189,'lay_of_the_leaves',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23190,'woodland_lullaby',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23191,'ranged_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23192,'wind_claw',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23193,'updraft',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23194,'sunset_plumes',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23195,'swift_gust',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23196,'swift_gale',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23197,'ranged_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23198,'devastate',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23199,'decimate',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23200,'pulverize',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23201,'scrutinize',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23202,'infuriate',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23203,'mud_sling',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23204,'kibosh',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23205,'sandspray',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23206,'misdirection',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23207,'flying_sardine',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23208,'yawn',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23209,'flying_marlin',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23210,'loam_cough',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23211,'violent_sneeze',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23212,'violent_sneeze',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23213,'beatdown',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23214,'violent_sneeze',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23215,'inhale',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23216,'ranged_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23217,'deft_slash',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23223,'imperial_guard',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23224,'magitek_cannon',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23225,'ranged_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23226,'trap_jaws',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23227,'stridulation',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23228,'mandible_bite',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23229,'formic_pheromones',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23230,'stone_s_throw',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23231,'rot_breath',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23232,'cloud_of_pestilence',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23233,'feather_flurry',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23234,'wing_cutter',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23235,'yolk_shower',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23236,'deafening_caw',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23237,'silencing_caw',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23238,'wooly_spindle',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23239,'lullaby',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23240,'dream_bubble',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23244,'doomwave',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23245,'magicked_skull',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23246,'shadow_sickle',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23247,'minions_of_the_pit',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23250,'slumber_spores',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23251,'slumber_cloud',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23254,'queasy_spores',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23255,'hypha_whip',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23256,'queasy_cloud',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23257,'agitation',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23258,'stellar_flame',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23259,'blinding_burst',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23260,'innernova',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23261,'hypernova',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23262,'sticky_tongue',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23263,'ranine_stare',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23264,'slimy_secretion',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23265,'livid_lap',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23266,'gut_press',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23269,'ranine_glare',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23270,'caudal_spine',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23271,'smoulder',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23272,'surge',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23273,'raging_horn',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23274,'burning_cyclone',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23275,'levinshower',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23276,'flames_of_defiance',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23277,'bolt_of_defiance',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23278,'serpentine_tail',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23280,'ranged_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23281,'sour_breath',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23282,'vine_probe',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23283,'sweeping_lash',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23284,'tendril_tremor',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23285,'bad_breath',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23286,'sweet_breath',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23287,'ranged_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23288,'caustic_blow',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23289,'deadly_thrust',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23290,'realm_shaker',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23291,'deadly_thrust',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23294,'sticky_web',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23295,'ranged_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23296,'pulverizing_pound',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23297,'onrush',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23298,'seismic_rift',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23299,'sonorous_blast',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23300,'terrene_blast',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23301,'remembrance',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23302,'chthonic_call',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23305,'ranged_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23306,'glossolalia',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23307,'amorphic_spear',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23308,'custard_cuff',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23310,'ranged_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23311,'bomb_toss',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23312,'bomb_toss',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23313,'hail_mary',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23314,'hail_mary',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23315,'firecracker_shower',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23317,'ranged_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23318,'charged_whisker',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23319,'charged_whisker',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23320,'charged_whisker',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23321,'blaster',0,1,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23322,'chaotic_eye',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23323,'whisker_charge',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23324,'whisker_charge',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23328,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23329,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23330,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23331,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23332,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23333,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23334,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23335,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23336,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23337,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23338,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23339,'attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,1,1,0,0);
INSERT INTO "server_battle_commands" VALUES (23340,'gillbrations',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23341,'good_gillbrations',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23342,'mode_change',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23343,'poison_breath',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23344,'circle_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23345,'stunner',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23346,'soul_eater',0,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (23347,'mucous_discharge',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23348,'corrosive_spit',0,1,0,768,17152,2,10,0,0.5,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23349,'ranged_attack',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,1);
INSERT INTO "server_battle_commands" VALUES (23350,'grim_cleaver',0,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,0,19,0,1,3,0,3,0,0,0,1,0,2,2,0,0);
INSERT INTO "server_battle_commands" VALUES (23456,'breath_of_the_lion',0,1,0,31,17152,2,12,0,0.5,0,1,100,1,0,0,0,0,0,10,2,0,0,0,11,3500,10,0,0,19,0,1,3,318771200,0,0,0,3,0,30301,2,2,9,1);
INSERT INTO "server_battle_commands" VALUES (23457,'voice_of_the_lion',0,1,0,31,17152,3,20,0,0,0,1,100,1,0,0,0,0,0,10,2,0,0,0,11,3500,10,0,0,19,0,2,3,318775296,0,0,0,3,0,30301,2,2,9,1);
INSERT INTO "server_battle_commands" VALUES (23458,'breath_of_the_dragon',0,1,0,31,17152,2,12,0,0.666667,0.25,1,100,1,0,0,0,0,0,10,2,0,0,0,11,3500,10,0,0,19,0,3,3,318779392,0,0,0,3,0,30301,2,2,9,1);
INSERT INTO "server_battle_commands" VALUES (23459,'voice_of_the_dragon',0,1,0,31,17152,1,22,15,2,0,1,100,1,0,0,0,0,0,10,2,0,0,0,11,3500,10,0,0,19,0,4,3,318783488,0,0,0,3,0,30301,2,2,9,1);
INSERT INTO "server_battle_commands" VALUES (23460,'breath_of_the_ram',0,1,0,31,17152,2,12,0,0.666667,-0.25,1,100,1,0,0,0,0,0,10,2,0,0,0,11,3500,10,0,0,19,0,5,3,318787584,0,0,0,3,0,30301,2,2,9,1);
INSERT INTO "server_battle_commands" VALUES (23461,'voice_of_the_ram',0,1,0,31,17152,1,10,0,2,0,1,100,1,0,0,0,0,0,10,2,0,0,0,11,3500,10,0,0,19,0,6,3,318791680,0,0,0,3,0,30301,2,2,9,1);
INSERT INTO "server_battle_commands" VALUES (23462,'dissent_of_the_bat',0,1,0,31,17152,2,16,0,0.66667,0,1,100,1,0,0,0,0,0,10,2,0,0,0,11,3500,10,0,0,19,0,7,3,318795776,0,0,0,3,0,30301,2,2,9,1);
INSERT INTO "server_battle_commands" VALUES (23463,'chaotic_chorus',0,1,0,31,17152,1,16,0,2,0,1,100,1,0,0,0,0,0,10,2,0,0,0,11,3500,10,0,0,19,0,8,3,318799872,0,0,0,3,0,30301,2,2,9,1);
INSERT INTO "server_battle_commands" VALUES (23464,'the_scorpions_sting',0,1,0,31,17152,2,12,0,0.5,1,1,100,1,0,0,0,0,0,10,2,0,0,0,11,3500,10,0,0,19,0,9,3,318803968,0,0,0,3,0,30301,2,2,9,1);
INSERT INTO "server_battle_commands" VALUES (27100,'second_wind',2,6,3,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,0,0,0,0,0,45,0,0,14,519,2,3,234889735,0,0,0,0,0,30320,3,3,13,0);
INSERT INTO "server_battle_commands" VALUES (27101,'blindside',2,14,3,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223237,60,1,0,0,60,0,0,14,635,2,3,234889851,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27102,'taunt',2,42,4,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,223073,5,1,0,0,60,0,0,14,517,2,3,234889733,0,0,0,0,0,30335,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27103,'featherfoot',2,2,3,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223075,30,1,0,0,60,0,0,14,535,2,3,234889751,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27104,'fists_of_fire',2,34,4,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223209,4294967295,1,0,0,10,0,0,14,684,2,3,234889900,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27105,'fists_of_earth',2,22,4,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223210,4294967295,1,0,0,10,0,0,14,685,2,3,234889901,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27106,'hundred_fists',15,50,0,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223244,15,1,0,0,900,0,0,14,712,2,3,234889928,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27107,'spinning_heel',15,35,0,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223245,20,1,0,0,120,0,0,14,718,2,3,234889934,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27108,'shoulder_tackle',15,30,0,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,223015,10,0.75,0,0,60,0,0,18,1048,205,3,302830616,0,0,0,0,0,30301,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27109,'fists_of_wind',15,40,0,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223211,4294967295,1,0,0,10,0,0,14,720,2,3,234889936,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27110,'pummel',2,1,1,768,17152,0,0,0,0,0,0,100,1,1,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,18,1027,1,3,301995011,0,27111,27113,1,0,30301,2,1,3,0);
INSERT INTO "server_battle_commands" VALUES (27111,'concussive_blow',2,10,1,768,17152,0,0,0,0,0,0,100,1,4,0,5,0,0,10,2,223007,30,0,0,0,30,0,1500,18,20,3,3,302002196,0,27112,0,2,0,30301,2,1,3,0);
INSERT INTO "server_battle_commands" VALUES (27112,'simian_thrash',2,50,4,768,17152,0,0,0,0,0,0,100,9,0,0,5,0,0,10,2,0,0,0,0,0,80,0,2000,18,1003,202,3,302818283,0,0,0,3,0,30301,2,1,3,0);
INSERT INTO "server_battle_commands" VALUES (27113,'aura_pulse',2,38,4,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,223003,30,0,0,0,40,0,1500,18,66,203,3,302821442,0,0,0,2,0,30301,2,1,3,0);
INSERT INTO "server_battle_commands" VALUES (27114,'pounce',2,4,4,768,17152,0,0,0,0,0,0,100,1,2,0,5,0,0,10,2,223015,10,0,0,0,20,0,1500,18,8,3,3,302002184,0,27115,27117,1,0,30301,2,1,3,0);
INSERT INTO "server_battle_commands" VALUES (27115,'demolish',2,30,1,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,1500,18,1028,2,3,301999108,0,27116,0,2,0,30301,2,1,3,0);
INSERT INTO "server_battle_commands" VALUES (27116,'howling_fist',2,46,4,768,17152,0,0,0,0,0,0,100,1,4,0,5,0,0,10,2,0,0,0,0,0,80,0,3000,18,1029,2,3,301999109,0,0,0,3,0,30301,2,1,3,0);
INSERT INTO "server_battle_commands" VALUES (27117,'sucker_punch',2,26,1,768,17152,0,0,0,0,0,0,100,1,4,0,5,0,0,10,2,0,0,0,0,0,15,0,1000,18,73,3,3,302002249,0,0,0,3,0,30301,2,1,3,0);
INSERT INTO "server_battle_commands" VALUES (27118,'dragon_kick',15,45,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,223013,10,0,0,0,60,0,2000,18,1041,204,3,302826513,0,0,0,0,0,30301,2,1,3,0);
INSERT INTO "server_battle_commands" VALUES (27119,'haymaker',2,18,4,768,17152,0,0,0,0,0,0,100,1,0,2,5,0,0,10,2,223015,10,0.75,0,0,5,0,250,18,23,201,3,302813207,0,0,0,0,0,30301,2,1,3,0);
INSERT INTO "server_battle_commands" VALUES (27140,'sentinel',3,22,3,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223062,15,1,0,0,90,0,0,14,526,2,3,234889742,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27141,'aegis_boon',3,6,8,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223058,30,1,0,0,60,0,0,14,583,21,3,234967623,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27142,'rampart',3,2,3,31,16445,0,8,0,0,0,1,100,1,0,0,0,0,0,10,2,223064,60,1,0,0,120,0,0,14,536,2,3,234889752,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27143,'tempered_will',3,42,8,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223068,20,1,0,0,180,0,0,14,515,2,3,234889731,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27144,'outmaneuver',3,34,8,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223236,30,1,0,0,90,0,0,14,512,21,3,234967552,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27145,'flash',3,14,3,768,17152,0,8,0,0,0,0,100,1,0,0,15,0,0,10,2,223007,10,0,0,0,30,0,0,14,696,2,3,234889912,0,0,0,0,0,30101,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27146,'cover',16,30,0,60,16412,0,0,0,0,0,1,100,1,0,0,15,0,0,10,2,223173,15,1,0,0,60,0,0,14,725,2,3,234889941,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27147,'divine_veil',16,35,0,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223248,20,1,0,0,60,0,0,14,713,2,3,234889929,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27148,'hallowed_ground',16,50,0,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223249,20,1,0,0,900,0,0,14,709,2,3,234889925,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27149,'holy_succor',16,40,0,53,16405,0,0,0,0,0,1,100,1,0,0,15,0,0,10,2,0,0,0,3,2000,10,100,0,1,701,1,3,16782013,0,0,0,0,0,30328,4,3,13,0);
INSERT INTO "server_battle_commands" VALUES (27150,'fast_blade',3,1,1,768,17152,0,0,0,0,0,0,100,1,1,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,18,1023,1,3,301995007,0,27151,27152,1,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27151,'flat_blade',3,26,1,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1500,18,1024,2,3,301999104,0,0,0,2,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27152,'savage_blade',3,10,1,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,1000,18,1025,1,3,301995009,0,27153,0,2,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27153,'goring_blade',3,50,8,768,17152,0,0,0,0,0,0,100,1,2,0,5,0,0,10,2,223206,30,0,0,0,60,0,3000,18,1026,301,3,303223810,0,0,0,3,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27154,'riot_blade',3,30,8,768,17152,0,0,0,0,0,0,100,1,2,0,15,0,0,10,2,223038,30,0,0,0,80,0,2000,18,75,2,3,301998155,0,27155,0,1,0,30301,2,1,1,1);
INSERT INTO "server_battle_commands" VALUES (27155,'rage_of_halone',3,46,8,768,17152,0,0,0,0,0,0,100,5,0,0,5,0,0,10,2,0,0,0,0,0,20,0,1500,18,1008,302,3,303227888,0,0,0,2,-40,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27156,'shield_bash',3,18,17,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,223015,5,0.75,0,0,30,0,250,18,5,26,3,302096389,0,0,0,0,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27157,'war_drum',3,38,24,768,17152,1,8,0,0,0,1,100,1,0,4,5,0,0,10,2,0,0,0,0,0,60,0,500,14,502,21,3,234967542,0,0,0,0,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27158,'phalanx',3,4,8,768,17152,0,0,0,0,0,1,100,1,0,4,5,0,0,10,2,0,0,0,0,0,5,0,250,18,32,1,3,301994016,0,27159,0,1,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27159,'spirits_within',16,45,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,3000,18,1044,304,3,303236116,0,0,0,2,50,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27180,'provoke',4,14,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,223034,30,0,0,0,30,0,0,14,600,2,3,234889816,0,0,0,0,0,30101,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27181,'foresight',4,2,3,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223083,30,1,0,0,60,0,0,14,545,2,3,234889761,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27182,'bloodbath',4,6,3,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223081,30,1,0,0,60,0,0,14,581,2,3,234889797,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27183,'berserk',4,22,32,31,16415,0,0,0,0,0,1,100,1,0,0,0,0,0,10,2,223207,4294967295,1,0,0,10,0,0,14,682,2,3,234889898,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27184,'rampage',4,34,32,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223208,4294967295,1,0,0,10,0,0,14,546,2,3,234889762,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27185,'enduring_march',4,42,32,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223078,20,1,0,0,180,0,0,14,539,2,3,234889755,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27186,'vengeance',17,30,0,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223250,15,1,0,0,150,0,0,14,714,2,3,234889930,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27187,'antagonize',17,35,0,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223251,15,1,0,0,120,0,0,14,715,2,3,234889931,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27188,'collusion',17,40,0,60,16412,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,223097,15,1,0,0,90,0,0,14,711,2,3,234889927,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27189,'mighty_strikes',17,50,0,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223252,15,1,0,0,900,0,0,14,716,2,3,234889932,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27190,'heavy_swing',4,1,1,768,17152,0,0,0,0,0,0,100,1,1,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,18,14,1,3,301993998,0,27191,0,1,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27191,'skull_sunder',4,10,1,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,1500,18,43,1,3,301994027,0,27192,0,2,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27192,'steel_cyclone',17,45,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,223015,3,0,0,0,30,0,2000,18,1040,404,3,303645712,0,0,0,3,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27193,'brutal_swing',4,4,1,768,17152,0,0,0,0,0,0,100,1,4,0,5,0,0,10,2,0,0,0,0,0,20,0,1500,18,15,3,3,302002191,0,27194,0,1,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27194,'maim',4,26,1,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,1500,18,88,1,3,301994072,0,27195,0,2,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27195,'godsbane',4,50,32,768,17152,0,0,0,0,0,0,100,3,0,0,5,0,0,10,2,0,0,0,0,0,60,0,3000,18,1014,402,3,303637494,0,0,0,3,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27196,'path_of_the_storm',4,38,32,768,17152,0,0,0,0,0,0,100,1,2,0,5,0,0,10,2,228021,30,0,0,0,30,0,1500,18,44,401,3,303632428,0,27197,0,1,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27197,'whirlwind',4,46,32,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,80,0,3000,18,1015,403,3,303641591,0,0,0,2,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27198,'fracture',4,18,32,768,17152,0,0,0,0,0,0,100,1,0,3,5,0,0,10,2,223013,8,0.75,0,0,40,0,500,18,42,3,3,302002218,0,0,0,0,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27199,'overpower',4,30,1,768,17152,2,8,0,0.5,0,1,100,1,0,3,8,0,0,10,2,0,0,0,0,0,5,0,250,18,89,1,3,301994073,0,0,0,0,0,30301,2,1,1,0);
INSERT INTO "server_battle_commands" VALUES (27220,'hawks_eye',7,6,3,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223106,15,1,0,0,90,0,0,14,516,2,3,234889732,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27221,'quelling_strike',7,22,3,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223104,30,1,0,0,60,0,0,14,614,2,3,234889830,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27222,'decoy',7,2,3,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223108,60,1,0,0,90,100,0,14,565,2,3,234889781,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27223,'chameleon',7,42,3,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,0,0,0,0,0,180,0,0,14,504,2,3,234889720,0,0,0,0,0,30101,3,0,0,0);
INSERT INTO "server_battle_commands" VALUES (27224,'barrage',7,34,64,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223220,60,1,0,0,90,0,0,14,683,2,3,234889899,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27225,'raging_strike',7,14,64,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223221,4294967295,1,0,0,10,0,0,14,632,2,3,234889848,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27226,'swiftsong',7,26,64,31,16445,1,20,0,0,0,1,100,1,0,0,0,0,0,10,2,223224,180,1,0,0,10,100,0,1,150,1,3,16781462,0,0,0,0,0,30328,4,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27227,'battle_voice',18,50,0,31,16445,1,20,0,0,0,1,100,1,0,0,0,0,0,10,2,223029,60,1,0,0,900,0,0,14,721,2,3,234889937,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27228,'heavy_shot',7,1,1,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,8,10,2,0,0,0,0,0,10,0,1000,18,1036,4,3,302007308,0,27229,27231,1,0,30301,2,1,4,1);
INSERT INTO "server_battle_commands" VALUES (27229,'leaden_arrow',7,10,1,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,228021,30,0.75,0,0,30,0,1500,18,1035,4,3,302007307,0,27230,0,2,0,30301,2,1,4,1);
INSERT INTO "server_battle_commands" VALUES (27230,'wide_volley',7,50,64,768,17152,1,8,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,80,0,2000,18,18,703,3,304869394,0,0,0,3,-20,30301,2,1,4,1);
INSERT INTO "server_battle_commands" VALUES (27231,'quick_nock',7,38,64,768,17152,2,10,0,0.5,0,1,100,1,0,0,10,0,0,10,2,0,0,0,0,0,180,0,1000,18,1017,702,3,304866297,0,27232,0,2,0,30301,2,1,4,1);
INSERT INTO "server_battle_commands" VALUES (27232,'rain_of_death',18,45,0,768,17152,1,8,0,0,0,0,100,1,0,0,20,0,0,10,2,223015,5,0.75,0,0,30,0,3000,18,1037,704,3,304874509,0,0,0,3,0,30301,2,1,4,1);
INSERT INTO "server_battle_commands" VALUES (27233,'piercing_arrow',7,4,1,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,8,10,2,0,0,0,0,0,20,0,1000,18,1038,1,3,301995022,0,27234,27236,1,0,30301,2,1,4,1);
INSERT INTO "server_battle_commands" VALUES (27234,'gloom_arrow',7,30,1,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,223007,30,0,0,0,10,0,1000,18,1039,4,3,302007311,0,27235,0,2,0,30301,2,1,4,1);
INSERT INTO "server_battle_commands" VALUES (27235,'bloodletter',7,46,64,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,223241,30,0.75,0,0,80,0,1500,18,53,701,3,304861237,0,0,0,3,0,30301,2,1,4,1);
INSERT INTO "server_battle_commands" VALUES (27236,'shadowbind',7,18,64,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,228011,15,0.9,0,0,40,0,250,18,17,4,3,302006289,0,0,0,2,0,30301,2,1,4,1);
INSERT INTO "server_battle_commands" VALUES (27237,'ballad_of_magi',18,30,0,31,16445,1,20,0,0,0,1,100,1,0,0,0,0,0,10,2,223254,180,1,8,3000,10,100,0,1,709,1,3,16782021,0,0,0,0,0,30328,4,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27238,'paeon_of_war',18,40,0,31,16445,1,20,0,0,0,1,100,1,0,0,0,0,0,10,2,223255,180,1,8,3000,10,50,1000,1,710,1,3,16782022,0,0,0,0,0,30328,4,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27239,'minuet_of_rigor',18,35,0,31,16445,1,20,0,0,0,1,100,1,0,0,0,0,0,10,2,223256,180,1,8,3000,10,100,0,1,711,1,3,16782023,0,0,0,0,0,30328,4,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27258,'refill',7,1,0,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,32613,3,0,0,0);
INSERT INTO "server_battle_commands" VALUES (27259,'light_shot',7,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,0,0,0,17,0,1,3,285216768,0,0,0,0,0,30301,3,1,0,1);
INSERT INTO "server_battle_commands" VALUES (27260,'invigorate',8,14,3,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223094,30,1,0,0,90,0,0,14,575,2,3,234889791,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27261,'power_surge',8,34,128,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223212,60,1,0,0,10,0,0,14,686,2,3,234889902,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27262,'life_surge',8,22,128,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223215,180,1,0,0,15,0,250,14,687,2,3,234889903,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27263,'dread_spike',8,42,128,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223218,30,1,0,0,120,0,0,14,686,2,3,234889902,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27264,'blood_for_blood',8,6,3,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223219,60,1,0,0,60,0,0,14,689,2,3,234889905,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27265,'keen_flurry',8,26,3,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223091,30,1,0,0,90,0,0,14,569,2,3,234889785,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27266,'jump',19,30,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,60,0,0,18,1045,804,3,305284117,0,0,0,0,0,30301,3,1,2,0);
INSERT INTO "server_battle_commands" VALUES (27267,'elusive_jump',19,40,0,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,0,0,0,0,0,180,0,0,18,1046,806,3,305292310,0,0,0,0,0,30101,3,0,0,0);
INSERT INTO "server_battle_commands" VALUES (27268,'dragonfire_dive',19,50,0,768,17152,1,4,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,900,0,0,18,1045,804,3,305284117,0,0,0,0,0,30301,3,2,5,0);
INSERT INTO "server_battle_commands" VALUES (27269,'true_thrust',8,1,1,768,17152,0,0,0,0,0,0,100,1,1,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,18,1030,2,3,301999110,0,27270,27273,1,0,30301,2,1,2,0);
INSERT INTO "server_battle_commands" VALUES (27270,'leg_sweep',8,30,1,768,17152,2,8,0,0.5,0,1,100,1,0,0,5,0,0,10,2,223015,8,0,0,0,30,0,1000,18,37,1,3,301994021,0,27271,0,2,0,30301,2,1,2,0);
INSERT INTO "server_battle_commands" VALUES (27271,'doom_spike',8,46,128,768,17152,3,5,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,3000,18,83,801,3,305270867,0,0,0,3,0,30301,2,1,2,0);
INSERT INTO "server_battle_commands" VALUES (27272,'disembowel',19,35,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,223005,15,0.75,0,0,30,0,750,18,1042,2,3,301999122,0,0,0,0,0,30301,2,1,2,0);
INSERT INTO "server_battle_commands" VALUES (27273,'heavy_thrust',8,10,1,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,223015,4,0.75,0,0,20,0,1500,18,1031,1,3,301995015,0,0,0,0,0,30301,2,1,2,0);
INSERT INTO "server_battle_commands" VALUES (27274,'vorpal_thrust',8,2,1,768,17152,0,0,0,0,0,0,100,1,2,0,5,0,0,10,2,0,0,0,0,0,20,0,1500,18,1032,2,3,301999112,0,27275,0,1,0,30301,2,1,2,0);
INSERT INTO "server_battle_commands" VALUES (27275,'impulse_drive',8,18,1,768,17152,0,0,0,0,0,0,100,1,4,0,5,0,0,10,2,0,0,0,0,0,30,0,1500,18,1033,2,3,301999113,0,27276,27277,2,0,30301,2,1,2,0);
INSERT INTO "server_battle_commands" VALUES (27276,'chaos_thrust',8,50,128,768,17152,0,0,0,0,0,0,100,6,0,0,5,0,0,10,2,0,0,0,0,0,80,0,3000,18,40,802,3,305274920,0,0,0,3,0,30301,2,1,2,0);
INSERT INTO "server_battle_commands" VALUES (27277,'ring_of_talons',19,45,0,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,2000,18,1009,803,3,305279985,0,0,0,3,0,30301,2,1,2,0);
INSERT INTO "server_battle_commands" VALUES (27278,'feint',8,4,1,768,17152,0,0,0,0,0,0,100,1,0,1,5,0,0,10,2,0,0,0,0,0,10,0,250,18,39,2,3,301998119,0,27272,0,1,100,30301,2,1,2,0);
INSERT INTO "server_battle_commands" VALUES (27279,'full_thrust',8,38,128,768,17152,0,0,0,0,0,0,100,1,0,1,5,0,0,10,2,0,0,0,0,0,30,0,250,18,1034,801,3,305271818,0,0,0,0,50,30301,2,1,2,0);
INSERT INTO "server_battle_commands" VALUES (27300,'dark_seal',22,14,3,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223229,30,1,0,0,90,0,0,14,518,2,3,234889734,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27301,'resonance',22,22,3,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223230,30,1,0,0,90,0,0,14,669,2,3,234889885,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27302,'excruciate',22,38,256,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223231,30,1,0,0,90,0,0,14,694,2,3,234889910,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27303,'necrogenesis',22,6,3,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223232,30,1,0,0,90,0,0,14,695,2,3,234889911,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27304,'parsimony',22,2,256,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223233,30,1,0,0,90,0,0,14,568,2,3,234889784,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27305,'convert',26,30,0,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,0,0,0,0,0,450,0,0,14,724,2,3,234889940,0,0,0,0,0,30101,3,0,0,0);
INSERT INTO "server_battle_commands" VALUES (27306,'sleep',22,42,256,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,228001,60,0.9,2,3000,0,75,0,1,651,1,3,16781963,0,0,0,0,0,30335,4,4,12,0);
INSERT INTO "server_battle_commands" VALUES (27307,'sanguine_rite',22,30,3,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223234,20,1,0,0,60,120,0,1,152,1,3,16781464,0,0,0,0,0,30328,4,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27308,'blizzard',22,4,256,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,228021,30,0.75,2,3000,10,90,0,1,502,1,3,16781814,0,0,0,0,0,30301,4,2,6,0);
INSERT INTO "server_battle_commands" VALUES (27309,'blizzara',22,26,256,768,17152,1,8,0,0,0,0,100,1,0,0,20,0,0,10,2,228011,30,0.75,0,0,40,150,0,1,506,1,3,16781818,0,0,0,0,0,30301,4,2,6,0);
INSERT INTO "server_battle_commands" VALUES (27310,'fire',22,10,3,768,17152,1,8,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,2,3000,8,105,0,1,501,1,3,16781813,0,27311,0,1,0,30301,4,2,5,0);
INSERT INTO "server_battle_commands" VALUES (27311,'fira',22,34,3,768,17152,1,8,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,2,5000,16,180,0,1,504,1,3,16781816,0,27312,0,2,0,30301,4,2,5,0);
INSERT INTO "server_battle_commands" VALUES (27312,'firaga',22,50,256,768,17152,1,8,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,2,8000,7,255,0,1,700,1,3,16782012,0,0,0,3,0,30301,4,2,5,0);
INSERT INTO "server_battle_commands" VALUES (27313,'thunder',22,1,3,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,2,2000,6,75,0,1,503,1,3,16781815,0,27314,0,1,0,30301,4,2,9,0);
INSERT INTO "server_battle_commands" VALUES (27314,'thundara',22,18,256,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,223015,4,0.75,0,0,30,135,0,1,508,1,3,16781820,0,27315,27316,2,0,30301,4,2,9,0);
INSERT INTO "server_battle_commands" VALUES (27315,'thundaga',22,46,256,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,2,5000,45,195,0,1,509,1,3,16781821,0,0,0,3,0,30301,4,2,9,0);
INSERT INTO "server_battle_commands" VALUES (27316,'burst',26,50,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,2,4000,900,90,0,1,705,1,3,16782017,0,0,0,3,0,30301,4,2,9,0);
INSERT INTO "server_battle_commands" VALUES (27317,'sleepga',26,45,0,768,17152,1,8,0,0,0,0,100,1,0,0,20,0,0,10,2,228001,60,0.9,2,4000,0,100,0,1,704,1,3,16782016,0,0,0,0,0,30335,4,4,12,0);
INSERT INTO "server_battle_commands" VALUES (27318,'flare',26,40,0,31,17152,1,8,0,0,0,1,100,1,0,0,20,0,0,10,2,223262,30,0.75,2,8000,120,200,0,1,706,1,3,16782018,0,0,0,0,0,30301,4,2,5,0);
INSERT INTO "server_battle_commands" VALUES (27319,'freeze',26,35,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,2,5000,120,120,0,1,707,1,3,16782019,0,0,0,0,0,30301,4,2,6,0);
INSERT INTO "server_battle_commands" VALUES (27340,'sacred_prism',23,34,3,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223225,60,1,0,0,90,0,0,14,690,2,3,234889906,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27341,'shroud_of_saints',23,38,512,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223226,20,1,0,0,180,0,0,14,691,2,3,234889907,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27342,'cleric_stance',23,10,512,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223227,4294967295,1,0,0,30,0,0,14,692,2,3,234889908,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27343,'blissful_mind',23,14,512,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223228,4294967295,1,0,0,30,0,0,14,693,2,3,234889909,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27344,'presence_of_mind',27,30,0,31,16415,0,0,0,0,0,0,100,1,0,0,0,0,0,10,2,223116,30,1,0,0,300,0,0,14,722,2,3,234889938,0,0,0,0,0,30328,3,4,0,0);
INSERT INTO "server_battle_commands" VALUES (27345,'benediction',27,50,0,31,16445,1,20,0,0,0,1,100,1,0,0,0,0,0,10,2,0,0,0,0,0,900,0,0,14,723,2,3,234889939,0,0,0,0,0,30320,3,3,13,0);
INSERT INTO "server_battle_commands" VALUES (27346,'cure',23,2,3,53,16393,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,3,2000,5,40,0,1,101,1,3,16781413,0,0,0,0,0,30320,4,3,13,0);
INSERT INTO "server_battle_commands" VALUES (27347,'cura',23,30,512,53,16393,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,3,2000,5,100,0,1,103,1,3,16781415,0,0,0,0,0,30320,4,3,13,0);
INSERT INTO "server_battle_commands" VALUES (27348,'curaga',23,46,512,61,16445,1,15,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,3,3000,10,150,0,1,146,1,3,16781458,0,0,0,0,0,30320,4,3,13,0);
INSERT INTO "server_battle_commands" VALUES (27349,'raise',23,18,512,12340,28724,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,3,10000,300,150,0,1,148,1,3,16781460,0,0,0,0,0,30101,4,4,11,0);
INSERT INTO "server_battle_commands" VALUES (27350,'stoneskin',23,26,3,53,16393,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,223133,300,1,3,3000,30,50,0,1,133,1,3,16781445,0,0,0,0,0,30328,4,4,8,0);
INSERT INTO "server_battle_commands" VALUES (27351,'protect',23,6,3,53,49205,1,20,0,0,0,0,100,1,0,0,20,0,0,10,2,223129,300,1,3,3000,30,80,0,1,1085,1,3,16782397,0,0,0,0,0,30328,4,4,11,0);
INSERT INTO "server_battle_commands" VALUES (27352,'repose',23,50,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,228001,60,0.9,3,3000,0,80,0,1,151,1,3,16781463,0,0,0,0,0,30328,4,4,10,0);
INSERT INTO "server_battle_commands" VALUES (27353,'aero',23,4,3,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,223235,20,0.75,3,3000,6,75,0,1,510,1,3,16781822,0,27354,0,1,0,30301,4,2,7,0);
INSERT INTO "server_battle_commands" VALUES (27354,'aerora',23,42,512,768,17152,1,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,3,4000,20,150,0,1,511,1,3,16781823,0,0,0,2,0,30301,4,2,7,0);
INSERT INTO "server_battle_commands" VALUES (27355,'stone',23,1,3,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,223243,10,0.75,3,2000,6,75,0,1,513,1,3,16781825,0,27356,0,1,0,30301,4,2,8,0);
INSERT INTO "server_battle_commands" VALUES (27356,'stonera',23,22,512,768,17152,1,0,0,0,0,0,100,1,0,0,20,0,0,10,2,228021,30,0.75,3,3000,30,150,0,1,514,1,3,16781826,0,0,0,2,0,30301,4,2,8,0);
INSERT INTO "server_battle_commands" VALUES (27357,'esuna',27,40,0,53,16405,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,3,2000,10,40,0,1,702,1,3,16782014,0,0,0,0,0,30329,4,0,13,0);
INSERT INTO "server_battle_commands" VALUES (27358,'regen',27,35,0,53,16405,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,223180,45,1,3,2000,5,20,0,1,703,1,3,16782015,0,0,0,0,0,30328,4,4,13,0);
INSERT INTO "server_battle_commands" VALUES (27359,'holy',27,45,0,31,17152,1,8,0,0,0,1,100,1,0,0,0,0,0,10,2,228011,10,0.9,0,0,300,100,0,1,708,1,3,16782020,0,0,0,0,0,30301,4,2,11,0);
-- THM starting abilities (Phantom Dart, Scourge, Banish) — values extracted from client gameCommandBasic sheet
INSERT INTO "server_battle_commands" VALUES (22302,'phantom_dart',22,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,10,0,0,1,503,1,3,16781815,0,0,0,0,0,30207,2,2,12,1);
INSERT INTO "server_battle_commands" VALUES (28592,'scourge',22,1,3,768,17152,0,0,0,0,0,0,80,1,0,0,12,0,0,10,2,223134,30,0.75,2,2000,5,10,0,1,503,1,3,16781815,0,28593,0,1,0,30170,4,2,12,0);
INSERT INTO "server_battle_commands" VALUES (28597,'banish',22,1,3,768,17152,1,8,0,0,0,1,80,1,0,0,12,0,0,10,2,223137,30,0.75,2,2000,5,10,0,1,503,1,3,16781815,0,28598,0,1,0,30187,4,2,11,0);
-- Auto-generated battle commands from FFXIV 1.0 client data
-- Generated by generate_battle_commands.py

-- Heavy Strike (Lv.1)
INSERT INTO "server_battle_commands" VALUES (22102,'heavy_strike',2,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,3,0,0,1,503,1,3,16781815,0,0,0,0,0,30198,2,1,0,0);
-- Concussive Blow (Lv.1)
INSERT INTO "server_battle_commands" VALUES (26615,'concussive_blow',2,1,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30088,2,1,0,0);
-- Light Strike (Lv.1)
INSERT INTO "server_battle_commands" VALUES (26677,'light_strike',2,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30213,2,1,0,0);
-- Haymaker (Lv.4)
INSERT INTO "server_battle_commands" VALUES (26618,'haymaker',2,4,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,5,0,250,1,503,1,3,16781815,0,0,0,0,0,30091,2,1,0,0);
-- Second Wind (Lv.6)
INSERT INTO "server_battle_commands" VALUES (26502,'second_wind',2,6,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,45,0,250,1,503,1,3,16781815,0,0,0,0,0,30021,3,4,0,0);
-- Seismic Shock (Lv.8)
INSERT INTO "server_battle_commands" VALUES (26621,'seismic_shock',2,8,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,10,1000,1,503,1,3,16781815,0,0,0,0,0,30089,2,1,8,0);
-- Enhanced Physical Attack (Lv.8)
INSERT INTO "server_battle_commands" VALUES (27127,'enhanced_physical_attack',2,8,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Taunt (Lv.10)
INSERT INTO "server_battle_commands" VALUES (26506,'taunt',2,10,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30017,3,4,0,1);
-- Featherfoot (Lv.12)
INSERT INTO "server_battle_commands" VALUES (26510,'featherfoot',2,12,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30022,3,4,0,0);
-- Enhanced Evasion (Lv.12)
INSERT INTO "server_battle_commands" VALUES (27129,'enhanced_evasion',2,12,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Jarring Strike (Lv.14)
INSERT INTO "server_battle_commands" VALUES (26624,'jarring_strike',2,14,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,5,0,250,1,503,1,3,16781815,0,0,0,0,0,30096,2,1,0,0);
-- Blindside (Lv.16)
INSERT INTO "server_battle_commands" VALUES (26514,'blindside',2,16,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30019,3,4,0,0);
-- Enhanced Physical Accuracy (Lv.16)
INSERT INTO "server_battle_commands" VALUES (27126,'enhanced_physical_accuracy',2,16,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Victimize (Lv.18)
INSERT INTO "server_battle_commands" VALUES (26612,'victimize',2,18,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,2000,1,503,1,3,16781815,0,0,0,0,0,30087,2,1,0,0);
-- Presence of Mind (Lv.20)
INSERT INTO "server_battle_commands" VALUES (26529,'presence_of_mind',2,20,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30023,3,4,0,0);
-- Pummel (Lv.20)
INSERT INTO "server_battle_commands" VALUES (26679,'pummel',2,20,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30215,2,1,0,0);
-- Enhanced Second Wind (Lv.20)
INSERT INTO "server_battle_commands" VALUES (27120,'enhanced_second_wind',2,20,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Concussive Blow II (Lv.22)
INSERT INTO "server_battle_commands" VALUES (26616,'concussive_blow_ii',2,22,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30314,2,1,0,0);
-- Aura Pulse (Lv.24)
INSERT INTO "server_battle_commands" VALUES (26628,'aura_pulse',2,24,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30090,2,1,0,0);
-- Enhanced Blindside (Lv.24)
INSERT INTO "server_battle_commands" VALUES (27121,'enhanced_blindside',2,24,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Discerning Eye (Lv.26)
INSERT INTO "server_battle_commands" VALUES (26530,'discerning_eye',2,26,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30011,3,4,0,0);
-- Seismic Shock II (Lv.28)
INSERT INTO "server_battle_commands" VALUES (26622,'seismic_shock_ii',2,28,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,10,1000,1,503,1,3,16781815,0,0,0,0,0,30316,2,1,8,0);
-- Enhanced Featherfoot (Lv.28)
INSERT INTO "server_battle_commands" VALUES (27123,'enhanced_featherfoot',2,28,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Accomplice (Lv.30)
INSERT INTO "server_battle_commands" VALUES (26524,'accomplice',2,30,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30020,3,4,0,1);
-- Prime Conditioning (Lv.30)
INSERT INTO "server_battle_commands" VALUES (29467,'prime_conditioning',2,30,4,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Haymaker II (Lv.32)
INSERT INTO "server_battle_commands" VALUES (26619,'haymaker_ii',2,32,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,5,0,250,1,503,1,3,16781815,0,0,0,0,0,30315,2,1,0,0);
-- Enhanced Physical Crit Damage (Lv.32)
INSERT INTO "server_battle_commands" VALUES (27130,'enhanced_physical_crit_damage',2,32,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Pounce (Lv.34)
INSERT INTO "server_battle_commands" VALUES (26634,'pounce',2,34,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,500,1,503,1,3,16781815,0,0,0,0,0,30098,2,1,0,0);
-- Second Wind II (Lv.36)
INSERT INTO "server_battle_commands" VALUES (26503,'second_wind_ii',2,36,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,45,0,250,1,503,1,3,16781815,0,0,0,0,0,30233,3,4,0,0);
-- Enhanced Fists of Earth (Lv.36)
INSERT INTO "server_battle_commands" VALUES (27125,'enhanced_fists_of_earth',2,36,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Jarring Strike II (Lv.38)
INSERT INTO "server_battle_commands" VALUES (26625,'jarring_strike_ii',2,38,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,5,0,250,1,503,1,3,16781815,0,0,0,0,0,30317,2,1,0,0);
-- Taunt II (Lv.40)
INSERT INTO "server_battle_commands" VALUES (26507,'taunt_ii',2,40,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,50,0,0,1,503,1,3,16781815,0,0,0,0,0,30235,3,4,0,1);
-- Flurry (Lv.40)
INSERT INTO "server_battle_commands" VALUES (26678,'flurry',2,40,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30214,2,1,0,0);
-- Enhanced Physical Attack II (Lv.40)
INSERT INTO "server_battle_commands" VALUES (27128,'enhanced_physical_attack_ii',2,40,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Featherfoot II (Lv.42)
INSERT INTO "server_battle_commands" VALUES (26511,'featherfoot_ii',2,42,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30237,3,4,0,0);
-- Follow Through (Lv.44)
INSERT INTO "server_battle_commands" VALUES (26637,'follow_through',2,44,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30095,2,1,0,0);
-- Enhanced Fists of Fire (Lv.44)
INSERT INTO "server_battle_commands" VALUES (27124,'enhanced_fists_of_fire',2,44,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Blindside II (Lv.46)
INSERT INTO "server_battle_commands" VALUES (26515,'blindside_ii',2,46,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30239,3,4,0,0);
-- Victimize II (Lv.48)
INSERT INTO "server_battle_commands" VALUES (26613,'victimize_ii',2,48,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,2000,1,503,1,3,16781815,0,0,0,0,0,30313,2,1,0,0);
-- Swift Taunt (Lv.48)
INSERT INTO "server_battle_commands" VALUES (27122,'swift_taunt',2,48,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,45,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Simian Thrash (Lv.50)
INSERT INTO "server_battle_commands" VALUES (26640,'simian_thrash',2,50,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,1500,1,503,1,3,16781815,0,0,0,0,0,30092,2,1,0,0);
-- Seasoned Veteran (Lv.50)
INSERT INTO "server_battle_commands" VALUES (29468,'seasoned_veteran',2,50,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Aura Pulse II (Lv.54)
INSERT INTO "server_battle_commands" VALUES (26629,'aura_pulse_ii',2,54,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30319,2,1,0,0);
-- Accomplice II (Lv.62)
INSERT INTO "server_battle_commands" VALUES (26525,'accomplice_ii',2,62,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30243,3,4,0,1);
-- Second Wind III (Lv.66)
INSERT INTO "server_battle_commands" VALUES (26504,'second_wind_iii',2,66,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,45,0,250,1,503,1,3,16781815,0,0,0,0,0,30234,3,4,0,0);
-- Taunt III (Lv.70)
INSERT INTO "server_battle_commands" VALUES (26508,'taunt_iii',2,70,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,40,0,0,1,503,1,3,16781815,0,0,0,0,0,30236,3,4,0,1);
-- Featherfoot III (Lv.72)
INSERT INTO "server_battle_commands" VALUES (26512,'featherfoot_iii',2,72,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30238,3,4,0,0);
-- Blindside III (Lv.76)
INSERT INTO "server_battle_commands" VALUES (26516,'blindside_iii',2,76,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30240,3,4,0,0);
-- .Steal (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26518,'steal',2,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30018,3,4,0,0);
-- .Steal II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26519,'steal_ii',2,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30241,3,4,0,0);
-- .- (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26521,'',2,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30024,3,4,0,0);
-- .- (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26522,'',2,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30242,3,4,0,0);
-- .- (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26527,'',2,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,180,0,0,1,503,1,3,16781815,0,0,0,0,0,30025,3,4,0,0);
-- Jarring Strike III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26626,'jarring_strike_iii',2,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,5,0,250,1,503,1,3,16781815,0,0,0,0,0,30318,2,1,0,0);
-- Aura Pulse III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26630,'aura_pulse_iii',2,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30320,2,1,0,0);
-- .Shoulder Tackle (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26632,'shoulder_tackle',2,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30097,2,1,0,0);
-- Pounce II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26635,'pounce_ii',2,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,500,1,503,1,3,16781815,0,0,0,0,0,30321,2,1,0,0);
-- Follow Through II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26638,'follow_through_ii',2,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30322,2,1,0,0);
-- .Asuran Fists (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26642,'asuran_fists',2,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,2000,1,503,1,3,16781815,0,0,0,0,0,30093,2,1,0,0);
-- .- (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26644,'',2,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30094,2,1,0,0);

-- Light Slash (Lv.1)
INSERT INTO "server_battle_commands" VALUES (22103,'light_slash',3,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,2,0,0,1,503,1,3,16781815,0,0,0,0,0,30199,2,1,0,0);
-- Red Lotus (Lv.1)
INSERT INTO "server_battle_commands" VALUES (26792,'red_lotus',3,1,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,10,1000,1,503,1,3,16781815,0,0,0,0,0,30076,2,1,5,0);
-- Light Stab (Lv.1)
INSERT INTO "server_battle_commands" VALUES (26857,'light_stab',3,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30200,2,1,0,0);
-- Rampart (Lv.4)
INSERT INTO "server_battle_commands" VALUES (26682,'rampart',3,4,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,300,0,0,1,503,1,3,16781815,0,0,0,0,0,30008,3,4,0,0);
-- Circle Slash (Lv.6)
INSERT INTO "server_battle_commands" VALUES (26795,'circle_slash',3,6,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30075,2,1,0,0);
-- Phalanx (Lv.8)
INSERT INTO "server_battle_commands" VALUES (26798,'phalanx',3,8,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,5,0,250,1,503,1,3,16781815,0,0,0,0,0,30084,2,1,0,0);
-- Enhanced Physical Defense (Lv.8)
INSERT INTO "server_battle_commands" VALUES (27168,'enhanced_physical_defense',3,8,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Provoke (Lv.10)
INSERT INTO "server_battle_commands" VALUES (26686,'provoke',3,10,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,20,0,0,1,503,1,3,16781815,0,0,0,0,0,30005,3,4,0,1);
-- Spinstroke (Lv.12)
INSERT INTO "server_battle_commands" VALUES (26802,'spinstroke',3,12,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30086,2,1,0,0);
-- Enhanced Rampart (Lv.12)
INSERT INTO "server_battle_commands" VALUES (27163,'enhanced_rampart',3,12,1,31,17152,1,8,0,0,0,1,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Still Precision (Lv.14)
INSERT INTO "server_battle_commands" VALUES (26690,'still_precision',3,14,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30009,3,4,0,0);
-- Howling Vortex (Lv.16)
INSERT INTO "server_battle_commands" VALUES (26807,'howling_vortex',3,16,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30085,2,1,0,0);
-- Enhanced Block Rate (Lv.16)
INSERT INTO "server_battle_commands" VALUES (27167,'enhanced_block_rate',3,16,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Obsess (Lv.18)
INSERT INTO "server_battle_commands" VALUES (26693,'obsess',3,18,3,31,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,45,0,0,1,503,1,3,16781815,0,0,0,0,0,30013,3,4,0,1);
-- Onion Cut (Lv.20)
INSERT INTO "server_battle_commands" VALUES (26805,'onion_cut',3,20,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30080,2,1,0,0);
-- Heavy Slash (Lv.20)
INSERT INTO "server_battle_commands" VALUES (26858,'heavy_slash',3,20,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30216,2,1,0,0);
-- Swift Aegis Boon (Lv.20)
INSERT INTO "server_battle_commands" VALUES (27164,'swift_aegis_boon',3,20,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,45,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Cover (Lv.22)
INSERT INTO "server_battle_commands" VALUES (26696,'cover',3,22,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30007,3,4,0,1);
-- Luminous Spire (Lv.24)
INSERT INTO "server_battle_commands" VALUES (26809,'luminous_spire',3,24,3,768,17152,1,8,0,0,0,1,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,10,1000,1,503,1,3,16781815,0,0,0,0,0,30077,2,1,11,0);
-- Enhanced Physical Defense II (Lv.24)
INSERT INTO "server_battle_commands" VALUES (27169,'enhanced_physical_defense_ii',3,24,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Cadence (Lv.26)
INSERT INTO "server_battle_commands" VALUES (26698,'cadence',3,26,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30010,3,4,0,0);
-- Red Lotus II (Lv.28)
INSERT INTO "server_battle_commands" VALUES (26793,'red_lotus_ii',3,28,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,10,1000,1,503,1,3,16781815,0,0,0,0,0,30323,2,1,5,0);
-- Enhanced Flash (Lv.28)
INSERT INTO "server_battle_commands" VALUES (27161,'enhanced_flash',3,28,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Ambidexterity (Lv.30)
INSERT INTO "server_battle_commands" VALUES (26701,'ambidexterity',3,30,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,300,0,0,1,503,1,3,16781815,0,0,0,0,0,30014,3,4,0,0);
-- Rage of Halone (Lv.30)
INSERT INTO "server_battle_commands" VALUES (26811,'rage_of_halone',3,30,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,2,5000,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30078,2,1,0,0);
-- Self-Preservation (Lv.30)
INSERT INTO "server_battle_commands" VALUES (29469,'self_preservation',3,30,4,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Circle Slash II (Lv.32)
INSERT INTO "server_battle_commands" VALUES (26796,'circle_slash_ii',3,32,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30324,2,1,0,0);
-- Enhanced Physical Crit Resilience (Lv.32)
INSERT INTO "server_battle_commands" VALUES (27166,'enhanced_physical_crit_resilience',3,32,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Rampart II (Lv.34)
INSERT INTO "server_battle_commands" VALUES (26683,'rampart_ii',3,34,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,300,0,0,1,503,1,3,16781815,0,0,0,0,0,30244,3,4,0,0);
-- Sentinel (Lv.36)
INSERT INTO "server_battle_commands" VALUES (26703,'sentinel',3,36,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30006,3,4,0,0);
-- Enhanced Sentinel (Lv.36)
INSERT INTO "server_battle_commands" VALUES (27160,'enhanced_sentinel',3,36,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Phalanx II (Lv.38)
INSERT INTO "server_battle_commands" VALUES (26799,'phalanx_ii',3,38,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,5,0,250,1,503,1,3,16781815,0,0,0,0,0,30325,2,1,0,0);
-- Provoke II (Lv.40)
INSERT INTO "server_battle_commands" VALUES (26687,'provoke_ii',3,40,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,20,0,0,1,503,1,3,16781815,0,0,0,0,0,30246,3,4,0,1);
-- Heavy Stab (Lv.40)
INSERT INTO "server_battle_commands" VALUES (26859,'heavy_stab',3,40,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30217,2,1,0,0);
-- Enhanced Physical Defense III (Lv.40)
INSERT INTO "server_battle_commands" VALUES (27170,'enhanced_physical_defense_iii',3,40,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Spinstroke II (Lv.42)
INSERT INTO "server_battle_commands" VALUES (26803,'spinstroke_ii',3,42,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30326,2,1,0,0);
-- Still Precision II (Lv.44)
INSERT INTO "server_battle_commands" VALUES (26691,'still_precision_ii',3,44,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30248,3,4,0,0);
-- Enhanced Outmaneuver (Lv.44)
INSERT INTO "server_battle_commands" VALUES (27165,'enhanced_outmaneuver',3,44,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Tempered Will (Lv.46)
INSERT INTO "server_battle_commands" VALUES (26708,'tempered_will',3,46,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30012,3,4,0,0);
-- Obsess II (Lv.48)
INSERT INTO "server_battle_commands" VALUES (26694,'obsess_ii',3,48,3,31,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,45,0,0,1,503,1,3,16781815,0,0,0,0,0,30249,3,4,0,1);
-- Enhanced Flash II (Lv.48)
INSERT INTO "server_battle_commands" VALUES (27162,'enhanced_flash_ii',3,48,1,31,17152,1,8,0,0,0,1,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Riot Blade (Lv.50)
INSERT INTO "server_battle_commands" VALUES (26814,'riot_blade',3,50,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,2000,1,503,1,3,16781815,0,0,0,0,0,30081,2,1,0,0);
-- Swordsmanship (Lv.50)
INSERT INTO "server_battle_commands" VALUES (29470,'swordsmanship',3,50,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Howling Vortex II (Lv.54)
INSERT INTO "server_battle_commands" VALUES (26808,'howling_vortex_ii',3,54,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30327,2,1,0,0);
-- Cadence II (Lv.66)
INSERT INTO "server_battle_commands" VALUES (26699,'cadence_ii',3,66,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30250,3,4,0,0);
-- Rampart III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26684,'rampart_iii',3,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,300,0,0,1,503,1,3,16781815,0,0,0,0,0,30245,3,4,0,0);
-- Provoke III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26688,'provoke_iii',3,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,20,0,0,1,503,1,3,16781815,0,0,0,0,0,30247,3,4,0,1);
-- Sentinel II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26704,'sentinel_ii',3,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30251,3,4,0,0);
-- .Master of Arms (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26710,'master_of_arms',3,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,180,0,0,1,503,1,3,16781815,0,0,0,0,0,30016,3,4,0,0);
-- .Battle Calm (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26712,'battle_calm',3,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30015,3,4,0,0);
-- Rage of Halone II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26812,'rage_of_halone_ii',3,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,2,5000,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30328,2,1,0,0);
-- Riot Blade II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26815,'riot_blade_ii',3,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,2000,1,503,1,3,16781815,0,0,0,0,0,30329,2,1,0,0);
-- .Stroke of Time (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26817,'stroke_of_time',3,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,40,0,2000,1,503,1,3,16781815,0,0,0,0,0,30083,2,1,0,0);
-- .Inferno Edge (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26819,'inferno_edge',3,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,10,1500,1,503,1,3,16781815,0,0,0,0,0,30082,2,1,5,0);
-- Void Rend (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26821,'void_rend',3,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,2000,1,503,1,3,16781815,0,0,0,0,0,30079,2,1,0,0);

-- Light Swing (Lv.1)
INSERT INTO "server_battle_commands" VALUES (22105,'light_swing',4,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,4,0,0,1,503,1,3,16781815,0,0,0,0,0,30201,2,1,0,0);
-- Trunksplitter (Lv.1)
INSERT INTO "server_battle_commands" VALUES (26972,'trunksplitter',4,1,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30099,2,1,0,0);
-- Broad Swing (Lv.1)
INSERT INTO "server_battle_commands" VALUES (27037,'broad_swing',4,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30218,2,1,0,0);
-- Brandish (Lv.4)
INSERT INTO "server_battle_commands" VALUES (26979,'brandish',4,4,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30101,2,1,0,0);
-- Bloodbath (Lv.6)
INSERT INTO "server_battle_commands" VALUES (26862,'bloodbath',4,6,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,45,0,0,1,503,1,3,16781815,0,0,0,0,0,30030,3,4,0,0);
-- Skull Sunder (Lv.8)
INSERT INTO "server_battle_commands" VALUES (26986,'skull_sunder',4,8,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,500,1,503,1,3,16781815,0,0,0,0,0,30106,2,1,0,0);
-- Enhanced Physical Attack Power (Lv.8)
INSERT INTO "server_battle_commands" VALUES (27210,'enhanced_physical_attack_power',4,8,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Defender (Lv.10)
INSERT INTO "server_battle_commands" VALUES (26872,'defender',4,10,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30033,3,4,0,0);
-- Foresight (Lv.12)
INSERT INTO "server_battle_commands" VALUES (26868,'foresight',4,12,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30032,3,4,0,0);
-- Enhanced Physical Defense (Lv.12)
INSERT INTO "server_battle_commands" VALUES (27208,'enhanced_physical_defense',4,12,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Fracture (Lv.14)
INSERT INTO "server_battle_commands" VALUES (26982,'fracture',4,14,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,5,0,250,1,503,1,3,16781815,0,0,0,0,0,30105,2,1,0,0);
-- Brutal Swing (Lv.16)
INSERT INTO "server_battle_commands" VALUES (26976,'brutal_swing',4,16,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30100,2,1,0,0);
-- Swift Bloodbath (Lv.16)
INSERT INTO "server_battle_commands" VALUES (27202,'swift_bloodbath',4,16,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,45,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Disorient (Lv.18)
INSERT INTO "server_battle_commands" VALUES (26865,'disorient',4,18,3,31,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,15,0,0,1,503,1,3,16781815,0,0,0,0,0,30036,3,4,0,1);
-- Enduring March (Lv.20)
INSERT INTO "server_battle_commands" VALUES (26876,'enduring_march',4,20,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30026,3,4,0,0);
-- Heavy Swing (Lv.20)
INSERT INTO "server_battle_commands" VALUES (27039,'heavy_swing',4,20,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30219,2,1,0,0);
-- Swift Foresight (Lv.20)
INSERT INTO "server_battle_commands" VALUES (27201,'swift_foresight',4,20,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,45,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Iron Tempest (Lv.22)
INSERT INTO "server_battle_commands" VALUES (26989,'iron_tempest',4,22,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,10,10,1000,1,503,1,3,16781815,0,0,0,0,0,30103,2,1,7,1);
-- Trunksplitter II (Lv.24)
INSERT INTO "server_battle_commands" VALUES (26973,'trunksplitter_ii',4,24,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30330,2,1,0,0);
-- Enhanced Parry (Lv.24)
INSERT INTO "server_battle_commands" VALUES (27207,'enhanced_parry',4,24,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Murderous Intent (Lv.26)
INSERT INTO "server_battle_commands" VALUES (26879,'murderous_intent',4,26,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,180,0,0,1,503,1,3,16781815,0,0,0,0,0,30027,3,4,0,0);
-- Skull Sunder II (Lv.28)
INSERT INTO "server_battle_commands" VALUES (26987,'skull_sunder_ii',4,28,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,500,1,503,1,3,16781815,0,0,0,0,0,30336,2,1,0,0);
-- Enhanced Provoke (Lv.28)
INSERT INTO "server_battle_commands" VALUES (27200,'enhanced_provoke',4,28,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Warmonger (Lv.30)
INSERT INTO "server_battle_commands" VALUES (26881,'warmonger',4,30,3,31,17152,0,0,0,0,0,0,100,1,0,0,10,0,0,10,2,0,0,0,0,0,120,0,0,1,503,1,3,16781815,0,0,0,0,0,30035,3,4,0,1);
-- Intimidation (Lv.30)
INSERT INTO "server_battle_commands" VALUES (29471,'intimidation',4,30,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Brandish II (Lv.32)
INSERT INTO "server_battle_commands" VALUES (26980,'brandish_ii',4,32,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30333,2,1,0,0);
-- Enhanced Physical Crit Evasion (Lv.32)
INSERT INTO "server_battle_commands" VALUES (27206,'enhanced_physical_crit_evasion',4,32,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Barbaric Yawp (Lv.34)
INSERT INTO "server_battle_commands" VALUES (26884,'barbaric_yawp',4,34,3,31,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,120,0,0,1,503,1,3,16781815,0,0,0,0,0,30029,3,4,0,0);
-- Maim (Lv.36)
INSERT INTO "server_battle_commands" VALUES (26992,'maim',4,36,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,2000,1,503,1,3,16781815,0,0,0,0,0,30102,2,1,0,0);
-- Enhanced Berserk (Lv.36)
INSERT INTO "server_battle_commands" VALUES (27205,'enhanced_berserk',4,36,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Fracture II (Lv.38)
INSERT INTO "server_battle_commands" VALUES (26983,'fracture_ii',4,38,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,5,0,250,1,503,1,3,16781815,0,0,0,0,0,30334,2,1,0,0);
-- Disorient II (Lv.40)
INSERT INTO "server_battle_commands" VALUES (26866,'disorient_ii',4,40,3,31,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,15,0,0,1,503,1,3,16781815,0,0,0,0,0,30253,3,4,0,1);
-- Full Swing (Lv.40)
INSERT INTO "server_battle_commands" VALUES (27038,'full_swing',4,40,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30220,2,1,0,0);
-- Enhanced Physical Defense II (Lv.40)
INSERT INTO "server_battle_commands" VALUES (27209,'enhanced_physical_defense_ii',4,40,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Foresight II (Lv.42)
INSERT INTO "server_battle_commands" VALUES (26869,'foresight_ii',4,42,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30254,3,4,0,0);
-- Brutal Swing II (Lv.44)
INSERT INTO "server_battle_commands" VALUES (26977,'brutal_swing_ii',4,44,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30332,2,1,0,0);
-- Enhanced Rampage (Lv.44)
INSERT INTO "server_battle_commands" VALUES (27204,'enhanced_rampage',4,44,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Storm's Path (Lv.46)
INSERT INTO "server_battle_commands" VALUES (26995,'storm_s_path',4,46,5,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,1500,1,503,1,3,16781815,0,0,0,0,0,30108,2,1,0,0);
-- Defender II (Lv.48)
INSERT INTO "server_battle_commands" VALUES (26873,'defender_ii',4,48,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30256,3,4,0,0);
-- Enhanced Enduring March (Lv.48)
INSERT INTO "server_battle_commands" VALUES (27203,'enhanced_enduring_march',4,48,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Bloodbath II (Lv.50)
INSERT INTO "server_battle_commands" VALUES (26863,'bloodbath_ii',4,50,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,45,0,0,1,503,1,3,16781815,0,0,0,0,0,30252,3,4,0,0);
-- Axemanship (Lv.50)
INSERT INTO "server_battle_commands" VALUES (29472,'axemanship',4,50,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Foresight III (Lv.72)
INSERT INTO "server_battle_commands" VALUES (26870,'foresight_iii',4,72,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30255,3,4,0,0);
-- Defender III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26874,'defender_iii',4,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30257,3,4,0,0);
-- Enduring March II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26877,'enduring_march_ii',4,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30258,3,4,0,0);
-- Warmonger II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26882,'warmonger_ii',4,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,10,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30259,3,4,0,1);
-- Barbaric Yawp II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26885,'barbaric_yawp_ii',4,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,120,0,0,1,503,1,3,16781815,0,0,0,0,0,30260,3,4,0,0);
-- .Rampage (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26887,'rampage',4,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30034,3,4,0,0);
-- .Entrench (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26889,'entrench',4,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,300,0,0,1,503,1,3,16781815,0,0,0,0,0,30028,3,4,0,0);
-- .Retaliation (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26891,'retaliation',4,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30031,3,4,0,0);
-- Trunksplitter III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26974,'trunksplitter_iii',4,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30331,2,1,0,0);
-- Fracture III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26984,'fracture_iii',4,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,5,0,250,1,503,1,3,16781815,0,0,0,0,0,30335,2,1,0,0);
-- Iron Tempest II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26990,'iron_tempest_ii',4,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,10,10,1000,1,503,1,3,16781815,0,0,0,0,0,30337,2,1,7,1);
-- Maim II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26993,'maim_ii',4,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,2000,1,503,1,3,16781815,0,0,0,0,0,30338,2,1,0,0);
-- Storm's Path II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26996,'storm_s_path_ii',4,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,1500,1,503,1,3,16781815,0,0,0,0,0,30339,2,1,0,0);
-- Godsbane (Lv.99)
INSERT INTO "server_battle_commands" VALUES (26998,'godsbane',4,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,2000,1,503,1,3,16781815,0,0,0,0,0,30104,2,1,0,0);
-- Whirlwind (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27000,'whirlwind',4,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,2000,1,503,1,3,16781815,0,0,0,0,0,30107,2,1,0,0);

-- Light Shot (Lv.1)
INSERT INTO "server_battle_commands" VALUES (22108,'light_shot',7,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,4,0,0,1,503,1,3,16781815,0,0,0,0,0,30202,2,2,0,1);
-- Refill (Lv.1)
INSERT INTO "server_battle_commands" VALUES (22310,'refill',7,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30210,2,2,0,0);
-- Puncture (Lv.1)
INSERT INTO "server_battle_commands" VALUES (27512,'puncture',7,1,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30124,2,2,0,1);
-- Close Shot (Lv.1)
INSERT INTO "server_battle_commands" VALUES (27578,'close_shot',7,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,10,0,0,10,2,0,0,0,0,0,4,0,0,1,503,1,3,16781815,0,0,0,0,0,30221,2,2,0,1);
-- Raging Strike (Lv.4)
INSERT INTO "server_battle_commands" VALUES (27402,'raging_strike',7,4,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30049,3,4,0,0);
-- Shadowbind (Lv.6)
INSERT INTO "server_battle_commands" VALUES (27515,'shadowbind',7,6,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,40,0,250,1,503,1,3,16781815,0,0,0,0,0,30122,2,2,0,1);
-- Enhanced Physical Accuracy (Lv.8)
INSERT INTO "server_battle_commands" VALUES (27249,'enhanced_physical_accuracy',7,8,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Wide Volley (Lv.8)
INSERT INTO "server_battle_commands" VALUES (27518,'wide_volley',7,8,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30123,2,2,0,1);
-- Quelling Strike (Lv.10)
INSERT INTO "server_battle_commands" VALUES (27406,'quelling_strike',7,10,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30048,3,4,0,0);
-- Enhanced Physical Evasion (Lv.12)
INSERT INTO "server_battle_commands" VALUES (27248,'enhanced_physical_evasion',7,12,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Scouring Strike (Lv.12)
INSERT INTO "server_battle_commands" VALUES (27521,'scouring_strike',7,12,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,40,0,500,1,503,1,3,16781815,0,0,0,0,0,30125,2,2,0,1);
-- Hawk's Eye (Lv.14)
INSERT INTO "server_battle_commands" VALUES (27409,'hawk_s_eye',7,14,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30052,3,4,0,0);
-- Enhanced Decoy (Lv.16)
INSERT INTO "server_battle_commands" VALUES (27244,'enhanced_decoy',7,16,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Arrow Helix (Lv.16)
INSERT INTO "server_battle_commands" VALUES (27524,'arrow_helix',7,16,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30126,2,2,0,1);
-- Scavenge (Lv.18)
INSERT INTO "server_battle_commands" VALUES (27412,'scavenge',7,18,1,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30050,3,4,0,0);
-- Enhanced Physical Crit Evasion (Lv.20)
INSERT INTO "server_battle_commands" VALUES (27247,'enhanced_physical_crit_evasion',7,20,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Quick Nock (Lv.20)
INSERT INTO "server_battle_commands" VALUES (27527,'quick_nock',7,20,5,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,60,0,2000,1,503,1,3,16781815,0,0,0,0,0,30127,2,2,0,1);
-- Multishot (Lv.20)
INSERT INTO "server_battle_commands" VALUES (27577,'multishot',7,20,0,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,15,0,0,1,503,1,3,16781815,0,0,0,0,0,30209,2,2,0,0);
-- Quickstride (Lv.22)
INSERT INTO "server_battle_commands" VALUES (27415,'quickstride',7,22,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,180,0,0,1,503,1,3,16781815,0,0,0,0,0,30055,3,4,0,0);
-- Enhanced Physical Accuracy II (Lv.24)
INSERT INTO "server_battle_commands" VALUES (27250,'enhanced_physical_accuracy_ii',7,24,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Shrieker (Lv.24)
INSERT INTO "server_battle_commands" VALUES (27530,'shrieker',7,24,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,40,0,500,1,503,1,3,16781815,0,0,0,0,0,30132,2,2,0,1);
-- Chameleon (Lv.26)
INSERT INTO "server_battle_commands" VALUES (27418,'chameleon',7,26,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,300,0,250,1,503,1,3,16781815,0,0,0,0,0,30053,3,4,0,0);
-- Enhanced Hawk's Eye (Lv.28)
INSERT INTO "server_battle_commands" VALUES (27240,'enhanced_hawk_s_eye',7,28,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Puncture II (Lv.28)
INSERT INTO "server_battle_commands" VALUES (27513,'puncture_ii',7,28,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30340,2,2,0,1);
-- Trifurcate (Lv.30)
INSERT INTO "server_battle_commands" VALUES (27421,'trifurcate',7,30,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,120,10,0,1,503,1,3,16781815,0,0,0,0,0,30051,3,4,0,0);
-- Out of Sight (Lv.30)
INSERT INTO "server_battle_commands" VALUES (29473,'out_of_sight',7,30,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Enhanced Quelling Strike (Lv.32)
INSERT INTO "server_battle_commands" VALUES (27241,'enhanced_quelling_strike',7,32,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Shadowbind II (Lv.32)
INSERT INTO "server_battle_commands" VALUES (27516,'shadowbind_ii',7,32,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,40,0,250,1,503,1,3,16781815,0,0,0,0,0,30341,2,2,0,1);
-- Barrage (Lv.34)
INSERT INTO "server_battle_commands" VALUES (27532,'barrage',7,34,5,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,30,0,1500,1,503,1,3,16781815,0,0,0,0,0,30128,2,2,0,1);
-- Enhanced Raging Strike (Lv.36)
INSERT INTO "server_battle_commands" VALUES (27243,'enhanced_raging_strike',7,36,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Decoy (Lv.36)
INSERT INTO "server_battle_commands" VALUES (27424,'decoy',7,36,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,250,1,503,1,3,16781815,0,0,0,0,0,30056,3,4,0,0);
-- Foeseeker (Lv.38)
INSERT INTO "server_battle_commands" VALUES (27534,'foeseeker',7,38,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30131,2,2,0,1);
-- Enhanced Physical Crit Accuracy (Lv.40)
INSERT INTO "server_battle_commands" VALUES (27246,'enhanced_physical_crit_accuracy',7,40,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Raging Strike II (Lv.40)
INSERT INTO "server_battle_commands" VALUES (27403,'raging_strike_ii',7,40,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30261,3,4,0,0);
-- Heavy Shot (Lv.40)
INSERT INTO "server_battle_commands" VALUES (27579,'heavy_shot',7,40,0,768,17152,0,0,0,0,0,0,100,1,0,0,20,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30222,2,2,0,1);
-- Quelling Strike II (Lv.42)
INSERT INTO "server_battle_commands" VALUES (27407,'quelling_strike_ii',7,42,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30263,3,4,0,0);
-- Enhanced Barrage (Lv.44)
INSERT INTO "server_battle_commands" VALUES (27242,'enhanced_barrage',7,44,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Wide Volley II (Lv.44)
INSERT INTO "server_battle_commands" VALUES (27519,'wide_volley_ii',7,44,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30342,2,2,0,1);
-- Farshot (Lv.46)
INSERT INTO "server_battle_commands" VALUES (27427,'farshot',7,46,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,40,0,0,1,503,1,3,16781815,0,0,0,0,0,30047,3,4,0,0);
-- Swift Chameleon (Lv.48)
INSERT INTO "server_battle_commands" VALUES (27245,'swift_chameleon',7,48,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,120,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Bloodletter (Lv.48)
INSERT INTO "server_battle_commands" VALUES (27536,'bloodletter',7,48,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30133,2,2,0,1);
-- Subtle Release (Lv.50)
INSERT INTO "server_battle_commands" VALUES (27430,'subtle_release',7,50,3,31,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,180,0,0,1,503,1,3,16781815,0,0,0,0,0,30054,3,4,0,0);
-- Bowmanship (Lv.50)
INSERT INTO "server_battle_commands" VALUES (29474,'bowmanship',7,50,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Raging Strike III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27404,'raging_strike_iii',7,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30262,3,4,0,0);
-- Hawk's Eye II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27410,'hawk_s_eye_ii',7,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30264,3,4,0,0);
-- Scavenge II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27413,'scavenge_ii',7,99,1,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30265,3,4,0,0);
-- Quickstride II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27416,'quickstride_ii',7,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,180,0,0,1,503,1,3,16781815,0,0,0,0,0,30266,3,4,0,0);
-- Chameleon II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27419,'chameleon_ii',7,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,180,0,250,1,503,1,3,16781815,0,0,0,0,0,30267,3,4,0,0);
-- Trifurcate II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27422,'trifurcate_ii',7,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30268,3,4,0,0);
-- Decoy II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27425,'decoy_ii',7,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,250,1,503,1,3,16781815,0,0,0,0,0,30269,3,4,0,0);
-- Farshot II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27428,'farshot_ii',7,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,40,0,0,1,503,1,3,16781815,0,0,0,0,0,30270,3,4,0,0);
-- Scouring Strike II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27522,'scouring_strike_ii',7,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,40,0,500,1,503,1,3,16781815,0,0,0,0,0,30343,2,2,0,1);
-- Arrow Helix II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27525,'arrow_helix_ii',7,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30344,2,2,0,1);
-- Quick Nock II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27528,'quick_nock_ii',7,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,60,0,2000,1,503,1,3,16781815,0,0,0,0,0,30345,2,2,0,1);
-- Bloodletter II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27537,'bloodletter_ii',7,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30346,2,2,0,1);
-- .Mindscatter (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27539,'mindscatter',7,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30134,2,2,0,1);
-- .Smite (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27541,'smite',7,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,60,0,500,1,503,1,3,16781815,0,0,0,0,0,30129,2,2,0,1);
-- .Swarmsting (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27543,'swarmsting',7,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,30,0,2000,1,503,1,3,16781815,0,0,0,0,0,30130,2,2,0,1);

-- Light Thrust (Lv.1)
INSERT INTO "server_battle_commands" VALUES (22109,'light_thrust',8,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,3,0,0,1,503,1,3,16781815,0,0,0,0,0,30203,2,1,0,0);
-- Skewer (Lv.1)
INSERT INTO "server_battle_commands" VALUES (27692,'skewer',8,1,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30110,2,1,0,0);
-- Heavy Thrust (Lv.1)
INSERT INTO "server_battle_commands" VALUES (27757,'heavy_thrust',8,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30223,2,1,0,0);
-- Ferocity (Lv.4)
INSERT INTO "server_battle_commands" VALUES (27582,'ferocity',8,4,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30039,3,4,0,0);
-- Trammel (Lv.6)
INSERT INTO "server_battle_commands" VALUES (27695,'trammel',8,6,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,500,1,503,1,3,16781815,0,0,0,0,0,30109,2,1,0,0);
-- Enhanced Physical Attack Power (Lv.8)
INSERT INTO "server_battle_commands" VALUES (27288,'enhanced_physical_attack_power',8,8,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Moonrise (Lv.8)
INSERT INTO "server_battle_commands" VALUES (27697,'moonrise',8,8,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30111,2,1,0,0);
-- Speed Surge (Lv.10)
INSERT INTO "server_battle_commands" VALUES (27586,'speed_surge',8,10,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30045,3,4,0,0);
-- Store TP (Lv.12)
INSERT INTO "server_battle_commands" VALUES (27286,'store_tp',8,12,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Doomspike (Lv.12)
INSERT INTO "server_battle_commands" VALUES (27710,'doomspike',8,12,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,2000,1,503,1,3,16781815,0,0,0,0,0,30115,2,1,0,0);
-- Invigorate (Lv.14)
INSERT INTO "server_battle_commands" VALUES (27589,'invigorate',8,14,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30040,3,4,0,0);
-- Swift Blood for Blood (Lv.16)
INSERT INTO "server_battle_commands" VALUES (27284,'swift_blood_for_blood',8,16,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,45,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Leg Sweep (Lv.16)
INSERT INTO "server_battle_commands" VALUES (27704,'leg_sweep',8,16,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,40,0,1000,1,503,1,3,16781815,0,0,0,0,0,30113,2,1,0,0);
-- Comrade in Arms (Lv.18)
INSERT INTO "server_battle_commands" VALUES (27593,'comrade_in_arms',8,18,3,31,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,30,0,500,1,503,1,3,16781815,0,0,0,0,0,30038,3,4,0,1);
-- Enhanced Physical Attack Power II (Lv.20)
INSERT INTO "server_battle_commands" VALUES (27289,'enhanced_physical_attack_power_ii',8,20,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Feint (Lv.20)
INSERT INTO "server_battle_commands" VALUES (27707,'feint',8,20,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,5,0,500,1,503,1,3,16781815,0,0,0,0,0,30116,2,1,0,0);
-- Pierce (Lv.20)
INSERT INTO "server_battle_commands" VALUES (27758,'pierce',8,20,0,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30224,2,1,0,0);
-- Life Surge (Lv.22)
INSERT INTO "server_battle_commands" VALUES (27596,'life_surge',8,22,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30046,3,4,0,0);
-- Enhanced Physical Crit Accuracy (Lv.24)
INSERT INTO "server_battle_commands" VALUES (27287,'enhanced_physical_crit_accuracy',8,24,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Skewer II (Lv.24)
INSERT INTO "server_battle_commands" VALUES (27693,'skewer_ii',8,24,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30347,2,1,0,0);
-- Keen Flurry (Lv.26)
INSERT INTO "server_battle_commands" VALUES (27599,'keen_flurry',8,26,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30037,3,4,0,0);
-- Enhanced Invigorate (Lv.28)
INSERT INTO "server_battle_commands" VALUES (27280,'enhanced_invigorate',8,28,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Heavy Trammel (Lv.28)
INSERT INTO "server_battle_commands" VALUES (27713,'heavy_trammel',8,28,3,768,17152,1,3,0,0,0,1,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,500,1,503,1,3,16781815,0,0,0,0,0,30112,2,1,0,0);
-- Collusion (Lv.30)
INSERT INTO "server_battle_commands" VALUES (27602,'collusion',8,30,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30043,3,4,0,0);
-- Fleet of Foot (Lv.30)
INSERT INTO "server_battle_commands" VALUES (29475,'fleet_of_foot',8,30,4,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Enhanced Life Surge (Lv.32)
INSERT INTO "server_battle_commands" VALUES (27282,'enhanced_life_surge',8,32,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Doomspike II (Lv.32)
INSERT INTO "server_battle_commands" VALUES (27711,'doomspike_ii',8,32,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,2000,1,503,1,3,16781815,0,0,0,0,0,30353,2,1,0,0);
-- Ferocity II (Lv.34)
INSERT INTO "server_battle_commands" VALUES (27583,'ferocity_ii',8,34,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30271,3,4,0,0);
-- Enhanced Keen Flurry (Lv.36)
INSERT INTO "server_battle_commands" VALUES (27285,'enhanced_keen_flurry',8,36,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Diversion (Lv.36)
INSERT INTO "server_battle_commands" VALUES (27605,'diversion',8,36,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,250,1,503,1,3,16781815,0,0,0,0,0,30044,3,4,0,0);
-- Moonrise II (Lv.38)
INSERT INTO "server_battle_commands" VALUES (27698,'moonrise_ii',8,38,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30348,2,1,0,0);
-- Enhanced Physical Attack Power III (Lv.40)
INSERT INTO "server_battle_commands" VALUES (27290,'enhanced_physical_attack_power_iii',8,40,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Speed Surge II (Lv.40)
INSERT INTO "server_battle_commands" VALUES (27587,'speed_surge_ii',8,40,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30273,3,4,0,0);
-- Full Thrust (Lv.40)
INSERT INTO "server_battle_commands" VALUES (27759,'full_thrust',8,40,0,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30225,2,1,0,0);
-- Twisting Vice (Lv.42)
INSERT INTO "server_battle_commands" VALUES (27715,'twisting_vice',8,42,5,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,60,0,1500,1,503,1,3,16781815,0,0,0,0,0,30114,2,1,0,0);
-- Enhanced Power Surge (Lv.44)
INSERT INTO "server_battle_commands" VALUES (27281,'enhanced_power_surge',8,44,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Invigorate II (Lv.44)
INSERT INTO "server_battle_commands" VALUES (27590,'invigorate_ii',8,44,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30274,3,4,0,0);
-- Line of Fire (Lv.46)
INSERT INTO "server_battle_commands" VALUES (27608,'line_of_fire',8,46,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30041,3,4,0,0);
-- Enhanced Blood for Blood (Lv.48)
INSERT INTO "server_battle_commands" VALUES (27283,'enhanced_blood_for_blood',8,48,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Comrade in Arms II (Lv.48)
INSERT INTO "server_battle_commands" VALUES (27594,'comrade_in_arms_ii',8,48,3,31,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,30,0,500,1,503,1,3,16781815,0,0,0,0,0,30276,3,4,0,1);
-- Chaos Thrust (Lv.50)
INSERT INTO "server_battle_commands" VALUES (27717,'chaos_thrust',8,50,5,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,30,0,2000,1,503,1,3,16781815,0,0,0,0,0,30118,2,1,0,0);
-- Pikemanship (Lv.50)
INSERT INTO "server_battle_commands" VALUES (29476,'pikemanship',8,50,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Ferocity III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27584,'ferocity_iii',8,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30272,3,4,0,0);
-- Invigorate III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27591,'invigorate_iii',8,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30275,3,4,0,0);
-- Life Surge II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27597,'life_surge_ii',8,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30277,3,4,0,0);
-- Keen Flurry II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27600,'keen_flurry_ii',8,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30278,3,4,0,0);
-- Collusion II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27603,'collusion_ii',8,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30279,3,4,0,0);
-- Diversion II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27606,'diversion_ii',8,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,250,1,503,1,3,16781815,0,0,0,0,0,30280,3,4,0,0);
-- .Jump (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27610,'jump',8,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,100,0,0,1,503,1,3,16781815,0,0,0,0,0,30042,3,4,0,0);
-- .Overrun (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27700,'overrun',8,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30120,2,1,0,0);
-- .Overrun II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27701,'overrun_ii',8,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30349,2,1,0,0);
-- .Overrun III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27702,'overrun_iii',8,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30350,2,1,0,0);
-- Leg Sweep II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27705,'leg_sweep_ii',8,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,40,0,1000,1,503,1,3,16781815,0,0,0,0,0,30351,2,1,0,0);
-- Feint II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27708,'feint_ii',8,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,5,0,500,1,503,1,3,16781815,0,0,0,0,0,30352,2,1,0,0);
-- .Ring of Thorns (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27719,'ring_of_thorns',8,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,30,0,1000,1,503,1,3,16781815,0,0,0,0,0,30117,2,1,0,0);
-- .Onslaught (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27721,'onslaught',8,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,30,0,1000,1,503,1,3,16781815,0,0,0,0,0,30119,2,1,0,0);
-- .Righteous Way (Lv.99)
INSERT INTO "server_battle_commands" VALUES (27723,'righteous_way',8,99,5,768,17152,0,0,0,0,0,0,100,1,0,0,8,0,0,10,2,0,0,0,0,0,30,0,1000,1,503,1,3,16781815,0,0,0,0,0,30121,2,1,0,0);

-- Exaltation (Lv.1)
INSERT INTO "server_battle_commands" VALUES (28485,'exaltation',22,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,600,0,0,1,503,1,3,16781815,0,0,0,0,0,30211,3,4,0,0);
-- Sanguine Rite (Lv.2)
INSERT INTO "server_battle_commands" VALUES (28462,'sanguine_rite',22,2,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30065,3,4,0,0);
-- Sacrifice (Lv.4)
INSERT INTO "server_battle_commands" VALUES (28666,'sacrifice',22,4,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,5,10,0,1,503,1,3,16781815,0,0,0,0,0,30182,4,2,13,0);
-- Poison (Lv.6)
INSERT INTO "server_battle_commands" VALUES (28618,'poison',22,6,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1000,5,10,0,1,503,1,3,16781815,0,0,0,0,0,30180,4,2,10,0);
-- Enhanced Magic Potency (Lv.8)
INSERT INTO "server_battle_commands" VALUES (27327,'enhanced_magic_potency',22,8,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Slow (Lv.8)
INSERT INTO "server_battle_commands" VALUES (28630,'slow',22,8,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1500,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30178,4,2,8,0);
-- Gravity (Lv.8)
INSERT INTO "server_battle_commands" VALUES (28632,'gravity',22,8,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1500,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30179,4,2,7,0);
-- Punishing Barbs (Lv.10)
INSERT INTO "server_battle_commands" VALUES (28466,'punishing_barbs',22,10,3,31,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,180,0,0,1,503,1,3,16781815,0,0,0,0,0,30067,3,4,0,1);
-- Damnation (Lv.10)
INSERT INTO "server_battle_commands" VALUES (28565,'damnation',22,10,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30138,2,2,12,1);
-- Enhanced Enfeebling Magic (Lv.12)
INSERT INTO "server_battle_commands" VALUES (27325,'enhanced_enfeebling_magic',22,12,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Bio (Lv.12)
INSERT INTO "server_battle_commands" VALUES (28602,'bio',22,12,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1500,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30173,4,2,12,0);
-- Dia (Lv.12)
INSERT INTO "server_battle_commands" VALUES (28606,'dia',22,12,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1500,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30177,4,2,11,0);
-- Dark Seal (Lv.14)
INSERT INTO "server_battle_commands" VALUES (28469,'dark_seal',22,14,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,120,0,0,1,503,1,3,16781815,0,0,0,0,0,30068,3,4,0,0);
-- Resurrect (Lv.14)
INSERT INTO "server_battle_commands" VALUES (28675,'resurrect',22,14,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,10000,300,10,0,1,503,1,3,16781815,0,0,0,0,0,30186,4,2,12,0);
-- Enhanced Parsimony (Lv.16)
INSERT INTO "server_battle_commands" VALUES (27323,'enhanced_parsimony',22,16,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Stygian Spikes (Lv.16)
INSERT INTO "server_battle_commands" VALUES (28671,'stygian_spikes',22,16,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30190,4,2,12,0);
-- Absorb ATK (Lv.18)
INSERT INTO "server_battle_commands" VALUES (28645,'absorb_atk',22,18,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30191,4,2,12,0);
-- Absorb DEF (Lv.18)
INSERT INTO "server_battle_commands" VALUES (28648,'absorb_def',22,18,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30192,4,2,12,0);
-- Absorb ACC (Lv.18)
INSERT INTO "server_battle_commands" VALUES (28651,'absorb_acc',22,18,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30193,4,2,12,0);
-- Absorb EVA (Lv.18)
INSERT INTO "server_battle_commands" VALUES (28654,'absorb_eva',22,18,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30194,4,2,12,0);
-- Auto-refresh (Lv.20)
INSERT INTO "server_battle_commands" VALUES (27330,'auto_refresh',22,20,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Silhouette (Lv.20)
INSERT INTO "server_battle_commands" VALUES (28589,'silhouette',22,20,0,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30226,2,2,0,1);
-- Siphon MP (Lv.20)
INSERT INTO "server_battle_commands" VALUES (28660,'siphon_mp',22,20,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30185,4,2,12,0);
-- Sacrifice II (Lv.20)
INSERT INTO "server_battle_commands" VALUES (28667,'sacrifice_ii',22,20,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,2250,5,10,0,1,503,1,3,16781815,0,0,0,0,0,30386,4,2,13,0);
-- Initiation (Lv.22)
INSERT INTO "server_battle_commands" VALUES (28473,'initiation',22,22,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30066,3,4,0,1);
-- Swift Necrogenesis (Lv.24)
INSERT INTO "server_battle_commands" VALUES (27322,'swift_necrogenesis',22,24,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Scourge II (Lv.24)
INSERT INTO "server_battle_commands" VALUES (28593,'scourge_ii',22,24,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,10,10,0,1,503,1,3,16781815,0,0,0,0,0,30360,4,2,12,0);
-- Banish II (Lv.24)
INSERT INTO "server_battle_commands" VALUES (28598,'banish_ii',22,24,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,10,10,0,1,503,1,3,16781815,0,0,0,0,0,30363,4,2,11,0);
-- Drain (Lv.26)
INSERT INTO "server_battle_commands" VALUES (28610,'drain',22,26,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30171,4,2,12,0);
-- Enhanced Magic Potency II (Lv.28)
INSERT INTO "server_battle_commands" VALUES (27328,'enhanced_magic_potency_ii',22,28,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Bind (Lv.28)
INSERT INTO "server_battle_commands" VALUES (28634,'bind',22,28,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,40,10,0,1,503,1,3,16781815,0,0,0,0,0,30174,4,2,6,0);
-- Silence (Lv.28)
INSERT INTO "server_battle_commands" VALUES (28636,'silence',22,28,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1000,40,10,0,1,503,1,3,16781815,0,0,0,0,0,30175,4,2,7,0);
-- Paralyze (Lv.28)
INSERT INTO "server_battle_commands" VALUES (28638,'paralyze',22,28,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30176,4,2,6,0);
-- Paradigm Shift (Lv.30)
INSERT INTO "server_battle_commands" VALUES (28476,'paradigm_shift',22,30,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30071,3,4,0,0);
-- Flashfreeze (Lv.30)
INSERT INTO "server_battle_commands" VALUES (28562,'flashfreeze',22,30,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,1000,1,503,1,3,16781815,0,0,0,0,0,30137,2,2,6,1);
-- Firm Conviction (Lv.30)
INSERT INTO "server_battle_commands" VALUES (29477,'firm_conviction',22,30,4,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Enhanced Enfeebling Magic II (Lv.32)
INSERT INTO "server_battle_commands" VALUES (27326,'enhanced_enfeebling_magic_ii',22,32,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- .Mass Fear (Lv.32)
INSERT INTO "server_battle_commands" VALUES (28642,'mass_fear',22,32,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,180,10,0,1,503,1,3,16781815,0,0,0,0,0,30197,4,2,12,0);
-- Siphon TP (Lv.32)
INSERT INTO "server_battle_commands" VALUES (28663,'siphon_tp',22,32,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30184,4,2,12,0);
-- Sanguine Rite II (Lv.34)
INSERT INTO "server_battle_commands" VALUES (28463,'sanguine_rite_ii',22,34,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30285,3,4,0,0);
-- Swift Dark Seal (Lv.36)
INSERT INTO "server_battle_commands" VALUES (27320,'swift_dark_seal',22,36,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Bio II (Lv.36)
INSERT INTO "server_battle_commands" VALUES (28603,'bio_ii',22,36,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30366,4,2,12,0);
-- Dia II (Lv.36)
INSERT INTO "server_battle_commands" VALUES (28607,'dia_ii',22,36,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30368,4,2,11,0);
-- Blind (Lv.38)
INSERT INTO "server_battle_commands" VALUES (28640,'blind',22,38,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30181,4,2,12,0);
-- .Soul Ward (Lv.38)
INSERT INTO "server_battle_commands" VALUES (28677,'soul_ward',22,38,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,10000,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30195,4,2,12,0);
-- Enhanced Magic Crit Potency (Lv.40)
INSERT INTO "server_battle_commands" VALUES (27329,'enhanced_magic_crit_potency',22,40,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Emulate (Lv.40)
INSERT INTO "server_battle_commands" VALUES (28478,'emulate',22,40,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30069,3,4,0,1);
-- Shadowfall (Lv.40)
INSERT INTO "server_battle_commands" VALUES (28588,'shadowfall',22,40,0,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30227,2,2,0,1);
-- Shadowsear (Lv.42)
INSERT INTO "server_battle_commands" VALUES (28622,'shadowsear',22,42,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,4000,180,10,0,1,503,1,3,16781815,0,0,0,0,0,30196,4,2,12,0);
-- Stygian Spikes II (Lv.42)
INSERT INTO "server_battle_commands" VALUES (28672,'stygian_spikes_ii',22,42,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30389,4,2,12,0);
-- Enhanced Sanguine Rite (Lv.44)
INSERT INTO "server_battle_commands" VALUES (27324,'enhanced_sanguine_rite',22,44,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Poison II (Lv.44)
INSERT INTO "server_battle_commands" VALUES (28619,'poison_ii',22,44,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,10,10,0,1,503,1,3,16781815,0,0,0,0,0,30374,4,2,10,0);
-- Siphon MP II (Lv.44)
INSERT INTO "server_battle_commands" VALUES (28661,'siphon_mp_ii',22,44,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30384,4,2,12,0);
-- Dark Seal II (Lv.46)
INSERT INTO "server_battle_commands" VALUES (28470,'dark_seal_ii',22,46,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,120,0,0,1,503,1,3,16781815,0,0,0,0,0,30288,3,4,0,0);
-- Enhanced Excruciate (Lv.48)
INSERT INTO "server_battle_commands" VALUES (27321,'enhanced_excruciate',22,48,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Drain II (Lv.48)
INSERT INTO "server_battle_commands" VALUES (28611,'drain_ii',22,48,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3500,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30370,4,2,12,0);
-- Sacrifice III (Lv.48)
INSERT INTO "server_battle_commands" VALUES (28668,'sacrifice_iii',22,48,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,2500,6,10,0,1,503,1,3,16781815,0,0,0,0,0,30387,4,2,13,0);
-- Contagion (Lv.50)
INSERT INTO "server_battle_commands" VALUES (28481,'contagion',22,50,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30070,3,4,0,1);
-- Flashfreeze II (Lv.50)
INSERT INTO "server_battle_commands" VALUES (28563,'flashfreeze_ii',22,50,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,1000,1,503,1,3,16781815,0,0,0,0,0,30356,2,2,6,1);
-- Transcendence (Lv.50)
INSERT INTO "server_battle_commands" VALUES (29478,'transcendence',22,50,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Absorb ATK II (Lv.52)
INSERT INTO "server_battle_commands" VALUES (28646,'absorb_atk_ii',22,52,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30379,4,2,12,0);
-- Absorb DEF II (Lv.52)
INSERT INTO "server_battle_commands" VALUES (28649,'absorb_def_ii',22,52,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30380,4,2,12,0);
-- Absorb ACC II (Lv.52)
INSERT INTO "server_battle_commands" VALUES (28652,'absorb_acc_ii',22,52,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30381,4,2,12,0);
-- Absorb EVA II (Lv.52)
INSERT INTO "server_battle_commands" VALUES (28655,'absorb_eva_ii',22,52,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30382,4,2,12,0);
-- Scourge III (Lv.56)
INSERT INTO "server_battle_commands" VALUES (28594,'scourge_iii',22,56,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,4000,10,10,0,1,503,1,3,16781815,0,0,0,0,0,30361,4,2,12,0);
-- Banish III (Lv.56)
INSERT INTO "server_battle_commands" VALUES (28599,'banish_iii',22,56,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,4000,10,10,0,1,503,1,3,16781815,0,0,0,0,0,30364,4,2,11,0);
-- Bio III (Lv.62)
INSERT INTO "server_battle_commands" VALUES (28604,'bio_iii',22,62,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2500,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30367,4,2,12,0);
-- Dia III (Lv.62)
INSERT INTO "server_battle_commands" VALUES (28608,'dia_iii',22,62,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2500,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30369,4,2,11,0);
-- Siphon TP II (Lv.64)
INSERT INTO "server_battle_commands" VALUES (28664,'siphon_tp_ii',22,64,3,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30385,4,2,12,0);
-- Stygian Spikes III (Lv.64)
INSERT INTO "server_battle_commands" VALUES (28673,'stygian_spikes_iii',22,64,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30390,4,2,12,0);
-- Shadowsear II (Lv.68)
INSERT INTO "server_battle_commands" VALUES (28623,'shadowsear_ii',22,68,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,6000,180,10,0,1,503,1,3,16781815,0,0,0,0,0,30376,4,2,12,0);
-- Sacrifice IV (Lv.68)
INSERT INTO "server_battle_commands" VALUES (28669,'sacrifice_iv',22,68,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,2750,6,10,0,1,503,1,3,16781815,0,0,0,0,0,30388,4,2,13,0);
-- Scourge IV (Lv.72)
INSERT INTO "server_battle_commands" VALUES (28595,'scourge_iv',22,72,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,5000,20,10,0,1,503,1,3,16781815,0,0,0,0,0,30362,4,2,12,0);
-- Banish IV (Lv.72)
INSERT INTO "server_battle_commands" VALUES (28600,'banish_iv',22,72,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,5000,20,10,0,1,503,1,3,16781815,0,0,0,0,0,30365,4,2,11,0);
-- Drain III (Lv.74)
INSERT INTO "server_battle_commands" VALUES (28612,'drain_iii',22,74,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,4000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30371,4,2,12,0);
-- Poison III (Lv.78)
INSERT INTO "server_battle_commands" VALUES (28620,'poison_iii',22,78,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,10,10,0,1,503,1,3,16781815,0,0,0,0,0,30375,4,2,10,0);
-- .Mass Fear II (Lv.78)
INSERT INTO "server_battle_commands" VALUES (28643,'mass_fear_ii',22,78,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,180,10,0,1,503,1,3,16781815,0,0,0,0,0,30378,4,2,12,0);
-- Sanguine Rite III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28464,'sanguine_rite_iii',22,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30286,3,4,0,0);
-- Punishing Barbs II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28467,'punishing_barbs_ii',22,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,0,0,180,0,0,1,503,1,3,16781815,0,0,0,0,0,30287,3,4,0,1);
-- Dark Seal III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28471,'dark_seal_iii',22,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,120,0,0,1,503,1,3,16781815,0,0,0,0,0,30289,3,4,0,0);
-- Initiation II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28474,'initiation_ii',22,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30290,3,4,0,1);
-- Emulate II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28479,'emulate_ii',22,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30291,3,4,0,1);
-- .Onus of Might (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28483,'onus_of_might',22,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,120,0,0,1,503,1,3,16781815,0,0,0,0,0,30072,3,4,0,1);
-- Damnation II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28566,'damnation_ii',22,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30357,2,2,12,1);
-- .Aspir (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28614,'aspir',22,99,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30172,4,2,12,0);
-- .Aspir II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28615,'aspir_ii',22,99,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3500,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30372,4,2,12,0);
-- .Aspir III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28616,'aspir_iii',22,99,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,4000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30373,4,2,12,0);
-- .- (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28625,'',22,99,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1000,5,10,0,1,503,1,3,16781815,0,0,0,0,0,30188,4,2,0,0);
-- .- (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28626,'',22,99,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1000,5,10,0,1,503,1,3,16781815,0,0,0,0,0,30377,4,2,0,0);
-- .- (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28628,'',22,99,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1000,5,10,0,1,503,1,3,16781815,0,0,0,0,0,30189,4,2,0,0);
-- .Absorb TP (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28657,'absorb_tp',22,99,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30183,4,2,12,0);
-- .Absorb TP II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28658,'absorb_tp_ii',22,99,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30383,4,2,12,0);

-- Spirit Dart (Lv.1)
INSERT INTO "server_battle_commands" VALUES (22303,'spirit_dart',23,1,0,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,10,0,0,1,503,1,3,16781815,0,0,0,0,0,30208,2,2,0,1);
-- Tranquility (Lv.1)
INSERT INTO "server_battle_commands" VALUES (28828,'tranquility',23,1,0,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,600,0,0,1,503,1,3,16781815,0,0,0,0,0,30212,3,4,0,0);
-- Fire (Lv.1)
INSERT INTO "server_battle_commands" VALUES (28932,'fire',23,1,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,6,10,0,1,503,1,3,16781815,0,0,0,0,0,30139,4,2,5,0);
-- Blizzard (Lv.1)
INSERT INTO "server_battle_commands" VALUES (28937,'blizzard',23,1,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,6,10,0,1,503,1,3,16781815,0,0,0,0,0,30140,4,2,6,0);
-- Aero (Lv.1)
INSERT INTO "server_battle_commands" VALUES (28942,'aero',23,1,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,6,10,0,1,503,1,3,16781815,0,0,0,0,0,30143,4,2,7,0);
-- Stone (Lv.1)
INSERT INTO "server_battle_commands" VALUES (28947,'stone',23,1,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,6,10,0,1,503,1,3,16781815,0,0,0,0,0,30144,4,2,8,0);
-- Thunder (Lv.1)
INSERT INTO "server_battle_commands" VALUES (28952,'thunder',23,1,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,6,10,0,1,503,1,3,16781815,0,0,0,0,0,30141,4,2,9,0);
-- Water (Lv.1)
INSERT INTO "server_battle_commands" VALUES (28957,'water',23,1,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,6,10,0,1,503,1,3,16781815,0,0,0,0,0,30142,4,2,10,0);
-- Trance Chant (Lv.2)
INSERT INTO "server_battle_commands" VALUES (28802,'trance_chant',23,2,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,120,0,0,1,503,1,3,16781815,0,0,0,0,0,30058,3,4,0,0);
-- Cure (Lv.4)
INSERT INTO "server_battle_commands" VALUES (29010,'cure',23,4,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,5,10,0,1,503,1,3,16781815,0,0,0,0,0,30157,4,2,13,0);
-- Stoneskin (Lv.6)
INSERT INTO "server_battle_commands" VALUES (29023,'stoneskin',23,6,2,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,6000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30168,4,2,8,0);
-- Greater Healing (Lv.8)
INSERT INTO "server_battle_commands" VALUES (27367,'greater_healing',23,8,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Repose (Lv.8)
INSERT INTO "server_battle_commands" VALUES (29004,'repose',23,8,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,40,10,0,1,503,1,3,16781815,0,0,0,0,0,30158,4,2,6,0);
-- Shock Spikes (Lv.8)
INSERT INTO "server_battle_commands" VALUES (29027,'shock_spikes',23,8,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,10,10,0,1,503,1,3,16781815,0,0,0,0,0,30167,4,2,9,0);
-- .Shock Spikes Counter (Lv.8)
INSERT INTO "server_battle_commands" VALUES (29043,'shock_spikes_counter',23,8,0,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,1000,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30000,4,2,9,0);
-- Profundity (Lv.10)
INSERT INTO "server_battle_commands" VALUES (28805,'profundity',23,10,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30057,3,4,0,0);
-- Radiance (Lv.10)
INSERT INTO "server_battle_commands" VALUES (28905,'radiance',23,10,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30136,2,2,11,1);
-- Greater Enhancing Magic (Lv.12)
INSERT INTO "server_battle_commands" VALUES (27366,'greater_enhancing_magic',23,12,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Burn (Lv.12)
INSERT INTO "server_battle_commands" VALUES (28962,'burn',23,12,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2500,12,10,0,1,503,1,3,16781815,0,0,0,0,0,30145,4,2,5,0);
-- Frost (Lv.12)
INSERT INTO "server_battle_commands" VALUES (28966,'frost',23,12,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2500,12,10,0,1,503,1,3,16781815,0,0,0,0,0,30146,4,2,6,0);
-- Choke (Lv.12)
INSERT INTO "server_battle_commands" VALUES (28970,'choke',23,12,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2500,12,10,0,1,503,1,3,16781815,0,0,0,0,0,30149,4,2,7,0);
-- Rasp (Lv.12)
INSERT INTO "server_battle_commands" VALUES (28974,'rasp',23,12,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2500,12,10,0,1,503,1,3,16781815,0,0,0,0,0,30150,4,2,8,0);
-- Shock (Lv.12)
INSERT INTO "server_battle_commands" VALUES (28978,'shock',23,12,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2500,12,10,0,1,503,1,3,16781815,0,0,0,0,0,30147,4,2,9,0);
-- Drown (Lv.12)
INSERT INTO "server_battle_commands" VALUES (28982,'drown',23,12,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2500,12,10,0,1,503,1,3,16781815,0,0,0,0,0,30148,4,2,10,0);
-- Soughspeak (Lv.14)
INSERT INTO "server_battle_commands" VALUES (28809,'soughspeak',23,14,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30063,3,4,0,0);
-- Raise (Lv.14)
INSERT INTO "server_battle_commands" VALUES (29037,'raise',23,14,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,10000,300,10,0,1,503,1,3,16781815,0,0,0,0,0,30164,4,2,11,0);
-- Enhanced Magic Accuracy (Lv.16)
INSERT INTO "server_battle_commands" VALUES (27369,'enhanced_magic_accuracy',23,16,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Protect (Lv.16)
INSERT INTO "server_battle_commands" VALUES (29015,'protect',23,16,2,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30162,4,2,11,0);
-- Shell (Lv.16)
INSERT INTO "server_battle_commands" VALUES (29019,'shell',23,16,2,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30163,4,2,11,0);
-- Curaga (Lv.16)
INSERT INTO "server_battle_commands" VALUES (29046,'curaga',23,16,2,768,17152,1,8,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,10,10,0,1,503,1,3,16781815,0,0,0,0,0,30462,4,2,13,0);
-- Spiritsong (Lv.18)
INSERT INTO "server_battle_commands" VALUES (28813,'spiritsong',23,18,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30061,3,4,0,0);
-- Auto-refresh (Lv.20)
INSERT INTO "server_battle_commands" VALUES (27370,'auto_refresh',23,20,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Elemental Shroud (Lv.20)
INSERT INTO "server_battle_commands" VALUES (28929,'elemental_shroud',23,20,0,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30229,2,2,0,1);
-- Cure II (Lv.20)
INSERT INTO "server_battle_commands" VALUES (29011,'cure_ii',23,20,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,2250,5,10,0,1,503,1,3,16781815,0,0,0,0,0,30429,4,2,13,0);
-- Purge (Lv.22)
INSERT INTO "server_battle_commands" VALUES (28815,'purge',23,22,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30060,3,4,0,1);
-- Enhanced Protect (Lv.24)
INSERT INTO "server_battle_commands" VALUES (27365,'enhanced_protect',23,24,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Fire II (Lv.24)
INSERT INTO "server_battle_commands" VALUES (28933,'fire_ii',23,24,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,14,10,0,1,503,1,3,16781815,0,0,0,0,0,30391,4,2,5,0);
-- Blizzard II (Lv.24)
INSERT INTO "server_battle_commands" VALUES (28938,'blizzard_ii',23,24,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,14,10,0,1,503,1,3,16781815,0,0,0,0,0,30394,4,2,6,0);
-- Aero II (Lv.24)
INSERT INTO "server_battle_commands" VALUES (28943,'aero_ii',23,24,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,14,10,0,1,503,1,3,16781815,0,0,0,0,0,30403,4,2,7,0);
-- Stone II (Lv.24)
INSERT INTO "server_battle_commands" VALUES (28948,'stone_ii',23,24,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,14,10,0,1,503,1,3,16781815,0,0,0,0,0,30406,4,2,8,0);
-- Thunder II (Lv.24)
INSERT INTO "server_battle_commands" VALUES (28953,'thunder_ii',23,24,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,14,10,0,1,503,1,3,16781815,0,0,0,0,0,30397,4,2,9,0);
-- Water II (Lv.24)
INSERT INTO "server_battle_commands" VALUES (28958,'water_ii',23,24,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,14,10,0,1,503,1,3,16781815,0,0,0,0,0,30400,4,2,10,0);
-- Resonance (Lv.26)
INSERT INTO "server_battle_commands" VALUES (28819,'resonance',23,26,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30062,3,4,0,0);
-- Greater Healing II (Lv.28)
INSERT INTO "server_battle_commands" VALUES (27368,'greater_healing_ii',23,28,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Poisona (Lv.28)
INSERT INTO "server_battle_commands" VALUES (29031,'poisona',23,28,2,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1000,5,10,0,1,503,1,3,16781815,0,0,0,0,0,30159,4,2,11,0);
-- Paralyna (Lv.28)
INSERT INTO "server_battle_commands" VALUES (29033,'paralyna',23,28,2,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1000,5,10,0,1,503,1,3,16781815,0,0,0,0,0,30160,4,2,11,0);
-- Silena (Lv.28)
INSERT INTO "server_battle_commands" VALUES (29035,'silena',23,28,2,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,1000,5,10,0,1,503,1,3,16781815,0,0,0,0,0,30161,4,2,11,0);
-- Roaming Soul (Lv.30)
INSERT INTO "server_battle_commands" VALUES (28822,'roaming_soul',23,30,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30059,3,4,0,0);
-- Levinbolt (Lv.30)
INSERT INTO "server_battle_commands" VALUES (28902,'levinbolt',23,30,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30135,2,2,9,1);
-- Curaga II (Lv.30)
INSERT INTO "server_battle_commands" VALUES (29047,'curaga_ii',23,30,2,768,17152,1,8,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,10,10,0,1,503,1,3,16781815,0,0,0,0,0,30463,4,2,13,0);
-- Fastcast (Lv.30)
INSERT INTO "server_battle_commands" VALUES (29479,'fastcast',23,30,4,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Enhanced Blissful Mind (Lv.32)
INSERT INTO "server_battle_commands" VALUES (27362,'enhanced_blissful_mind',23,32,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Sleep (Lv.32)
INSERT INTO "server_battle_commands" VALUES (29007,'sleep',23,32,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30169,4,2,12,0);
-- Profundity II (Lv.34)
INSERT INTO "server_battle_commands" VALUES (28806,'profundity_ii',23,34,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30293,3,4,0,0);
-- Enhanced Stoneskin (Lv.36)
INSERT INTO "server_battle_commands" VALUES (27364,'enhanced_stoneskin',23,36,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Burn II (Lv.36)
INSERT INTO "server_battle_commands" VALUES (28963,'burn_ii',23,36,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,14,10,0,1,503,1,3,16781815,0,0,0,0,0,30409,4,2,5,0);
-- Frost II (Lv.36)
INSERT INTO "server_battle_commands" VALUES (28967,'frost_ii',23,36,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,14,10,0,1,503,1,3,16781815,0,0,0,0,0,30411,4,2,6,0);
-- Choke II (Lv.36)
INSERT INTO "server_battle_commands" VALUES (28971,'choke_ii',23,36,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,14,10,0,1,503,1,3,16781815,0,0,0,0,0,30417,4,2,7,0);
-- Rasp II (Lv.36)
INSERT INTO "server_battle_commands" VALUES (28975,'rasp_ii',23,36,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,14,10,0,1,503,1,3,16781815,0,0,0,0,0,30419,4,2,8,0);
-- Shock II (Lv.36)
INSERT INTO "server_battle_commands" VALUES (28979,'shock_ii',23,36,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,14,10,0,1,503,1,3,16781815,0,0,0,0,0,30413,4,2,9,0);
-- Drown II (Lv.36)
INSERT INTO "server_battle_commands" VALUES (28983,'drown_ii',23,36,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,14,10,0,1,503,1,3,16781815,0,0,0,0,0,30415,4,2,10,0);
-- Raise II (Lv.38)
INSERT INTO "server_battle_commands" VALUES (29038,'raise_ii',23,38,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,10000,150,10,0,1,503,1,3,16781815,0,0,0,0,0,30460,4,2,11,0);
-- .Reraise (Lv.38)
INSERT INTO "server_battle_commands" VALUES (29039,'reraise',23,38,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,10000,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30165,4,2,11,0);
-- Swift Sacred Prism (Lv.40)
INSERT INTO "server_battle_commands" VALUES (27360,'swift_sacred_prism',23,40,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Chainspell (Lv.40)
INSERT INTO "server_battle_commands" VALUES (28825,'chainspell',23,40,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,300,0,0,1,503,1,3,16781815,0,0,0,0,0,30064,3,4,0,0);
-- Nature's Fury (Lv.40)
INSERT INTO "server_battle_commands" VALUES (28928,'nature_s_fury',23,40,0,768,17152,1,3,0,0,0,1,100,1,0,0,15,0,0,10,2,0,0,0,0,0,30,0,0,1,503,1,3,16781815,0,0,0,0,0,30230,2,2,0,1);
-- Stoneskin II (Lv.42)
INSERT INTO "server_battle_commands" VALUES (29024,'stoneskin_ii',23,42,2,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,6000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30436,4,2,8,0);
-- Shock Spikes II (Lv.42)
INSERT INTO "server_battle_commands" VALUES (29028,'shock_spikes_ii',23,42,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,10,10,0,1,503,1,3,16781815,0,0,0,0,0,30438,4,2,9,0);
-- .Tractor (Lv.42)
INSERT INTO "server_battle_commands" VALUES (29041,'tractor',23,42,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,10000,10,0,0,1,503,1,3,16781815,0,0,0,0,0,30166,4,2,11,0);
-- .Shock Spikes Counter II (Lv.42)
INSERT INTO "server_battle_commands" VALUES (29044,'shock_spikes_counter_ii',23,42,0,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,1000,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30000,4,2,9,0);
-- Swift Shroud of Saints (Lv.44)
INSERT INTO "server_battle_commands" VALUES (27361,'swift_shroud_of_saints',23,44,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,120,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Flare (Lv.44)
INSERT INTO "server_battle_commands" VALUES (28986,'flare',23,44,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,6000,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30151,4,2,5,0);
-- Freeze (Lv.44)
INSERT INTO "server_battle_commands" VALUES (28989,'freeze',23,44,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,6000,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30152,4,2,6,0);
-- Tornado (Lv.44)
INSERT INTO "server_battle_commands" VALUES (28992,'tornado',23,44,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,6000,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30155,4,2,7,0);
-- Quake (Lv.44)
INSERT INTO "server_battle_commands" VALUES (28995,'quake',23,44,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,6000,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30156,4,2,8,0);
-- Burst (Lv.44)
INSERT INTO "server_battle_commands" VALUES (28998,'burst',23,44,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,6000,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30153,4,2,9,0);
-- Flood (Lv.44)
INSERT INTO "server_battle_commands" VALUES (29001,'flood',23,44,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,6000,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30154,4,2,10,0);
-- Purge II (Lv.46)
INSERT INTO "server_battle_commands" VALUES (28816,'purge_ii',23,46,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30297,3,4,0,1);
-- Enhanced Raise (Lv.48)
INSERT INTO "server_battle_commands" VALUES (27363,'enhanced_raise',23,48,1,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,5,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,1);
-- Cure III (Lv.48)
INSERT INTO "server_battle_commands" VALUES (29012,'cure_iii',23,48,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,2500,6,10,0,1,503,1,3,16781815,0,0,0,0,0,30430,4,2,13,0);
-- Protect II (Lv.48)
INSERT INTO "server_battle_commands" VALUES (29016,'protect_ii',23,48,2,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30432,4,2,11,0);
-- Shell II (Lv.48)
INSERT INTO "server_battle_commands" VALUES (29020,'shell_ii',23,48,2,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30434,4,2,11,0);
-- Soughspeak II (Lv.50)
INSERT INTO "server_battle_commands" VALUES (28810,'soughspeak_ii',23,50,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30295,3,4,0,0);
-- Levinbolt II (Lv.50)
INSERT INTO "server_battle_commands" VALUES (28903,'levinbolt_ii',23,50,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30358,2,2,9,1);
-- Rebirth (Lv.50)
INSERT INTO "server_battle_commands" VALUES (29040,'rebirth',23,50,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,10000,1800,10,0,1,503,1,3,16781815,0,0,0,0,0,30461,4,2,11,0);
-- One With Nature (Lv.50)
INSERT INTO "server_battle_commands" VALUES (29480,'one_with_nature',23,50,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30447,3,4,0,0);
-- Fire III (Lv.54)
INSERT INTO "server_battle_commands" VALUES (28934,'fire_iii',23,54,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,4000,22,10,0,1,503,1,3,16781815,0,0,0,0,0,30392,4,2,5,0);
-- Blizzard III (Lv.54)
INSERT INTO "server_battle_commands" VALUES (28939,'blizzard_iii',23,54,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,4000,22,10,0,1,503,1,3,16781815,0,0,0,0,0,30395,4,2,6,0);
-- Aero III (Lv.54)
INSERT INTO "server_battle_commands" VALUES (28944,'aero_iii',23,54,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,4000,22,10,0,1,503,1,3,16781815,0,0,0,0,0,30404,4,2,7,0);
-- Stone III (Lv.54)
INSERT INTO "server_battle_commands" VALUES (28949,'stone_iii',23,54,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,4000,22,10,0,1,503,1,3,16781815,0,0,0,0,0,30407,4,2,8,0);
-- Thunder III (Lv.54)
INSERT INTO "server_battle_commands" VALUES (28954,'thunder_iii',23,54,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,4000,22,10,0,1,503,1,3,16781815,0,0,0,0,0,30398,4,2,9,0);
-- Water III (Lv.54)
INSERT INTO "server_battle_commands" VALUES (28959,'water_iii',23,54,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,4000,22,10,0,1,503,1,3,16781815,0,0,0,0,0,30401,4,2,10,0);
-- Repose II (Lv.58)
INSERT INTO "server_battle_commands" VALUES (29005,'repose_ii',23,58,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,2000,40,10,0,1,503,1,3,16781815,0,0,0,0,0,30427,4,2,6,0);
-- Burn III (Lv.62)
INSERT INTO "server_battle_commands" VALUES (28964,'burn_iii',23,62,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3500,16,10,0,1,503,1,3,16781815,0,0,0,0,0,30410,4,2,5,0);
-- Frost III (Lv.62)
INSERT INTO "server_battle_commands" VALUES (28968,'frost_iii',23,62,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3500,16,10,0,1,503,1,3,16781815,0,0,0,0,0,30412,4,2,6,0);
-- Choke III (Lv.62)
INSERT INTO "server_battle_commands" VALUES (28972,'choke_iii',23,62,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3500,16,10,0,1,503,1,3,16781815,0,0,0,0,0,30418,4,2,7,0);
-- Rasp III (Lv.62)
INSERT INTO "server_battle_commands" VALUES (28976,'rasp_iii',23,62,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3500,16,10,0,1,503,1,3,16781815,0,0,0,0,0,30420,4,2,8,0);
-- Shock III (Lv.62)
INSERT INTO "server_battle_commands" VALUES (28980,'shock_iii',23,62,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3500,16,10,0,1,503,1,3,16781815,0,0,0,0,0,30414,4,2,9,0);
-- Drown III (Lv.62)
INSERT INTO "server_battle_commands" VALUES (28984,'drown_iii',23,62,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3500,16,10,0,1,503,1,3,16781815,0,0,0,0,0,30416,4,2,10,0);
-- Stoneskin III (Lv.64)
INSERT INTO "server_battle_commands" VALUES (29025,'stoneskin_iii',23,64,2,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,6000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30437,4,2,8,0);
-- Shock Spikes III (Lv.64)
INSERT INTO "server_battle_commands" VALUES (29029,'shock_spikes_iii',23,64,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,10,10,0,1,503,1,3,16781815,0,0,0,0,0,30439,4,2,9,0);
-- .Shock Spikes Counter III (Lv.64)
INSERT INTO "server_battle_commands" VALUES (29045,'shock_spikes_counter_iii',23,64,0,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,1000,0,0,0,1,503,1,3,16781815,0,0,0,0,0,30000,4,2,9,0);
-- Cure IV (Lv.68)
INSERT INTO "server_battle_commands" VALUES (29013,'cure_iv',23,68,2,768,17152,0,0,0,0,0,0,100,1,0,0,12,0,0,10,2,0,0,0,2,2750,6,10,0,1,503,1,3,16781815,0,0,0,0,0,30431,4,2,13,0);
-- Protect III (Lv.68)
INSERT INTO "server_battle_commands" VALUES (29017,'protect_iii',23,68,2,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30433,4,2,11,0);
-- Shell III (Lv.68)
INSERT INTO "server_battle_commands" VALUES (29021,'shell_iii',23,68,2,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,60,10,0,1,503,1,3,16781815,0,0,0,0,0,30435,4,2,11,0);
-- Fire IV (Lv.72)
INSERT INTO "server_battle_commands" VALUES (28935,'fire_iv',23,72,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,5000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30393,4,2,5,0);
-- Blizzard IV (Lv.72)
INSERT INTO "server_battle_commands" VALUES (28940,'blizzard_iv',23,72,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,5000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30396,4,2,6,0);
-- Aero IV (Lv.72)
INSERT INTO "server_battle_commands" VALUES (28945,'aero_iv',23,72,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,5000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30405,4,2,7,0);
-- Stone IV (Lv.72)
INSERT INTO "server_battle_commands" VALUES (28950,'stone_iv',23,72,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,5000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30408,4,2,8,0);
-- Thunder IV (Lv.72)
INSERT INTO "server_battle_commands" VALUES (28955,'thunder_iv',23,72,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,5000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30399,4,2,9,0);
-- Water IV (Lv.72)
INSERT INTO "server_battle_commands" VALUES (28960,'water_iv',23,72,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,5000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30402,4,2,10,0);
-- Sleep II (Lv.74)
INSERT INTO "server_battle_commands" VALUES (29008,'sleep_ii',23,74,3,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,3000,30,10,0,1,503,1,3,16781815,0,0,0,0,0,30428,4,2,12,0);
-- Flare II (Lv.80)
INSERT INTO "server_battle_commands" VALUES (28987,'flare_ii',23,80,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,8000,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30421,4,2,5,0);
-- Freeze II (Lv.80)
INSERT INTO "server_battle_commands" VALUES (28990,'freeze_ii',23,80,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,8000,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30422,4,2,6,0);
-- Tornado II (Lv.80)
INSERT INTO "server_battle_commands" VALUES (28993,'tornado_ii',23,80,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,8000,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30425,4,2,7,0);
-- Quake II (Lv.80)
INSERT INTO "server_battle_commands" VALUES (28996,'quake_ii',23,80,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,8000,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30426,4,2,8,0);
-- Burst II (Lv.80)
INSERT INTO "server_battle_commands" VALUES (28999,'burst_ii',23,80,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,8000,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30423,4,2,9,0);
-- Flood II (Lv.80)
INSERT INTO "server_battle_commands" VALUES (29002,'flood_ii',23,80,4,768,17152,1,5,0,0,0,1,100,1,0,0,12,0,0,10,2,0,0,0,2,8000,90,10,0,1,503,1,3,16781815,0,0,0,0,0,30424,4,2,10,0);
-- Trance Chant II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28803,'trance_chant_ii',23,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,90,0,0,1,503,1,3,16781815,0,0,0,0,0,30292,3,4,0,0);
-- Profundity III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28807,'profundity_iii',23,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30294,3,4,0,0);
-- Soughspeak III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28811,'soughspeak_iii',23,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30296,3,4,0,0);
-- Purge III (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28817,'purge_iii',23,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30298,3,4,0,1);
-- Resonance II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28820,'resonance_ii',23,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30299,3,4,0,0);
-- Roaming Soul II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28823,'roaming_soul_ii',23,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,60,0,0,1,503,1,3,16781815,0,0,0,0,0,30300,3,4,0,0);
-- Chainspell II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28826,'chainspell_ii',23,99,3,31,17152,0,0,0,0,0,0,100,1,0,0,5,0,0,10,2,0,0,0,0,0,300,0,0,1,503,1,3,16781815,0,0,0,0,0,30301,3,4,0,0);
-- Radiance II (Lv.99)
INSERT INTO "server_battle_commands" VALUES (28906,'radiance_ii',23,99,3,768,17152,0,0,0,0,0,0,100,1,0,0,15,0,0,10,2,0,0,0,0,0,10,0,1000,1,503,1,3,16781815,0,0,0,0,0,30359,2,2,11,1);

-- Dump completed on 2019-06-05 18:56:04
