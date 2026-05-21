-- LANG-ADAPT (compat schema migration).
-- Alt PM (2026-05-22 import) cambió el schema de `server_zones_privateareas` para
-- colapsar `daymusic`/`nightmusic`/`battlemusic` (3 cols) en una sola `music`.
--
-- PM C# code (WorldManager.LoadPrivateAreas) sigue consultando las 3 columnas legacy.
-- Añadimos las 3 columnas y las populamos con el valor de `music`.

ALTER TABLE server_zones_privateareas ADD COLUMN IF NOT EXISTS daymusic   integer NOT NULL DEFAULT 0;
ALTER TABLE server_zones_privateareas ADD COLUMN IF NOT EXISTS nightmusic integer NOT NULL DEFAULT 0;
ALTER TABLE server_zones_privateareas ADD COLUMN IF NOT EXISTS battlemusic integer NOT NULL DEFAULT 0;

UPDATE server_zones_privateareas
SET daymusic = music,
    nightmusic = music,
    battlemusic = music
WHERE music IS NOT NULL;
