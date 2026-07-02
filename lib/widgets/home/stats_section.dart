import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';
import '../../theme/app_colors.dart';
import 'stat_card.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();
    final lastScoreText = home.lastTotal > 0
        ? '${home.lastScore}/${home.lastTotal}'
        : '—';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Text(
            'Your Stats',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: StatCard(
                  label: 'Total Attempts',
                  value: '${home.totalAttempts}',
                  icon: Icons.flag_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  label: 'Highest Score',
                  value: '${home.highestScore}',
                  icon: Icons.emoji_events_rounded,
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  label: 'Last Score',
                  value: lastScoreText,
                  icon: Icons.history_rounded,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
