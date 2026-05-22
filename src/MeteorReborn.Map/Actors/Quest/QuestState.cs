using MeteorReborn.Map.Lua;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MeteorReborn.Map.Actors.QuestNS
{
    class QuestState
    {
        public enum QuestFlag { None = 0, Map = 1, Plate = 2 }

        public class QuestENpc
        {
            public readonly uint actorClassId;
            public byte questFlagType { set; get; }
            public bool isSpawned { set; get; }
            public bool isTalkEnabled { set; get; }
            public bool isEmoteEnabled { set; get; }
            public bool isPushEnabled { set; get; }

            public QuestENpc(uint actorClassId, byte questFlagType, bool isSpawned, bool isTalkEnabled, bool isEmoteEnabled, bool isPushEnabled)
            {
                this.actorClassId = actorClassId;
                this.questFlagType = questFlagType;
                this.isSpawned = isSpawned;
                this.isTalkEnabled = isTalkEnabled;
                this.isEmoteEnabled = isEmoteEnabled;
                this.isPushEnabled = isPushEnabled;
            }

            public bool IsChanged(byte flagType, bool isTalkEnabled, bool isPushEnabled, bool isEmoteEnabled, bool isSpawned)
            {
                return flagType != this.questFlagType
                    || isTalkEnabled != this.isTalkEnabled
                    || isPushEnabled != this.isPushEnabled
                    || isEmoteEnabled != this.isEmoteEnabled
                    || isSpawned != this.isSpawned;
            }

            public void Update(byte flagType, bool isTalkEnabled, bool isPushEnabled, bool isEmoteEnabled, bool isSpawned)
            {
                this.questFlagType = flagType;
                this.isSpawned = isSpawned;
                this.isTalkEnabled = isTalkEnabled;
                this.isEmoteEnabled = isEmoteEnabled;
                this.isPushEnabled = isPushEnabled;
            }
        }

        private readonly Player Owner;
        private readonly Quest Parent;
        private Dictionary<uint, QuestENpc> CurrentENPCs = new Dictionary<uint, QuestENpc>();
        private Dictionary<uint, QuestENpc> OldENPCs = new Dictionary<uint, QuestENpc>();

        public QuestState(Player owner, Quest parent)
        {
            Owner = owner;
            Parent = parent;
        }

        public void AddENpc(uint classId, byte flagType = 0, bool isTalkEnabled = true, bool isPushEnabled = false, bool isEmoteEnabled = false, bool isSpawned = false)
        {
            QuestENpc instanceUpdated = null;

            if (OldENPCs.ContainsKey(classId))
            {
                if (OldENPCs[classId].IsChanged(flagType, isTalkEnabled, isPushEnabled, isEmoteEnabled, isSpawned))
                {
                    OldENPCs[classId].Update(flagType, isTalkEnabled, isPushEnabled, isEmoteEnabled, isSpawned);
                    instanceUpdated = OldENPCs[classId];
                }

                // Replace dupes
                if (CurrentENPCs.ContainsKey(classId))
                    CurrentENPCs.Remove(classId);

                CurrentENPCs.Add(classId, OldENPCs[classId]);
                OldENPCs.Remove(classId);
            }
            else
            {
                instanceUpdated = new QuestENpc(classId, flagType, isSpawned, isTalkEnabled, isEmoteEnabled, isPushEnabled);
                CurrentENPCs.Add(classId, instanceUpdated);
            }

            if (instanceUpdated != null)
                Owner.playerSession.UpdateQuestNpcInInstance(instanceUpdated);
        }

        public QuestENpc GetENpc(uint classId)
        {
            if (CurrentENPCs.ContainsKey(classId))
                return CurrentENPCs[classId];
            return null;
        }

        public bool HasENpc(uint classId)
        {
            return CurrentENPCs.ContainsKey(classId);
        }

        public void UpdateState()
        {
            ushort currentSeq = Parent.GetSequence();
            OldENPCs = CurrentENPCs;
            CurrentENPCs = new Dictionary<uint, QuestENpc>();
            LuaEngine.GetInstance().CallLuaFunctionForReturn(Owner, Parent, "onStateChange", false, currentSeq);
            foreach (var enpc in OldENPCs)
                Owner.playerSession.UpdateQuestNpcInInstance(enpc.Value, true);
            OldENPCs = null;
        }

        public void DeleteState()
        {
            foreach (var enpc in CurrentENPCs)
                Owner.playerSession.UpdateQuestNpcInInstance(enpc.Value, true);
            CurrentENPCs.Clear();
        }
    }
}
