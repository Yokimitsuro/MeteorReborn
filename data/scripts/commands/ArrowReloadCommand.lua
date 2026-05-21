require ("global")
require ("utils")

function onEventStarted(player, command, eventType, eventName, arg1, arg2, arg3, arg4, targetActor, arg5, arg6, arg7, arg8)
	player.Ability(command.Id, targetActor);
	player:endEvent();
end;