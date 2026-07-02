import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/quiz_provider.dart';
import '../../theme/app_colors.dart';

class QuizNavButtons extends StatefulWidget {
  const QuizNavButtons({super.key});

  @override
  State<QuizNavButtons> createState() => _QuizNavButtonsState();
}

class _QuizNavButtonsState extends State<QuizNavButtons> {
  bool _isFinishing = false;

  Future<void> _handleFinish(QuizProvider quiz) async {
    if (_isFinishing) return;
    setState(() => _isFinishing = true);
    try {
      final result = await quiz.finishQuiz();
      if (mounted) {
        context.go('/result', extra: result);
      }
    } finally {
      if (mounted) setState(() => _isFinishing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final hasSelection = quiz.selectedOption != null;
    final isLast = quiz.isLastQuestion;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: isLast
          ? ElevatedButton.icon(
              onPressed: hasSelection && !_isFinishing
                  ? () => _handleFinish(quiz)
                  : null,
              icon: _isFinishing
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.emoji_events_rounded),
              label: Text(_isFinishing ? 'Saving…' : 'Finish Quiz'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    hasSelection ? AppColors.success : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            )
          : ElevatedButton.icon(
              onPressed: hasSelection
                  ? () => context.read<QuizProvider>().nextQuestion()
                  : null,
              icon: const Icon(Icons.arrow_forward_rounded),
              label: const Text('Next Question'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
    );
  }
}
