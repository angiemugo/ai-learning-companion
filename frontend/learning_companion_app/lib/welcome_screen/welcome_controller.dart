import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_companion_app/welcome_screen/welcome_form_state.dart';
import 'package:learning_companion_app/utils/shared_prefs_repository.dart';

final welcomeFormProvider =
    StateNotifierProvider<WelcomeFormNotifier, WelcomeFormState>((ref) {
  return WelcomeFormNotifier();
});

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

class WelcomeFormNotifier extends StateNotifier<WelcomeFormState> {
  final SharedPrefsRepository _repository = SharedPrefsRepository();

  WelcomeFormNotifier() : super(const WelcomeFormState()) {
    _loadSavedData();
  }

  void updateChildName(String name) {
    state = state.copyWith(childName: name.trim());
    _repository.saveChildName(state.childName);
  }

  void updateParentEmail(String email) {
    state = state.copyWith(parentEmail: email.trim());
    _repository.saveParentEmail(state.parentEmail);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  Future<void> _loadSavedData() async {
    final savedChildName = await _repository.getChildName() ?? '';
    final savedParentEmail = await _repository.getParentEmail() ?? '';

    state = state.copyWith(
      childName: savedChildName,
      parentEmail: savedParentEmail,
    );
  }

  Future<void> clearSavedData() async {
    await _repository.clearData();
    state = const WelcomeFormState();
  }
}
