// PM-COMPLETE → verbatim port de Map Server/DataObjects/Session.cs (PM:22-185).
// LANG-ADAPT: namespace + nullable.
// Deps forward (no portados aún): Player (3.9), Actor (3.3), Retainer (3.11), Npc (3.10),
// RemoveActorPacket (3.12), Server.GetWorldConnection (3.26).

using MeteorReborn.Common;

using MeteorReborn.Map.Actors;
using MeteorReborn.Map.Packets.Send.Actor;
using System.Collections.Generic;

namespace MeteorReborn.Map.DataObjects;

class Session
{
    public uint id = 0;
    Player playerActor;
    public List<Actor> actorInstanceList = new List<Actor>();
    public uint languageCode = 1;
    private uint lastPingPacket = MeteorReborn.Common.Utils.UnixTimeStampUTC();

    public bool isUpdatesLocked = true;

    public string errorMessage = "";

    public Session(uint sessionId)
    {
        this.id = sessionId;
        playerActor = new Player(this, sessionId);
    }

    public void QueuePacket(List<SubPacket> packets)
    {
        foreach (SubPacket s in packets)
            QueuePacket(s);
    }

    public void QueuePacket(SubPacket subPacket)
    {
        subPacket.SetTargetId(id);
        Server.GetWorldConnection().QueuePacket(subPacket);
    }

    public Player GetActor()
    {
        return playerActor;
    }

    public void Ping()
    {
        lastPingPacket = MeteorReborn.Common.Utils.UnixTimeStampUTC();
    }

    public bool CheckIfDCing()
    {
        uint currentTime = MeteorReborn.Common.Utils.UnixTimeStampUTC();
        if (currentTime - lastPingPacket >= 5000) //Show D/C flag
            playerActor.SetDCFlag(true);
        else if (currentTime - lastPingPacket >= 30000) //DCed
            return true;
        else
            playerActor.SetDCFlag(false);
        return false;
    }

    public void UpdatePlayerActorPosition(float x, float y, float z, float rot, ushort moveState)
    {
        if (isUpdatesLocked)
            return;

        if (playerActor.positionX == x && playerActor.positionY == y && playerActor.positionZ == z && playerActor.rotation == rot)
            return;

        /*
        playerActor.oldPositionX = playerActor.positionX;
        playerActor.oldPositionY = playerActor.positionY;
        playerActor.oldPositionZ = playerActor.positionZ;
        playerActor.oldRotation = playerActor.rotation;

        playerActor.positionX = x;
        playerActor.positionY = y;
        playerActor.positionZ = z;
        */
        playerActor.rotation = rot;
        playerActor.moveState = moveState;

        //GetActor().GetZone().UpdateActorPosition(GetActor());
        playerActor.QueuePositionUpdate(new Vector3(x, y, z));
    }

    // PM-INCOMPLETE (FINISH-PM stub): the ioncannon/quest_system branch added a
    // version that updates an NPC's quest icon/emote status in this session's actor
    // instance list. It depends on `QuestENpc` and `SetActorQuestGraphicPacket` which
    // aren't ported yet. Stubbed to no-op so QuestState.cs compiles; flesh out when
    // the quest_system data pipeline is fully wired.
    public void UpdateQuestNpcInInstance(object questENpc, bool clearInstance = false)
    {
        // TODO: port full body from PM/Map Server/DataObjects/Session.cs:183
    }

    public void UpdateInstance(List<Actor> list, bool force = false)
    {
        if (isUpdatesLocked && !force)
            return;

        List<BasePacket> basePackets = new List<BasePacket>();
        List<SubPacket> RemoveActorSubpackets = new List<SubPacket>();
        List<SubPacket> posUpdateSubpackets = new List<SubPacket>();

        //Remove missing actors
        for (int i = 0; i < actorInstanceList.Count; i++)
        {
            //Retainer Instance
            if (actorInstanceList[i] is Retainer && playerActor.currentSpawnedRetainer == null)
            {
                QueuePacket(RemoveActorPacket.BuildPacket(actorInstanceList[i].actorId));
                actorInstanceList.RemoveAt(i);
            }
            else if (!list.Contains(actorInstanceList[i]) && !(actorInstanceList[i] is Retainer))
            {
                QueuePacket(RemoveActorPacket.BuildPacket(actorInstanceList[i].actorId));
                actorInstanceList.RemoveAt(i);
            }
        }

        //Retainer Instance
        if (playerActor.currentSpawnedRetainer != null && !playerActor.sentRetainerSpawn)
        {
            Actor actor = playerActor.currentSpawnedRetainer;
            QueuePacket(actor.GetSpawnPackets(playerActor, 1));
            QueuePacket(actor.GetInitPackets());
            QueuePacket(actor.GetSetEventStatusPackets());
            actorInstanceList.Add(actor);
            ((Npc)actor).DoOnActorSpawn(playerActor);
            playerActor.sentRetainerSpawn = true;
        }

        //Add new actors or move
        for (int i = 0; i < list.Count; i++)
        {
            Actor actor = list[i];

            if (actor.actorId == playerActor.actorId)
                continue;

            if (actorInstanceList.Contains(actor))
            {

            }
            else
            {
                QueuePacket(actor.GetSpawnPackets(playerActor, 1));

                QueuePacket(actor.GetInitPackets());
                QueuePacket(actor.GetSetEventStatusPackets());
                actorInstanceList.Add(actor);

                if (actor is Npc)
                {
                    ((Npc)actor).DoOnActorSpawn(playerActor);
                }
            }
        }

    }


    public void ClearInstance()
    {
        actorInstanceList.Clear();
    }


    public void LockUpdates(bool f)
    {
        isUpdatesLocked = f;
    }
}
