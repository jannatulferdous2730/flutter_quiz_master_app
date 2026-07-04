import 'dart:math';
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/question_model.dart';
import '../models/quiz_result_model.dart';
import '../services/quiz_data_service.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';

class QuizProvider extends ChangeNotifier {
  CategoryModel? _category;
  List<QuestionModel> _questions = [];
  List<List<String>> _shuffledOptionsPerQuestion = [];
  int _currentIndex = 0;
  String? _selectedOption;
  List<bool?> _answerCorrectness = [];
  bool _isLoading = false;
  bool _hasError = false;

  CategoryModel? get category => _category;
  List<QuestionModel> get questions => _questions;
  List<List<String>> get shuffledOptionsPerQuestion => _shuffledOptionsPerQuestion;
  int get currentIndex => _currentIndex;
  String? get selectedOption => _selectedOption;
  List<bool?> get answerCorrectness => _answerCorrectness;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get isEmpty => !_isLoading && _questions.isEmpty;

  QuestionModel? get currentQuestion =>
      _questions.isNotEmpty ? _questions[_currentIndex] : null;

  List<String>? get currentOptions =>
      _shuffledOptionsPerQuestion.isNotEmpty
          ? _shuffledOptionsPerQuestion[_currentIndex]
          : null;

  bool get isLastQuestion =>
      _questions.isNotEmpty && _currentIndex == _questions.length - 1;

  Future<void> loadQuiz(CategoryModel category) async {
    _isLoading = true;
    _hasError = false;
    _category = category;
    _questions = [];
    _shuffledOptionsPerQuestion = [];
    _currentIndex = 0;
    _selectedOption = null;
    _answerCorrectness = [];
    notifyListeners();

    try {
      var qs = await QuizDataService.instance.getQuestionsByCategory(category.id);
      
      final rng = Random();
      qs.shuffle(rng);
      if (qs.length > AppConstants.questionsPerQuiz) {
        qs = qs.take(AppConstants.questionsPerQuiz).toList();
      }

      _questions = qs;
      _answerCorrectness = List.filled(qs.length, null);

      _shuffledOptionsPerQuestion = qs.map((q) {
        final opts = [q.correctAnswer, ...q.incorrectAnswers];
        opts.shuffle(rng);
        return opts;
      }).toList();
    } catch (_) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }

  void nextQuestion() {
    if (_selectedOption != null && _currentIndex < _questions.length) {
      _answerCorrectness[_currentIndex] =
          _selectedOption == _questions[_currentIndex].correctAnswer;
    }
    _currentIndex++;
    _selectedOption = null;
    notifyListeners();
  }

  /// Records the final answer, persists result, and returns the [QuizResultModel].
  Future<QuizResultModel> finishQuiz() async {
    // Record the last answer.
    if (_selectedOption != null) {
      _answerCorrectness[_currentIndex] =
          _selectedOption == _questions[_currentIndex].correctAnswer;
    }

    final score = _answerCorrectness.where((b) => b == true).length;
    final total = _questions.length;
    final percentage = total > 0 ? (score / total) * 100 : 0.0;

    final result = QuizResultModel(
      categoryName: _category?.name ?? '',
      score: score,
      totalQuestions: total,
      percentage: percentage,
      dateTime: DateTime.now(),
    );

    await Future.wait([
      StorageService.instance.recordQuizCompletion(score: score, total: total),
      StorageService.instance.addToHistory(result),
    ]);

    return result;
  }

  /// Reshuffles options and resets state for replaying the same category.
  Future<void> restartQuiz() async {
    if (_category != null) {
      await loadQuiz(_category!);
    }
  }
}
