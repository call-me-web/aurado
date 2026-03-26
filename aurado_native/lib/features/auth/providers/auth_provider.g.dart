// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Manages global authentication logic and state.

@ProviderFor(Auth)
final authProvider = AuthProvider._();

/// Manages global authentication logic and state.
final class AuthProvider extends $NotifierProvider<Auth, AuthStateData> {
  /// Manages global authentication logic and state.
  AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthStateData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthStateData>(value),
    );
  }
}

String _$authHash() => r'bb6f16eb2d6ccb215ad474a5c1d0d01850308411';

/// Manages global authentication logic and state.

abstract class _$Auth extends $Notifier<AuthStateData> {
  AuthStateData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthStateData, AuthStateData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthStateData, AuthStateData>,
              AuthStateData,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'1a55446dab144ea05a10e75828e4ab5ce652259e';

@ProviderFor(backupRepository)
final backupRepositoryProvider = BackupRepositoryProvider._();

final class BackupRepositoryProvider
    extends
        $FunctionalProvider<
          BackupRepository,
          BackupRepository,
          BackupRepository
        >
    with $Provider<BackupRepository> {
  BackupRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupRepositoryHash();

  @$internal
  @override
  $ProviderElement<BackupRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BackupRepository create(Ref ref) {
    return backupRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupRepository>(value),
    );
  }
}

String _$backupRepositoryHash() => r'6802196ca7e544f5909404291459fe9f0e80d2cc';
