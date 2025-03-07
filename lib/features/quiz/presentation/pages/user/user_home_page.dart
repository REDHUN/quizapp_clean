import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz/quiz_event.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz/quiz_state.dart';
import 'package:game_app/features/quiz/presentation/pages/shimmer/home_screen_shimmer.dart';
import 'package:game_app/features/quiz/presentation/pages/widgets/leaderboard.dart';
import 'package:game_app/features/quiz/presentation/pages/widgets/popular_quizzes.dart';
import 'package:game_app/features/quiz/presentation/pages/widgets/welcome_section.dart';

import '../widgets/quick_actions_grid.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => getIt<QuizBloc>()..add(GetQuizEvent()),
      child: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
         if (state.status == QuizStatus.error) {
            return Text(state.errorMessage.toString());
          } else {
            return Column(
              children: [
                const WelcomeSection(),
                const SizedBox(height: 24),
                const QuickActionsGrid(),
                const SizedBox(height: 24),
                PopularQuizzes(
                  quizList: state.quizModel ?? [],
                ),
                const SizedBox(height: 24),
                const Leaderboard(),
                const SizedBox(height: 80), // Space for FAB
              ],
            );
          }
        },
      ),
    );
  }
}
