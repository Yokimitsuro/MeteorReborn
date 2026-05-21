require ("global")
require ("utils")

function onEventStarted(player, command, eventType, eventName, arg1, arg2, arg3, arg4, targetActor, arg5, arg6, arg7, arg8)
	if (player:GetState() ~= 2) then
		player:SendGameMessage(GetWorldMaster(), 32503, 0x20);
		player:endEvent();
		return;
	end

	if not player.aiContainer.IsEngaged() then
		player.Engage(targetActor);
	end;
	player.WeaponSkill(command.Id, targetActor);
	player:endEvent();
end;
