import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/core/storage/shared_prefs.dart';
import 'package:game_app/core/theme/app_theme.dart';
import 'package:game_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:game_app/features/create_quiz/presentation/bloc/create_quiz_bloc.dart';
import 'package:game_app/features/quiz/presentation/bloc/theme/theme_state.dart';
import 'package:game_app/features/quiz_report/presentation/bloc/quiz_report_bloc.dart';
import 'package:game_app/firebase_options.dart';

import 'features/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'features/quiz/presentation/bloc/theme/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefs.init();
  setup();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<QuizBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<QuizReportBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ThemeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<CreateQuizBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    ),
  );
}
