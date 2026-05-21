// PM-COMPLETE → verbatim port de Map Server/Actors/EventList.cs (PM:22-89).
// LANG-ADAPT: namespace + nullable.

using System.Collections.Generic;

namespace MeteorReborn.Map.Actors;

class EventList
{
    public List<TalkEventCondition> talkEventConditions = null!;
    public List<NoticeEventCondition> noticeEventConditions = null!;
    public List<EmoteEventCondition> emoteEventConditions = null!;
    public List<PushCircleEventCondition> pushWithCircleEventConditions = null!;
    public List<PushFanEventCondition> pushWithFanEventConditions = null!;
    public List<PushBoxEventCondition> pushWithBoxEventConditions = null!;

    public class TalkEventCondition
    {
        public byte unknown1;
        public bool isDisabled = false;
        public string conditionName = null!;
    }

    public class NoticeEventCondition
    {
        public byte unknown1;
        public byte unknown2;
        public string conditionName;

        public NoticeEventCondition(string name, byte unk1, byte unk2)
        {
            conditionName = name;
            unknown1 = unk1;
            unknown2 = unk2;
        }
    }

    public class EmoteEventCondition
    {
        public byte unknown1;
        public byte unknown2;
        public byte emoteId;
        public string conditionName = null!;
    }

    public class PushCircleEventCondition
    {
        public string conditionName = "";
        public float radius = 30.0f;
        public bool outwards = false;
        public bool silent = true;
    }

    public class PushFanEventCondition
    {
        public string conditionName = null!;
        public float radius = 30.0f;
        public bool outwards = false;
        public bool silent = true;
    }

    public class PushBoxEventCondition
    {
        public uint bgObj;
        public uint layout;
        public string conditionName = "";
        public string reactName = "";
        public bool outwards = false;
        public bool silent = true;
    }
}
