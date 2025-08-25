import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Ello! Your Learning Companion'**
  String get appTitle;

  /// Placeholder text for child name input
  ///
  /// In en, this message translates to:
  /// **'Enter child\'s name'**
  String get childNameHint;

  /// Loading message when starting session
  ///
  /// In en, this message translates to:
  /// **'Starting your learning session...'**
  String get startingSession;

  /// LiveKit connection status - connected
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// LiveKit connection status - offline
  ///
  /// In en, this message translates to:
  /// **'Offline Mode'**
  String get offlineMode;

  /// Welcome screen tagline
  ///
  /// In en, this message translates to:
  /// **'Lets learn about colors together!'**
  String get welcomeTagline;

  /// Label for child name input field
  ///
  /// In en, this message translates to:
  /// **'Child\'s Name'**
  String get childNameLabel;

  /// Label for parent email input field
  ///
  /// In en, this message translates to:
  /// **'Parent\'s Email'**
  String get parentEmailLabel;

  /// Hint text for parent email input field
  ///
  /// In en, this message translates to:
  /// **'Enter parent\'s email for progress report'**
  String get parentEmailHintText;

  /// Validation message for child name field
  ///
  /// In en, this message translates to:
  /// **'Please enter child\'s name'**
  String get childNameValidation;

  /// Validation message for parent email field
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get parentEmailValidation;

  /// Text for start learning session button
  ///
  /// In en, this message translates to:
  /// **'Start Learning Session! 🎨'**
  String get startLearningSessionButton;

  /// Description of what the learning session will cover
  ///
  /// In en, this message translates to:
  /// **'We\'ll learn about primary colors and then test what you learned!'**
  String get learningDescription;

  /// Title for end session dialog
  ///
  /// In en, this message translates to:
  /// **'End Learning Session'**
  String get endLearningSession;

  /// Confirmation message for ending session
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to end this session?'**
  String get endSessionConfirmation;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// End session button text
  ///
  /// In en, this message translates to:
  /// **'End Session'**
  String get endSession;

  /// Error message when connection fails
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to session'**
  String get failedToConnect;

  /// Placeholder text shown in transcription area
  ///
  /// In en, this message translates to:
  /// **'Transcriptions will appear here when the AI agent speaks.\n\nNote: This requires the backend AI agent to be running and connected to the same LiveKit room.'**
  String get transcriptionPlaceholder;

  /// Label for mute microphone button
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get mute;

  /// Label for unmute microphone button
  ///
  /// In en, this message translates to:
  /// **'Unmute'**
  String get unmute;

  /// Status message showing microphone state
  ///
  /// In en, this message translates to:
  /// **'Microphone is {status}. Tap to toggle.'**
  String microphoneStatus(String status);

  /// Status text for enabled state
  ///
  /// In en, this message translates to:
  /// **'enabled'**
  String get enabled;

  /// Status text for disabled state
  ///
  /// In en, this message translates to:
  /// **'disabled'**
  String get disabled;

  /// Status message while waiting for connection
  ///
  /// In en, this message translates to:
  /// **'Waiting for connection...'**
  String get waitingForConnection;

  /// Learning session screen title with emoji
  ///
  /// In en, this message translates to:
  /// **'🌈 Learning with {childName}'**
  String learningWithTitleEmoji(String childName);

  /// Loading message with emojis
  ///
  /// In en, this message translates to:
  /// **'🎨✨ Starting your learning session...'**
  String get startingSessionWithEmoji;

  /// Connection error title with emoji
  ///
  /// In en, this message translates to:
  /// **'😟 Connection Error'**
  String get connectionErrorEmoji;

  /// Retry button with emoji
  ///
  /// In en, this message translates to:
  /// **'🔄 Retry Connection'**
  String get retryEmoji;

  /// AI teacher title with art emojis
  ///
  /// In en, this message translates to:
  /// **'🎨 AI Art Teacher! 🎨'**
  String get aiTeacherTitle;

  /// Connected status with emoji
  ///
  /// In en, this message translates to:
  /// **'✨ Connected'**
  String get connectedWithEmoji;

  /// Offline status with emoji
  ///
  /// In en, this message translates to:
  /// **'⏳ Offline Mode'**
  String get offlineModeWithEmoji;

  /// Transcription placeholder with emojis
  ///
  /// In en, this message translates to:
  /// **'💬✨ Transcriptions will appear here when the AI agent speaks.\n\nNote: This requires the backend AI agent to be running and connected to the same LiveKit room.'**
  String get transcriptionPlaceholderWithEmoji;

  /// Validation message for invalid email format
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmailValidation;

  /// General form validation error message
  ///
  /// In en, this message translates to:
  /// **'Please fix the errors above before continuing.'**
  String get formValidationError;

  /// Generic error message for unexpected errors
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get genericError;

  /// Title for change user dialog
  ///
  /// In en, this message translates to:
  /// **'Change User'**
  String get changeUser;

  /// Confirmation message for changing user
  ///
  /// In en, this message translates to:
  /// **'This will clear the saved user data and return to the welcome screen. Continue?'**
  String get changeUserConfirmation;

  /// Continue button text for confirmations
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// Validation message for name minimum length
  ///
  /// In en, this message translates to:
  /// **'Name must be at least {minLength} characters long'**
  String nameMinLengthValidation(int minLength);

  /// Validation message for name maximum length
  ///
  /// In en, this message translates to:
  /// **'Name must be less than {maxLength} characters long'**
  String nameMaxLengthValidation(int maxLength);

  /// Emoji for AI teacher
  ///
  /// In en, this message translates to:
  /// **'🎨'**
  String get aiTeacherEmoji;

  /// Emoji for connected status
  ///
  /// In en, this message translates to:
  /// **'✅'**
  String get connectedEmoji;

  /// Emoji for offline status
  ///
  /// In en, this message translates to:
  /// **'❌'**
  String get offlineEmoji;

  /// Emoji for sad/error state
  ///
  /// In en, this message translates to:
  /// **'😢'**
  String get sadEmoji;

  /// Emojis for loading state
  ///
  /// In en, this message translates to:
  /// **'⏳✨'**
  String get loadingEmojis;

  /// Emojis for transcription area
  ///
  /// In en, this message translates to:
  /// **'💬📝'**
  String get transcriptionEmojis;

  /// Error when LIVEKIT_SANDBOX_ID is not configured
  ///
  /// In en, this message translates to:
  /// **'Sandbox ID is not set'**
  String get sandboxIdNotSet;

  /// Debug message when sandbox ID is not set
  ///
  /// In en, this message translates to:
  /// **'LIVEKIT_SANDBOX_ID is not set in environment variables'**
  String get sandboxIdNotSetDebug;

  /// Debug message showing sandbox ID being used
  ///
  /// In en, this message translates to:
  /// **'Using sandbox ID: {sandboxId}'**
  String usingSandboxId(String sandboxId);

  /// Error when parsing LiveKit response fails
  ///
  /// In en, this message translates to:
  /// **'Error parsing connection details from LiveKit: {error}'**
  String errorParsingConnectionDetails(String error);

  /// Error from LiveKit API with status code and response
  ///
  /// In en, this message translates to:
  /// **'LiveKit API Error {statusCode}: {errorBody}'**
  String liveKitApiError(int statusCode, String errorBody);

  /// Error when network connection fails
  ///
  /// In en, this message translates to:
  /// **'Network connection failed. Check your internet connection.'**
  String get networkConnectionFailed;

  /// Error when request times out
  ///
  /// In en, this message translates to:
  /// **'Request timed out. LiveKit service may be unavailable.'**
  String get requestTimedOut;

  /// General connection error to LiveKit
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to LiveKit Cloud sandbox: {error}'**
  String failedToConnectToLiveKit(String error);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
