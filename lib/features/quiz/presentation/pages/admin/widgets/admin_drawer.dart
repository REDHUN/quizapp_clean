import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/quiz/presentation/pages/drawer/drawer_header.dart';
import 'package:game_app/features/quiz/presentation/pages/drawer/drawer_menu_item.dart';
import 'package:game_app/features/quiz/presentation/pages/drawer/drawer_stats.dart';


class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.darkGradient : AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const CustomDrawerHeader(),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        const DrawerStats(),
                        const SizedBox(height: 24),
                        DrawerMenuItem(
                          icon: Icons.dashboard_rounded,
                          title: 'Dashboard',
                          subtitle: 'Overview & Stats',
                          onTap: () {},
                        ),
                        DrawerMenuItem(
                          icon: Icons.quiz_rounded,
                          title: 'Quiz Management',
                          subtitle: 'Create & Edit Quizzes',
                          badge: '3',
                          badgeColor: AppColors.primary,
                          onTap: () {},
                        ),
                        DrawerMenuItem(
                          icon: Icons.people_rounded,
                          title: 'User Management',
                          subtitle: 'Manage Users',
                          badge: '120',
                          badgeColor: AppColors.success,
                          onTap: () {},
                        ),
                        DrawerMenuItem(
                          icon: Icons.analytics_rounded,
                          title: 'Analytics',
                          subtitle: 'Reports & Insights',
                          onTap: () {},
                        ),
                        DrawerMenuItem(
                          icon: Icons.category_rounded,
                          title: 'Categories',
                          subtitle: 'Manage Quiz Categories',
                          badge: '8',
                          badgeColor: AppColors.warning,
                          onTap: () {},
                        ),
                        DrawerMenuItem(
                          icon: Icons.settings_rounded,
                          title: 'Settings',
                          subtitle: 'App Configuration',
                          onTap: () {},
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          child: Divider(),
                        ),
                        DrawerMenuItem(
                          icon: Icons.logout_rounded,
                          title: 'Logout',
                          subtitle: 'Exit Admin Panel',
                          color: AppColors.error,
                          onTap: () =>
                              Navigator.of(context).pushReplacementNamed('/'),
                        ),
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
    );
  }
}
