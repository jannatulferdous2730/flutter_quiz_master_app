import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class QuestionCard extends StatelessWidget {
  final String questionText;
  final String difficulty;

  const QuestionCard({
    super.key,
    required this.questionText,
    required this.difficulty,
  });

  Color get _difficultyColor {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return AppColors.diffEasy;
      case 'hard':
        return AppColors.diffHard;
      default:
        return AppColors.diffMedium;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: AppColors.primary.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Difficulty chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _difficultyColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              difficulty[0].toUpperCase() + difficulty.substring(1),
              style: TextStyle(
                color: _difficultyColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            questionText,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
