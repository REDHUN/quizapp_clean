import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.quiz_rounded,
            size: 72,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Colors.white70],
          ).createShader(bounds),
          child: const Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue your journey',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.9),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
