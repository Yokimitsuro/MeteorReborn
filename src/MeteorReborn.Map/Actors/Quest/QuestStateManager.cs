using MeteorReborn.Common;
using MeteorReborn.Map.DataObjects;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MeteorReborn.Map.Actors.QuestNS
{
    class QuestStateManager
    {
        private const int SCENARIO_START = 110001;
        private const int SCENARIO_MAX = 2048;

        private readonly Player player;
        private readonly Bitstream CompletedQuestsBitfield = new Bitstream(SCENARIO_MAX);
        private readonly Bitstream AvailableQuestsBitfield = new Bitstream(SCENARIO_MAX);
        private readonly Bitstream MinLevelBitfield = new Bitstream(SCENARIO_MAX);
        private readonly Bitstream PrereqBitfield = new Bitstream(SCENARIO_MAX, true);
        private readonly Bitstream GCRankBitfield = new Bitstream(SCENARIO_MAX, true);

        private List<Quest> ActiveQuests = new List<Quest>();
        private List<Quest> UpdatableQuests = new List<Quest>();
        private Dictionary<uint, QuestState> QuestStateTable = new Dictionary<uint, QuestState>();

        public QuestStateManager(Player player)
        {
            this.player = player;
        }

        public void Init(Quest[] journalQuests, bool[] completedQuests)
        {
            // Preload any quests that the player loaded
            if (journalQuests != null)
            {
                foreach (var quest in journalQuests)
                {
                    if (quest != null)
                    {
                        ActiveQuests.Add(quest);
                        AvailableQuestsBitfield.Set(quest.GetQuestId() - SCENARIO_START);
                    }
                }
            }                

            // Init MinLv
            QuestGameData[] minLvl = Server.GetQuestGamedataByMaxLvl(player.GetHighestLevel(), true);
            foreach (var questData in minLvl)
                MinLevelBitfield.Set(questData.Id - SCENARIO_START);

            // Init Prereq
            CompletedQuestsBitfield.SetTo(completedQuests);
            foreach (var questData in Server.GetQuestGamedataAllPrerequisite())
            {
                if (CompletedQuestsBitfield.Get(((Quest)Server.GetStaticActors(0xA0F00000 | questData.PrerequisiteQuest)).GetQuestId() - SCENARIO_START))
                    PrereqBitfield.Set(questData.Id - SCENARIO_START);
                else
                    PrereqBitfield.Clear(questData.Id - SCENARIO_START);
            }

            ComputeAvailable();
        }

        public void UpdateLevel(int level)
        {
            QuestGameData[] updated = Server.GetQuestGamedataByMaxLvl(level);
            foreach (var questData in updated)
                MinLevelBitfield.Set(questData.Id - SCENARIO_START);
            ComputeAvailable();
        }

        public void UpdateQuestCompleted(Quest quest)
        {
            CompletedQuestsBitfield.Set(quest.GetQuestId() - SCENARIO_START);
            QuestGameData[] updated = Server.GetQuestGamedataByPrerequisite(quest.GetQuestId());
            foreach (var questData in updated)
                PrereqBitfield.Set(questData.Id - SCENARIO_START);
            ComputeAvailable();
        }

        public void UpdateQuestAbandoned()
        {
            ComputeAvailable();
        }

        private void ComputeAvailable()
        {
            Bitstream result = new Bitstream(SCENARIO_MAX);
            result.NOTOR(CompletedQuestsBitfield);
            result.AND(MinLevelBitfield);
            result.AND(PrereqBitfield);
            result.AND(GCRankBitfield);

            Bitstream difference = AvailableQuestsBitfield.Copy();
            difference.XOR(result);
            byte[] diffBytes = difference.GetBytes();

            for (int i = 0; i < diffBytes.Length; i++)
            {
                if (diffBytes[i] == 0)
                    continue;
                for (int shift = 0; shift < 8; shift++)
                {
                    if ((diffBytes[i] >> shift & 1) == 1)
                    {
                        int index = i * 8 + shift;
                        Quest quest = (Quest)Server.GetStaticActors(0xA0F00000 | (SCENARIO_START + (uint)index));
                        if (!AvailableQuestsBitfield.Get(index))
                            AddActiveQuest(quest);
                        else
                            RemoveActiveQuest(quest);
                    }
                }
            }

            AvailableQuestsBitfield.SetTo(result);
        }

        public void ForceAddActiveQuest(Quest questInstance)
        {
            ActiveQuests.Add(questInstance);
            QuestStateTable.Add(questInstance.Id, questInstance.GetQuestState());
        }

        private void AddActiveQuest(Quest staticQuest)
        {
            Quest instance = new Quest(player, staticQuest);
            ActiveQuests.Add(instance);
            QuestStateTable.Add(staticQuest.Id, instance.GetQuestState());
        }

        private void RemoveActiveQuest(Quest staticQuest)
        {
            // Do not remove quests in the player's journal
            if (player.HasQuest(staticQuest.GetQuestId()))
                return;

            ActiveQuests.Remove(staticQuest);
            UpdatableQuests.Remove(staticQuest);

            if (QuestStateTable.ContainsKey(staticQuest.Id))
            {
                QuestStateTable[staticQuest.Id].DeleteState();
                QuestStateTable.Remove(staticQuest.Id);
            }
        }

        public void ForceQuestStateUpdate()
        {
            ComputeAvailable();
        }

        public Quest GetActiveQuest(uint id)
        {
            return ActiveQuests.Find(quest => quest.GetQuestId() == id);
        }

        public Quest[] GetQuestsForNpc(Npc npc, bool isPrivateArea)
        {
            return ActiveQuests.FindAll(quest => quest.IsQuestENPC(player, npc)).ToArray();
        }

        public byte[] GetCompletionSliceBytes(ushort from, ushort to)
        {
            return CompletedQuestsBitfield.GetSlice(from, to); 
        }

        public bool IsQuestComplete(uint questId)
        {
            return CompletedQuestsBitfield.Get(questId - SCENARIO_START);
        }

        public void ForceQuestCompleteFlag(uint questId, bool flag)
        {
            if (flag)
                CompletedQuestsBitfield.Set(questId - SCENARIO_START);
            else 
                CompletedQuestsBitfield.Clear(questId - SCENARIO_START);
            QuestGameData[] updated = Server.GetQuestGamedataByPrerequisite(questId);
            foreach (var questData in updated) 
            {
                if (flag)
                    PrereqBitfield.Set(questData.Id - SCENARIO_START);
                else
                    PrereqBitfield.Clear(questData.Id - SCENARIO_START);
            }
            ComputeAvailable();
        }

        public void Update(DateTime tick)
        {
            foreach (Quest quest in ActiveQuests)
                quest.Update(tick);
        }
    }
}
