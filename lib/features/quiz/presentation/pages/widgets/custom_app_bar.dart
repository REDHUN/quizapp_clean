import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/quiz/presentation/bloc/theme/theme_bloc.dart';
import 'package:game_app/features/quiz/presentation/bloc/theme/theme_event.dart';
import 'package:game_app/features/quiz/presentation/bloc/theme/theme_state.dart';

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
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return _buildActionButton(
              context,
              icon: state.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              onPressed: () => context.read<ThemeBloc>().add(ToggleTheme()),
            );
          },
        ),
        _buildActionButton(
          context,
          icon: Icons.notifications_outlined,
          onPressed: () {},
        ),
        // _buildActionButton(
        //   context,
        //   icon: Icons.person_outline_rounded,
        //   onPressed: () {},
        //   rightMargin: 16,
        // ),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context, {
        required IconData icon,
        required VoidCallback onPressed,
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
