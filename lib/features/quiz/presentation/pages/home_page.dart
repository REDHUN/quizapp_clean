import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_state.dart';
import 'package:game_app/features/quiz/presentation/pages/shimmer/home_screen_shimmer.dart';
import 'package:game_app/features/quiz/presentation/pages/widgets/custom_app_bar.dart';
import 'package:game_app/features/quiz/presentation/pages/widgets/leaderboard.dart';
import 'package:game_app/features/quiz/presentation/pages/widgets/popular_quizzes.dart';
import 'package:game_app/features/quiz/presentation/pages/widgets/quick_actions_grid.dart';
import 'package:game_app/features/quiz/presentation/pages/widgets/start_quiz_fab.dart';
import 'package:game_app/features/quiz/presentation/pages/widgets/welcome_section.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String route = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<QuizBloc>()
        ..add(GetQuizEvent()),
      child: Scaffold(
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state.status == QuizStatus.loading) {
              return
                HomeScreenShimmer();
            }
            if (state.status == QuizStatus.error) {
              return
                Text(state.errorMessage.toString());
            } else {
              return CustomScrollView(
                slivers: [
                  const CustomAppBar(),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([

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
                      ]),
                    ),
                  ),
                ],
              );
            }
          },
        ),
        floatingActionButton: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state.status == QuizStatus.loading) {
              return SizedBox.shrink();
            } else {
              return StartQuizFAB();
            }
          },
        ),

      ),
    );
  }
}
