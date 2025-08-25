import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_companion_app/models/session_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:learning_companion_app/utils/session_strings.dart';

class SessionService {
  String? get sandboxId {
    final value = dotenv.env['LIVEKIT_SANDBOX_ID'];
    if (value != null) {
      return value.replaceAll('"', '');
    }
    return null;
  }

  final String sandboxUrl =
      'https://cloud-api.livekit.io/api/sandbox/connection-details';

  Future<SessionModel> fetchSessionDetails(
      {required roomName, required childName}) async {
    if (sandboxId == null) {
      debugPrint(SessionStrings.sandboxIdNotSetDebug);
      throw Exception(SessionStrings.sandboxIdNotSet);
    }

    debugPrint(SessionStrings.usingSandboxId(sandboxId!));

    final uri = Uri.parse(sandboxUrl).replace(queryParameters: {
      'roomName': roomName,
      'participantName': childName,
    });

    try {
      final response =
          await http.post(uri, headers: {"X-Sandbox-ID": sandboxId!});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final data = jsonDecode(response.body);
          return SessionModel.fromJson(data);
        } catch (e) {
          throw Exception(SessionStrings.errorParsingConnectionDetails(e.toString()));
        }
      } else {
        throw Exception(
            SessionStrings.liveKitApiError(response.statusCode, response.body));
      }
    } catch (e) {
        throw Exception(SessionStrings.failedToConnectToLiveKit(e.toString()));
      }
  }
}
