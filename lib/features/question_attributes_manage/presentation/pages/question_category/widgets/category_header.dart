import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';


class CategoryHeader extends StatelessWidget {
  final int totalCategories;
  final int activeCategories;
  final int totalQuestions;

  const CategoryHeader({
    super.key,
    required this.totalCategories,
    required this.activeCategories,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quiz Categories',
                    style:  TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage and organize your content',
                    style:  TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
              _buildTotalBadge(),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildHeaderStat(
                context,
                'Active Categories',
                activeCategories.toString(),
                Icons.check_circle_outline,
                AppColors.success,
              ),
              const SizedBox(width: 16),
              _buildHeaderStat(
                context,
                'Total Questions',
                totalQuestions.toString(),
                Icons.quiz_outlined,
                AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalBadge() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.category_outlined,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            '$totalCategories Total',
            style:  TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style:  TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style:  TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
