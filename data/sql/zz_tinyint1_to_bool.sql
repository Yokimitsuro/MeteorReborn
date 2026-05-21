-- LANG-ADAPT (MySQL→Postgres): PM stored boolean-semantic columns as tinyint(1).
-- MySqlConnector reads tinyint(1) as Boolean (`reader.GetBoolean(ord)` works).
-- Our Postgres dumps converted tinyint(1)→smallint which Npgsql refuses to coerce to bool.
-- Convert affected columns to native boolean so PM call-sites `reader.GetBoolean(ord)` remain verbatim.
--
-- Filename prefix `zz_tinyint1` runs AFTER `zz_lowercase_cols` alphabetically, so columns are
-- already lowercase by the time we hit this script.
--
-- Pattern: DROP DEFAULT → ALTER TYPE bool → re-set DEFAULT as boolean literal.

ALTER TABLE characters_chocobo               ALTER COLUMN haschocobo DROP DEFAULT;
ALTER TABLE characters_chocobo               ALTER COLUMN haschocobo TYPE boolean USING (haschocobo::int <> 0);
ALTER TABLE characters_chocobo               ALTER COLUMN haschocobo SET DEFAULT false;

ALTER TABLE characters_chocobo               ALTER COLUMN hasgoobbue DROP DEFAULT;
ALTER TABLE characters_chocobo               ALTER COLUMN hasgoobbue TYPE boolean USING (hasgoobbue::int <> 0);
ALTER TABLE characters_chocobo               ALTER COLUMN hasgoobbue SET DEFAULT false;

ALTER TABLE characters_npclinkshell          ALTER COLUMN iscalling DROP DEFAULT;
ALTER TABLE characters_npclinkshell          ALTER COLUMN iscalling TYPE boolean USING (iscalling::int <> 0);
ALTER TABLE characters_npclinkshell          ALTER COLUMN iscalling SET DEFAULT false;

ALTER TABLE characters_npclinkshell          ALTER COLUMN isextra DROP DEFAULT;
ALTER TABLE characters_npclinkshell          ALTER COLUMN isextra TYPE boolean USING (isextra::int <> 0);
ALTER TABLE characters_npclinkshell          ALTER COLUMN isextra SET DEFAULT false;

ALTER TABLE characters_quest_guildleve_local    ALTER COLUMN abandoned DROP DEFAULT;
ALTER TABLE characters_quest_guildleve_local    ALTER COLUMN abandoned TYPE boolean USING (abandoned::int <> 0);
ALTER TABLE characters_quest_guildleve_local    ALTER COLUMN abandoned SET DEFAULT false;

ALTER TABLE characters_quest_guildleve_local    ALTER COLUMN completed DROP DEFAULT;
ALTER TABLE characters_quest_guildleve_local    ALTER COLUMN completed TYPE boolean USING (completed::int <> 0);
ALTER TABLE characters_quest_guildleve_local    ALTER COLUMN completed SET DEFAULT false;

ALTER TABLE characters_quest_guildleve_regional ALTER COLUMN abandoned DROP DEFAULT;
ALTER TABLE characters_quest_guildleve_regional ALTER COLUMN abandoned TYPE boolean USING (abandoned::int <> 0);
ALTER TABLE characters_quest_guildleve_regional ALTER COLUMN abandoned SET DEFAULT false;

ALTER TABLE characters_quest_guildleve_regional ALTER COLUMN completed DROP DEFAULT;
ALTER TABLE characters_quest_guildleve_regional ALTER COLUMN completed TYPE boolean USING (completed::int <> 0);
ALTER TABLE characters_quest_guildleve_regional ALTER COLUMN completed SET DEFAULT false;

ALTER TABLE characters_retainers             ALTER COLUMN dorename DROP DEFAULT;
ALTER TABLE characters_retainers             ALTER COLUMN dorename TYPE boolean USING (dorename::int <> 0);
ALTER TABLE characters_retainers             ALTER COLUMN dorename SET DEFAULT false;

ALTER TABLE gamedata_items                   ALTER COLUMN israre              TYPE boolean USING (israre::int <> 0);
ALTER TABLE gamedata_items                   ALTER COLUMN isexclusive         TYPE boolean USING (isexclusive::int <> 0);
ALTER TABLE gamedata_items_equipment         ALTER COLUMN materiabindpermission TYPE boolean USING (materiabindpermission::int <> 0);

ALTER TABLE server_battlenpc_genus_mods      ALTER COLUMN ismobmod DROP DEFAULT;
ALTER TABLE server_battlenpc_genus_mods      ALTER COLUMN ismobmod TYPE boolean USING (ismobmod::int <> 0);
ALTER TABLE server_battlenpc_genus_mods      ALTER COLUMN ismobmod SET DEFAULT false;

ALTER TABLE server_battlenpc_pool_mods       ALTER COLUMN ismobmod DROP DEFAULT;
ALTER TABLE server_battlenpc_pool_mods       ALTER COLUMN ismobmod TYPE boolean USING (ismobmod::int <> 0);
ALTER TABLE server_battlenpc_pool_mods       ALTER COLUMN ismobmod SET DEFAULT false;

ALTER TABLE server_battlenpc_spawn_mods      ALTER COLUMN ismobmod DROP DEFAULT;
ALTER TABLE server_battlenpc_spawn_mods      ALTER COLUMN ismobmod TYPE boolean USING (ismobmod::int <> 0);
ALTER TABLE server_battlenpc_spawn_mods      ALTER COLUMN ismobmod SET DEFAULT false;

ALTER TABLE server_zones                     ALTER COLUMN isisolated DROP DEFAULT;
ALTER TABLE server_zones                     ALTER COLUMN isisolated TYPE boolean USING (isisolated::int <> 0);
ALTER TABLE server_zones                     ALTER COLUMN isisolated SET DEFAULT false;

ALTER TABLE server_zones                     ALTER COLUMN isinn DROP DEFAULT;
ALTER TABLE server_zones                     ALTER COLUMN isinn TYPE boolean USING (isinn::int <> 0);
ALTER TABLE server_zones                     ALTER COLUMN isinn SET DEFAULT false;

ALTER TABLE server_zones                     ALTER COLUMN canridechocobo DROP DEFAULT;
ALTER TABLE server_zones                     ALTER COLUMN canridechocobo TYPE boolean USING (canridechocobo::int <> 0);
ALTER TABLE server_zones                     ALTER COLUMN canridechocobo SET DEFAULT true;

ALTER TABLE server_zones                     ALTER COLUMN canstealth DROP DEFAULT;
ALTER TABLE server_zones                     ALTER COLUMN canstealth TYPE boolean USING (canstealth::int <> 0);
ALTER TABLE server_zones                     ALTER COLUMN canstealth SET DEFAULT false;

ALTER TABLE server_zones                     ALTER COLUMN isinstanceraid DROP DEFAULT;
ALTER TABLE server_zones                     ALTER COLUMN isinstanceraid TYPE boolean USING (isinstanceraid::int <> 0);
ALTER TABLE server_zones                     ALTER COLUMN isinstanceraid SET DEFAULT false;

ALTER TABLE server_zones                     ALTER COLUMN loadnavmesh TYPE boolean USING (loadnavmesh::int <> 0);
ALTER TABLE servers                          ALTER COLUMN isactive    TYPE boolean USING (isactive::int <> 0);

ALTER TABLE supportdesk_tickets              ALTER COLUMN isopen DROP DEFAULT;
ALTER TABLE supportdesk_tickets              ALTER COLUMN isopen TYPE boolean USING (isopen::int <> 0);
ALTER TABLE supportdesk_tickets              ALTER COLUMN isopen SET DEFAULT true;
