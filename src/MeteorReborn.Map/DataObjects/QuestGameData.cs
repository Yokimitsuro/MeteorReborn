using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MeteorReborn.Map.DataObjects
{
    class QuestGameData
    {
        public uint Id { get; }
        public string ClassName { get; }
        public string Name { get; }
        public uint PrerequisiteQuest { get; }
        public int MinLevel { get; }
        public int MinGCRank { get; }

        public QuestGameData(uint id, string className, string name, uint prereq, int minLv, int minGcRank)
        {
            Id = id;
            ClassName = className;
            Name = Name;
            PrerequisiteQuest = prereq;
            MinLevel = minLv;
            MinGCRank = minGcRank;
        }
    }
}
