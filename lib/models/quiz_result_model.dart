class QuizResultModel {
  final String categoryName;
  final int score;
  final int totalQuestions;
  final double percentage;
  final DateTime dateTime;

  const QuizResultModel({
    required this.categoryName,
    required this.score,
    required this.totalQuestions,
    required this.percentage,
    required this.dateTime,
  });

  factory QuizResultModel.fromJson(Map<String, dynamic> json) {
    return QuizResultModel(
      categoryName: json['categoryName'] as String,
      score: json['score'] as int,
      totalQuestions: json['totalQuestions'] as int,
      percentage: (json['percentage'] as num).toDouble(),
      dateTime: DateTime.parse(json['dateTime'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'categoryName': categoryName,
        'score': score,
        'totalQuestions': totalQuestions,
        'percentage': percentage,
        'dateTime': dateTime.toIso8601String(),
      };
}
