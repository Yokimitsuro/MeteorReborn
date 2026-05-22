-- LANG-ADAPT (ioncannon/quest_system schema migration).
--
-- PM's `ioncannon/quest_system` branch (commit 89f8ff37) rewrote the
-- characters_quest_scenario columns from the old (currentPhase, questData,
-- questFlags) model to a richer per-quest state with bit-packed flags and
-- 4 counters for objective progress tracking.
--
-- New columns matching the rewrite:
--   sequence      smallint   — current step in the quest (0…65533, or SEQ_NOT_STARTED / SEQ_COMPLETED sentinels)
--   flags         bigint     — bit-packed objective flags (replaces text JSON in questData)
--   counter1..4   integer    — counters for kill/collect objectives etc.
--   npclsfrom     integer    — NPC linkshell ID the quest is associated with
--   npclsmsgstep  smallint   — current NPC linkshell message step
--
-- Old columns are kept (alongside the new ones) so that legacy MR call-sites
-- still using `currentPhase`/`questData`/`questFlags` keep working. Once the
-- full questStateManager wiring lands, drop the old columns.

ALTER TABLE characters_quest_scenario ADD COLUMN IF NOT EXISTS sequence      smallint NOT NULL DEFAULT 0;
ALTER TABLE characters_quest_scenario ADD COLUMN IF NOT EXISTS flags         bigint   NOT NULL DEFAULT 0;
ALTER TABLE characters_quest_scenario ADD COLUMN IF NOT EXISTS counter1      integer  NOT NULL DEFAULT 0;
ALTER TABLE characters_quest_scenario ADD COLUMN IF NOT EXISTS counter2      integer  NOT NULL DEFAULT 0;
ALTER TABLE characters_quest_scenario ADD COLUMN IF NOT EXISTS counter3      integer  NOT NULL DEFAULT 0;
ALTER TABLE characters_quest_scenario ADD COLUMN IF NOT EXISTS counter4      integer  NOT NULL DEFAULT 0;
ALTER TABLE characters_quest_scenario ADD COLUMN IF NOT EXISTS npclsfrom     integer  NOT NULL DEFAULT 0;
ALTER TABLE characters_quest_scenario ADD COLUMN IF NOT EXISTS npclsmsgstep  smallint NOT NULL DEFAULT 0;
