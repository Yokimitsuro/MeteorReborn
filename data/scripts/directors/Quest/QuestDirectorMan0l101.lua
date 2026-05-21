require ("global")
require ("quests/man/man0l1")

function init()
	return "/Director/Quest/QuestDirectorMan0l101";
end

function onCreateContentArea(players, director, contentArea, contentGroup)

	sisipu = contentArea:SpawnActor(2290007, "sisipu", -49, 36.43, 162, 2.2);
	
	for _, player in pairs(players) do
        contentGroup:AddMember(player);
    end;
	
	contentGroup:AddMember(director);
	contentGroup:AddMember(sisipu);
	
end

function onEventStarted(player, director, triggerName)	

	player:EndEvent();
	
	
end

function main()
end