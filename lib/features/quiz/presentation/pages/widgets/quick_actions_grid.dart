import 'package:flutter/material.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/core/theme/app_colors.dart';



class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildActionCard(
              context,
              title: 'Start Quiz',
              subtitle: 'Test your knowledge',
              icon: Icons.play_arrow_rounded,
              color: AppColors.primary,
              onTap: () {},
            ),
            _buildActionCard(
              context,
              title: 'Practice Mode',
              subtitle: 'Learn at your pace',
              icon: Icons.school_rounded,
              color: AppColors.success,
              onTap: () {},
            ),
            _buildActionCard(
              context,
              title: 'Challenges',
              subtitle: 'Compete with others',
              icon: Icons.emoji_events_rounded,
              color: AppColors.warning,
              onTap: () {},
            ),
            _buildActionCard(
              context,
              title: 'Statistics',
              subtitle: 'Track your progress',
              icon: Icons.analytics_rounded,
              color: AppColors.accent,
              onTap: () { AppRouter.router.push('/quizResultList');
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Get gradient colors based on card type
    List<Color> gradientColors = _getGradientColors(title);

    return Card(
      elevation: isDark ? 2 : 0,
      shadowColor: color.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [color.withOpacity(0.2), color.withOpacity(0.1)]
                  : gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.2, 0.9],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: isDark
                ? null
                : [
              BoxShadow(
                color: gradientColors[0].withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                size: 32,
                color: isDark ? color : Colors.white,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> _getGradientColors(String title) {
    switch (title) {
      case 'Start Quiz':
        return [
          const Color(0xFF6C33FF), // Deep Purple
          const Color(0xFF8E2DE2), // Vivid Purple
        ];
      case 'Practice Mode':
        return [
          const Color(0xFF00B4DB), // Bright Blue
          const Color(0xFF0083B0), // Ocean Blue
        ];
      case 'Challenges':
        return [
          const Color(0xFFFF6B6B), // Coral Red
          const Color(0xFFFF2525), // Vibrant Red
        ];
      case 'Statistics':
        return [
          const Color(0xFF02AAB0), // Teal
          const Color(0xFF00CDAC), // Mint Green
        ];
      default:
        return [
          const Color(0xFF6C33FF),
          const Color(0xFF8E2DE2),
        ];
    }
  }
}
