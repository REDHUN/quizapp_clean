import 'package:flutter/material.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});
  static String route = '/quizResult';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Result Page"),
      ),
    );
  }
}
