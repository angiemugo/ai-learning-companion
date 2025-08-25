// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$learningSessionControllerHash() =>
    r'0b0ea03d4d82841083c13fb3e9f63491e1fef899';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$LearningSessionController
    extends BuildlessAutoDisposeAsyncNotifier<LearningSessionState> {
  late final String childName;
  late final String parentEmail;

  FutureOr<LearningSessionState> build({
    required String childName,
    required String parentEmail,
  });
}

/// See also [LearningSessionController].
@ProviderFor(LearningSessionController)
const learningSessionControllerProvider = LearningSessionControllerFamily();

/// See also [LearningSessionController].
class LearningSessionControllerFamily
    extends Family<AsyncValue<LearningSessionState>> {
  /// See also [LearningSessionController].
  const LearningSessionControllerFamily();

  /// See also [LearningSessionController].
  LearningSessionControllerProvider call({
    required String childName,
    required String parentEmail,
  }) {
    return LearningSessionControllerProvider(
      childName: childName,
      parentEmail: parentEmail,
    );
  }

  @override
  LearningSessionControllerProvider getProviderOverride(
    covariant LearningSessionControllerProvider provider,
  ) {
    return call(
      childName: provider.childName,
      parentEmail: provider.parentEmail,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'learningSessionControllerProvider';
}

/// See also [LearningSessionController].
class LearningSessionControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<LearningSessionController,
        LearningSessionState> {
  /// See also [LearningSessionController].
  LearningSessionControllerProvider({
    required String childName,
    required String parentEmail,
  }) : this._internal(
          () => LearningSessionController()
            ..childName = childName
            ..parentEmail = parentEmail,
          from: learningSessionControllerProvider,
          name: r'learningSessionControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$learningSessionControllerHash,
          dependencies: LearningSessionControllerFamily._dependencies,
          allTransitiveDependencies:
              LearningSessionControllerFamily._allTransitiveDependencies,
          childName: childName,
          parentEmail: parentEmail,
        );

  LearningSessionControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.childName,
    required this.parentEmail,
  }) : super.internal();

  final String childName;
  final String parentEmail;

  @override
  FutureOr<LearningSessionState> runNotifierBuild(
    covariant LearningSessionController notifier,
  ) {
    return notifier.build(
      childName: childName,
      parentEmail: parentEmail,
    );
  }

  @override
  Override overrideWith(LearningSessionController Function() create) {
    return ProviderOverride(
      origin: this,
      override: LearningSessionControllerProvider._internal(
        () => create()
          ..childName = childName
          ..parentEmail = parentEmail,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        childName: childName,
        parentEmail: parentEmail,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<LearningSessionController,
      LearningSessionState> createElement() {
    return _LearningSessionControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LearningSessionControllerProvider &&
        other.childName == childName &&
        other.parentEmail == parentEmail;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, childName.hashCode);
    hash = _SystemHash.combine(hash, parentEmail.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LearningSessionControllerRef
    on AutoDisposeAsyncNotifierProviderRef<LearningSessionState> {
  /// The parameter `childName` of this provider.
  String get childName;

  /// The parameter `parentEmail` of this provider.
  String get parentEmail;
}

class _LearningSessionControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<LearningSessionController,
        LearningSessionState> with LearningSessionControllerRef {
  _LearningSessionControllerProviderElement(super.provider);

  @override
  String get childName =>
      (origin as LearningSessionControllerProvider).childName;
  @override
  String get parentEmail =>
      (origin as LearningSessionControllerProvider).parentEmail;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
