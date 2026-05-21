<sup>[English](README.md) · **Español**</sup>

# Meteor Reborn

Servidor emulador de **FINAL FANTASY XIV 1.0 (versión 1.23b)** — port de
[Project Meteor](https://bitbucket.org/Ioncannon/project-meteor-server) a un stack
moderno con .NET 10, PostgreSQL y Docker.

PM era un proyecto abandonado en 2019. Meteor Reborn lo revive y lo lleva a un
entorno reproducible: levantas todo con `docker compose up` y te conectas con un
cliente 1.23b parcheado.

## Arquitectura

Cuatro servicios + base de datos, todos en Docker:

| Servicio   | Puerto | Rol                                                        |
|------------|--------|------------------------------------------------------------|
| `postgres` | 5432   | Base de datos PostgreSQL 17                                |
| `login`    | 17743  | HTTP server para crear cuentas y sesiones (MR-original)    |
| `lobby`    | 54994  | Selección de personajes, handshake Blowfish                |
| `world`    | 54992  | Router de zonas, partidas, linkshells                      |
| `map`      | 1989   | Game logic, NPCs, combate, Lua scripting                   |

Flujo del cliente:

```
Launcher  →  Login HTTP (account + sessionId)
          →  ffxivgame.exe  →  Lobby (TCP+Blowfish)
                            →  World  ↔  Map
```

## Prerequisitos

- **PostgreSQL 17** (Docker lo bundlea; si vas modo "sin Docker", instálalo
  aparte y crea una base `meteor` con usuario `meteor` / pass `meteor`).
- **Docker Desktop** (Windows o Linux) — *recomendado*. Alternativa: ejecutar
  los servicios directamente con `dotnet run` (ver sección "Sin Docker").
- **.NET 10 SDK** — siempre necesario si compilas el launcher; obligatorio
  también en modo "sin Docker" para los 4 servidores.
- **Cliente FFXIV 1.x instalado** en tu PC (cualquier versión entre 2010-09 y
  2012-09 — el launcher parchea hasta 1.23b si está outdated).

> El proyecto NO distribuye el cliente base. Tienes que tener tu propia copia
> instalada. El launcher solo aplica los `.patch` oficiales sobre tu install.

## Quick start (con Docker — recomendado)

### 1. Levantar el server

```bash
git clone <repo>
cd "Meteor Reborn"
docker compose up -d
```

Esto crea:
- Volumen `meteorreborn_postgres-data` con la base de datos inicializada (~65 SQL
  dumps + migraciones automáticas para tipos boolean y lowercase columns).
- 4 containers `.NET 10` corriendo lobby/world/map/login.

Verifica que todo está arriba:

```bash
docker compose ps
```

## Sin Docker (modo nativo)

Si prefieres no usar Docker, instala Postgres aparte y arranca cada servicio
con `dotnet run`.

### 1. Postgres + carga de schema

Instala PostgreSQL 17 desde
[postgresql.org/download](https://www.postgresql.org/download/) y crea la DB:

```bash
psql -U postgres -c "CREATE USER meteor WITH PASSWORD 'meteor';"
psql -U postgres -c "CREATE DATABASE meteor OWNER meteor;"
```

Carga los 65 dumps + migraciones (orden alfabético es importante: los `zz_*`
deben correr al final):

```bash
cd "Meteor Reborn/data/sql"
for f in $(ls *.sql | sort); do
  psql -U meteor -d meteor -f "$f"
done
```

### 2. Configura los `.ini` para apuntar a Postgres local

Edita `data/config/*.ini` (4 archivos: `login_config.ini`, `lobby_config.ini`,
`map_config.ini`, `world_config.ini`) y cambia `host=postgres` por
`host=127.0.0.1`. Para `map_config.ini` cambia también `server_ip=map` por
`server_ip=127.0.0.1` (y haz lo mismo en la DB:
`UPDATE server_zones SET serverip='127.0.0.1';`
`UPDATE servers SET address='127.0.0.1';`).

Copia los `.ini` al cwd que vayas a usar para lanzar cada servicio (cada uno
busca su `*_config.ini` en el directorio actual).

### 3. Arranca los 4 servicios

En 4 terminales separadas:

```bash
# Terminal 1 — Login (:17743)
cd src/MeteorReborn.Login
cp ../../data/config/login_config.ini .
dotnet run -c Release

# Terminal 2 — Lobby (:54994)
cd src/MeteorReborn.Lobby
cp ../../data/config/lobby_config.ini .
dotnet run -c Release

# Terminal 3 — World (:54992)
cd src/MeteorReborn.World
cp ../../data/config/world_config.ini .
dotnet run -c Release

# Terminal 4 — Map (:1989)
cd src/MeteorReborn.Map
cp ../../data/config/map_config.ini .
cp ../../data/staticactors.bin .
cp -r ../../data/scripts .
dotnet run -c Release
```

A partir de aquí el launcher funciona igual que en modo Docker.

### 2. Compilar y abrir el launcher

(Mismo paso en modo Docker o sin Docker.)

```bash
cd tools/MeteorReborn.Launcher
dotnet build -c Release
.\bin\Release\net10.0-windows\MeteorReborn.Launcher.exe
```

En el launcher:

- **Game path**: ruta a tu carpeta FFXIV (donde está `ffxivgame.exe`).
- **Login server**: `http://127.0.0.1:17743` (default).
- **Lobby server**: `127.0.0.1:54994` (default).
- **Patch source**: carpeta local para los `.patch` (default
  `.\Meteor Reborn\data\clientPatch`). Si falta algún patch, el launcher lo
  descarga del **Patch URL base** (default
  `http://ffxivpatches.s3.amazonaws.com/`).

Pasos:

1. **Create account** — usa el formulario para registrarte (POST `/api/account`
   contra el Login server).
2. **PLAY** — el launcher revisa tu `game.ver`. Si no es 1.23b te pregunta si
   actualizar; si aceptas baja y aplica los 49 patches (~5 GB). Cuando termina,
   spawnea `ffxivgame.exe` parcheado en memoria (`LobbyHostNameRva` +
   `EncryptionTimePatchRva`) y se conecta al lobby.

## Configuración

Todos los archivos de configuración viven en **`./Meteor Reborn/data/config/`**:

```
data/config/
├── login_config.ini   # Login HTTP (:17743) + credenciales DB
├── lobby_config.ini   # Lobby TCP (:54994) + credenciales DB
├── map_config.ini     # Map TCP (:1989) + credenciales DB
└── world_config.ini   # World TCP (:54992) + credenciales DB
```

### Credenciales DB

Por defecto los 4 servicios usan `meteor:meteor@<host>:5432/meteor` (host=
`postgres` en Docker, `127.0.0.1` en modo nativo). Cambia las credenciales en
los 4 `*.ini` antes de levantar el server.

### Hostnames

- **Modo Docker**: los servicios se ven entre sí por nombre (`map`, `world`,
  `postgres`). El cliente FFXIV se conecta vía `127.0.0.1` (port-forward del host).
  `server_zones.serverip = 'map'` permite que **world** encuentre el game server
  vía DNS interna del docker network.
- **Modo nativo**: todo es `127.0.0.1`. Asegúrate de hacer el `UPDATE
  server_zones SET serverip='127.0.0.1'` después de cargar los dumps.

### Acceso directo a la DB

```bash
docker exec -it meteorreborn-postgres psql -U meteor -d meteor
```

Tablas relevantes:
- `users` / `sessions` — login server
- `characters` / `characters_appearance` — personajes
- `server_zones` / `server_spawn_locations` — mundo
- `gamedata_*` — referencia (items, NPCs, equipo, achievements)

## Estructura de carpetas

```
Meteor Reborn/
├── docker-compose.yml        # postgres + login + lobby + world + map
├── Dockerfile                # build multi-stage parametrizable por PROJECT
├── README.md                 # English (default) / README.es.md (este archivo)
├── MeteorReborn.sln
├── src/
│   ├── MeteorReborn.Common/  # Wire format, Blowfish, ZLib, utils
│   ├── MeteorReborn.Login/   # HTTP server (FINISH-PM, MR-original)
│   ├── MeteorReborn.Lobby/   # TCP server :54994
│   ├── MeteorReborn.World/   # TCP server :54992 (router)
│   └── MeteorReborn.Map/     # TCP server :1989 (gameplay)
├── tests/
│   └── MeteorReborn.Common.Tests/
├── tools/
│   └── MeteorReborn.Launcher/   # WPF .NET 10 — auth + patcher + game launch
└── data/
    ├── sql/                  # 65 dumps PM + 2 migraciones (zz_*)
    ├── scripts/              # Lua del map server (commands, quests, NPCs)
    ├── config/               # *.ini para cada servicio
    └── clientPatch/          # cache de .patch descargados (auto-creado)
```

## Estado actual

Lo que ya funciona end-to-end:

- Stack docker estable (postgres healthy + 4 servidores escuchando).
- Launcher: create account, login HTTP, version check, descarga + aplicación de
  los 49 patches FFXIV hasta 1.23b, spawn de `ffxivgame.exe` parcheado en memoria.
- Lobby: selección + creación de personajes, handshake con world.
- World ↔ Map: TCP cluster cross-container vía docker service DNS.
- Map: load de 2414 actors, 8403 items, 624 guildleves, 82 zonas, 976 spawns,
  151 battle commands, 77 traits.

Limitaciones conocidas:

- **Zone-in incompleto**: el cliente entra al world pero map no envía toda la
  cadena de packets de zone-in (SetMap/SetMusic/SetWeather + spawn player). Se
  desconecta tras ~12s.
- **Pocos monsters de fábrica**: los SQL dumps de PM solo traen 7 spawn
  locations (5 scripted + 2 normal en Central Thanalan). Para tener más
  enemigos hay que insertar entries en `server_battlenpc_*` manualmente.
- **Lua scripts incompletos**: PM tenía partes sin terminar. El parche del
  GM command `!spawn` desactiva una llamada muerta a `actor.SetAppearance` que
  NLua silenciaba pero MoonSharp rechaza.

## Cómo se hizo el port

PM original corre sobre .NET Framework + MySQL + NLua + Mono. Meteor Reborn lo
lleva a .NET 10 + PostgreSQL + Npgsql + MoonSharp + Serilog, manteniendo la
capa de bytes del wire idéntica a PM (los packets que recibe el cliente 1.23b
son byte-exactos).

Cada cambio sobre PM se clasifica en una de estas categorías (mira los
comentarios `// PM-...` y `// FINISH-PM` en el código para localizarlas):

- **PM-COMPLETE** — port verbatim, citando `// PM file:line`.
- **PM-INCOMPLETE** — PM tenía la lógica empezada; MR la termina.
- **PM-MISSING** — PM no la implementó pero el cliente 1.23b la pide; MR la
  añade marcada `FINISH-PM` (ejemplo: el HTTP login server).
- **LANG-ADAPT** — adaptación de stack (MySQL → Postgres, NLua → MoonSharp,
  nullable C#), aplicada solo cuando el comportamiento observable es idéntico.

Si quieres contribuir o leer código, esos prefijos te dicen rápido si lo que
ves es PM original, una adaptación de lenguaje, o algo añadido por MR.

## Créditos

- **[Project Meteor](https://bitbucket.org/Ioncannon/project-meteor-server)**
  por Ioncannon y contribuidores — código base del servidor (AGPL-3.0).
- **[Seventh Umbral Launcher](https://github.com/jpd002/SeventhUmbral)** por
  jpd002 — referencia del formato de parche FFXIV (ZIPATCH) y URLs S3 de los
  patches oficiales.
- **Square Enix** — FINAL FANTASY XIV 1.x. Este es un servidor emulador
  educacional; no se redistribuye contenido del cliente.

## Licencia

AGPL-3.0 (heredada de Project Meteor). Mira [LICENSE](LICENSE) si está
presente o el repo de PM original para texto completo.
