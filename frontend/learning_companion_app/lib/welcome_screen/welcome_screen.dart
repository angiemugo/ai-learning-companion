import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_companion_app/welcome_screen/welcome_controller.dart';
import 'package:learning_companion_app/utils/app_constants.dart';
import 'package:learning_companion_app/widgets/custom_text_field.dart';
import 'package:learning_companion_app/widgets/welcome_header.dart';
import 'package:learning_companion_app/learning_screen/learning_session_screen.dart';
import 'package:learning_companion_app/l10n/app_localizations.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final _childNameController = TextEditingController();
  final _parentEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final formState = ref.read(welcomeFormProvider);
      _childNameController.text = formState.childName;
      _parentEmailController.text = formState.parentEmail;
       if (formState.childName.isNotEmpty && formState.parentEmail.isNotEmpty) {

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => LearningSessionScreen(childName: formState.childName, parentEmail: formState.parentEmail,), 
          ),
        );
    }
        });

  }

  @override
  void dispose() {
    _childNameController.dispose();
    _parentEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(welcomeFormProvider);
    final formNotifier = ref.watch(welcomeFormProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spaceMedium),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const WelcomeHeader(),
                const SizedBox(height: AppConstants.spaceLarge),
                if (formState.error != null)
                  Container(
                    padding: const EdgeInsets.all(AppConstants.spaceMedium),
                    margin:
                        const EdgeInsets.only(bottom: AppConstants.spaceMedium),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusSmall),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.error,
                        width: AppConstants.elevationSmall / 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: AppConstants.spaceSmall),
                        Expanded(
                          child: Text(
                            formState.error!,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                              fontSize: AppConstants.textMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                CustomTextField(
                  controller: _childNameController,
                  labelText: AppLocalizations.of(context)!.childNameLabel,
                  hintText: AppLocalizations.of(context)!.childNameHint,
                  prefixIcon: Icons.child_care,
                  enabled: !formState.isLoading,
                  maxLength: AppConstants.childNameMaxLength,
                  autocorrect: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                  validator: _validateChildName,
                  onChanged: (value) {
                    formNotifier.updateChildName(value);
                    formNotifier.setError(null);
                  },
                ),
                const SizedBox(height: AppConstants.spaceMedium),
                CustomTextField(
                  controller: _parentEmailController,
                  labelText: AppLocalizations.of(context)!.parentEmailLabel,
                  hintText: AppLocalizations.of(context)!.parentEmailHintText,
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !formState.isLoading,
                  validator: _validateEmail,
                  onChanged: (value) {
                    formNotifier.updateParentEmail(value);
                    formNotifier.setError(null);
                  },
                ),
                const SizedBox(height: AppConstants.spaceLarge),
                SizedBox(
                  width: double.infinity,
                  height: AppConstants.buttonHeight,
                  child: ElevatedButton(
                    onPressed:
                        formState.isLoading ? null : _startLearningSession,
                    child: formState.isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: AppConstants.progressSize,
                                height: AppConstants.progressSize,
                                child: CircularProgressIndicator(
                                  strokeWidth: AppConstants.progressStroke,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppConstants.spaceMedium),
                              Text(
                                AppLocalizations.of(context)!.startingSession,
                              ),
                            ],
                          )
                        : Text(
                            AppLocalizations.of(context)!
                                .startLearningSessionButton,
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
                const SizedBox(height: AppConstants.spaceMedium),
                Text(
                  AppLocalizations.of(context)!.learningDescription,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateChildName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.childNameValidation;
    }
    if (value.trim().length < AppConstants.childNameMinLength) {
      return AppLocalizations.of(context)!
          .nameMinLengthValidation(AppConstants.childNameMinLength);
    }
    if (value.trim().length > AppConstants.childNameMaxLength) {
      return AppLocalizations.of(context)!
          .nameMaxLengthValidation(AppConstants.childNameMaxLength);
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.parentEmailValidation;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$',
      caseSensitive: false,
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return AppLocalizations.of(context)!.invalidEmailValidation;
    }

    return null;
  }

  Future<void> _startLearningSession() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      ref.read(welcomeFormProvider.notifier).setError(
            AppLocalizations.of(context)!.formValidationError,
          );
      return;
    }

    final formNotifier = ref.read(welcomeFormProvider.notifier);
    formNotifier.setLoading(true);
    formNotifier.setError(null);

    try {
      await Future.delayed(AppConstants.animationSlow);

      if (mounted) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                LearningSessionScreen(
              childName: _childNameController.text.trim(),
              parentEmail: _parentEmailController.text.trim(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.easeInOut)),
                ),
                child: child,
              );
            },
            transitionDuration: AppConstants.animationMedium,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        formNotifier.setError(
          AppLocalizations.of(context)!.genericError,
        );
      }
    } finally {
      if (mounted) {
        formNotifier.setLoading(false);
      }
    }
  }
}
