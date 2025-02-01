import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
import 'package:game_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:game_app/features/auth/presentation/bloc/user_event.dart';
import 'package:game_app/features/auth/presentation/bloc/user_state.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz/quiz_state.dart';
import 'package:game_app/features/quiz/presentation/pages/admin/admin_screen.dart';
import 'package:game_app/features/quiz/presentation/pages/drawer/app_drawer.dart';
import 'package:game_app/features/quiz/presentation/pages/shimmer/home_screen_shimmer.dart';
import 'package:game_app/features/quiz/presentation/pages/user/user_home_page.dart';
import 'package:game_app/features/quiz/presentation/pages/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: BlocProvider(
        create: (context) =>
        getIt<UserBloc>()
          ..add(LoadUserRoles()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            if (userState.status == UserStatus.loading) {
              return CircularProgressIndicator();
            } else if(userState.status == UserStatus.success) {
              return BlocBuilder<QuizBloc, QuizState>(
                builder: (context, state) {
                  if(state.status==QuizStatus.loading){
                    return HomeScreenShimmer();
                  }
                  else{
                    return

                      CustomScrollView(
                        slivers: [
                          const CustomAppBar(),
                          SliverPadding(
                            padding: const EdgeInsets.all(11.0),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                Column(
                                  children: [
                                     (userState.isAdmin)?

                                    AdminScreen()
                                        :
                                    UserHomeScreen(),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ],
                      );
                  }

                },
              );
            }
            else{
              return Container();
            }
          },
        ),
      ),
      // floatingActionButton: BlocBuilder<QuizBloc, QuizState>(
      //   builder: (context, state) {
      //     if (state.status == QuizStatus.loading) {
      //       return SizedBox.shrink();
      //     } else {
      //       return StartQuizFAB();
      //     }
      //   },
      // ),
    );
  }
}
