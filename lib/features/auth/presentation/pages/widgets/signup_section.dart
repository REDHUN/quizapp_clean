import 'package:flutter/material.dart';

class SignUpSection extends StatelessWidget {
  const SignUpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF6366F1),
          ),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
