import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';


class StatsCards extends StatelessWidget {
  const StatsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildStatCard(
            context,
            'Total Quizzes',
            '24',
            Icons.quiz_outlined,
            AppColors.primary,
          ),
          _buildStatCard(
            context,
            'Active Users',
            '1.2K',
            Icons.people_outline,
            AppColors.success,
          ),
          _buildStatCard(
            context,
            'Completion Rate',
            '85%',
            Icons.trending_up_outlined,
            AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: color.withOpacity(isDark ? 0.2 : 0.1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
