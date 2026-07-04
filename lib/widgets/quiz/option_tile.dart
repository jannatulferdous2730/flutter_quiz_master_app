import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/quiz_provider.dart';
import '../../theme/app_colors.dart';

class OptionTile extends StatelessWidget {
  final String option;
  final int optionIndex;

  const OptionTile({
    super.key,
    required this.option,
    required this.optionIndex,
  });

  static const _labels = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final isSelected = quiz.selectedOption == option;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final borderColor = isSelected ? AppColors.primary : Colors.transparent;
    final bgColor = isSelected
        ? AppColors.primary.withValues(alpha: 0.12)
        : (isDark ? AppColors.darkCard : AppColors.lightCard);
    final labelBg =
        isSelected ? AppColors.primary : AppColors.primary.withValues(alpha: 0.12);
    final labelColor = isSelected ? Colors.white : AppColors.primary;

    return GestureDetector(
      onTap: () => context.read<QuizProvider>().selectOption(option),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.18),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: (isDark ? Colors.black : Colors.grey)
                        .withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: labelBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  _labels[optionIndex % 4],
                  style: TextStyle(
                    color: labelColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                option,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
