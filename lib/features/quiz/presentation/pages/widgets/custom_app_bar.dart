import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      floating: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: const Row(
        children: [
          Icon(
            Icons.quiz_rounded,
            size: 32,
            color: Color(0xFF6366F1),
          ),
          SizedBox(width: 12),
          Text(
            'Quiz App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        _buildActionButton(
          context,
          Icons.person_rounded,
          () {},
        ),
        _buildActionButton(
          context,
          Icons.settings_rounded,
          () {},
          rightMargin: 12,
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed, {
    double rightMargin = 6,
  }) {
    return Container(
      margin: EdgeInsets.only(right: rightMargin, left: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: const Color(0xFF6366F1),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
