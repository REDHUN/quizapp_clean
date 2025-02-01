import 'package:flutter/material.dart';
import 'package:game_app/core/storage/shared_prefs.dart';

class WelcomeSection extends StatefulWidget {
  const WelcomeSection({super.key});

  @override
  State<WelcomeSection> createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection> {
  List<String>? userRoles;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    _loadUserRoles();
  }

  Future<void> _loadUserRoles() async {
    await SharedPrefs.init();
    final roles = await SharedPrefs.getRoles();
    setState(() {
      userRoles = roles;
      isAdmin = roles?.contains("ROLE_ADMIN") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? const [
            Color(0xFF1A1F38), // Dark Blue
            Color(0xFF2C3E50), // Dark Slate
          ]
              : const [
            Color(0xFF845EC2), // Rich Purple
            Color(0xFF2C73D2), // Deep Blue
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.2, 0.9],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : const Color(0xFF845EC2))
                .withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: isDark
            ? Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ready for today\'s challenge?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(isDark ? 0.1 : 0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: isDark
                      ? Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  )
                      : null,
                ),
                child: Icon(
                  Icons.emoji_events_rounded,
                  color: Colors.white.withOpacity(isDark ? 0.9 : 1),
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(isDark ? 0.1 : 0.15),
              borderRadius: BorderRadius.circular(12),
              border: isDark
                  ? Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              )
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat('Quizzes', '12', isDark),
                _buildDivider(isDark),
                _buildStat('Correct', '85%', isDark),
                _buildDivider(isDark),
                _buildStat('Streak', '5 days', isDark),
              ],
            ),
          ),
          if (isAdmin) // Example: Show admin-specific UI
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Admin Mode',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, bool isDark) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(isDark ? 0.9 : 1),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(isDark ? 0.7 : 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(bool isDark) {
    return Container(
      height: 24,
      width: 1,
      color: Colors.white.withOpacity(isDark ? 0.1 : 0.2),
    );
  }
}