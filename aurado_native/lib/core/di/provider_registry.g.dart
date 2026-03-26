// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_registry.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(supabaseClient)
final supabaseClientProvider = SupabaseClientProvider._();

final class SupabaseClientProvider
    extends $FunctionalProvider<SupabaseClient, SupabaseClient, SupabaseClient>
    with $Provider<SupabaseClient> {
  SupabaseClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseClientHash();

  @$internal
  @override
  $ProviderElement<SupabaseClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SupabaseClient create(Ref ref) {
    return supabaseClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseClient>(value),
    );
  }
}

String _$supabaseClientHash() => r'834a58d6ae4b94e36f4e04a10d8a7684b929310e';

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'e42dff42b4826e7f2845bb0d9d4891b3a5c913d7';

@ProviderFor(dio)
final dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'70903c815d38c4b5809a824858828a365feaa97a';

@ProviderFor(networkInfo)
final networkInfoProvider = NetworkInfoProvider._();

final class NetworkInfoProvider
    extends $FunctionalProvider<NetworkInfo, NetworkInfo, NetworkInfo>
    with $Provider<NetworkInfo> {
  NetworkInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkInfoHash();

  @$internal
  @override
  $ProviderElement<NetworkInfo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NetworkInfo create(Ref ref) {
    return networkInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkInfo>(value),
    );
  }
}

String _$networkInfoHash() => r'b4d63136480cc6414c36a9624415313f800055f1';

@ProviderFor(signedUrlResolver)
final signedUrlResolverProvider = SignedUrlResolverProvider._();

final class SignedUrlResolverProvider
    extends
        $FunctionalProvider<
          SignedUrlResolver,
          SignedUrlResolver,
          SignedUrlResolver
        >
    with $Provider<SignedUrlResolver> {
  SignedUrlResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signedUrlResolverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signedUrlResolverHash();

  @$internal
  @override
  $ProviderElement<SignedUrlResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SignedUrlResolver create(Ref ref) {
    return signedUrlResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignedUrlResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignedUrlResolver>(value),
    );
  }
}

String _$signedUrlResolverHash() => r'ba7697ee32d1e1ef77bb5e7ba6b573e44449a956';

@ProviderFor(connectivity)
final connectivityProvider = ConnectivityProvider._();

final class ConnectivityProvider
    extends $FunctionalProvider<Connectivity, Connectivity, Connectivity>
    with $Provider<Connectivity> {
  ConnectivityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityHash();

  @$internal
  @override
  $ProviderElement<Connectivity> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Connectivity create(Ref ref) {
    return connectivity(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Connectivity value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Connectivity>(value),
    );
  }
}

String _$connectivityHash() => r'c8cb981d0ce03d9ad499e9c5654c16e6481c54d8';
