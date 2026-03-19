import 'dart:io';
import 'package:aurado/core/di/service_locator.dart';
import 'package:aurado/features/exams/domain/models/exam_model.dart';
import 'package:aurado/features/exams/domain/repositories/exam_repository.dart';
import 'package:aurado/features/exams/presentation/providers/exam_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gap/gap.dart';

class CqScreen extends ConsumerStatefulWidget {
  final String examId;

  const CqScreen({super.key, required this.examId});

  @override
  ConsumerState<CqScreen> createState() => _CqScreenState();
}

class _CqScreenState extends ConsumerState<CqScreen> {
  final ImagePicker _picker = ImagePicker();
  final Map<String, List<File>> _localImages = {};
  int _currentQuestionIndex = 0;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _initializeExam());
  }

  Future<void> _initializeExam() async {
    final exam = await ref.read(examProvider(widget.examId).future);
    final userId = 'student_one'; // TODO: Auth state
    await ref
        .read(activeExamSessionProvider.notifier)
        .startSession(widget.examId, userId);

    final cqQuestions = exam.questions.where((q) => q.type == 'cq').toList();
    if (cqQuestions.isNotEmpty) {
      ref
          .read(activeExamSessionProvider.notifier)
          .setCurrentQuestion(cqQuestions.first.id);
    }
  }

  Future<void> _pickImage(String questionId) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    final file = File(image.path);
    setState(() {
      _localImages[questionId] = (_localImages[questionId] ?? [])..add(file);
    });

    _uploadImage(file, questionId);
  }

  Future<void> _uploadImage(File file, String questionId) async {
    setState(() => _isUploading = true);
    try {
      final attempt = ref.read(activeExamSessionProvider).value;
      if (attempt == null) throw Exception("Session not initialized");

      final tenantSlug = 'fix-academ'; // TODO: Dynamically fetch

      // Upload and get URL from R2
      final url = await sl<ExamRepository>().uploadCqAnswerImage(
        file,
        tenantSlug,
        attempt.id,
        questionId,
      );

      // Now attach it to the provider (which handles the upsert to DB)
      await ref
          .read(activeExamSessionProvider.notifier)
          .attachCqImage(questionId, url);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _nextQuestion(int totalQuestions) {
    if (_currentQuestionIndex < totalQuestions - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      final exam = ref.read(examProvider(widget.examId)).value!;
      final cqQuestions = exam.questions.where((q) => q.type == 'cq').toList();
      ref
          .read(activeExamSessionProvider.notifier)
          .setCurrentQuestion(cqQuestions[_currentQuestionIndex].id);
    } else {
      // Submit
      ref.read(activeExamSessionProvider.notifier).submit();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final examAsync = ref.watch(examProvider(widget.examId));

    return Scaffold(
      appBar: AppBar(title: const Text('Creative Question')),
      body: examAsync.when(
        data: (exam) => _buildBody(exam),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildBody(ExamModel exam) {
    final questions = exam.questions.where((q) => q.type == 'cq').toList();
    if (questions.isEmpty) return const Center(child: Text('No CQ found.'));

    final question = questions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${_currentQuestionIndex + 1} of ${questions.length}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const Gap(16),
          Text(
            question.content,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Gap(24),
          Text(
            'Upload your handwritten answer:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Gap(16),
          _buildImageGrid(question.id),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: _isUploading ? null : () => _pickImage(question.id),
              icon: const Icon(Icons.camera_alt),
              label: Text(_isUploading ? 'Uploading...' : 'Take Photo'),
            ),
          ),
          const Gap(16),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: TextButton(
              onPressed: () => _nextQuestion(questions.length),
              child: Text(
                _currentQuestionIndex == questions.length - 1
                    ? 'Finish & Submit'
                    : 'Next Question',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid(String questionId) {
    final images = _localImages[questionId] ?? [];
    if (images.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: const Center(child: Text('No photos yet')),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                images[index],
                width: 150,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
