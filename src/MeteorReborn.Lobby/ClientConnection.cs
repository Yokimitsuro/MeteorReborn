// PM-COMPLETE → verbatim port de Lobby Server/ClientConnection.cs (PM:22-101).
// LANG-ADAPT: namespace + nullable + NLog `Program.Log` → Serilog `Log`. Cyotek.Collections nuget
// package (mismo que PM packages.config).

using System;
using System.Collections.Concurrent;
using System.Net;
using System.Net.Sockets;

using Cyotek.Collections.Generic;
using MeteorReborn.Common;
using Serilog;

namespace MeteorReborn.Lobby;

class ClientConnection
{
    //Connection stuff
    public Blowfish blowfish = null!;
    public Socket socket = null!;
    public byte[] buffer = new byte[0xffff];
    public CircularBuffer<byte> incomingStream = new CircularBuffer<byte>(1024);
    public BlockingCollection<BasePacket> SendPacketQueue = new BlockingCollection<BasePacket>(100);
    public int lastPartialSize = 0;

    //Instance Stuff
    public uint currentUserId = 0;
    public uint currentAccount;
    public string currentSessionToken = null!;

    //Chara Creation
    public string newCharaName = null!;
    public uint newCharaPid;
    public uint newCharaCid;
    public ushort newCharaSlot;
    public ushort newCharaWorldId;


    public void ProcessIncoming(int bytesIn)
    {
        if (bytesIn == 0)
            return;

        incomingStream.Put(buffer, 0, bytesIn);
    }

    public void QueuePacket(BasePacket packet)
    {
        if (SendPacketQueue.Count == SendPacketQueue.BoundedCapacity - 1)
            FlushQueuedSendPackets();

        SendPacketQueue.Add(packet);
    }

    public void FlushQueuedSendPackets()
    {
        if (!socket.Connected)
            return;

        while (SendPacketQueue.Count > 0)
        {
            BasePacket packet = SendPacketQueue.Take();
            byte[] packetBytes = packet.GetPacketBytes();
            byte[] buffer = new byte[0xffff];
            Array.Copy(packetBytes, buffer, packetBytes.Length);
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

    public void Disconnect()
    {
        socket.Shutdown(SocketShutdown.Both);
        socket.Disconnect(false);
    }
}
