# A custom signaling solution

_Signaling_ is the process of communicating with a remote endpoint with the intent of establishing a peer-to-peer connection. The WebRTC standard does not enforce any specific protocol or solution for WebRTC signaling; instead it simply states that some opaque messages must be transported between the remote peers by whatever mean the developer choses, its _signaling solution_.

The .NET Core Desktop tutorial [introduces the `NamedPipeSignaler`](helloworld-cs-signaling-core3.md), a simple solution for local discovery based on named pipes. Unfortunately named pipes are not available on UWP, so this solution cannot be used. Instead, and also as an example of an alternate solution, we rely in this tutorial on the existing `NodeDssSignaler` already used by the `TestAppUWP` sample app and the Unity integration. This requires a little bit more setup, described in details in the Unity tutorial.

> [!NOTE]
> The `NodeDssSignaler` found in the `TestAppUWP` and the one found in the Unity integration use the same protocol and are compatible, but the code is different, the latter being based on Unity's [`MonoBehaviour`](https://docs.unity3d.com/ScriptReference/MonoBehaviour.html) component class. Here we use the former, which is written in pure C# and is independent of Unity.

## Install

Like for the `VideoBridge` helper class, the easiest way to consume the `NodeDssSignaler` class in the `App1` sample app for UWP is to copy the [`NodeDssSignaler.cs`](https://github.com/microsoft/MixedReality-WebRTC/blob/master/examples/TestAppUwp/NodeDssSignaler.cs) file alongside the `App1.csproj` project of the current tutorial, and add a reference to it in the project using right-click > **Add** > **Existing Item...** (or Shift+Alt+A).

The `NodeDssSignaler` class makes use of the `Newtonsoft.Json` package for JSON data serialization and deserialization. This module is available as a NuGet package.

1. In the _Solution Explorer_ panel, right click on the **References** item and select **Manage NuGet Packages...**.

2. In the **Browse** panel, search for the `Newtonsoft.Json` package, select the latest stable version, and click the **Install** button.

![Install the Newtonsoft.Json NuGet package](cs-uwp14.png)

> [!Warning]
> Do not forget to start the `node-dss` signaling server. See [the detailed explanations in the Unity turorial](../unity/helloworld-unity-connection.md#configuring-the-nodedsssignaler) about installing and starting it with NodeJS. In this tutorial we choose the _local peer ID_ to be the string "`App1`", and the _remote peer ID_ is the value we will assign below to the `NodeDssSignaler.RemotePeerId` field.

## Setup

Continue editing the `MainPage.xaml.cs` file.

1. Import the `TestAppUwp` module. At the top of the `MainPage.xaml.cs` file add:

   ```cs
   using TestAppUwp;
   ```

2. At the top of the `MainPage` class, create a `NodeDssSignaler` field.

   ```cs
   private NodeDssSignaler _signaler;
   ```

3. In the `OnLoaded()` method, add some subscriptions to the signaling events.

   ```cs
   _peerConnection.LocalSdpReadytoSend += Peer_LocalSdpReadytoSend;
   _peerConnection.IceCandidateReadytoSend += Peer_IceCandidateReadytoSend;
   ```

   The [`LocalSdpReadytoSend`](xref:Microsoft.MixedReality.WebRTC.PeerConnection.LocalSdpReadytoSend) event is triggered after a call to [`CreateOffer`](xref:Microsoft.MixedReality.WebRTC.PeerConnection.CreateOffer) or [`CreateAnswer`](xref:Microsoft.MixedReality.WebRTC.PeerConnection.CreateAnswer) when WebRTC prepared the corresponding SDP message and signals the application the message is ready to be sent. The [`IceCandidateReadytoSend`](xref:Microsoft.MixedReality.WebRTC.PeerConnection.IceCandidateReadytoSend) event similarly corresponds to ICE candidate messages generated by WebRTC, which the application needs to deliver to the remote peer.

4. Implement the event handlers, which simply format the SDP message for the signaler using the utility methods provided by the `NodeDssSignaler` class.

   ```cs
   private void Peer_LocalSdpReadytoSend(SdpMessage message)
   {
       var msg = NodeDssSignaler.FromSdpMessage(message);
       _signaler.SendMessageAsync(msg);
   }

   private void Peer_IceCandidateReadytoSend(IceCandidate iceCandidate)
   {
       var msg = NodeDssSignaler.FromIceCandidate(iceCandidate);
       _signaler.SendMessageAsync(msg);
   }
   ```

5. Continue appending to the `OnLoaded()` method to initialize and start the signaler.

   ```cs
   // Initialize the signaler
   _signaler = new NodeDssSignaler()
   {
       HttpServerAddress = "http://127.0.0.1:3000/",
       LocalPeerId = "App1",
       RemotePeerId = "<input the remote peer ID here>",
   };
   _signaler.OnMessage += async (NodeDssSignaler.Message msg) =>
   {
       switch (msg.MessageType)
       {
           case NodeDssSignaler.Message.WireMessageType.Offer:
               // Wait for the offer to be applied
               await _peerConnection.SetRemoteDescriptionAsync(msg.ToSdpMessage());
               // Once applied, create an answer
               _peerConnection.CreateAnswer();
               break;

           case NodeDssSignaler.Message.WireMessageType.Answer:
               // No need to await this call; we have nothing to do after it
               _peerConnection.SetRemoteDescriptionAsync(msg.ToSdpMessage());
               break;

           case NodeDssSignaler.Message.WireMessageType.Ice:
               _peerConnection.AddIceCandidate(msg.ToIceCandidate());
               break;
       }
   };
   _signaler.StartPollingAsync();
   ```

   > [!WARNING]
   > Take care to set the value of the `RemotePeerId` field of the `NodeDssSignaler` to the remote peer's ID, otherwise the signaling will not work. Similarly, this tutorial arbitrarily uses `App1` as the local peer ID for the application; this value needs to be set as the remote peer's ID when configuring the remote peer signaler. See [the explanations in the Unity turorial](../unity/helloworld-unity-connection.md#configuring-the-nodedsssignaler) for more details.

6. In the `App_Suspending()` event handler, stop the signaler and clean-up the resources.

   ```cs
   if (_signaler != null)
   {
       _signaler.StopPollingAsync();
       _signaler = null;
   }
   ```

At this point the sample app is ready to establish a connection.

----

Next : [Establishing a WebRTC connection](helloworld-cs-connection-uwp.md)
