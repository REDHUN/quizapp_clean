import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/quiz/presentation/pages/shimmer/shimmer_widget.dart';

class QuizScreenShimmer extends StatelessWidget {
  const QuizScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildAppBarShimmer(),
            _buildProgressBarShimmer(),
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
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _buildQuestionCardShimmer(),
                      const SizedBox(height: 20),
                      _buildOptionsShimmer(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarShimmer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ShimmerWidget.circular(
              width: 40,
              height: 40,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const ShimmerWidget.rectangular(
                  width: 120,
                  height: 24,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ShimmerWidget.rectangular(
                  width: 80,
                  height: 20,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ShimmerWidget.circular(
              width: 40,
              height: 40,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBarShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ShimmerWidget.rectangular(
                width: 150,
                height: 16,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              ShimmerWidget.rectangular(
                width: 40,
                height: 16,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ShimmerWidget.rectangular(
            width: double.infinity,
            height: 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCardShimmer() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerWidget.rectangular(
            width: 100,
            height: 24,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          const SizedBox(height: 16),
          const ShimmerWidget.rectangular(
            width: double.infinity,
            height: 20,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          const SizedBox(height: 8),
          const ShimmerWidget.rectangular(
            width: double.infinity,
            height: 20,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          const SizedBox(height: 16),
          ShimmerWidget.rectangular(
            width: double.infinity,
            height: 200,
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: List.generate(
          4,
              (index) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary.withOpacity(0.1),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ShimmerWidget.rectangular(
              width: double.infinity,
              height: 60,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
