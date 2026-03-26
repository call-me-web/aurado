import 'dart:async';
import 'package:aurado/core/security/secure_screen.dart';
import 'package:aurado/features/exams/domain/models/exam_model.dart';
import 'package:aurado/features/exams/presentation/providers/exam_provider.dart';
import 'package:aurado/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';

class McqScreen extends ConsumerStatefulWidget {
  final String examId;

  const McqScreen({super.key, required this.examId});

  @override
  ConsumerState<McqScreen> createState() => _McqScreenState();
}

class _McqScreenState extends ConsumerState<McqScreen>
    with WidgetsBindingObserver {
  int _currentQuestionIndex = 0;
  final Map<String, String> _selectedAnswers = {};
  late Timer _examTimer;
  int _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(() => _initializeExam());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _examTimer.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      ref
          .read(activeExamSessionProvider.notifier)
          .recordProctoringEvent(
            'app_backgrounded',
            metadata: 'Question Index: $_currentQuestionIndex',
          );
    }
  }

  Future<void> _initializeExam() async {
    final exam = await ref.read(examProvider(widget.examId).future);
    _secondsRemaining = exam.durationMinutes * 60;

    final authState = ref.read(authProvider);
    final userId = authState.user?.id ?? 'guest';
    
    await ref
        .read(activeExamSessionProvider.notifier)
        .startSession(widget.examId, userId);

    if (exam.questions.isNotEmpty) {
      ref
          .read(activeExamSessionProvider.notifier)
          .setCurrentQuestion(exam.questions.first.id);
    }

    _examTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _submitExam();
      }
    });
  }

  void _nextQuestion(int totalQuestions) {
    if (_currentQuestionIndex < totalQuestions - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      final questionId = ref
          .read(examProvider(widget.examId))
          .value!
          .questions[_currentQuestionIndex]
          .id;
      ref
          .read(activeExamSessionProvider.notifier)
          .setCurrentQuestion(questionId);
    } else {
      _showSubmitConfirmation();
    }
  }

  void _submitExam() {
    _examTimer.cancel();
    ref.read(activeExamSessionProvider.notifier).submit();
    Navigator.pop(context);
  }

  void _showSubmitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit Exam?'),
        content: const Text(
          'Are you sure you want to finish and submit your answers?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _submitExam();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final examAsync = ref.watch(examProvider(widget.examId));
    final theme = Theme.of(context);

    return SecureScreen(
      userName: 'Fahim',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Online Exam'),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedClock01,
                    color: theme.colorScheme.error,
                    size: 16,
                  ),
                  const Gap(8),
                  Text(
                    _formatTime(_secondsRemaining),
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: examAsync.when(
          data: (exam) => _buildExamBody(exam, theme),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  Widget _buildExamBody(ExamModel exam, ThemeData theme) {
    if (exam.questions.isEmpty) {
      return const Center(child: Text('No questions found.'));
    }

    final question = exam.questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / exam.questions.length;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(value: progress),
          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${_currentQuestionIndex + 1} of ${exam.questions.length}',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              Text(
                '${question.marks} Marks',
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
          const Gap(12),
          Text(
            question.content,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (question.explanation != null) ...[
            const Gap(12),
            Text(question.explanation!, style: theme.textTheme.bodyMedium),
          ],
          const Gap(32),
          Expanded(
            child: ListView.separated(
              itemCount: question.options.length,
              separatorBuilder: (context, index) => const Gap(16),
              itemBuilder: (context, index) {
                final option = question.options[index];
                final isSelected = _selectedAnswers[question.id] == option.id;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedAnswers[question.id] = option.id;
                    });

                    final answerObj = {
                      'selected_id': option.id,
                      'text': option.text,
                    };
                    ref
                        .read(activeExamSessionProvider.notifier)
                        .updateAnswer(question.id, answerObj);
                  },
                  borderRadius: BorderRadius.circular(7.0),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.dividerColor,
                        width: 2,
                      ),
                      color: isSelected
                          ? theme.colorScheme.primaryContainer.withValues(
                              alpha: 0.1,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          String.fromCharCode(65 + index), // A, B, C, D
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Gap(16),
                        Expanded(child: Text(option.text)),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: theme.colorScheme.primary,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Gap(24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => _nextQuestion(exam.questions.length),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
              child: Text(
                _currentQuestionIndex == exam.questions.length - 1
                    ? 'Submit Exam'
                    : 'Next Question',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    if (seconds <= 0) return "00:00";
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
