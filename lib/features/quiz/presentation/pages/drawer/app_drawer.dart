import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';


import 'drawer_header.dart';
import 'drawer_menu_item.dart';
import 'drawer_stats.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkGradient
              : AppColors.primaryGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const CustomDrawerHeader(),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  decoration:  BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const DrawerStats(),
                        const SizedBox(height: 20),
                        const Divider(),
                        DrawerMenuItem(
                          icon: Icons.home_rounded,
                          title: 'Home',
                          subtitle: 'Back to main screen',
                          onTap: () =>
                              Navigator.of(context).pushReplacementNamed('/'),
                        ),
                        const DrawerMenuItem(
                          icon: Icons.history_rounded,
                          title: 'Quiz History',
                          subtitle: 'View your past attempts',
                          badge: '3',
                        ),
                        DrawerMenuItem(
                          icon: Icons.leaderboard_rounded,
                          title: 'Leaderboard',
                          subtitle: 'Check your ranking',
                          badge: 'New',
                          badgeColor: AppColors.success,
                        ),
                        DrawerMenuItem(
                          icon: Icons.emoji_events_rounded,
                          title: 'Achievements',
                          subtitle: 'Your accomplishments',
                          badge: '5',
                          badgeColor: AppColors.warning,
                        ),
                        const DrawerMenuItem(
                          icon: Icons.settings_rounded,
                          title: 'Settings',
                          subtitle: 'App preferences',
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Divider(),
                        ),
                        DrawerMenuItem(
                          icon: Icons.logout_rounded,
                          title: 'Logout',
                          subtitle: 'See you soon!',
                          color: AppColors.error,
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
