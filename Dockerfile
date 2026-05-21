# LANG-ADAPT (PM-MISSING — PM no tiene Dockerfile, MR-original infrastructure).
# Multi-stage build parametrizable por proyecto. Uso: `docker build --build-arg PROJECT=MeteorReborn.Login .`
#
# Proyectos soportados:
#   MeteorReborn.Login  (FINISH-PM, HTTP server :17743)  → aspnet runtime
#   MeteorReborn.Lobby  (PM Lobby Server, TCP :54994)     → runtime
#   MeteorReborn.Map    (PM Map Server, TCP :1989)        → runtime
#   MeteorReborn.World  (PM World Server, TCP :54992)     → runtime

ARG DOTNET_SDK_TAG=10.0
ARG DOTNET_RUNTIME_TAG=10.0

# ── Build stage ─────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/sdk:${DOTNET_SDK_TAG} AS build
WORKDIR /src

# Copy sln + all csproj first for restore layer caching.
COPY MeteorReborn.sln ./
COPY src/MeteorReborn.Common/MeteorReborn.Common.csproj src/MeteorReborn.Common/
COPY src/MeteorReborn.Login/MeteorReborn.Login.csproj   src/MeteorReborn.Login/
COPY src/MeteorReborn.Lobby/MeteorReborn.Lobby.csproj   src/MeteorReborn.Lobby/
COPY src/MeteorReborn.Map/MeteorReborn.Map.csproj       src/MeteorReborn.Map/
COPY src/MeteorReborn.World/MeteorReborn.World.csproj   src/MeteorReborn.World/
COPY tests/MeteorReborn.Common.Tests/MeteorReborn.Common.Tests.csproj tests/MeteorReborn.Common.Tests/
RUN dotnet restore MeteorReborn.sln

# Copy the rest and publish the target project.
COPY src/ src/
ARG PROJECT
RUN test -n "$PROJECT" || (echo "ERROR: pass --build-arg PROJECT=MeteorReborn.{Login|Lobby|Map|World}" && exit 1)
RUN dotnet publish src/${PROJECT}/${PROJECT}.csproj \
    -c Release \
    -o /app/publish \
    --no-restore

# ── Runtime stage ───────────────────────────────────────────────────────────
# Login is ASP.NET Core (web), needs aspnet runtime. Others use plain runtime.
# We use the aspnet image for ALL to keep one stage path; aspnet image is a superset.
FROM mcr.microsoft.com/dotnet/aspnet:${DOTNET_RUNTIME_TAG} AS runtime
WORKDIR /app

# Copy published binaries
COPY --from=build /app/publish ./

# Copy config files to /app (each server looks for its *_config.ini in cwd).
COPY data/config/login_config.ini ./login_config.ini
COPY data/config/lobby_config.ini ./lobby_config.ini
COPY data/config/map_config.ini   ./map_config.ini
COPY data/config/world_config.ini ./world_config.ini

# Map server runtime data (./staticactors.bin + ./scripts/...).
# Copied into every image (cheap, simplifies Dockerfile vs per-PROJECT branching).
COPY data/staticactors.bin ./staticactors.bin
COPY data/scripts ./scripts

ARG PROJECT
ENV PROJECT_DLL=${PROJECT}.dll
ENTRYPOINT ["sh", "-c", "exec dotnet $PROJECT_DLL"]
