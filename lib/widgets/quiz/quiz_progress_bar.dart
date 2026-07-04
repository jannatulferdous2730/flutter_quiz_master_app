import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class QuizProgressBar extends StatelessWidget {
  /// Value between 0.0 and 1.0.
  final double progress;

  const QuizProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progress),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        builder: (context, value, _) {
          return LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          );
        },
      ),
    );
  }
}
