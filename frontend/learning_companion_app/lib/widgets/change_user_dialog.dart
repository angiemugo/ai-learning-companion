import 'package:flutter/material.dart';
import 'package:learning_companion_app/l10n/app_localizations.dart';
import 'package:learning_companion_app/utils/shared_prefs_repository.dart';

class ChangeUserDialog extends StatelessWidget {
  final SharedPrefsRepository _repository = SharedPrefsRepository();

  ChangeUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.changeUser),
      content: Text(AppLocalizations.of(context)!.changeUserConfirmation),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () => _handleChangeUser(context),
          child: Text(AppLocalizations.of(context)!.continueAction),
        ),
      ],
    );
  }

  Future<void> _handleChangeUser(BuildContext context) async {
    try {
      await _repository.clearData();

      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.genericError),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ChangeUserDialog(),
    );
  }
}
