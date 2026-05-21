// FINISH-PM: PM-MISSING — PM no tiene Login Server HTTP. PM clientes establecen sesión
// directamente con el Lobby (TCP+Blowfish). MR usa un launcher externo que requiere un
// endpoint HTTP `/api/auth/login` para crear sesiones de 56 chars antes de invocar
// `ffxivgame.exe`. Este servidor es MR-original.
//
// Endpoints:
//   POST /api/account       — crear cuenta (username + password)
//   POST /api/auth/login    — validar credenciales, devolver sessionId
//
// Schema usado: tabla `users` (id, name, passhash, salt, email) + `sessions` (id 56 char,
// userid, expiration). Schema vive en data/sql/users.sql + sessions.sql (PM verbatim).

using System.Security.Cryptography;
using System.Text;
using MeteorReborn.Common;
using Npgsql;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

Log.Logger = new LoggerConfiguration()
    .MinimumLevel.Information()
    .WriteTo.Console()
    .CreateLogger();

builder.Host.UseSerilog();

var app = builder.Build();

// ── Config (lee el mismo lobby_config.ini para reaprovechar credenciales DB) ──
// Si no existe, usa defaults razonables.
string dbHost = "127.0.0.1", dbPort = "5432", dbName = "meteor", dbUser = "meteor", dbPass = "meteor";
try
{
    var ini = new INIFile("./login_config.ini");
    dbHost = ini.GetValue("Database", "host", dbHost);
    dbPort = ini.GetValue("Database", "port", dbPort);
    dbName = ini.GetValue("Database", "database", dbName);
    dbUser = ini.GetValue("Database", "username", dbUser);
    dbPass = ini.GetValue("Database", "password", dbPass);
}
catch
{
    Log.Warning("login_config.ini not found, using defaults host=127.0.0.1 db=meteor");
}

string connStr = $"Host={dbHost}; Port={dbPort}; Database={dbName}; Username={dbUser}; Password={dbPass}";

// Test DB connection on startup
try
{
    using var testConn = new NpgsqlConnection(connStr);
    testConn.Open();
    Log.Information("Login Server DB connection OK ({Host}/{Db})", dbHost, dbName);
}
catch (Exception ex)
{
    Log.Error("DB connection failed: {Msg}", ex.Message);
}

// ── Helpers ──
static string GenerateSessionId()
{
    // 56-char hex token = 28 bytes random
    var bytes = RandomNumberGenerator.GetBytes(28);
    return Convert.ToHexString(bytes).ToLowerInvariant();
}

static string GenerateSalt()
{
    var bytes = RandomNumberGenerator.GetBytes(28);
    return Convert.ToHexString(bytes).ToLowerInvariant();
}

static string HashPassword(string password, string salt)
{
    // PBKDF2-HMAC-SHA256 con 100k iter, 28-byte output → 56 char hex (matches `char(56)` schema)
    using var pbkdf2 = new Rfc2898DeriveBytes(password, Encoding.UTF8.GetBytes(salt), 100_000, HashAlgorithmName.SHA256);
    return Convert.ToHexString(pbkdf2.GetBytes(28)).ToLowerInvariant();
}

// ── Endpoints ──

// POST /api/account — register
app.MapPost("/api/account", async (AccountRequest req) =>
{
    if (string.IsNullOrWhiteSpace(req.Username) || string.IsNullOrWhiteSpace(req.Password))
        return Results.BadRequest(new { error = "username/password required" });

    using var conn = new NpgsqlConnection(connStr);
    await conn.OpenAsync();

    // Check unique username
    using (var check = new NpgsqlCommand("SELECT 1 FROM users WHERE name = @n", conn))
    {
        check.Parameters.AddParam("@n", req.Username);
        if (await check.ExecuteScalarAsync() != null)
            return Results.BadRequest(new { error = "username already exists" });
    }

    var salt = GenerateSalt();
    var passhash = HashPassword(req.Password, salt);

    using var ins = new NpgsqlCommand(
        "INSERT INTO users (name, passhash, salt, email) VALUES (@n, @h, @s, @e) RETURNING id",
        conn);
    ins.Parameters.AddParam("@n", req.Username);
    ins.Parameters.AddParam("@h", passhash);
    ins.Parameters.AddParam("@s", salt);
    ins.Parameters.AddParam("@e", req.Email ?? "");
    var userId = (int)(await ins.ExecuteScalarAsync())!;

    Log.Information("Account created: {User} (id={Id})", req.Username, userId);
    return Results.Ok(new { userId });
});

// POST /api/auth/login — verify and create session
app.MapPost("/api/auth/login", async (LoginRequest req) =>
{
    if (string.IsNullOrWhiteSpace(req.Username) || string.IsNullOrWhiteSpace(req.Password))
        return Results.BadRequest(new { error = "username/password required" });

    using var conn = new NpgsqlConnection(connStr);
    await conn.OpenAsync();

    int userId;
    string storedHash, storedSalt;
    using (var sel = new NpgsqlCommand("SELECT id, passhash, salt FROM users WHERE name = @n", conn))
    {
        sel.Parameters.AddParam("@n", req.Username);
        using var r = await sel.ExecuteReaderAsync();
        if (!await r.ReadAsync())
            return Results.Unauthorized();
        userId = r.GetInt32(0);
        storedHash = r.GetString(1).TrimEnd();
        storedSalt = r.GetString(2).TrimEnd();
    }

    var hashTry = HashPassword(req.Password, storedSalt);
    if (!CryptographicOperations.FixedTimeEquals(
            Encoding.ASCII.GetBytes(hashTry), Encoding.ASCII.GetBytes(storedHash)))
        return Results.Unauthorized();

    var sessionId = GenerateSessionId();
    // ON CONFLICT replace existing session for this user (PM-style: one session per user).
    using (var upsert = new NpgsqlCommand(@"
        INSERT INTO sessions (id, userid, expiration)
        VALUES (@s, @u, NOW() + INTERVAL '1 hour')
        ON CONFLICT (userid) DO UPDATE SET id = EXCLUDED.id, expiration = EXCLUDED.expiration", conn))
    {
        upsert.Parameters.AddParam("@s", sessionId);
        upsert.Parameters.AddParam("@u", userId);
        await upsert.ExecuteNonQueryAsync();
    }

    Log.Information("Login OK: {User} (sid prefix={Sid})", req.Username, sessionId[..8]);
    return Results.Ok(new { sessionId, userId });
});

app.MapGet("/", () => Results.Ok(new { service = "MeteorReborn Login", status = "ok" }));

Log.Information("MeteorReborn Login Server starting on http://0.0.0.0:17743");
app.Urls.Add("http://0.0.0.0:17743");
app.Run();

// ── DTOs ──
record AccountRequest(string Username, string Password, string? Email);
record LoginRequest(string Username, string Password);
