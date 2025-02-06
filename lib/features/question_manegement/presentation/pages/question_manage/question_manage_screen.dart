import 'package:flutter/material.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_create/create_question_screen.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_view/question_view_screen.dart';


class QuestionManagementScreen extends StatelessWidget {
  const QuestionManagementScreen({super.key});
  static String route = '/questionManagement';
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Management'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
              Colors.grey[900]!,
              Colors.grey[850]!,
            ]
                : [
              Colors.grey[100]!,
              Colors.grey[50]!,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
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
                          Icons.quiz_rounded,
                          size: 30,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Question Options',
                        style:
                        Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Select an option to manage your quiz questions',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildActionCard(
              context,
              title: 'Add New Question',
              subtitle: 'Create and add new questions to your quiz bank',
              icon: Icons.add_circle_outline,
              color: AppColors.primary,
              onTap: () =>  AppRouter.router.push(CreateQuestionScreen.route)
            ),
            _buildActionCard(
              context,
              title: 'View All Questions',
              subtitle: 'Browse and manage your existing questions',
              icon: Icons.list_alt_rounded,
              color: AppColors.success,
              onTap: () => AppRouter.router.push(QuestionViewScreen.route)
            ),
            _buildActionCard(
              context,
              title: 'Categories',
              subtitle: 'Organize questions by topics and difficulty',
              icon: Icons.category_rounded,
              color: AppColors.warning,
              onTap: () => Navigator.pushNamed(
                context,
                '/admin/questions/categories',
              ),
            ),
            _buildActionCard(
              context,
              title: 'Import/Export',
              subtitle: 'Transfer questions between devices or backup',
              icon: Icons.import_export_rounded,
              color: AppColors.accent,
              onTap: () => Navigator.pushNamed(
                context,
                '/admin/questions/import-export',
              ),
            ),
            _buildActionCard(
              context,
              title: 'Delete Questions',
              subtitle: 'Remove questions from your quiz bank',
              icon: Icons.delete_outline_rounded,
              color: AppColors.error,
              onTap: () => Navigator.pushNamed(
                context,
                '/admin/questions/delete',
              ),
            ),
          ],
        ),
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
