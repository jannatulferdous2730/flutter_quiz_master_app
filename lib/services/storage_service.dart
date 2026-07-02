import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_result_model.dart';
import '../utils/constants.dart';

/// Thin wrapper around [SharedPreferences] for all persistence needs.
class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();

  // ─── Theme ───────────────────────────────────────────────────────────────

  Future<bool> getIsDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.keyIsDarkMode) ?? false;
  }

  Future<void> setIsDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyIsDarkMode, isDark);
  }

  // ─── Stats ────────────────────────────────────────────────────────────────

  Future<int> getTotalAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(AppConstants.keyTotalAttempts) ?? 0;
  }

  Future<int> getHighestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(AppConstants.keyHighestScore) ?? 0;
  }

  Future<int> getLastScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(AppConstants.keyLastScore) ?? 0;
  }

  Future<int> getLastTotal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(AppConstants.keyLastTotal) ?? 0;
  }

  /// Atomically updates totalAttempts, highestScore, and lastScore.
  Future<void> recordQuizCompletion({
    required int score,
    required int total,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final attempts = (prefs.getInt(AppConstants.keyTotalAttempts) ?? 0) + 1;
    final highest = prefs.getInt(AppConstants.keyHighestScore) ?? 0;
    await prefs.setInt(AppConstants.keyTotalAttempts, attempts);
    await prefs.setInt(AppConstants.keyHighestScore, score > highest ? score : highest);
    await prefs.setInt(AppConstants.keyLastScore, score);
    await prefs.setInt(AppConstants.keyLastTotal, total);
  }

  // ─── History ──────────────────────────────────────────────────────────────

  Future<List<QuizResultModel>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(AppConstants.keyHistory) ?? [];
    return raw
        .map((e) => QuizResultModel.fromJson(json.decode(e) as Map<String, dynamic>))
        .toList();
  }

  /// Prepends [result] to history, capping at [AppConstants.maxHistoryEntries].
  Future<void> addToHistory(QuizResultModel result) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(AppConstants.keyHistory) ?? [];
    raw.insert(0, json.encode(result.toJson()));
    final capped = raw.take(AppConstants.maxHistoryEntries).toList();
    await prefs.setStringList(AppConstants.keyHistory, capped);
  }
}
