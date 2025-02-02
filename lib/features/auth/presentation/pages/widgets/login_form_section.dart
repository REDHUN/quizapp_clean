import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:game_app/features/auth/presentation/bloc/user_event.dart';
import 'package:game_app/features/auth/presentation/bloc/user_state.dart';
import 'package:game_app/features/auth/presentation/pages/widgets/auth_textfield.dart';
import 'package:game_app/features/quiz/presentation/pages/home_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController;
    passwordController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTextField(
          textEditingController: nameController,
          label: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          textEditingController: passwordController,
          label: 'Password',
          icon: Icons.lock_outline,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF6366F1),
            ),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 24),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state.status == UserStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage ?? '')));
            }
            else if (state.status == UserStatus.success) {
              AppRouter.router.go(HomeScreen.route);
            }
          },
          child: ElevatedButton(
            onPressed: () {
              context.read<UserBloc>().add(
                  LoginWithPassowordEvent(
                      password: passwordController.text.trim(),
                      username: nameController.text.trim()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              shadowColor: const Color(0xFF6366F1).withOpacity(0.5),
            ),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return
                  state.status==UserStatus.loading?
                      Center(
                        child: CircularProgressIndicator()
                      ):

                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
