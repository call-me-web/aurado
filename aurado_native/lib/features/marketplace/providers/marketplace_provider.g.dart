// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MarketplaceTenants)
final marketplaceTenantsProvider = MarketplaceTenantsProvider._();

final class MarketplaceTenantsProvider
    extends $AsyncNotifierProvider<MarketplaceTenants, List<TenantModel>> {
  MarketplaceTenantsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'marketplaceTenantsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$marketplaceTenantsHash();

  @$internal
  @override
  MarketplaceTenants create() => MarketplaceTenants();
}

String _$marketplaceTenantsHash() =>
    r'3b60aa7b81e06077727e10fc9874808ec9b4cf84';

abstract class _$MarketplaceTenants extends $AsyncNotifier<List<TenantModel>> {
  FutureOr<List<TenantModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<TenantModel>>, List<TenantModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<TenantModel>>, List<TenantModel>>,
              AsyncValue<List<TenantModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(tenant)
final tenantProvider = TenantFamily._();

final class TenantProvider
    extends
        $FunctionalProvider<
          AsyncValue<TenantModel?>,
          TenantModel?,
          FutureOr<TenantModel?>
        >
    with $FutureModifier<TenantModel?>, $FutureProvider<TenantModel?> {
  TenantProvider._({
    required TenantFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tenantProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tenantHash();

  @override
  String toString() {
    return r'tenantProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TenantModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TenantModel?> create(Ref ref) {
    final argument = this.argument as String;
    return tenant(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TenantProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tenantHash() => r'4bcace895fecf1df56e7482b5370c1915c56a51d';

final class TenantFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TenantModel?>, String> {
  TenantFamily._()
    : super(
        retry: null,
        name: r'tenantProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TenantProvider call(String id) => TenantProvider._(argument: id, from: this);

  @override
  String toString() => r'tenantProvider';
}

@ProviderFor(DiscoveryCourses)
final discoveryCoursesProvider = DiscoveryCoursesFamily._();

final class DiscoveryCoursesProvider
    extends
        $AsyncNotifierProvider<DiscoveryCourses, List<DiscoveryCourseModel>> {
  DiscoveryCoursesProvider._({
    required DiscoveryCoursesFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'discoveryCoursesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$discoveryCoursesHash();

  @override
  String toString() {
    return r'discoveryCoursesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DiscoveryCourses create() => DiscoveryCourses();

  @override
  bool operator ==(Object other) {
    return other is DiscoveryCoursesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$discoveryCoursesHash() => r'5d349976a3f50890000224e9040b7ea4811528c5';

final class DiscoveryCoursesFamily extends $Family
    with
        $ClassFamilyOverride<
          DiscoveryCourses,
          AsyncValue<List<DiscoveryCourseModel>>,
          List<DiscoveryCourseModel>,
          FutureOr<List<DiscoveryCourseModel>>,
          String?
        > {
  DiscoveryCoursesFamily._()
    : super(
        retry: null,
        name: r'discoveryCoursesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DiscoveryCoursesProvider call({String? tenantId}) =>
      DiscoveryCoursesProvider._(argument: tenantId, from: this);

  @override
  String toString() => r'discoveryCoursesProvider';
}

abstract class _$DiscoveryCourses
    extends $AsyncNotifier<List<DiscoveryCourseModel>> {
  late final _$args = ref.$arg as String?;
  String? get tenantId => _$args;

  FutureOr<List<DiscoveryCourseModel>> build({String? tenantId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<DiscoveryCourseModel>>,
              List<DiscoveryCourseModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DiscoveryCourseModel>>,
                List<DiscoveryCourseModel>
              >,
              AsyncValue<List<DiscoveryCourseModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(tenantId: _$args));
  }
}

@ProviderFor(EnrolledCourses)
final enrolledCoursesProvider = EnrolledCoursesProvider._();

final class EnrolledCoursesProvider
    extends
        $AsyncNotifierProvider<EnrolledCourses, List<DiscoveryCourseModel>> {
  EnrolledCoursesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enrolledCoursesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enrolledCoursesHash();

  @$internal
  @override
  EnrolledCourses create() => EnrolledCourses();
}

String _$enrolledCoursesHash() => r'ff7cb5b91442d263956674703be0f0d7274f1299';

abstract class _$EnrolledCourses
    extends $AsyncNotifier<List<DiscoveryCourseModel>> {
  FutureOr<List<DiscoveryCourseModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<DiscoveryCourseModel>>,
              List<DiscoveryCourseModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DiscoveryCourseModel>>,
                List<DiscoveryCourseModel>
              >,
              AsyncValue<List<DiscoveryCourseModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Computes the top popular categories dynamically based on fetched courses.

@ProviderFor(popularCategories)
final popularCategoriesProvider = PopularCategoriesProvider._();

/// Computes the top popular categories dynamically based on fetched courses.

final class PopularCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  /// Computes the top popular categories dynamically based on fetched courses.
  PopularCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'popularCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popularCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return popularCategories(ref);
  }
}

String _$popularCategoriesHash() => r'49b984beb9a3a848b54e67c94d6c17b5df2cb0b7';

@ProviderFor(EnrollmentController)
final enrollmentControllerProvider = EnrollmentControllerProvider._();

final class EnrollmentControllerProvider
    extends $NotifierProvider<EnrollmentController, AsyncValue<String?>> {
  EnrollmentControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enrollmentControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enrollmentControllerHash();

  @$internal
  @override
  EnrollmentController create() => EnrollmentController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<String?>>(value),
    );
  }
}

String _$enrollmentControllerHash() =>
    r'9957a7364ad594359853d026972433fdbede8597';

abstract class _$EnrollmentController extends $Notifier<AsyncValue<String?>> {
  AsyncValue<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, AsyncValue<String?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, AsyncValue<String?>>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
