// LANG-ADAPT — namespace globals para tipos comunes que viven en subnamespaces con casing
// lowercase PM-faithful. PM tenía namespaces lowercase (`player`, `npc`, `director`, `state`,
// `group`) y tipos PascalCase, evitando la colisión namespace/tipo. MR replica el mismo
// patrón. Importar globalmente evita escribir el `using` en cada archivo consumidor.
// Comportamiento idéntico a PM.

global using MeteorReborn.Map.Actors.Chara.player;
global using MeteorReborn.Map.Actors.Chara.npc;
global using MeteorReborn.Map.Actors.Chara.Ai.state;
global using MeteorReborn.Map.Actors.director;
global using MeteorReborn.Map.Actors.group;
global using MeteorReborn.Map.Actors.area;

