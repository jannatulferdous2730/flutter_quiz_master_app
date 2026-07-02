/// SharedPreferences key constants — never use magic strings outside this file.
class AppConstants {
  AppConstants._();

  // Theme
  static const String keyIsDarkMode = 'is_dark_mode';

  // Stats
  static const String keyTotalAttempts = 'total_attempts';
  static const String keyHighestScore = 'highest_score';
  static const String keyLastScore = 'last_score';
  static const String keyLastTotal = 'last_total';

  // History
  static const String keyHistory = 'quiz_history';

  /// Maximum number of history entries to keep.
  static const int maxHistoryEntries = 10;

  /// Number of questions presented per quiz session.
  /// Change this value to adjust quiz length app-wide.
  static const int questionsPerQuiz = 10;
}
