import 'package:flutter/material.dart';
import 'package:learning_companion_app/l10n/app_localizations.dart';
import 'package:learning_companion_app/utils/app_constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.spaceLarge),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(AppConstants.radiusXl),
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.2),
                    spreadRadius: AppConstants.shadowSpread,
                    blurRadius: AppConstants.shadowBlur,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.loadingEmojis,
                    style: const TextStyle(fontSize: AppConstants.iconXxl),
                  ),
                  const SizedBox(height: AppConstants.spaceMedium),
                  CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    strokeWidth: AppConstants.progressStroke,
                  ),
                  const SizedBox(height: AppConstants.spaceLarge),
                  Text(
                    AppLocalizations.of(context)!.startingSession,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: AppConstants.textLarge,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
