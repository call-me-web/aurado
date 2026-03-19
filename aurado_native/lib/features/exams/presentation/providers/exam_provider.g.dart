// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$examsHash() => r'17d6edb08e9b97923a29ce057e5cfe6b260a76ef';

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

String _$examHash() => r'e74ae4bfc4ad2f6778f43c626010fd32d627630e';

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

String _$activeExamSessionHash() => r'66aea48fc1c62b9c2f67342378f331b57a478f05';

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
