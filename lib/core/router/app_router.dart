import 'package:game_app/features/auth/presentation/pages/auth_page.dart';
import 'package:game_app/features/quiz/presentation/pages/home_page.dart';
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
      path: HomePage.route,
      builder: (context, state) {
        return HomePage();
      },
    )
  ]);
}
