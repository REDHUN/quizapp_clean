import 'package:flutter/material.dart';

class QuizSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;

  const QuizSubmitButton({
    super.key,
    required this.onPressed,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          elevation: 5,
          shadowColor: buttonColor.withOpacity(0.3),
        ),
        child: const Text(
          'Create Quiz',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
