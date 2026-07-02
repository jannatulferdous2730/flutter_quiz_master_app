import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ResultMetricRow extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  
  const ResultMetricRow({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final wrongAnswers = totalQuestions - correctAnswers;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget buildMetric(String label, int value, Color color, IconData icon) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                '$value',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        buildMetric('Total', totalQuestions, AppColors.primary, Icons.quiz_rounded),
        const SizedBox(width: 12),
        buildMetric('Correct', correctAnswers, AppColors.success, Icons.check_circle_rounded),
        const SizedBox(width: 12),
        buildMetric('Wrong', wrongAnswers, AppColors.error, Icons.cancel_rounded),
      ],
    );
  }
}
