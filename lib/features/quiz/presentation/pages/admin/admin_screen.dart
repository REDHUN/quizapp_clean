import 'package:flutter/material.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/core/theme/grediant.dart';
import 'package:game_app/features/create_quiz/presentation/pages/create_quiz_screen.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_manage_screen.dart';

import 'widgets/admin_stat_card.dart';
import 'widgets/quiz_management_card.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return  Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.darkGradient : AppColors.primaryGradient,
        ),
        child: Column(
          children: [

            Container(
            //  margin: const EdgeInsets.only(top: 24),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,

              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  //top: Radius.circular(32),
                ),
                child: ListView(

                  shrinkWrap: true,
                  padding:  EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 180,
                      child: _buildStatistics(context),
                    ),
                    const SizedBox(height: 24),
                    _buildQuickActions(context),
                    const SizedBox(height: 24),
                    _buildQuizManagement(context),
                    const SizedBox(height: 24),
                    _buildUserManagement(context),
                    const SizedBox(height: 24),
                    _buildQuestionBank(context),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildRecentActivity(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

    );
  }



  Widget _buildStatistics(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          AdminStatCard(
            title: 'Total Quizzes',
            value: '24',
            subtitle: '+3 this month',
            icon: Icons.quiz_rounded,
            gradient: GradientColors.getGradientByIndex(0),
          ),
          AdminStatCard(
            title: 'Active Users',
            value: '1.2K',
            subtitle: '+12% from last week',
            icon: Icons.people_rounded,
            gradient: GradientColors.getGradientByIndex(1),
          ),
          AdminStatCard(
            title: 'Completion Rate',
            value: '85%',
            subtitle: '+5% this month',
            icon: Icons.trending_up_rounded,
            gradient: GradientColors.getGradientByIndex(2),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Define custom gradients for each action card
    final actionGradients = [
      // Create Quiz - Purple to Blue
      [const Color(0xFF6C33FF), const Color(0xFF8E54E9)],

      // Analytics - Blue to Cyan
      [const Color(0xFF0061FF), const Color(0xFF60EFFF)],

      // Categories - Orange to Pink
      [const Color(0xFFFF8C42), const Color(0xFFFF5F6D)],

      // Reports - Green to Teal
      [const Color(0xFF11998E), const Color(0xFF38EF7D)],

      // Settings - Deep Purple to Pink
      [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],

      // Export Data - Blue to Purple
      [const Color(0xFF4E65FF), const Color(0xFF92EFFD)],
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
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
            childAspectRatio: 1,
            children: [
              _buildActionCard(
                context,
                title: 'Create Quiz',
                subtitle: 'Add new quiz',
                icon: Icons.add_circle_outline,
                gradient: actionGradients[0],
                onTap: () {

                  AppRouter.router.push(CreateQuizScreen.route);
                },
              ),
              _buildActionCard(
                context,
                title: 'Question Management',
                subtitle: 'Manage Questions',
                icon: Icons.question_mark,
                gradient: actionGradients[4],
                onTap: () {

                  AppRouter.router.push(QuestionManagementScreen.route);
                },
              ),
              _buildActionCard(
                context,
                title: 'Analytics',
                subtitle: 'View insights',
                icon: Icons.analytics_outlined,
                gradient: actionGradients[1],
                onTap: () {},
              ),
              _buildActionCard(
                context,
                title: 'Categories',
                subtitle: 'Manage topics',
                icon: Icons.category_outlined,
                gradient: actionGradients[2],
                badge: '8',
                onTap: () {},
              ),
              _buildActionCard(
                context,
                title: 'Reports',
                subtitle: 'User feedback',
                icon: Icons.report_outlined,
                gradient: actionGradients[3],
                badge: 'New',
                onTap: () {},
              ),
              _buildActionCard(
                context,
                title: 'Settings',
                subtitle: 'Configure app',
                icon: Icons.settings_outlined,
                gradient: actionGradients[4],
                onTap: () {},
              ),
              _buildActionCard(
                context,
                title: 'Export Data',
                subtitle: 'Download reports',
                icon: Icons.download_outlined,
                gradient: actionGradients[5],
                onTap: () {},
              ),
            ],
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
    required List<Color> gradient,
    String? badge,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: isDark ? 2 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(

          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      gradient[0].withOpacity(0.8),
                      gradient[1].withOpacity(0.8),
                    ]
                  : gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: gradient[0].withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  if (badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizManagement(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Quiz Management',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              QuizManagementCard(
                title: 'World Capitals',
                subtitle: '20 Questions',
                gradient: GradientColors.getGradientByIndex(0),
                onTap: () {},
              ),
              QuizManagementCard(
                title: 'Science Quiz',
                subtitle: '15 Questions',
                gradient: GradientColors.getGradientByIndex(1),
                onTap: () {},
              ),
              QuizManagementCard(
                title: 'Math Quiz',
                subtitle: '25 Questions',
                gradient: GradientColors.getGradientByIndex(2),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserManagement(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User Management',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: isDark ? 2 : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _buildUserManagementTile(
                  context,
                  title: 'Active Users',
                  count: '1.2K',
                  icon: Icons.people_outline,
                  gradient: GradientColors.getGradientByIndex(5),
                ),
                _buildUserManagementTile(
                  context,
                  title: 'Premium Users',
                  count: '256',
                  icon: Icons.workspace_premium_outlined,
                  gradient: GradientColors.getGradientByIndex(5),
                ),
                _buildUserManagementTile(
                  context,
                  title: 'New Registrations',
                  count: '+28',
                  icon: Icons.person_add_outlined,
                  gradient: GradientColors.getGradientByIndex(5),
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserManagementTile(
    BuildContext context, {
    required String title,
    required String count,
    required IconData icon,
    required List<Color> gradient,
    bool isLast = false,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        gradient[0].withOpacity(0.2),
                        gradient[1].withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: gradient[0].withOpacity(0.1),
                    ),
                  ),
                  child: Icon(icon, color: gradient[0]),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage and monitor $title',
                        softWrap: true, // This ensures the text will wrap onto the next line if it's too long
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        gradient[0].withOpacity(0.2),
                        gradient[1].withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: gradient[0].withOpacity(0.1),
                    ),
                  ),
                  child: Text(
                    count,
                    style: TextStyle(
                      color: gradient[0],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(
            indent: 68,
            endIndent: 20,
            color: Theme.of(context).dividerColor.withOpacity(0.5),
          ),
      ],
    );
  }

  Widget _buildQuestionBank(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categories = [
      {'name': 'Geography', 'count': 245, 'icon': Icons.public_outlined},
      {'name': 'Science', 'count': 189, 'icon': Icons.science_outlined},
      {'name': 'History', 'count': 167, 'icon': Icons.history_edu_outlined},
      {'name': 'Mathematics', 'count': 203, 'icon': Icons.functions_outlined},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Question Bank',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final gradientColors =
                  GradientColors.getGradientByIndex(index + 8);

              return Container(
                width: 160,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  elevation: isDark ? 2 : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              category['icon'] as IconData,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            category['name'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${category['count']} Questions',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: isDark ? 2 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                final gradientColors = GradientColors.getGradientByIndex(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              gradientColors[0].withOpacity(0.2),
                              gradientColors[1].withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: gradientColors[0].withOpacity(0.1),
                          ),
                        ),
                        child: Icon(
                          Icons.person_outline,
                          color: gradientColors[0],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(

                              'User ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.quiz_outlined,
                                  size: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    softWrap: true,
                                    'Completed World Capitals Quiz',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.color,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              gradientColors[0].withOpacity(0.2),
                              gradientColors[1].withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: gradientColors[0].withOpacity(0.1),
                          ),
                        ),
                        child: Text(
                          '${90 - index * 5}%',
                          style: TextStyle(
                            color: gradientColors[0],
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddQuizFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: const Text('Add Quiz'),
      icon: const Icon(Icons.add),
      backgroundColor: AppColors.primary,
    );
  }
}
