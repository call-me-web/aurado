// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(marketplaceRepository)
final marketplaceRepositoryProvider = MarketplaceRepositoryProvider._();

final class MarketplaceRepositoryProvider
    extends
        $FunctionalProvider<
          MarketplaceRepository,
          MarketplaceRepository,
          MarketplaceRepository
        >
    with $Provider<MarketplaceRepository> {
  MarketplaceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'marketplaceRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$marketplaceRepositoryHash();

  @$internal
  @override
  $ProviderElement<MarketplaceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MarketplaceRepository create(Ref ref) {
    return marketplaceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MarketplaceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MarketplaceRepository>(value),
    );
  }
}

String _$marketplaceRepositoryHash() =>
    r'1831fe0f092d27cfcfe2b3130e61b4d83c61c084';

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
    r'3accbc6ccec2ca3f54930073a0d1adb16fc2c761';

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

@ProviderFor(searchTenants)
final searchTenantsProvider = SearchTenantsFamily._();

final class SearchTenantsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TenantModel>>,
          List<TenantModel>,
          FutureOr<List<TenantModel>>
        >
    with
        $FutureModifier<List<TenantModel>>,
        $FutureProvider<List<TenantModel>> {
  SearchTenantsProvider._({
    required SearchTenantsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchTenantsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchTenantsHash();

  @override
  String toString() {
    return r'searchTenantsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TenantModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TenantModel>> create(Ref ref) {
    final argument = this.argument as String;
    return searchTenants(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchTenantsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchTenantsHash() => r'21b266796a5d916813e549652601c13791d30db4';

final class SearchTenantsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TenantModel>>, String> {
  SearchTenantsFamily._()
    : super(
        retry: null,
        name: r'searchTenantsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SearchTenantsProvider call(String query) =>
      SearchTenantsProvider._(argument: query, from: this);

  @override
  String toString() => r'searchTenantsProvider';
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

String _$tenantHash() => r'd2b0d14236c2ccd86c877e8395b584eefd4f0c9b';

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
    required ({String? tenantId, String? category}) super.argument,
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
        '$argument';
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

String _$discoveryCoursesHash() => r'2639e16298113e02215e028309e8844e40298d86';

final class DiscoveryCoursesFamily extends $Family
    with
        $ClassFamilyOverride<
          DiscoveryCourses,
          AsyncValue<List<DiscoveryCourseModel>>,
          List<DiscoveryCourseModel>,
          FutureOr<List<DiscoveryCourseModel>>,
          ({String? tenantId, String? category})
        > {
  DiscoveryCoursesFamily._()
    : super(
        retry: null,
        name: r'discoveryCoursesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DiscoveryCoursesProvider call({String? tenantId, String? category}) =>
      DiscoveryCoursesProvider._(
        argument: (tenantId: tenantId, category: category),
        from: this,
      );

  @override
  String toString() => r'discoveryCoursesProvider';
}

abstract class _$DiscoveryCourses
    extends $AsyncNotifier<List<DiscoveryCourseModel>> {
  late final _$args = ref.$arg as ({String? tenantId, String? category});
  String? get tenantId => _$args.tenantId;
  String? get category => _$args.category;

  FutureOr<List<DiscoveryCourseModel>> build({
    String? tenantId,
    String? category,
  });
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
    element.handleCreate(
      ref,
      () => build(tenantId: _$args.tenantId, category: _$args.category),
    );
  }
}

@ProviderFor(featuredCourses)
final featuredCoursesProvider = FeaturedCoursesProvider._();

final class FeaturedCoursesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DiscoveryCourseModel>>,
          List<DiscoveryCourseModel>,
          FutureOr<List<DiscoveryCourseModel>>
        >
    with
        $FutureModifier<List<DiscoveryCourseModel>>,
        $FutureProvider<List<DiscoveryCourseModel>> {
  FeaturedCoursesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featuredCoursesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featuredCoursesHash();

  @$internal
  @override
  $FutureProviderElement<List<DiscoveryCourseModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DiscoveryCourseModel>> create(Ref ref) {
    return featuredCourses(ref);
  }
}

String _$featuredCoursesHash() => r'565f718ba516a7870d36f608ecccdb75d8aa1c1a';

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

String _$enrolledCoursesHash() => r'8b939936d60f7c09ba22c807240c02996c112135';

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

String _$popularCategoriesHash() => r'1933891d23fa5231b74e2fed6ff6a033d40cff1c';

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
    r'8deac39e03dfdc95b89485c4f77d2188e34895fb';

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
