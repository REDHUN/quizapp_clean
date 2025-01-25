import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6366F1);
  static const Color secondary = Color(0xFF8B5CF6);

  // Action Colors
  static const Color success = Color(0xFF14B8A6);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEC4899);

  // Social Media Colors
  static const Color google = Colors.red;
  static const Color facebook = Color(0xFF1877F2);

  // Medal Colors
  static const Color gold = Color(0xFFEAB308);
  static const Color silver = Color(0xFF94A3B8);
  static const Color bronze = Color(0xFFD97706);

  // Background Colors
  static Color backgroundLight = Colors.grey[100]!;

  // Text Colors
  static Color textGrey = Colors.grey[600]!;

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Opacity Colors
  static Color white20 = Colors.white.withOpacity(0.2);
  static Color white15 = Colors.white.withOpacity(0.15);
  static Color black10 = Colors.black.withOpacity(0.1);
  static Color grey30 = Colors.grey[300]!;
}

