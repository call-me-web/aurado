// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(curriculumRepository)
final curriculumRepositoryProvider = CurriculumRepositoryProvider._();

final class CurriculumRepositoryProvider
    extends
        $FunctionalProvider<
          CurriculumRepository,
          CurriculumRepository,
          CurriculumRepository
        >
    with $Provider<CurriculumRepository> {
  CurriculumRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'curriculumRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$curriculumRepositoryHash();

  @$internal
  @override
  $ProviderElement<CurriculumRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CurriculumRepository create(Ref ref) {
    return curriculumRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurriculumRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurriculumRepository>(value),
    );
  }
}

String _$curriculumRepositoryHash() =>
    r'd52b0f96fad9d0bf05c940d92bdafd82fe759d26';

@ProviderFor(curriculum)
final curriculumProvider = CurriculumFamily._();

final class CurriculumProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SubjectModel>>,
          List<SubjectModel>,
          FutureOr<List<SubjectModel>>
        >
    with
        $FutureModifier<List<SubjectModel>>,
        $FutureProvider<List<SubjectModel>> {
  CurriculumProvider._({
    required CurriculumFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'curriculumProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$curriculumHash();

  @override
  String toString() {
    return r'curriculumProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SubjectModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SubjectModel>> create(Ref ref) {
    final argument = this.argument as String;
    return curriculum(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CurriculumProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$curriculumHash() => r'966045dea631aa940a5ae3e60098d53740be0624';

final class CurriculumFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SubjectModel>>, String> {
  CurriculumFamily._()
    : super(
        retry: null,
        name: r'curriculumProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CurriculumProvider call(String courseId) =>
      CurriculumProvider._(argument: courseId, from: this);

  @override
  String toString() => r'curriculumProvider';
}
