import 'package:flutter/material.dart';
import 'package:learning_companion_app/l10n/app_localizations.dart';
import 'package:learning_companion_app/utils/app_constants.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'app-header',
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spaceLarge),
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
              color: Theme.of(context).shadowColor.withValues(alpha: 0.3),
              spreadRadius: AppConstants.shadowSpread,
              blurRadius: AppConstants.shadowBlur,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              Icons.school,
              size: AppConstants.iconXxl,
              color: Theme.of(context).iconTheme.color,
            ),
            const SizedBox(height: AppConstants.spaceSmall),
            Text(
              AppLocalizations.of(context)!.appTitle,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spaceSmall),
            Text(
              AppLocalizations.of(context)!.welcomeTagline,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
