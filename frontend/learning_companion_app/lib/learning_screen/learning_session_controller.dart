import 'package:learning_companion_app/services/session_service.dart';
import 'package:livekit_client/livekit_client.dart' as sdk;
import 'package:livekit_components/livekit_components.dart' as components;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:learning_companion_app/models/learning_session_state.dart';

part 'learning_session_controller.g.dart';

@riverpod
class LearningSessionController extends _$LearningSessionController {
  late final sdk.Room _room =
      sdk.Room(roomOptions: const sdk.RoomOptions(enableVisualizer: true));
  late final roomContext = components.RoomContext(room: _room);
  final SessionService _tokenService = SessionService();
  List<sdk.TranscriptionSegment> transcriptions = [];

  @override
  Future<LearningSessionState> build(
      {required String childName, required String parentEmail}) async {
    try {
      final sessionDetails = await _tokenService.fetchSessionDetails(
        childName: childName,
        roomName: parentEmail,
      );

      _setupRoomEventListeners();

      await _room.connect(
        sessionDetails.serverUrl,
        sessionDetails.participantToken,
      );

     _room.localParticipant?.setAttributes(
          {"parentEmail": parentEmail, "childName": childName});

      _room.events.on<sdk.TranscriptionEvent>((event) {
        transcriptions = event.segments;
        state = state.whenData((currentState) => currentState.copyWith(
              transcriptions: transcriptions,
            ));
      });

      return LearningSessionState(
        connectionState: ConnectionStateEnum.connected,
        room: _room,
        roomContext: roomContext,
        error: null,
        isMicrophoneEnabled: true,
        transcriptions: transcriptions,
      );
    } catch (error) {
      return LearningSessionState(
        connectionState: ConnectionStateEnum.disconnected,
        error: error.toString(),
        isMicrophoneEnabled: false,
      );
    }
  }

  void _setupRoomEventListeners() {
    _room.addListener(_onRoomEvent);
  }

  void _onRoomEvent() {
    if (_room.connectionState == sdk.ConnectionState.disconnected) {
      _handleRoomDisconnected();
    }
  }

  void _handleRoomDisconnected() {
    state = state.whenData((currentState) => currentState.copyWith(
          connectionState: ConnectionStateEnum.disconnected,
          error: 'Room disconnected',
        ));
  }

  Future<void> toggleMicrophone() async {
    final currentState = await future;
    if (currentState.room != null) {
      final newMicState = !currentState.isMicrophoneEnabled;
      await currentState.room!.localParticipant
          ?.setMicrophoneEnabled(newMicState);
      state = AsyncValue.data(
          currentState.copyWith(isMicrophoneEnabled: newMicState));
    }
  }

  Future<void> disconnectFromSession() async {
    await _room.disconnect();
    final currentState = await future;
    state = AsyncValue.data(currentState.copyWith(
        connectionState: ConnectionStateEnum.disconnected));
  }

  void dispose() {
    _room.removeListener(_onRoomEvent);
    _room.dispose();
  }
}
