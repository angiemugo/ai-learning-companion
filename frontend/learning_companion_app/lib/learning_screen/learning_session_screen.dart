import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_companion_app/models/learning_session_state.dart';
import 'package:learning_companion_app/widgets/ai_character.dart';
import 'package:learning_companion_app/widgets/transcriptions.dart';
import 'package:learning_companion_app/utils/app_constants.dart';
import 'package:learning_companion_app/utils/app_strings.dart';
import 'package:learning_companion_app/l10n/app_localizations.dart';
import 'package:learning_companion_app/widgets/error_screen.dart';
import 'package:learning_companion_app/widgets/loading_screen.dart';
import 'package:learning_companion_app/widgets/change_user_dialog.dart';
import 'learning_session_controller.dart';

class LearningSessionScreen extends ConsumerWidget {
  final String childName;
  final String parentEmail;

  const LearningSessionScreen({
    super.key,
    required this.childName,
    required this.parentEmail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionProvider = learningSessionControllerProvider(
      childName: childName,
      parentEmail: parentEmail,
    );

    final sessionAsync = ref.watch(sessionProvider);

    return sessionAsync.when(
      data: (state) => _ConnectedScreen(
        childName: childName,
        parentEmail: parentEmail,
        sessionProvider: sessionProvider,
      ),
      loading: () => const LoadingScreen(),
      error: (error, stackTrace) => ErrorScreen(
        error: error.toString(),
        childName: childName,
        parentEmail: parentEmail,
        onRetry: () => ref.invalidate(sessionProvider),
      ),
    );
  }
}

class _ConnectedScreen extends ConsumerWidget {
  final String childName;
  final String parentEmail;
  final LearningSessionControllerProvider sessionProvider;

  const _ConnectedScreen({
    required this.childName,
    required this.parentEmail,
    required this.sessionProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sessionProvider).value!;

    if (state.error != null) {
      return ErrorScreen(
        error: state.error!,
        childName: childName,
        parentEmail: parentEmail,
        onRetry: () => ref.invalidate(sessionProvider),
      );
    }

    final isConnected = state.connectionState == ConnectionStateEnum.connected;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.learningWithTitleEmoji(childName)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AiCharacter(session: state),
              Transcriptions(session: state),
              if (isConnected) _VoiceControls(
                childName: childName,
                parentEmail: parentEmail,
                sessionProvider: sessionProvider,
              ),
              _Instructions(sessionProvider: sessionProvider),
            ],
          ),
        ),
      ),
    );
  }
}

class _VoiceControls extends ConsumerWidget {
  final String childName;
  final String parentEmail;
  final LearningSessionControllerProvider sessionProvider;

  const _VoiceControls({
    required this.childName,
    required this.parentEmail,
    required this.sessionProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionProvider);
    
    return sessionAsync.when(
      data: (state) => Padding(
        padding: const EdgeInsets.all(AppConstants.spaceSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ControlButton(
              icon: state.isMicrophoneEnabled ? Icons.mic : Icons.mic_off,
              color: state.isMicrophoneEnabled
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.error,
              onTap: () => _toggleMicrophone(context, ref),
              label: state.isMicrophoneEnabled
                  ? '${AppStrings.muteEmoji} ${AppLocalizations.of(context)!.mute}'
                  : '${AppStrings.micEmoji} ${AppLocalizations.of(context)!.unmute}',
            ),
            _ControlButton(
              icon: Icons.exit_to_app,
              color: Theme.of(context).colorScheme.error,
              onTap: () => _endSession(context, ref),
              label: '${AppStrings.waveEmoji} ${AppLocalizations.of(context)!.endSession}',
            ),
          ],
        ),
      ),
      loading: () => const Padding(
        padding: EdgeInsets.all(AppConstants.spaceSmall),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Padding(
        padding: const EdgeInsets.all(AppConstants.spaceSmall),
        child: Text(
          '${AppStrings.voiceControlsUnavailable}: ${error.toString()}',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> _toggleMicrophone(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(sessionProvider.notifier).toggleMicrophone();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppStrings.failedToToggleMicrophone}: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _endSession(BuildContext context, WidgetRef ref) {
    final controller = ref.read(sessionProvider.notifier);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.endLearningSession),
        content: Text(AppLocalizations.of(context)!.endSessionConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ChangeUserDialog.show(context);
            },
            child: Text(AppLocalizations.of(context)!.changeUser),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await controller.disconnectFromSession();
              if (context.mounted) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            child: Text(AppLocalizations.of(context)!.endSession),
          ),
        ],
      ),
    );
  }
}

class _Instructions extends ConsumerWidget {
  final LearningSessionControllerProvider sessionProvider;
  
  const _Instructions({required this.sessionProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionProvider);
    
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spaceMedium),
      child: sessionAsync.when(
        data: (state) {
          final isConnected = state.connectionState == ConnectionStateEnum.connected;
          return Text(
            isConnected
                ? AppLocalizations.of(context)!.microphoneStatus(
                    state.isMicrophoneEnabled
                        ? AppLocalizations.of(context)!.enabled
                        : AppLocalizations.of(context)!.disabled,
                  )
                : AppLocalizations.of(context)!.waitingForConnection,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          );
        },
        loading: () => Text(
          AppLocalizations.of(context)!.waitingForConnection,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        error: (error, _) => Text(
          AppStrings.connectionErrorOccurred,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.error,
              ),
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String label;

  const _ControlButton({
    required this.icon,
    required this.color,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: AppConstants.iconXxl,
            height: AppConstants.iconXxl,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withValues(alpha: 0.7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  spreadRadius: AppConstants.shadowSpread,
                  blurRadius: AppConstants.shadowBlur,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary,
              size: AppConstants.iconMedium,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spaceXs),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: AppConstants.textSmall,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
