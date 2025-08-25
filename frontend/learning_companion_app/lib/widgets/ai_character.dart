import 'package:flutter/material.dart';
import 'package:learning_companion_app/models/learning_session_state.dart';
import 'package:learning_companion_app/utils/app_constants.dart';
import 'package:learning_companion_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiCharacter extends ConsumerStatefulWidget {
  final LearningSessionState session;
  const AiCharacter({super.key, required this.session});

  @override
  ConsumerState<AiCharacter> createState() => _AiCharacterState();
}

class _AiCharacterState extends ConsumerState<AiCharacter> {
  @override
  Widget build(BuildContext context) {
    final isConnected =
        widget.session.connectionState == ConnectionStateEnum.connected;

    return Container(
      height: AppConstants.containerHeightMedium,
      width: double.infinity,
      margin: const EdgeInsets.all(AppConstants.spaceMedium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
            spreadRadius: AppConstants.shadowSpread,
            blurRadius: AppConstants.shadowBlur,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spaceMedium),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/ello_teacher.png',
                width: AppConstants.iconXxl,
                height: AppConstants.iconXxl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Text(
                    AppLocalizations.of(context)!.aiTeacherEmoji,
                    style: const TextStyle(fontSize: AppConstants.iconXl),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spaceMedium),
          Text(
            AppLocalizations.of(context)!.aiTeacherTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppConstants.spaceXs),
          if (isConnected)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.connectedEmoji,
                  style: const TextStyle(fontSize: AppConstants.textMedium),
                ),
                const SizedBox(width: AppConstants.spaceXs),
                Text(
                  AppLocalizations.of(context)!.connected,
                  style: TextStyle(
                    fontSize: AppConstants.textSmall,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.offlineEmoji,
                  style: const TextStyle(fontSize: AppConstants.textMedium),
                ),
                const SizedBox(width: AppConstants.spaceXs),
                Text(
                  AppLocalizations.of(context)!.offlineMode,
                  style: TextStyle(
                    fontSize: AppConstants.textSmall,
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
