import 'package:html_unescape/html_unescape.dart';

final _unescape = HtmlUnescape();

class QuestionModel {
  final int categoryId;
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  const QuestionModel({
    required this.categoryId,
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      categoryId: json['category_id'] as int,
      category: _unescape.convert(json['category'] as String),
      type: json['type'] as String,
      difficulty: json['difficulty'] as String,
      question: _unescape.convert(json['question'] as String),
      correctAnswer: _unescape.convert(json['correct_answer'] as String),
      incorrectAnswers: (json['incorrect_answers'] as List<dynamic>)
          .map((e) => _unescape.convert(e as String))
          .toList(),
    );
  }
}
