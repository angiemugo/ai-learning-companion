import 'package:livekit_client/livekit_client.dart' as sdk;
import 'package:livekit_components/livekit_components.dart' as components;

enum ConnectionStateEnum { disconnected, connecting, connected }

class LearningSessionState {
  final ConnectionStateEnum connectionState;
  final sdk.Room? room;
  final String? error;
  final bool isMicrophoneEnabled;
  final components.RoomContext? roomContext;
  final List<sdk.TranscriptionSegment> transcriptions;

  const LearningSessionState({
    this.connectionState = ConnectionStateEnum.disconnected,
    this.room,
    this.error,
    this.isMicrophoneEnabled = true,
    this.roomContext,
    this.transcriptions = const [],
  });

  LearningSessionState copyWith({
    ConnectionStateEnum? connectionState,
    sdk.Room? room,
    String? error,
    bool? isMicrophoneEnabled,
    components.RoomContext? roomContext,
    List<sdk.TranscriptionSegment>? transcriptions,
    String? agentState,
    String? userState,
    String? statusMessage,
  }) {
    return LearningSessionState(
      connectionState: connectionState ?? this.connectionState,
      room: room ?? this.room,
      error: error ?? this.error,
      isMicrophoneEnabled: isMicrophoneEnabled ?? this.isMicrophoneEnabled,
      roomContext: roomContext ?? this.roomContext,
      transcriptions: transcriptions ?? this.transcriptions,
    );
  }
}
