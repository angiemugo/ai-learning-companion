class SessionModel {
  final String serverUrl;
  final String roomName;
  final String participantName;
  final String participantToken;

  SessionModel({
    required this.serverUrl,
    required this.roomName,
    required this.participantName,
    required this.participantToken,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      serverUrl: json['serverUrl'],
      roomName: json['roomName'],
      participantName: json['participantName'],
      participantToken: json['participantToken'] ?? '',
    );
  }
}
