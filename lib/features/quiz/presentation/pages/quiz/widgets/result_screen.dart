import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/quiz/domain/model/quiz_result_model/quiz_result_model.dart';
import 'package:game_app/features/quiz/presentation/pages/home_page.dart';

class QuizResultScreen extends StatefulWidget {

  final QuizResultModel quizResultModel;

  const QuizResultScreen(
      {super.key,
        required this.quizResultModel

    });

  static String route = '/quizResultPage:quizResultModel';

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scoreAnimation;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scoreAnimation = Tween<double>(
      begin: 0,
      end: ((widget.quizResultModel.score ?? 0) / (widget.quizResultModel.totalQuestions ?? 1)) * 100,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _controller.forward();
    if ((widget.quizResultModel.score ?? 0) / (widget.quizResultModel.totalQuestions ?? 1) >= 0.7) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _confettiController.play();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildAppBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            _buildScoreCircle(),
                            const SizedBox(height: 30),
                            _buildMessage(),
                            const SizedBox(height: 30),
                            _buildStats(),
                            const SizedBox(height: 30),
                           // const Spacer(),
                            _buildButtons(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 10,
              minBlastForce: 5,
              emissionFrequency: 0.15,
              numberOfParticles: 50,
              gravity: 0.3,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
                Colors.yellow,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.more_vert_outlined, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              const Expanded(
                child: Text(
                  'Quiz Result',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.quizResultModel.quizName??"",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCircle() {
    return AnimatedBuilder(
      animation: _scoreAnimation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.1),
              ),
            ),
            SizedBox(
              width: 180,
              height: 180,
              child: CircularProgressIndicator(
                value: _scoreAnimation.value / 100,
                strokeWidth: 12,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getScoreColor(_scoreAnimation.value),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${_scoreAnimation.value.toInt()}%',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: _getScoreColor(_scoreAnimation.value),
                  ),
                ),
                Text(
                  '${widget.quizResultModel.score??0}/${widget.quizResultModel.totalQuestions??0} Correct',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMessage() {
    final score = (widget.quizResultModel.score ?? 0) / (widget.quizResultModel.totalQuestions ?? 1);
    String message;
    Color color;
    IconData icon;

    if (score >= 0.8) {
      message = 'Outstanding!';
      color = AppColors.success;
      icon = Icons.emoji_events_rounded;
    } else if (score >= 0.6) {
      message = 'Well Done!';
      color = AppColors.warning;
      icon = Icons.star_rounded;
    } else {
      message = 'Keep Practicing!';
      color = AppColors.error;
      icon = Icons.refresh_rounded;
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 32,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey[200]!,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // _buildStatItem(
          //   icon: Icons.timer_outlined,
          //   value: _formatDuration(widget.timeTaken),
          //   label: 'Time Taken',
          // ),
          _buildDivider(),
          _buildStatItem(
            icon: Icons.check_circle_outline,
            value: '${widget.quizResultModel.score??""}',
            label: 'Correct',
            color: AppColors.success,
          ),
          _buildDivider(),
          _buildStatItem(
            icon: Icons.cancel_outlined,
            value: '${(widget.quizResultModel.totalQuestions ?? 0) - (widget.quizResultModel.score ?? 0)}',
            label: 'Wrong',
            color: AppColors.error,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    Color? color,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: (color ?? AppColors.primary).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon, color: color ?? AppColors.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color ?? AppColors.primary,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(

        children: [
          // ElevatedButton.icon(
          //   onPressed: () {
          //     // Handle try again
          //   },
          //   icon: const Icon(Icons.refresh),
          //   label: const Text('Try Again'),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: AppColors.primary,
          //     foregroundColor: Colors.white,
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 32,
          //       vertical: 16,
          //     ),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(16),
          //     ),
          //     minimumSize: const Size(double.infinity, 54),
          //   ),
          // ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200]!,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: OutlinedButton.icon(
              onPressed: () {
                AppRouter.router.go(HomeScreen.route);
              },
              icon: const Icon(Icons.home),
              label: const Text('Back to Home'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minimumSize: const Size(double.infinity, 54),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return AppColors.success;
    if (score >= 60) return AppColors.warning;
    return AppColors.error;
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }
}
