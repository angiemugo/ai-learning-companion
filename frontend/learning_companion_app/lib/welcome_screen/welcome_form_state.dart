class WelcomeFormState {
  final String childName;
  final String parentEmail;
  final bool isLoading;
  final String? error;

  const WelcomeFormState({
    this.childName = '',
    this.parentEmail = '',
    this.isLoading = false,
    this.error,
  });

  WelcomeFormState copyWith({
    String? childName,
    String? parentEmail,
    bool? isLoading,
    String? error,
  }) {
    return WelcomeFormState(
      childName: childName ?? this.childName,
      parentEmail: parentEmail ?? this.parentEmail,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
