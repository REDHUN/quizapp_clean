import 'package:flutter/material.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/question_attributes_manage/presentation/pages/question_category/question_category_screen.dart';


class QuestionAttributeScreen extends StatelessWidget {
  const QuestionAttributeScreen({super.key});
  static String route = '/questionAttribute';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Attributes'),
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
              title: 'Question Categories',
              subtitle: 'Manage and organize question categories',
              icon: Icons.category_outlined,
              color: AppColors.primary,
              onTap: () => AppRouter.router.push(QuizCategoryScreen.route),
            ),
            _buildActionCard(
              context,
              title: 'Question Types',
              subtitle: 'Configure different types of questions',
              icon: Icons.quiz_outlined,
              color: AppColors.success,
              onTap: () => AppRouter.router.push('/questionTypes'),
            ),
            _buildActionCard(
              context,
              title: 'Difficulty Levels',
              subtitle: 'Set up and modify difficulty levels',
              icon: Icons.signal_cellular_alt_outlined,
              color: AppColors.warning,
              onTap: () => AppRouter.router.push('/difficultyLevels'),
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
                  Icons.settings_outlined,
                  size: 30,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                'Question Attributes',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Manage categories, types, and difficulty levels for your questions',
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