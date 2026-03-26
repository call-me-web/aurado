// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(examRepository)
final examRepositoryProvider = ExamRepositoryProvider._();

final class ExamRepositoryProvider
    extends $FunctionalProvider<ExamRepository, ExamRepository, ExamRepository>
    with $Provider<ExamRepository> {
  ExamRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'examRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$examRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExamRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExamRepository create(Ref ref) {
    return examRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExamRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExamRepository>(value),
    );
  }
}

String _$examRepositoryHash() => r'c8e79a56143633193cdfe801d776b41d2f496b84';

@ProviderFor(exams)
final examsProvider = ExamsFamily._();

final class ExamsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ExamModel>>,
          List<ExamModel>,
          FutureOr<List<ExamModel>>
        >
    with $FutureModifier<List<ExamModel>>, $FutureProvider<List<ExamModel>> {
  ExamsProvider._({
    required ExamsFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'examsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$examsHash();

  @override
  String toString() {
    return r'examsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<ExamModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ExamModel>> create(Ref ref) {
    final argument = this.argument as (String, String);
    return exams(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is ExamsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$examsHash() => r'd0a935dfe1c459ca7313309dbcbd1bf31de70b76';

final class ExamsFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<ExamModel>>, (String, String)> {
  ExamsFamily._()
    : super(
        retry: null,
        name: r'examsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExamsProvider call(String targetType, String targetId) =>
      ExamsProvider._(argument: (targetType, targetId), from: this);

  @override
  String toString() => r'examsProvider';
}

@ProviderFor(exam)
final examProvider = ExamFamily._();

final class ExamProvider
    extends
        $FunctionalProvider<
          AsyncValue<ExamModel>,
          ExamModel,
          FutureOr<ExamModel>
        >
    with $FutureModifier<ExamModel>, $FutureProvider<ExamModel> {
  ExamProvider._({
    required ExamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'examProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$examHash();

  @override
  String toString() {
    return r'examProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ExamModel> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ExamModel> create(Ref ref) {
    final argument = this.argument as String;
    return exam(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ExamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$examHash() => r'48fd30035ac6751a9139ed37db5881a3d9be1583';

final class ExamFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ExamModel>, String> {
  ExamFamily._()
    : super(
        retry: null,
        name: r'examProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExamProvider call(String examId) =>
      ExamProvider._(argument: examId, from: this);

  @override
  String toString() => r'examProvider';
}

@ProviderFor(ActiveExamSession)
final activeExamSessionProvider = ActiveExamSessionProvider._();

final class ActiveExamSessionProvider
    extends $AsyncNotifierProvider<ActiveExamSession, ExamAttemptModel?> {
  ActiveExamSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeExamSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeExamSessionHash();

  @$internal
  @override
  ActiveExamSession create() => ActiveExamSession();
}

String _$activeExamSessionHash() => r'89b84f10f779130dfa4ad1cb79378d00da5c9181';

abstract class _$ActiveExamSession extends $AsyncNotifier<ExamAttemptModel?> {
  FutureOr<ExamAttemptModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ExamAttemptModel?>, ExamAttemptModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ExamAttemptModel?>, ExamAttemptModel?>,
              AsyncValue<ExamAttemptModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
