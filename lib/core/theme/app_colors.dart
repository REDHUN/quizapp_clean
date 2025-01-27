import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF4C6FFF); // Modern blue
  static const Color secondary = Color(0xFF4DCCFF); // Light blue
  static const Color accent = Color(0xFF845EF7); // Purple

  // Action Colors
  static const Color success = Color(0xFF00C48C); // Fresh green
  static const Color warning = Color(0xFFFFB800); // Warm yellow
  static const Color error = Color(0xFFFF3B3B); // Vibrant red

  // Social Media Colors
  static const Color google = Color(0xFFEA4335);
  static const Color facebook = Color(0xFF1877F2);
  static const Color apple = Color(0xFF000000);

  // Medal Colors
  static const Color gold = Color(0xFFEAB308);
  static const Color silver = Color(0xFF94A3B8);
  static const Color bronze = Color(0xFFD97706);

  // Background Colors
  static Color backgroundLight = Colors.grey[100]!;

  // Text Colors
  static Color textGrey = Colors.grey[600]!;

  // Gradient
  static final LinearGradient primaryGradient = LinearGradient(
    colors: [
      primary,
      secondary,
      accent.withOpacity(0.8),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Opacity Colors
  static Color white20 = Colors.white.withOpacity(0.2);
  static Color white15 = Colors.white.withOpacity(0.15);
  static Color black10 = Colors.black.withOpacity(0.1);
  static Color grey30 = Colors.grey[300]!;

  // Additional Gradients
  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF00C48C), Color(0xFF00E6A5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warningGradient = LinearGradient(
    colors: [Color(0xFFFFB800), Color(0xFFFFD600)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient errorGradient = LinearGradient(
    colors: [Color(0xFFFF3B3B), Color(0xFFFF5C5C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // New vibrant colors
  static const Color purple = Color(0xFF9C27B0);
  static const Color teal = Color(0xFF009688);
  static const Color indigo = Color(0xFF3F51B5);
  static const Color coral = Color(0xFFFF6B6B);

  // New gradients
  static final LinearGradient purpleGradient = LinearGradient(
    colors: [purple, purple.withOpacity(0.8), accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final LinearGradient glassGradient = LinearGradient(
    colors: [
      Colors.white.withOpacity(0.2),
      Colors.white.withOpacity(0.1),
      Colors.white.withOpacity(0.05),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient getScoreGradient(int score) {
    if (score >= 80) {
      return LinearGradient(
        colors: [
          success,
          const Color(0xFF34EAB9),
          const Color(0xFF00E5AE),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    if (score >= 60) {
      return LinearGradient(
        colors: [
          warning,
          const Color(0xFFFFD93D),
          const Color(0xFFFFE74D),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return LinearGradient(
      colors: [
        error,
        coral,
        const Color(0xFFFF8585),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  // Add this to AppColors class
  static final LinearGradient darkGradient = LinearGradient(
    colors: [
      const Color(0xFF2D2D2D),
      const Color(0xFF1A1A1A),
      primary.withOpacity(0.8),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
