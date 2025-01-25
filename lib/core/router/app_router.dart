import 'package:game_app/features/auth/presentation/pages/auth_page.dart';
import 'package:game_app/features/quiz/presentation/pages/home_page.dart';
import 'package:game_app/features/quiz/presentation/pages/quiz/quiz_screen.dart';
import 'package:game_app/features/quiz/presentation/pages/quiz_attend_page/quiz_attend_page.dart';
import 'package:game_app/features/quiz/presentation/pages/quiz_result_page/quiz_result_page.dart';
import 'package:game_app/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static var router = GoRouter(initialLocation: SplashPage.route, routes: [
    GoRoute(
      path: SplashPage.route,
      builder: (context, state) {
        return SplashPage();
      },
    ),
    GoRoute(
      path: AuthPage.route,
      builder: (context, state) {
        return AuthPage();
      },
    ),
    GoRoute(
      path: HomeScreen.route,
      builder: (context, state) {
        return HomeScreen();
      },
    ),
    GoRoute(

      path: QuizScreen.route,

      builder: (context, state) {
        final quizId = state.pathParameters['quizId'];
        return QuizScreen(quizId: "1");
      },
    ),
    GoRoute(
      path: QuizResultPage.route,

      builder: (context, state) {
        return QuizResultPage();
      },
    )
  ]);
}
