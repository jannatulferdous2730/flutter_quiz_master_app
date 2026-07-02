import 'package:flutter/material.dart';
import '../models/quiz_result_model.dart';
import '../widgets/result/result_summary_card.dart';
import '../widgets/result/result_metric_row.dart';
import '../widgets/result/result_action_buttons.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatelessWidget {
  final QuizResultModel result;
  
  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Completed'),
        automaticallyImplyLeading: false, // Prevent back button since they should use the actions
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          tooltip: 'Close',
          onPressed: () => context.go('/'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Great Job!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'You completed the ${result.categoryName} quiz.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              ResultSummaryCard(result: result),
              
              const SizedBox(height: 24),
              
              ResultMetricRow(
                totalQuestions: result.totalQuestions,
                correctAnswers: result.score,
              ),
              
              const SizedBox(height: 48),
              
              const ResultActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
