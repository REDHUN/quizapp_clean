import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/core/ui/default_button.dart';
import 'package:game_app/core/ui/default_textfield.dart';
import 'package:game_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:game_app/features/auth/presentation/bloc/user_event.dart';
import 'package:game_app/features/auth/presentation/bloc/user_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_app/features/quiz/presentation/pages/home_page.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});

  static const String route = '/auth';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void dispose() {
    widget.nameController;
    widget.passwordController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Chronicle',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const Spacer(),
                  Expanded(child: SvgPicture.asset('assets/images/login_image.svg')),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Collaborate with friends to craft unique stories',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  DefaultTextField(
                    controller: widget.nameController,
                    hintText: "name",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DefaultTextField(
                    controller: widget.passwordController,
                    hintText: "password",
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state.status == UserStatus.loading) {
                        return ElevatedButton(
                            onPressed: null,
                            child: CircularProgressIndicator());
                      } else {
                        return DefaultButton(
                          text: 'Login',
                          textColor: AppColors.textColor,
                          backgroundColor: AppColors.secondary,
                          onPressed: () {
                            context.read<UserBloc>().add(
                                LoginWithPassowordEvent(
                                    password: widget.passwordController.text,
                                    username: widget.nameController.text));
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            );
          },
          listener: (context, state) {


            if (state.status == UserStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage ?? '')));
            }
            else if(state.status==UserStatus.success){

              AppRouter.router.go(HomePage.route);
            }
          },
        ),
      ),
    );
  }
}
