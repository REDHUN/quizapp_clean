import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_state.dart';

import 'widgets/quiz_options.dart';
import 'widgets/quiz_progress_bar.dart';
import 'widgets/quiz_question_card.dart';

class QuizScreen extends StatefulWidget {
  final String quizId;

  const QuizScreen({super.key, required this.quizId});

  static String route = '/quizAttend:quizId';

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int? selectedAnswerIndex;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<QuizBloc>()..add(GetQuizQuestionsEvent(quizId: widget.quizId)),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: FadeTransition(
          opacity: _fadeController,
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: SafeArea(
              child: BlocBuilder<QuizBloc, QuizState>(
                builder: (context, state) {
                  print(state.selectedIndex);
                  if (state.status == QuizStatus.questionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == QuizStatus.questionLoadError) {
                    return const Center(
                        child: Text("Failed to load questions"));
                  } else if (state.status == QuizStatus.questionLoadSuccess &&
                      state.quizQuestionList != null) {
                    return Column(
                      children: [
                        _buildAppBar(),
                        QuizProgressBar(
                          currentQuestion: state.currentQuestionIndex + 1,
                          totalQuestions: state.quizQuestionList!.length,
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  QuizQuestionCard(
                                    questionNumber:
                                        state.currentQuestionIndex + 1,
                                    question: state
                                            .quizQuestionList![
                                                state.currentQuestionIndex]
                                            .question ??
                                        "",
                                    imageUrl:
                                        'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
                                  ),
                                  const SizedBox(height: 20),
                                  QuizOptions(
                                    options: state
                                            .quizQuestionList![
                                                state.currentQuestionIndex]
                                            .options ??
                                        [],
                                    selectedIndex: state.selectedIndex,
                                    onOptionSelected: (index) {
                                      context.read<QuizBloc>().add(
                                            SelectQuizAnswerEvent(
                                                selectedIndex: index,
                                                selectedAnswerId: state
                                                        .quizQuestionList?[state
                                                            .currentQuestionIndex]
                                                        .options?[index]
                                                        .id ??
                                                    0),
                                          );
                                    },
                                  ),
                                  const SizedBox(height: 100),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state.status == QuizStatus.questionCompleted) {
                    return const Center(child: Text("Quiz Completed!"));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ),
        bottomSheet: _buildBottomButtons(context),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(
            Icons.close,
            () => Navigator.pop(context),
          ),
          Column(
            children: [
              const Text(
                'World Capitals',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '15:00',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildIconButton(
            Icons.more_horiz,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                state.currentQuestionIndex != 0
                    ? Expanded(
                        child: _buildNavigationButton(
                          icon: Icons.arrow_back_rounded,
                          label: 'Previous',
                          onPressed: () {
                            context.read<QuizBloc>().add(
                                  GetQuizPreviousQuestionEvent(),
                                );
                          },
                          isOutlined: true,
                        ),
                      )
                    : SizedBox(),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildNavigationButton(
                    icon: Icons.arrow_forward_rounded,
                    label:state.quizQuestionList?.length !=
                        state.currentQuestionIndex + 1? 'Next':'Submit',
                    onPressed: state.selectedIndex != null
                        ? () {
                            if (state.quizQuestionList?.length !=
                                state.currentQuestionIndex + 1) {
                              context.read<QuizBloc>().add(
                                    GetQuizNextQuestionEvent(),
                                  );
                            } else {
                              print("Updated Selected Answer List: ${state.selectedAnswerIdList}");
                            }
                          }
                        : null,
                    isOutlined: false,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    required bool isOutlined,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: onPressed != null ? 1.0 : 0.6,
      child: isOutlined
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: AppColors.primary,
              ),
              label: Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
    );
  }
}
