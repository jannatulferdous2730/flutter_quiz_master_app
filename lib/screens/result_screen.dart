import 'package:flutter/material.dart';
import '../models/quiz_result_model.dart';

class ResultScreen extends StatelessWidget {
  final QuizResultModel result;
  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Center(child: Text('Score: ${result.score}/${result.totalQuestions}')),
    );
  }
}
