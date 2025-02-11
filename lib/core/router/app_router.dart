
import 'package:game_app/features/auth/presentation/pages/auth_page.dart';
import 'package:game_app/features/create_quiz/presentation/pages/create_quiz_screen.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_create/create_question_screen.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_edit/edit_question_screen.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_manage_screen.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_view/question_view_screen.dart';
import 'package:game_app/features/quiz/presentation/pages/home_page.dart';
import 'package:game_app/features/quiz/presentation/pages/quiz/quiz_screen.dart';
import 'package:game_app/features/quiz_report/presentation/pages/quiz_report/quiz_history_screen.dart';
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
        final quizName = state.pathParameters['quizName'];
        return QuizScreen(quizId: quizId!,quizName: quizName??"",);
      },
    ),
    GoRoute(
      path: QuizHistoryScreen.route,
      builder: (context, state) {
        return QuizHistoryScreen();
      },
    ),
    GoRoute(
      path: CreateQuizScreen.route,
      builder: (context, state) {
        return CreateQuizScreen();
      },
    ),
    GoRoute(
      path: QuestionManagementScreen.route,
      builder: (context, state) {
        return QuestionManagementScreen();
      },
    ),
    GoRoute(
      path: CreateQuestionScreen.route,
      builder: (context, state) {
        return CreateQuestionScreen();
      },
    ),
    GoRoute(
      path: QuestionViewScreen.route,
      builder: (context, state) {
        return QuestionViewScreen();
      },
    ),
    // GoRoute(
    //   path: EditQuestionScreen.route,
    //   builder: (context, state) {
    //     return EditQuestionScreen();
    //   },
    // ),
  ]);
}
