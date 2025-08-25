import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_companion_app/l10n/app_localizations.dart';
import 'package:learning_companion_app/utils/app_constants.dart';

class ErrorScreen extends ConsumerWidget {
  final String error;
  final String childName;
  final String parentEmail;
  final VoidCallback onRetry;

  const ErrorScreen({
    super.key,
    required this.error,
    required this.childName,
    required this.parentEmail,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.connectionErrorEmoji),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.sadEmoji,
              style: const TextStyle(fontSize: AppConstants.iconXxl),
            ),
            const SizedBox(height: AppConstants.spaceLarge),
            Text(
              AppLocalizations.of(context)!.failedToConnect,
              style: TextStyle(
                fontSize: AppConstants.textXl,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: AppConstants.spaceSmall),
            Padding(
              padding: const EdgeInsets.all(AppConstants.spaceLarge),
              child: Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppConstants.textMedium,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
            const SizedBox(height: AppConstants.spaceLarge),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(AppLocalizations.of(context)!.retryEmoji),
            ),
          ],
        ),
      ),
    );
  }
}
