require("global");

properties = {
    permissions = 0,
    parameters = "d",
    description = "Spawns a actor",
}

function onTrigger(player, argc, actorClassId, width, height)

	if (actorClassId == nil) then
		player:SendMessage(0x20, "", "No actor class id provided.");
		return;
	end	

    local pos = player:GetPos();
    local x = pos[0];
    local y = pos[1];
    local z = pos[2];
    local rot = pos[3];
    local zone = pos[4];
         
	actorClassId = tonumber(actorClassId);
	
	if (actorClassId ~= nil) then		
		zone = player:GetZone();
		local w = tonumber(width) or 0;
        local h = tonumber(height) or 0;
        printf("%f %f %f", x, y, z);
        --local x, y, z = player.GetPos();
        for i = 0, w do
            for j = 0, h do
				actor = zone:SpawnActor(actorClassId, "test", pos[0] + (i - (w / 2) * 3), pos[1], pos[2] + (j - (h / 2) * 3), pos[3]);
				-- FINISH-PM: PM llama `actor.SetAppearance(1001149)` pero el método NO existe
				-- en el C# de PM (verificado: 0 hits en Project Meteor/Map Server/). NLua de PM
				-- silenciaba el error; MoonSharp en MR aborta la Lua a la mitad y deja al actor
				-- con appearance=0 → cliente recibe spawn corrupto y crashea. Comentado.
				-- actor.SetAppearance(1001149)
			end
		end
	end
	
	if (actor == nil) then
		player:SendMessage(0x20, "", "This actor class id cannot be spawned.");
	end
	
end;