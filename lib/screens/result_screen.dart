import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/quiz_result_model.dart';
import '../theme/app_colors.dart';
import '../widgets/result/result_action_buttons.dart';
import '../widgets/result/result_metric_row.dart';
import '../widgets/result/result_summary_card.dart';

class ResultScreen extends StatelessWidget {
  final QuizResultModel result;

  const ResultScreen({super.key, required this.result});

  String get _greeting {
    if (result.percentage >= 90) return '🏆 Outstanding!';
    if (result.percentage >= 70) return '🎉 Great Job!';
    if (result.percentage >= 50) return '👍 Good Effort!';
    return '💪 Keep Practising!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.home_rounded),
          tooltip: 'Home',
          onPressed: () => context.go('/'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Category pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  result.categoryName,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                _greeting,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                'You answered ${result.score} of ${result.totalQuestions} correctly',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              ResultSummaryCard(result: result),
              const SizedBox(height: 20),
              ResultMetricRow(
                totalQuestions: result.totalQuestions,
                correctAnswers: result.score,
              ),
              const SizedBox(height: 40),
              const ResultActionButtons(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
