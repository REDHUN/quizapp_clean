import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/core/ui/default_button.dart';
import 'package:game_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:game_app/features/auth/presentation/bloc/user_event.dart';
import 'package:game_app/features/auth/presentation/bloc/user_state.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_state.dart';
import 'package:game_app/splash_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  static String route = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<QuizBloc>()..add(GetQuizEvent()),
      child: Scaffold(
          appBar: AppBar(
            title: BlocConsumer<UserBloc, UserState>(
              builder: (context, state) {
                return Text(state.userModel?.username ?? "");
              },
              listener: (context, state) {
                if (state.status == UserStatus.initial) {
                  AppRouter.router.go(SplashPage.route);
                }
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<UserBloc>().add(UserLogoutEvent());
                },
                icon: Icon(Icons.logout),
                color: AppColors.primary,
              )
            ],
          ),
          body: Center(child: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              if (state.status == QuizStatus.loading) {
                return
                CircularProgressIndicator();
              }
              if (state.status == QuizStatus.error) {
                return
                Text(state.errorMessage.toString());
              } else {
                return ListView.builder(itemCount: state.quizModel?.length, itemBuilder: (context, index) => Container(child: Text(state.quizModel?[index].title??""),),);
              }
            },
          ))),
    );
  }
}
