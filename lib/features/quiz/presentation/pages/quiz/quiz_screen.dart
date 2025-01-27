import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz/quiz_event.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz/quiz_state.dart';
import 'package:game_app/features/quiz/presentation/pages/quiz/widgets/quiz_screen_shimmer.dart';
import 'package:game_app/features/quiz/presentation/pages/quiz/widgets/result_screen.dart';

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
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state.status == QuizStatus.questionLoading) {
              return const Center(child: QuizScreenShimmer());
            } else if (state.status == QuizStatus.quizResultError) {
              return Center(child: Text(state.errorMessage.toString()));
            } else {
              return FadeTransition(
                opacity: _fadeController,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        _buildAppBar(),
                        // Progress Bar (rebuilds only when current question index changes)
                        BlocSelector<QuizBloc, QuizState, int>(
                          selector: (state) => state.currentQuestionIndex,
                          builder: (context, currentQuestionIndex) {
                            return QuizProgressBar(
                              currentQuestion: currentQuestionIndex + 1,
                              totalQuestions:
                                  state.quizQuestionList?.length ?? 0,
                            );
                          },
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
                                  // Question Card (rebuilds only when current question changes)
                                  BlocSelector<QuizBloc, QuizState, int>(
                                    selector: (state) =>
                                        state.currentQuestionIndex,
                                    builder: (context, currentQuestionIndex) {
                                      return QuizQuestionCard(
                                        questionNumber:
                                            currentQuestionIndex + 1,
                                        question: state
                                                .quizQuestionList?[
                                                    currentQuestionIndex]
                                                .question ??
                                            "",
                                        imageUrl:
                                            'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  // Quiz Options (rebuilds only when selected index changes)
                                  BlocSelector<QuizBloc, QuizState, int?>(
                                    selector: (state) => state.selectedIndex,
                                    builder: (context, selectedIndex) {
                                      return QuizOptions(
                                        options: state
                                                .quizQuestionList?[
                                                    state.currentQuestionIndex]
                                                .options ??
                                            [],
                                        selectedIndex: selectedIndex,
                                        onOptionSelected: (index) {
                                          context.read<QuizBloc>().add(
                                                SelectQuizAnswerEvent(
                                                  selectedIndex: index,
                                                  selectedAnswerId: state
                                                          .quizQuestionList?[state
                                                              .currentQuestionIndex]
                                                          .options?[index]
                                                          .id ??
                                                      0,
                                                ),
                                              );
                                        },
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
                    ),
                  ),
                ),
              );
            }
          },
        ),
        bottomSheet: _buildBottomButtons(context, int.parse(widget.quizId)),
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

  Widget _buildBottomButtons(BuildContext context, int quizId) {
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {
        if (state.status == QuizStatus.quizResultSuccess) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return QuizResultScreen(quizResultModel: state.quizResultModel!);
          }));

          //  final quizResultModelJson = jsonEncode(state.quizResultModel!.toJson());
          //   AppRouter.router.push('/quizResultPage${state.quizResultModel}');
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
                    : const SizedBox(),
                const SizedBox(width: 16),
                // Submit Button (rebuilds only when status changes)
                BlocSelector<QuizBloc, QuizState, QuizStatus>(
                  selector: (state) => state.status,
                  builder: (context, status) {
                    return Expanded(
                      child: _buildNavigationButton(
                        icon: Icons.arrow_forward_rounded,
                        label: state.quizQuestionList?.length !=
                                state.currentQuestionIndex + 1
                            ? 'Next'
                            : status == QuizStatus.quizResultLoading
                                ? "Submitting"
                                : 'Submit',
                        onPressed: state.selectedIndex != null
                            ? () {
                                if (state.quizQuestionList?.length !=
                                    state.currentQuestionIndex + 1) {
                                  context.read<QuizBloc>().add(
                                        GetQuizNextQuestionEvent(),
                                      );
                                } else {
                                  context.read<QuizBloc>().add(
                                        GetQuizResultEvent(
                                          quizId: quizId,
                                          userAnswer:
                                              state.selectedAnswerIdList ?? [],
                                        ),
                                      );
                                }
                              }
                            : null,
                        isOutlined: false,
                      ),
                    );
                  },
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
