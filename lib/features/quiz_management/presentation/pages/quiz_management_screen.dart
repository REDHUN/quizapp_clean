import 'package:flutter/material.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/core/theme/app_colors.dart';

class QuizManagementScreen extends StatelessWidget {
  const QuizManagementScreen({super.key});
  static String route = '/quizManagement';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Management'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [Colors.grey[900]!, Colors.grey[850]!]
                : [Colors.grey[100]!, Colors.grey[50]!],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildHeaderCard(context),
            const SizedBox(height: 24),
            _buildActionCard(
              context,
              title: 'Create New Quiz',
              subtitle: 'Design and set up a new quiz with custom settings',
              icon: Icons.add_box_outlined,
              color: AppColors.primary,
              onTap: () => AppRouter.router.push('/createQuiz'),
            ),
            _buildActionCard(
              context,
              title: 'Manage Quizzes',
              subtitle: 'View, edit, or delete existing quizzes',
              icon: Icons.quiz_outlined,
              color: AppColors.success,
              onTap: () => AppRouter.router.push('/quizList'),
            ),
            _buildActionCard(
              context,
              title: 'Quiz Analytics',
              subtitle: 'View performance metrics and statistics',
              icon: Icons.analytics_outlined,
              color: AppColors.warning,
              onTap: () => AppRouter.router.push('/quizAnalytics'),
            ),
            _buildActionCard(
              context,
              title: 'Quiz Settings',
              subtitle: 'Configure global quiz settings and preferences',
              icon: Icons.settings_outlined,
              color: AppColors.accent,
              onTap: () => AppRouter.router.push('/quizSettings'),
            ),
            _buildActionCard(
              context,
              title: 'Quiz Templates',
              subtitle: 'Create and manage reusable quiz templates',
              icon: Icons.copy_outlined,
              color: Colors.purple,
              onTap: () => AppRouter.router.push('/quizTemplates'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.assignment_outlined,
                  size: 30,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                'Quiz Management',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Create and manage your quizzes with ease',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
        ],
      ),
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

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: isDark ? 2 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: color.withOpacity(0.1),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 30,
                    color: color,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: color.withOpacity(0.8),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}