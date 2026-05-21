// PM-COMPLETE → verbatim port de Map Server/DataObjects/ZoneConnection.cs (PM:22-89).
// LANG-ADAPT: namespace + nullable + NLog → Serilog.
// Dep forward: `WorldRequestZoneChangePacket` (sub-item 3.16, packets/WorldPackets/Send).

using System;
using System.Net.Sockets;

using MeteorReborn.Common;
using System.Collections.Concurrent;
using System.Net;
using MeteorReborn.Map.Packets.WorldPackets.Send;
using Serilog;

namespace MeteorReborn.Map.DataObjects;

class ZoneConnection
{
    //Connection stuff
    public Socket socket = null!;
    public byte[] buffer = null!;
    private BlockingCollection<SubPacket> SendPacketQueue = new BlockingCollection<SubPacket>(1000);
    public int lastPartialSize = 0;

    public void QueuePacket(SubPacket subpacket)
    {
        if (SendPacketQueue.Count == SendPacketQueue.BoundedCapacity - 1)
            FlushQueuedSendPackets();

        SendPacketQueue.Add(subpacket);
    }

    public void FlushQueuedSendPackets()
    {
        if (socket == null || !socket.Connected)
            return;

        while (SendPacketQueue.Count > 0)
        {
            SubPacket packet = SendPacketQueue.Take();

            byte[] packetBytes = packet.GetBytes();

            try
            {
                socket.Send(packetBytes);
            }
            catch (Exception e)
            { Log.Error(e, "Weird case, socket was d/ced: {Msg}"); }
        }
    }

    public String GetAddress()
    {
        return String.Format("{0}:{1}", (socket.RemoteEndPoint as IPEndPoint)!.Address, (socket.RemoteEndPoint as IPEndPoint)!.Port);
    }

    public bool IsConnected()
    {
        return (socket.Poll(1, SelectMode.SelectRead) && socket.Available == 0);
    }

    public void Disconnect()
    {
        if (socket.Connected)
            socket.Disconnect(false);
    }

    public void RequestZoneChange(uint sessionId, uint destinationZoneId, byte spawnType, float spawnX, float spawnY, float spawnZ, float spawnRotation)
    {
        WorldRequestZoneChangePacket.BuildPacket(sessionId, destinationZoneId, spawnType, spawnX, spawnY, spawnZ, spawnRotation).DebugPrintSubPacket();
        QueuePacket(WorldRequestZoneChangePacket.BuildPacket(sessionId, destinationZoneId, spawnType, spawnX, spawnY, spawnZ, spawnRotation));
    }
}
