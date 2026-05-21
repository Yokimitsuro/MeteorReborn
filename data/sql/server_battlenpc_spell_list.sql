-- MySQL dump 10.13  Distrib 5.7.18, for Win64 (x86_64)
--
-- Host: localhost    Database: ffxiv_server

-- Server version	5.7.18-log

--
-- Table structure for server_battlenpc_spell_list
--

DROP TABLE IF EXISTS "server_battlenpc_spell_list" CASCADE;
CREATE TABLE "server_battlenpc_spell_list" (
  "spellListId" bigint NOT NULL DEFAULT '0',
  "spellId" bigint NOT NULL DEFAULT '0',
  PRIMARY KEY ("spellListId", "spellId")
) ;

--
-- Dumping data for table "server_battlenpc_spell_list"
--

-- Spell lists for magic-using mob types

-- Spell List 1: Bomb (fire magic)
INSERT INTO "server_battlenpc_spell_list" VALUES (1, 27310);  -- fire

-- Spell List 2: Sprite/Will-O-Wisp (thunder + blizzard)
INSERT INTO "server_battlenpc_spell_list" VALUES (2, 27308);  -- blizzard
INSERT INTO "server_battlenpc_spell_list" VALUES (2, 27313);  -- thunder

-- Spell List 3: Petitghost (thunder + sleep)
INSERT INTO "server_battlenpc_spell_list" VALUES (3, 27313);  -- thunder
INSERT INTO "server_battlenpc_spell_list" VALUES (3, 27306);  -- sleep

-- Spell List 4: Poisonous Flower (aero - wind DoT)
INSERT INTO "server_battlenpc_spell_list" VALUES (4, 27353);  -- aero

-- Spell List 5: Goblin (stone)
INSERT INTO "server_battlenpc_spell_list" VALUES (5, 27355);  -- stone

-- Dump completed
