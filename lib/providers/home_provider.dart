import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/quiz_result_model.dart';
import '../services/quiz_data_service.dart';
import '../services/storage_service.dart';

class HomeProvider extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  int _totalAttempts = 0;
  int _highestScore = 0;
  int _lastScore = 0;
  int _lastTotal = 0;
  List<QuizResultModel> _history = [];
  bool _isLoading = false;

  // Question counts keyed by category id
  Map<int, int> _questionCounts = {};

  List<CategoryModel> get categories => _categories;
  int get totalAttempts => _totalAttempts;
  int get highestScore => _highestScore;
  int get lastScore => _lastScore;
  int get lastTotal => _lastTotal;
  List<QuizResultModel> get history => _history;
  bool get isLoading => _isLoading;

  int questionCountFor(int categoryId) => _questionCounts[categoryId] ?? 0;

  Future<void> loadDashboardData() async {
    _isLoading = true;
    notifyListeners();

    final dataService = QuizDataService.instance;
    final storageService = StorageService.instance;

    final results = await Future.wait([
      dataService.getCategories(),
      storageService.getTotalAttempts(),
      storageService.getHighestScore(),
      storageService.getLastScore(),
      storageService.getLastTotal(),
      storageService.getHistory(),
    ]);

    _categories = results[0] as List<CategoryModel>;
    _totalAttempts = results[1] as int;
    _highestScore = results[2] as int;
    _lastScore = results[3] as int;
    _lastTotal = results[4] as int;
    _history = results[5] as List<QuizResultModel>;

    // Compute question counts per category in parallel.
    final countFutures = _categories
        .map((c) => dataService.getQuestionCountForCategory(c.id));
    final counts = await Future.wait(countFutures);
    _questionCounts = {
      for (var i = 0; i < _categories.length; i++)
        _categories[i].id: counts[i]
    };

    _isLoading = false;
    notifyListeners();
  }
}
