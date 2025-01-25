import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/core/storage/shared_prefs.dart';
import 'package:game_app/core/theme/app_theme.dart';
import 'package:game_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:game_app/firebase_options.dart';

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
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
