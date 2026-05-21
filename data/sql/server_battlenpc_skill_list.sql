-- MySQL dump 10.13  Distrib 5.7.18, for Win64 (x86_64)
--
-- Host: localhost    Database: ffxiv_server

-- Server version	5.7.18-log

--
-- Table structure for server_battlenpc_skill_list
--

DROP TABLE IF EXISTS "server_battlenpc_skill_list" CASCADE;
CREATE TABLE "server_battlenpc_skill_list" (
  "skillListId" bigint NOT NULL DEFAULT '0',
  "skillId" bigint NOT NULL DEFAULT '0',
  PRIMARY KEY ("skillListId", "skillId")
) ;

--
-- Dumping data for table "server_battlenpc_skill_list"
--

-- Monster Skill Lists - Using REAL monster ability IDs (23xxx)
-- Extracted from FFXIV 1.0 client xtx/command data
-- skillListId corresponds to pool table references

-- Skill List 1: Wolf (genus 3)
INSERT INTO "server_battlenpc_skill_list" VALUES (1, 23138);  -- piercing_din
INSERT INTO "server_battlenpc_skill_list" VALUES (1, 23139);  -- corrosive_spit
INSERT INTO "server_battlenpc_skill_list" VALUES (1, 23140);  -- brain_spike
INSERT INTO "server_battlenpc_skill_list" VALUES (1, 23142);  -- midnight_howl
INSERT INTO "server_battlenpc_skill_list" VALUES (1, 23143);  -- threatening_growl
INSERT INTO "server_battlenpc_skill_list" VALUES (1, 23144);  -- foul_bite

-- Skill List 2: Raptor (genus 32)
INSERT INTO "server_battlenpc_skill_list" VALUES (2, 23021);  -- vorpal_roar
INSERT INTO "server_battlenpc_skill_list" VALUES (2, 23029);  -- ripper_fang
INSERT INTO "server_battlenpc_skill_list" VALUES (2, 23031);  -- scythe_tail

-- Skill List 3: Cactuar (genus 13)
INSERT INTO "server_battlenpc_skill_list" VALUES (3, 23146);  -- needleshot
INSERT INTO "server_battlenpc_skill_list" VALUES (3, 23147);  -- 1000_needles
INSERT INTO "server_battlenpc_skill_list" VALUES (3, 23148);  -- tender_thrust
INSERT INTO "server_battlenpc_skill_list" VALUES (3, 23149);  -- sun_spines

-- Skill List 4: Ogre (genus 60)
INSERT INTO "server_battlenpc_skill_list" VALUES (4, 23041);  -- double_smash
INSERT INTO "server_battlenpc_skill_list" VALUES (4, 23042);  -- elbow_drop
INSERT INTO "server_battlenpc_skill_list" VALUES (4, 23044);  -- bone_breaker
INSERT INTO "server_battlenpc_skill_list" VALUES (4, 23045);  -- booming_bellow

-- Skill List 5: Goblin (genus 26)
INSERT INTO "server_battlenpc_skill_list" VALUES (5, 23310);  -- ranged_attack (goblin)
INSERT INTO "server_battlenpc_skill_list" VALUES (5, 23311);  -- bomb_toss
INSERT INTO "server_battlenpc_skill_list" VALUES (5, 23313);  -- hail_mary

-- Skill List 6: Opo-opo (genus 4)
INSERT INTO "server_battlenpc_skill_list" VALUES (6, 23009);  -- nutkick
INSERT INTO "server_battlenpc_skill_list" VALUES (6, 23010);  -- somersault_slash
INSERT INTO "server_battlenpc_skill_list" VALUES (6, 23013);  -- regurgitate

-- Skill List 7: Bomb (genus 64)
INSERT INTO "server_battlenpc_skill_list" VALUES (7, 23032);  -- fireball
INSERT INTO "server_battlenpc_skill_list" VALUES (7, 23033);  -- self_destruct
INSERT INTO "server_battlenpc_skill_list" VALUES (7, 23034);  -- combustion

-- Skill List 8: Flying-trap (genus 15)
INSERT INTO "server_battlenpc_skill_list" VALUES (8, 23037);  -- tendril_spines
INSERT INTO "server_battlenpc_skill_list" VALUES (8, 23038);  -- binding_tendrils
INSERT INTO "server_battlenpc_skill_list" VALUES (8, 23039);  -- numbing_tendrils
INSERT INTO "server_battlenpc_skill_list" VALUES (8, 23040);  -- firespit

-- Skill List 9: Bat (genus 43)
INSERT INTO "server_battlenpc_skill_list" VALUES (9, 23047);  -- guano_lob
INSERT INTO "server_battlenpc_skill_list" VALUES (9, 23048);  -- ultrasonics
INSERT INTO "server_battlenpc_skill_list" VALUES (9, 23049);  -- blood_drain

-- Skill List 10: Boar (genus 9)
INSERT INTO "server_battlenpc_skill_list" VALUES (10, 23154);  -- snort
INSERT INTO "server_battlenpc_skill_list" VALUES (10, 23155);  -- reckless_charge
INSERT INTO "server_battlenpc_skill_list" VALUES (10, 23157);  -- bellowing_grunt

-- Skill List 11: Dodo (genus 42)
INSERT INTO "server_battlenpc_skill_list" VALUES (11, 23083);  -- beak_snap
INSERT INTO "server_battlenpc_skill_list" VALUES (11, 23084);  -- bombardier

-- Skill List 12: Ladybug/Swarm (genus 34/38)
INSERT INTO "server_battlenpc_skill_list" VALUES (12, 23085);  -- spoil
INSERT INTO "server_battlenpc_skill_list" VALUES (12, 23086);  -- seedvolley
INSERT INTO "server_battlenpc_skill_list" VALUES (12, 23088);  -- seedspray

-- Skill List 13: Mole (genus 11)
INSERT INTO "server_battlenpc_skill_list" VALUES (13, 23073);  -- reaching_scratch
INSERT INTO "server_battlenpc_skill_list" VALUES (13, 23076);  -- soil_smear

-- Skill List 14: Rodent (genus 12) - basic melee, uses simple attack variants
INSERT INTO "server_battlenpc_skill_list" VALUES (14, 23069);  -- prickle (repurposed for rodent)

-- Skill List 15: Buffalo/Yak (genus 8)
INSERT INTO "server_battlenpc_skill_list" VALUES (15, 23077);  -- sneeze
INSERT INTO "server_battlenpc_skill_list" VALUES (15, 23078);  -- stampede
INSERT INTO "server_battlenpc_skill_list" VALUES (15, 23079);  -- hoofkick

-- Skill List 16: Ghost (genus 46)
INSERT INTO "server_battlenpc_skill_list" VALUES (16, 23127);  -- dark_cloud
INSERT INTO "server_battlenpc_skill_list" VALUES (16, 23128);  -- curse
INSERT INTO "server_battlenpc_skill_list" VALUES (16, 23129);  -- grave_reel

-- Skill List 17: Funguar (genus 14)
INSERT INTO "server_battlenpc_skill_list" VALUES (17, 23250);  -- slumber_spores
INSERT INTO "server_battlenpc_skill_list" VALUES (17, 23254);  -- queasy_spores
INSERT INTO "server_battlenpc_skill_list" VALUES (17, 23255);  -- hypha_whip

-- Skill List 18: Sprite/Will-O-Wisp (genus 53)
INSERT INTO "server_battlenpc_skill_list" VALUES (18, 23151);  -- aetherial_wave
INSERT INTO "server_battlenpc_skill_list" VALUES (18, 23152);  -- aetherial_barrier
INSERT INTO "server_battlenpc_skill_list" VALUES (18, 23153);  -- aetherial_torrent

-- Skill List 19: Griffin/Hippogryph (genus 44)
INSERT INTO "server_battlenpc_skill_list" VALUES (19, 23294);  -- sticky_web
INSERT INTO "server_battlenpc_skill_list" VALUES (19, 23296);  -- pulverizing_pound
INSERT INTO "server_battlenpc_skill_list" VALUES (19, 23297);  -- onrush
INSERT INTO "server_battlenpc_skill_list" VALUES (19, 23299);  -- sonorous_blast

-- Skill List 20: Amaalja/Lizardman (genus 23)
INSERT INTO "server_battlenpc_skill_list" VALUES (20, 23198);  -- devastate
INSERT INTO "server_battlenpc_skill_list" VALUES (20, 23199);  -- decimate
INSERT INTO "server_battlenpc_skill_list" VALUES (20, 23200);  -- pulverize

-- Skill List 21: Drake/Winglizard (genus 30)
INSERT INTO "server_battlenpc_skill_list" VALUES (21, 23024);  -- sand_breath
INSERT INTO "server_battlenpc_skill_list" VALUES (21, 23025);  -- heavy_stomp
INSERT INTO "server_battlenpc_skill_list" VALUES (21, 23026);  -- body_slam
INSERT INTO "server_battlenpc_skill_list" VALUES (21, 23028);  -- foul_breath

-- Skill List 22: Coeurl (genus 5)
INSERT INTO "server_battlenpc_skill_list" VALUES (22, 23069);  -- prickle
INSERT INTO "server_battlenpc_skill_list" VALUES (22, 23070);  -- hair_ball
INSERT INTO "server_battlenpc_skill_list" VALUES (22, 23317);  -- ranged_attack (coeurl)
INSERT INTO "server_battlenpc_skill_list" VALUES (22, 23321);  -- blaster
INSERT INTO "server_battlenpc_skill_list" VALUES (22, 23322);  -- chaotic_eye

-- Skill List 23: Chigoe (genus 36)
INSERT INTO "server_battlenpc_skill_list" VALUES (23, 23049);  -- blood_drain

-- Skill List 24: Slug (genus 21)
INSERT INTO "server_battlenpc_skill_list" VALUES (24, 23050);  -- digestive_ooze
INSERT INTO "server_battlenpc_skill_list" VALUES (24, 23051);  -- mortal_mist

-- Skill List 25: Megalo-crab (genus 22)
INSERT INTO "server_battlenpc_skill_list" VALUES (25, 23132);  -- brackish_bubble
INSERT INTO "server_battlenpc_skill_list" VALUES (25, 23133);  -- claw_guard
INSERT INTO "server_battlenpc_skill_list" VALUES (25, 23134);  -- bubble_shower

-- Skill List 26: Morbol (genus 16)
INSERT INTO "server_battlenpc_skill_list" VALUES (26, 23281);  -- sour_breath
INSERT INTO "server_battlenpc_skill_list" VALUES (26, 23282);  -- vine_probe
INSERT INTO "server_battlenpc_skill_list" VALUES (26, 23285);  -- bad_breath
INSERT INTO "server_battlenpc_skill_list" VALUES (26, 23290);  -- realm_shaker

-- Skill List 27: Gigantoad (genus 18)
INSERT INTO "server_battlenpc_skill_list" VALUES (27, 23207);  -- flying_sardine
INSERT INTO "server_battlenpc_skill_list" VALUES (27, 23262);  -- sticky_tongue
INSERT INTO "server_battlenpc_skill_list" VALUES (27, 23265);  -- livid_lap

-- Skill List 28: Basilisk (genus 31)
INSERT INTO "server_battlenpc_skill_list" VALUES (28, 23022);  -- cold_gaze
INSERT INTO "server_battlenpc_skill_list" VALUES (28, 23023);  -- stone_gaze
INSERT INTO "server_battlenpc_skill_list" VALUES (28, 23105);  -- basilisk_breath

-- Skill List 29: Grenade (genus 65)
INSERT INTO "server_battlenpc_skill_list" VALUES (29, 23257);  -- agitation
INSERT INTO "server_battlenpc_skill_list" VALUES (29, 23258);  -- stellar_flame
INSERT INTO "server_battlenpc_skill_list" VALUES (29, 23259);  -- blinding_burst
INSERT INTO "server_battlenpc_skill_list" VALUES (29, 23260);  -- innernova

-- Skill List 30: Ant-ring (genus 33)
INSERT INTO "server_battlenpc_skill_list" VALUES (30, 23226);  -- trap_jaws
INSERT INTO "server_battlenpc_skill_list" VALUES (30, 23227);  -- stridulation
INSERT INTO "server_battlenpc_skill_list" VALUES (30, 23228);  -- mandible_bite

-- Skill List 31: Vulture (genus 41)
INSERT INTO "server_battlenpc_skill_list" VALUES (31, 23233);  -- feather_flurry
INSERT INTO "server_battlenpc_skill_list" VALUES (31, 23234);  -- wing_cutter
INSERT INTO "server_battlenpc_skill_list" VALUES (31, 23236);  -- deafening_caw

-- Skill List 32: Sheep (genus 7)
INSERT INTO "server_battlenpc_skill_list" VALUES (32, 23090);  -- bleat
INSERT INTO "server_battlenpc_skill_list" VALUES (32, 23091);  -- head_butt
INSERT INTO "server_battlenpc_skill_list" VALUES (32, 23238);  -- wooly_spindle
INSERT INTO "server_battlenpc_skill_list" VALUES (32, 23239);  -- lullaby

-- Skill List 33: Aldgoat (genus 1)
INSERT INTO "server_battlenpc_skill_list" VALUES (33, 23091);  -- head_butt
INSERT INTO "server_battlenpc_skill_list" VALUES (33, 23092);  -- alpine_fury
INSERT INTO "server_battlenpc_skill_list" VALUES (33, 23093);  -- seismic_scream

-- Skill List 34: Flan (genus 63)
INSERT INTO "server_battlenpc_skill_list" VALUES (34, 23306);  -- glossolalia
INSERT INTO "server_battlenpc_skill_list" VALUES (34, 23307);  -- amorphic_spear
INSERT INTO "server_battlenpc_skill_list" VALUES (34, 23308);  -- custard_cuff

-- Skill List 35: Wight (genus 48)
INSERT INTO "server_battlenpc_skill_list" VALUES (35, 23244);  -- doomwave
INSERT INTO "server_battlenpc_skill_list" VALUES (35, 23245);  -- magicked_skull
INSERT INTO "server_battlenpc_skill_list" VALUES (35, 23246);  -- shadow_sickle

-- Skill List 36: The-Damned (genus 47)
INSERT INTO "server_battlenpc_skill_list" VALUES (36, 23230);  -- stones_throw
INSERT INTO "server_battlenpc_skill_list" VALUES (36, 23231);  -- rot_breath
INSERT INTO "server_battlenpc_skill_list" VALUES (36, 23232);  -- cloud_of_pestilence

-- Skill List 37: Puk (genus 45)
INSERT INTO "server_battlenpc_skill_list" VALUES (37, 23080);  -- gale_switch
INSERT INTO "server_battlenpc_skill_list" VALUES (37, 23081);  -- shriek
INSERT INTO "server_battlenpc_skill_list" VALUES (37, 23082);  -- overtone_shriek

-- Skill List 38: Orobon (genus 17)
INSERT INTO "server_battlenpc_skill_list" VALUES (38, 23060);  -- brine_blast
INSERT INTO "server_battlenpc_skill_list" VALUES (38, 23061);  -- rage_of_the_deep
INSERT INTO "server_battlenpc_skill_list" VALUES (38, 23062);  -- feeding_frenzy

-- Skill List 39: Diremite (genus 35)
INSERT INTO "server_battlenpc_skill_list" VALUES (39, 23073);  -- reaching_scratch
INSERT INTO "server_battlenpc_skill_list" VALUES (39, 23074);  -- drop_kick
INSERT INTO "server_battlenpc_skill_list" VALUES (39, 23075);  -- deep_scratch

-- Skill List 40: Ixal (genus 24)
INSERT INTO "server_battlenpc_skill_list" VALUES (40, 23192);  -- wind_claw
INSERT INTO "server_battlenpc_skill_list" VALUES (40, 23193);  -- updraft
INSERT INTO "server_battlenpc_skill_list" VALUES (40, 23195);  -- swift_gust

-- Skill List 41: Kobold (genus 27)
INSERT INTO "server_battlenpc_skill_list" VALUES (41, 23183);  -- titans_flesh
INSERT INTO "server_battlenpc_skill_list" VALUES (41, 23184);  -- titans_soul
INSERT INTO "server_battlenpc_skill_list" VALUES (41, 23185);  -- titans_anger

-- Skill List 42: Salamander (genus 19)
INSERT INTO "server_battlenpc_skill_list" VALUES (42, 23101);  -- tail_strike
INSERT INTO "server_battlenpc_skill_list" VALUES (42, 23102);  -- frenzied_claw
INSERT INTO "server_battlenpc_skill_list" VALUES (42, 23271);  -- smoulder

-- Skill List 43: Goobbue (genus 6) - uses ogre-adjacent heavy attacks
INSERT INTO "server_battlenpc_skill_list" VALUES (43, 23041);  -- double_smash
INSERT INTO "server_battlenpc_skill_list" VALUES (43, 23046);  -- primal_scream

-- Skill List 44: Antelope (genus 2)
INSERT INTO "server_battlenpc_skill_list" VALUES (44, 23055);  -- breakout
INSERT INTO "server_battlenpc_skill_list" VALUES (44, 23057);  -- cliff_cry
INSERT INTO "server_battlenpc_skill_list" VALUES (44, 23058);  -- backflip

-- Skill List 45: Jelly-fish (genus 20)
INSERT INTO "server_battlenpc_skill_list" VALUES (45, 23066);  -- thunderstrike
INSERT INTO "server_battlenpc_skill_list" VALUES (45, 23097);  -- caterwaul
INSERT INTO "server_battlenpc_skill_list" VALUES (45, 23098);  -- aqueous_discharge

-- Skill List 46: Coblyn (genus 49)
INSERT INTO "server_battlenpc_skill_list" VALUES (46, 23113);  -- mine_dust
INSERT INTO "server_battlenpc_skill_list" VALUES (46, 23114);  -- cluster_geyser
INSERT INTO "server_battlenpc_skill_list" VALUES (46, 23115);  -- sphere_of_cold

-- Skill List 47: Spriggan (genus 50)
INSERT INTO "server_battlenpc_skill_list" VALUES (47, 23122);  -- frenetic_flurry
INSERT INTO "server_battlenpc_skill_list" VALUES (47, 23123);  -- romp
INSERT INTO "server_battlenpc_skill_list" VALUES (47, 23124);  -- triple_tumble

-- Skill List 48: Ahriman (genus 51)
INSERT INTO "server_battlenpc_skill_list" VALUES (48, 23094);  -- level_5_petrify
INSERT INTO "server_battlenpc_skill_list" VALUES (48, 23095);  -- aural_vacuum
INSERT INTO "server_battlenpc_skill_list" VALUES (48, 23244);  -- doomwave

-- Skill List 49: Imp (genus 52)
INSERT INTO "server_battlenpc_skill_list" VALUES (49, 23116);  -- impish_incantations
INSERT INTO "server_battlenpc_skill_list" VALUES (49, 23119);  -- stardust

-- Skill List 50: Qiqirn (genus 25)
INSERT INTO "server_battlenpc_skill_list" VALUES (50, 23203);  -- mud_sling
INSERT INTO "server_battlenpc_skill_list" VALUES (50, 23204);  -- kibosh
INSERT INTO "server_battlenpc_skill_list" VALUES (50, 23205);  -- sandspray
INSERT INTO "server_battlenpc_skill_list" VALUES (50, 23206);  -- misdirection

-- Dump completed
