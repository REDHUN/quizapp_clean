import 'package:flutter/material.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/core/storage/shared_prefs.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/auth/presentation/pages/auth_page.dart';
import 'package:game_app/features/quiz/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String route = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkAuth();
  }
  Future<void> checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final token = await SharedPrefs.getToken();
    final username = await SharedPrefs.getLoginUserName();
    final password = await SharedPrefs.getLoginUserPass();
    if (token!=null&&password!=null&&username!=null) {
      AppRouter.router.go(HomeScreen.route);
    } else {
      AppRouter.router.go(AuthPage.route);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Text('Quiz App',style: TextStyle(color: AppColors.backgroundLight,fontSize: 30)),
      ),
    );
  }
}