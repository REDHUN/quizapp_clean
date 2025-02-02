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
  final String quizName;

  const QuizScreen({super.key, required this.quizId, required this.quizName});

  static String route = '/quizAttend/:quizId/:quizName';

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
    )
      ..forward();
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
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return BlocProvider(
      create: (context) =>
      getIt<QuizBloc>()
        ..add(GetQuizQuestionsEvent(quizId: widget.quizId)),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state.status == QuizStatus.questionLoading) {
              return const Center(child: QuizScreenShimmer());
            }
            else if (state.status == QuizStatus.quizResultError) {
              return Center(child: Text(state.errorMessage.toString()));
            }
            else if (state.quizQuestionList == null ||
                state.quizQuestionList!.isEmpty) {
              return Center(child: _buildEmptyState());
            }

            return FadeTransition(
              opacity: _fadeController,
              child: Container(
                decoration: BoxDecoration(
                  gradient: isDark ? AppColors.darkGradient : AppColors
                      .primaryGradient,
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      _buildAppBar(quizName: widget.quizName),


                      BlocSelector<QuizBloc, QuizState, int>(
                        selector: (state) => state.currentQuestionIndex,
                        builder: (context, currentQuestionIndex) {
                          return QuizProgressBar(
                            currentQuestion: currentQuestionIndex + 1,
                            totalQuestions: state.quizQuestionList?.length ?? 0,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                BlocSelector<QuizBloc, QuizState, int>(
                                  selector: (state) =>
                                  state.currentQuestionIndex,
                                  builder: (context, currentQuestionIndex) {
                                    final currentQuestion = state
                                        .quizQuestionList?[currentQuestionIndex];
                                    return QuizQuestionCard(
                                      questionNumber: currentQuestionIndex + 1,
                                      question: currentQuestion?.question ?? "",
                                      imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                                BlocSelector<QuizBloc, QuizState, int?>(
                                  selector: (state) => state.selectedIndex,
                                  builder: (context, selectedIndex) {
                                    final currentQuestion = state
                                        .quizQuestionList?[state
                                        .currentQuestionIndex];
                                    return QuizOptions(
                                      options: currentQuestion?.options ?? [],
                                      selectedIndex: selectedIndex,
                                      onOptionSelected: (index) {
                                        if (currentQuestion?.options != null &&
                                            index < currentQuestion!.options!
                                                .length) {
                                          context.read<QuizBloc>().add(
                                            SelectQuizAnswerEvent(
                                              selectedIndex: index,
                                              selectedAnswerId: currentQuestion
                                                  .options![index].id ?? 0,
                                            ),
                                          );
                                        }
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
          },
        ),
        bottomSheet: _buildBottomButtons(context, int.parse(widget.quizId)),
      ),
    );
  }

  Widget _buildAppBar({required String quizName}) {
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
              Text(
                quizName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                    overflow: TextOverflow.ellipsis
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
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {
        if (state.status == QuizStatus.quizResultSuccess) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return QuizResultScreen(quizResultModel: state.quizResultModel!);
          }));
        }
      },
      builder: (context, state) {
        if (state.quizQuestionList == null || state.quizQuestionList!.isEmpty) {
          return const SizedBox();
        }

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                if (state.currentQuestionIndex != 0) ...[
                  Expanded(
                    child: _buildNavigationButton(
                      icon: Icons.arrow_back_rounded,
                      label: 'Previous',
                      onPressed: () {
                        context.read<QuizBloc>().add(
                            GetQuizPreviousQuestionEvent());
                      },
                      isOutlined: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: _buildNavigationButton(
                    icon: Icons.arrow_forward_rounded,
                    label: state.quizQuestionList?.length !=
                        state.currentQuestionIndex + 1
                        ? 'Next'
                        : state.status == QuizStatus.quizResultLoading
                        ? "Submitting..."
                        : 'Submit',
                    onPressed: state.selectedIndex != null
                        ? () {
                      if (state.quizQuestionList?.length !=
                          state.currentQuestionIndex + 1) {
                        context.read<QuizBloc>().add(
                            GetQuizNextQuestionEvent());
                      } else {
                        context.read<QuizBloc>().add(
                          GetQuizResultEvent(
                            quizId: quizId,
                            userAnswer: state.selectedAnswerIdList ?? [],
                          ),
                        );
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

  Widget _buildEmptyState() {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.darkGradient : AppColors
              .primaryGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              _buildAppBar(quizName: widget.quizName),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .scaffoldBackgroundColor.withOpacity(0.8),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.history_edu,
                    size: 64,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'No Questions Available',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
                ),


                ],
              ),
        ),
      )
    ,
    );
  }
}