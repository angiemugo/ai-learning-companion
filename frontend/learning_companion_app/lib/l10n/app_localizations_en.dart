// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ello! Your Learning Companion';

  @override
  String get childNameHint => 'Enter child\'s name';

  @override
  String get startingSession => 'Starting your learning session...';

  @override
  String get connected => 'Connected';

  @override
  String get offlineMode => 'Offline Mode';

  @override
  String get welcomeTagline => 'Lets learn about colors together!';

  @override
  String get childNameLabel => 'Child\'s Name';

  @override
  String get parentEmailLabel => 'Parent\'s Email';

  @override
  String get parentEmailHintText => 'Enter parent\'s email for progress report';

  @override
  String get childNameValidation => 'Please enter child\'s name';

  @override
  String get parentEmailValidation => 'Please enter a valid email';

  @override
  String get startLearningSessionButton => 'Start Learning Session! 🎨';

  @override
  String get learningDescription =>
      'We\'ll learn about primary colors and then test what you learned!';

  @override
  String get endLearningSession => 'End Learning Session';

  @override
  String get endSessionConfirmation =>
      'Are you sure you want to end this session?';

  @override
  String get cancel => 'Cancel';

  @override
  String get endSession => 'End Session';

  @override
  String get failedToConnect => 'Failed to connect to session';

  @override
  String get transcriptionPlaceholder =>
      'Transcriptions will appear here when the AI agent speaks.\n\nNote: This requires the backend AI agent to be running and connected to the same LiveKit room.';

  @override
  String get mute => 'Mute';

  @override
  String get unmute => 'Unmute';

  @override
  String microphoneStatus(String status) {
    return 'Microphone is $status. Tap to toggle.';
  }

  @override
  String get enabled => 'enabled';

  @override
  String get disabled => 'disabled';

  @override
  String get waitingForConnection => 'Waiting for connection...';

  @override
  String learningWithTitleEmoji(String childName) {
    return '🌈 Learning with $childName';
  }

  @override
  String get startingSessionWithEmoji =>
      '🎨✨ Starting your learning session...';

  @override
  String get connectionErrorEmoji => '😟 Connection Error';

  @override
  String get retryEmoji => '🔄 Retry Connection';

  @override
  String get aiTeacherTitle => '🎨 AI Art Teacher! 🎨';

  @override
  String get connectedWithEmoji => '✨ Connected';

  @override
  String get offlineModeWithEmoji => '⏳ Offline Mode';

  @override
  String get transcriptionPlaceholderWithEmoji =>
      '💬✨ Transcriptions will appear here when the AI agent speaks.\n\nNote: This requires the backend AI agent to be running and connected to the same LiveKit room.';

  @override
  String get invalidEmailValidation => 'Please enter a valid email address';

  @override
  String get formValidationError =>
      'Please fix the errors above before continuing.';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get changeUser => 'Change User';

  @override
  String get changeUserConfirmation =>
      'This will clear the saved user data and return to the welcome screen. Continue?';

  @override
  String get continueAction => 'Continue';

  @override
  String nameMinLengthValidation(int minLength) {
    return 'Name must be at least $minLength characters long';
  }

  @override
  String nameMaxLengthValidation(int maxLength) {
    return 'Name must be less than $maxLength characters long';
  }

  @override
  String get aiTeacherEmoji => '🎨';

  @override
  String get connectedEmoji => '✅';

  @override
  String get offlineEmoji => '❌';

  @override
  String get sadEmoji => '😢';

  @override
  String get loadingEmojis => '⏳✨';

  @override
  String get transcriptionEmojis => '💬📝';

  @override
  String get sandboxIdNotSet => 'Sandbox ID is not set';

  @override
  String get sandboxIdNotSetDebug =>
      'LIVEKIT_SANDBOX_ID is not set in environment variables';

  @override
  String usingSandboxId(String sandboxId) {
    return 'Using sandbox ID: $sandboxId';
  }

  @override
  String errorParsingConnectionDetails(String error) {
    return 'Error parsing connection details from LiveKit: $error';
  }

  @override
  String liveKitApiError(int statusCode, String errorBody) {
    return 'LiveKit API Error $statusCode: $errorBody';
  }

  @override
  String get networkConnectionFailed =>
      'Network connection failed. Check your internet connection.';

  @override
  String get requestTimedOut =>
      'Request timed out. LiveKit service may be unavailable.';

  @override
  String failedToConnectToLiveKit(String error) {
    return 'Failed to connect to LiveKit Cloud sandbox: $error';
  }
}
