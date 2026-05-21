require("global")

function init()
	return "/Director/AfterQuestWarpDirector";
end

function onEventStarted(player, director, eventType, eventName)
	if (player:HasQuest(110002) == true) then
		quest = player:GetQuest("Man0l1");
		quest:OnNotice(player);
    elseif (player:HasQuest(110006) == true) then
		quest = player:GetQuest("Man0g1");
		quest:OnNotice(player);    
	end
end

function main()
end