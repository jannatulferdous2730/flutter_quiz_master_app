import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/category_model.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/common/loading_view.dart';
import '../widgets/quiz/question_counter.dart';
import '../widgets/quiz/quiz_progress_bar.dart';
import '../widgets/quiz/question_card.dart';
import '../widgets/quiz/option_tile.dart';
import '../widgets/quiz/quiz_nav_buttons.dart';

class QuizScreen extends StatefulWidget {
  final CategoryModel category;

  const QuizScreen({super.key, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().loadQuiz(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          tooltip: 'Exit Quiz',
          onPressed: () => context.go('/'),
        ),
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quiz, _) {
          if (quiz.isLoading) {
            return const LoadingView(message: 'Loading questions…');
          }

          if (quiz.hasError || quiz.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.sentiment_dissatisfied_rounded,
                      size: 64,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      quiz.hasError
                          ? 'Failed to load questions.\nPlease try again.'
                          : 'No questions available\nfor this category.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.home_rounded),
                      label: const Text('Back to Home'),
                    ),
                  ],
                ),
              ),
            );
          }

          final question = quiz.currentQuestion!;
          final options = quiz.currentOptions!;
          final progress = quiz.questions.isNotEmpty
              ? (quiz.currentIndex + 1) / quiz.questions.length
              : 0.0;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Counter + progress bar
                  QuestionCounter(
                    current: quiz.currentIndex + 1,
                    total: quiz.questions.length,
                  ),
                  const SizedBox(height: 12),
                  QuizProgressBar(progress: progress),
                  const SizedBox(height: 24),

                  // Question card
                  QuestionCard(
                    questionText: question.question,
                    difficulty: question.difficulty,
                  ),
                  const SizedBox(height: 24),

                  // Options list (scrollable in case text is long)
                  Expanded(
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (context, index) => OptionTile(
                        option: options[index],
                        optionIndex: index,
                      ),
                    ),
                  ),

                  // Nav button
                  const QuizNavButtons(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
