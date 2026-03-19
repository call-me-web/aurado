// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$curriculumHash() => r'610c71ee66ae58af15813d0ce2681c8db64dd93e';

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
