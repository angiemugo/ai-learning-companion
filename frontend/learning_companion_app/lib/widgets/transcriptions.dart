import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:learning_companion_app/utils/app_constants.dart';
import 'package:learning_companion_app/l10n/app_localizations.dart';
import 'package:learning_companion_app/models/learning_session_state.dart';

class Transcriptions extends ConsumerWidget {
  final LearningSessionState session;
  
  const Transcriptions({super.key, required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnected = session.connectionState == ConnectionStateEnum.connected;
    
    if (isConnected && session.transcriptions.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.all(AppConstants.spaceMedium),
        padding: const EdgeInsets.all(AppConstants.spaceMedium),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.transcriptionEmojis,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: AppConstants.spaceSmall),
                Text(
                  'Conversation',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spaceSmall),
            ...session.transcriptions.map((segment) => Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.spaceSmall),
              child: Text(
                segment.text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )),
          ],
        ),
      );
    } else {
      return _buildPlaceholderWidget(context);
    }
  }

  Widget _buildPlaceholderWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.spaceMedium),
      padding: const EdgeInsets.all(AppConstants.spaceMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusXl),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
          width: AppConstants.elevationSmall,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            spreadRadius: AppConstants.elevationSmall,
            blurRadius: AppConstants.spaceSmall,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.transcriptionEmojis,
            style: const TextStyle(fontSize: AppConstants.iconXxl),
          ),
          const SizedBox(height: AppConstants.spaceSmall),
          Text(
            AppLocalizations.of(context)!.transcriptionPlaceholder,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}