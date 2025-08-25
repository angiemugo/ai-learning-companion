import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_companion_app/utils/shared_prefs_repository.dart';
import 'package:learning_companion_app/welcome_screen/welcome_screen.dart';
import 'package:learning_companion_app/learning_screen/learning_session_screen.dart';
import 'package:learning_companion_app/widgets/loading_screen.dart';

final savedUserDataProvider = FutureProvider<Map<String, String>?>((ref) async {
  final repository = SharedPrefsRepository();
  final childName = await repository.getChildName();
  final parentEmail = await repository.getParentEmail();

  if (childName != null &&
      childName.isNotEmpty &&
      parentEmail != null &&
      parentEmail.isNotEmpty) {
    return {
      'childName': childName,
      'parentEmail': parentEmail,
    };
  }
  return null;
});

class AppRouter extends ConsumerWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedData = ref.watch(savedUserDataProvider);

    return savedData.when(
      data: (data) {
        if (data != null) {
          return LearningSessionScreen(
            childName: data['childName']!,
            parentEmail: data['parentEmail']!,
          );
        } else {
          return const WelcomeScreen();
        }
      },
      loading: () => const LoadingScreen(),
      error: (error, stackTrace) => const WelcomeScreen(),
    );
  }
}
