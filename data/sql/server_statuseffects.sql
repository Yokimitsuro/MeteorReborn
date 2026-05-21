-- MySQL dump 10.13  Distrib 5.7.23, for Win64 (x86_64)
--
-- Host: localhost    Database: ffxiv_server

-- Server version	5.7.23

--
-- Table structure for table "server_statuseffects"
--

DROP TABLE IF EXISTS "server_statuseffects" CASCADE;
CREATE TABLE "server_statuseffects" (
  "id" bigint NOT NULL,
  "name" varchar(128) NOT NULL,
  "flags" bigint NOT NULL DEFAULT '10',
  "overwrite" smallint NOT NULL DEFAULT '1',
  "tickMs" bigint NOT NULL DEFAULT '3000',
  "hidden" smallint NOT NULL DEFAULT '0',
  "silentOnGain" smallint NOT NULL DEFAULT '0',
  "silentOnLoss" smallint NOT NULL DEFAULT '0',
  "statusGainTextId" smallint NOT NULL DEFAULT '30328',
  "statusLossTextId" integer NOT NULL DEFAULT '30331',
  PRIMARY KEY ("id")
) ;

--
-- Dumping data for table "server_statuseffects"
--

INSERT INTO "server_statuseffects" VALUES (223001,'quick',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223002,'haste',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223003,'slow',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223004,'petrification',264241173,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223005,'paralysis',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223006,'silence',4194325,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223007,'blind',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223008,'mute',4194325,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223009,'slowcast',517,1,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223010,'glare',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223011,'poison',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223012,'transfixion',268435477,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223013,'pacification',8388629,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223014,'amnesia',16777237,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223015,'stun',264241173,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223016,'daze',264241173,2,0,0,0,0,30335,30338);
-- Positional exposure
INSERT INTO "server_statuseffects" VALUES (223017,'expose_front',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223018,'expose_right',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223019,'expose_rear',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223020,'expose_left',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223021,'incapacitated',264241173,2,0,0,0,0,30335,30338);
-- Stat max buffs/debuffs
INSERT INTO "server_statuseffects" VALUES (223028,'hp_max_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223029,'hp_boost',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223030,'hp_penalty',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223031,'mp_max_down',21,2,0,0,0,0,30335,30338);
-- Core stat buffs/debuffs
INSERT INTO "server_statuseffects" VALUES (223032,'attack_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223033,'attack_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223034,'accuracy_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223035,'accuracy_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223036,'defense_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223037,'defense_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223038,'defense_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223039,'evasion_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223040,'magic_potency_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223041,'magic_potency_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223042,'magic_accuracy_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223043,'magic_accuracy_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223044,'magic_defense_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223045,'magic_defense_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223046,'magic_resistance_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223047,'magic_resistance_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223048,'crit_rate_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223049,'crit_rate_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223050,'magic_crit_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223051,'magic_crit_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223052,'crit_resistance_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223053,'crit_resistance_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223054,'magic_crit_resistance_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223055,'magic_crit_resistance_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223056,'tp_inhibited',21,2,0,0,0,0,30335,30338);
-- Player ability effects
INSERT INTO "server_statuseffects" VALUES (223057,'aegis_boon2',528409,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223058,'aegis_boon',528409,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223059,'outmaneuver',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223060,'provoke',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223061,'sentinel',1048601,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223062,'sentinel',1048601,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223063,'cover',16409,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223064,'rampart',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223065,'cadence',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223066,'discerning_eye',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223067,'still_precision',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223068,'tempered_will',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223069,'obsess',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223070,'ambidexterity',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223071,'battle_calm',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223072,'master_of_arms',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223073,'taunt',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223074,'blindside',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223075,'featherfoot',131097,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223076,'presence_of_mind',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223077,'coeurl_step',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223078,'enduring_march',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223079,'murderous_intent',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223080,'entrenched',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223081,'bloodbath',1048601,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223082,'retaliation',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223083,'foresight',262169,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223084,'defender',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223085,'rampage',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223086,'enraged',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223087,'warmonger',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223088,'disorient_1',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223089,'disorient_2',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223090,'disorient_3',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223091,'keen_flurry',1033,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223092,'comrade_in_arms',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223093,'ferocity',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223094,'invigorate',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223095,'line_of_fire',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223096,'leaping',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223097,'collusion',1048601,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223098,'diversion',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223099,'speed_surge',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223100,'life_surge',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223101,'speed_sap',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223102,'life_sap',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223103,'farshot',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223104,'quelling_strike',1041,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223105,'raging_strike',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223106,'hawks_eye',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223107,'subtle_release',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223108,'decoy',4113,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223109,'profundity',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223110,'trance_chant',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223111,'roaming_soul',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223112,'purge',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223113,'spiritsong',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223114,'resonance',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223115,'soughspeak',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223116,'sanguine_rite',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223117,'punishing_barbs',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223118,'dark_seal',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223119,'emulate',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223120,'paradigm_shift',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223121,'concussive_blow_1',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223122,'scourge',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223123,'concussive_blow_2',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223124,'concussive_blow_3',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223125,'skull_sunder',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223126,'bloodletter_dot',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223127,'bloodletter',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223128,'levinbolt',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223129,'protect',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223130,'shell',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223131,'reraise',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223132,'shock_spikes',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223133,'stoneskin',16393,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223134,'bio',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223135,'dia',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223136,'banish',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223137,'stygian_spikes',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223138,'attack_absorb_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223139,'defense_absorb_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223140,'accuracy_absorb_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223141,'evasion_absorb_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223142,'attack_absorb',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223143,'defense_absorb',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223144,'accuracy_absorb',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223145,'evasion_absorb',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223146,'soul_ward',9,2,0,0,0,0,30328,30331);
-- Elemental DoTs
INSERT INTO "server_statuseffects" VALUES (223147,'burn',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223148,'frost',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223149,'shock',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223150,'drown',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223151,'choke',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223152,'rasp',21,2,3000,0,0,0,30335,30338);
-- Nuke enhancements
INSERT INTO "server_statuseffects" VALUES (223153,'flare',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223154,'freeze',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223155,'burst',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223156,'flood',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223157,'tornado',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223158,'quake',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223159,'berserking',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223160,'regimen_ruin',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223161,'regimen_trauma',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223162,'regimen_despair',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223163,'regimen_constraint',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223164,'weakness',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223165,'scavenge',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223166,'fastcast',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223167,'midnight_howl',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223168,'outlast',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223169,'steadfast',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223170,'double_nock',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223171,'triple_nock',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223172,'perfect_dodge',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223173,'covered',4105,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223174,'expert_mining',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223175,'expert_logging',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223176,'expert_harvesting',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223177,'expert_fishing',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223178,'expert_spearfishing',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223180,'regen',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223181,'refresh',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223182,'regain',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223183,'tp_bleed',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223184,'empowered',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223185,'imperiled',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223186,'adept',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223187,'inept',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223188,'quickened',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223190,'wrist_flick',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223191,'glossolalia',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223192,'sonorous_blast',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223193,'comradery',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223194,'strength_in_numbers',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223196,'brink_of_death',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223197,'crafters_grace',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223198,'gatherers_grace',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223199,'rebirth',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223200,'stealth',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223201,'stealth_II',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223202,'stealth_III',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223203,'stealth_IV',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223205,'combo',21,2,0,0,1,0,0,30331);
INSERT INTO "server_statuseffects" VALUES (223206,'goring_blade',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223207,'berserk2',537936145,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223208,'rampage2',538984721,1,5000,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223209,'fists_of_fire',536872209,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223210,'fists_of_earth',536872209,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223211,'fists_of_wind',536872209,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223212,'power_surge_I',1297,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223213,'power_surge_II',1297,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223214,'power_surge_III',1297,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223215,'life_surge_I',1048857,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223216,'life_surge_II',1048857,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223217,'life_surge_III',1048857,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223218,'dread_spike',16649,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223219,'blood_for_blood',8209,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223220,'barrage',3081,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223221,'raging_strike2',537985297,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223224,'swiftsong',137,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223225,'sacred_prism',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223226,'shroud_of_saints',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223227,'cleric_stance',8209,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223228,'blissful_mind',536871185,1,1000,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223229,'dark_seal2',1033,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223230,'resonance2',2569,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223231,'excruciate',2098185,2,3000,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223232,'necrogenesis',1048585,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223233,'parsimony',1049097,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223234,'sanguine_rite2',16393,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223235,'aero',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223236,'outmaneuver2',524313,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223237,'blindside2',8209,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223238,'decoy2',4113,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223239,'protect2',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223240,'sanguine_rite3',16393,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223241,'bloodletter2',21,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223242,'fully_blissful_mind',536871185,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223243,'magic_evasion_down',9,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223244,'hundred_fists',257,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223245,'spinning_heel',9,1,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223248,'divine_veil',36889,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223249,'hallowed_ground',36889,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223250,'vengeance',16401,1,5000,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223251,'antagonize',1048601,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223252,'mighty_strikes',8209,1,3000,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223253,'battle_voice',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223254,'ballad_of_magi',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223255,'paeon_of_war',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223256,'minuet_of_rigor',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223258,'gold_lung',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223259,'goldbile',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223260,'aurum_veil',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223261,'aurum_veil_II',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223263,'resting',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223264,'divine_regen',9,2,0,0,0,0,30328,30331);
-- Food/potion stat effects
INSERT INTO "server_statuseffects" VALUES (223265,'defense_evasion_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223266,'magic_defense_evasion_up',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223267,'attack_up_food',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223268,'magic_potency_up_food',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223269,'defense_evasion_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223270,'magic_defense_evasion_down',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223271,'poison_dot',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223272,'deep_burn',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (223273,'lunar_curtain',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223274,'defense_up_food',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223275,'gc_sanction',9,2,0,0,0,0,30328,30331);
-- Quest/misc
INSERT INTO "server_statuseffects" VALUES (223994,'medicated',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (223998,'well_fed',9,2,0,0,0,0,30328,30331);
-- Sleep variant
INSERT INTO "server_statuseffects" VALUES (225010,'sleep_npc',264273941,2,0,0,0,0,30335,30338);
-- Crowd control
INSERT INTO "server_statuseffects" VALUES (228001,'sleep',264273941,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (228011,'bind',67108885,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (228013,'heavy_npc',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (228021,'heavy',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (228031,'flee',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (228041,'doom',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (228051,'synthesis_support',9,2,0,0,0,0,30328,30331);
-- Crafting/gathering facility access
INSERT INTO "server_statuseffects" VALUES (230001,'woodyard_access',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (230002,'smiths_forge_access',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (230003,'armorers_forge_access',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (230004,'gemmary_access',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (230005,'tannery_access',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (230006,'clothshop_access',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (230007,'laboratory_access',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (230008,'cookery_access',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (230009,'miners_support',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (230010,'botanists_support',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (230011,'fishers_support',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (230012,'gear_change',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (230013,'gear_damage',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (230014,'heavy_gear_damage',21,2,0,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (230015,'lamed',21,2,0,0,0,0,30335,30338);
-- NPC combat effects
INSERT INTO "server_statuseffects" VALUES (231001,'poison_npc',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (231002,'envenom',21,2,3000,0,0,0,30335,30338);
INSERT INTO "server_statuseffects" VALUES (231003,'berserk_npc',21,2,0,0,0,0,30335,30338);
-- Special
INSERT INTO "server_statuseffects" VALUES (253001,'guardians_aspect',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (253002,'training',9,2,0,0,0,0,30328,30331);
INSERT INTO "server_statuseffects" VALUES (300000,'evade_proc',273,1,0,1,1,1,0,30331);
INSERT INTO "server_statuseffects" VALUES (300001,'block_proc',273,1,0,1,1,1,0,30331);
INSERT INTO "server_statuseffects" VALUES (300002,'parry_proc',273,1,0,1,1,1,0,30331);
INSERT INTO "server_statuseffects" VALUES (300003,'miss_proc',273,1,0,1,1,1,0,30331);
INSERT INTO "server_statuseffects" VALUES (300004,'expchain',273,1,0,1,1,1,0,30331);

-- Dump completed on 2019-06-05 18:56:07
