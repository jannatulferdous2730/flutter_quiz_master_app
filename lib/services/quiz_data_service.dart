import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/category_model.dart';
import '../models/question_model.dart';

/// Loads and caches category and question data from local JSON assets.
class QuizDataService {
  QuizDataService._();

  static final QuizDataService instance = QuizDataService._();

  List<CategoryModel>? _categoriesCache;
  List<QuestionModel>? _questionsCache;

  /// Returns all categories (cached after first load).
  Future<List<CategoryModel>> getCategories() async {
    if (_categoriesCache != null) return _categoriesCache!;
    final String raw = await rootBundle.loadString('assets/data/categories.json');
    final List<dynamic> list = json.decode(raw) as List<dynamic>;
    _categoriesCache = list
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return _categoriesCache!;
  }

  /// Returns all questions (cached after first load).
  Future<List<QuestionModel>> _getAllQuestions() async {
    if (_questionsCache != null) return _questionsCache!;
    final String raw = await rootBundle.loadString('assets/data/questions.json');
    final List<dynamic> list = json.decode(raw) as List<dynamic>;
    _questionsCache = list
        .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return _questionsCache!;
  }

  /// Returns questions filtered to [categoryId].
  Future<List<QuestionModel>> getQuestionsByCategory(int categoryId) async {
    final all = await _getAllQuestions();
    return all.where((q) => q.categoryId == categoryId).toList();
  }

  /// Returns the count of questions for [categoryId].
  Future<int> getQuestionCountForCategory(int categoryId) async {
    final questions = await getQuestionsByCategory(categoryId);
    return questions.length;
  }
}
