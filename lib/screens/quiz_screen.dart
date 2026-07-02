import 'package:flutter/material.dart';
import '../models/category_model.dart';

class QuizScreen extends StatefulWidget {
  final CategoryModel category;
  const QuizScreen({super.key, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.name)),
      body: const Center(child: Text('Quiz Screen — coming in Step 7')),
    );
  }
}
