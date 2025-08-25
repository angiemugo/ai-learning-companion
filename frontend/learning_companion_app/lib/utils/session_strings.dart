class SessionStrings {
  static const String sandboxIdNotSet = "Sandbox ID is not set";
  static const String sandboxIdNotSetDebug = "LIVEKIT_SANDBOX_ID is not set in environment variables";
  static const String networkConnectionFailed = "Network connection failed. Check your internet connection.";
  static const String requestTimedOut = "Request timed out. LiveKit service may be unavailable.";
  
  static String usingSandboxId(String sandboxId) => "Using sandbox ID: $sandboxId";
  static String errorParsingConnectionDetails(String error) => "Error parsing connection details from LiveKit: $error";
  static String liveKitApiError(int statusCode, String errorBody) => "LiveKit API Error $statusCode: $errorBody";
  static String failedToConnectToLiveKit(String error) => "Failed to connect to LiveKit Cloud sandbox: $error";
}