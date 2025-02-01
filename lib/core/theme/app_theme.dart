import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6366F1),
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      cardTheme: CardTheme(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: "Lexend",
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        headlineSmall: TextStyle(
          fontFamily: "Lexend",
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          fontFamily: "Lexend",
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        bodyLarge: TextStyle(
          fontFamily: "Lexend",
        ),
        bodyMedium: TextStyle(
          fontFamily: "Lexend",
        ),
        bodySmall: TextStyle(
          fontFamily: "Lexend",
        ),
        labelLarge: TextStyle(
          fontFamily: "Lexend",
        ),
        labelSmall: TextStyle(
          fontFamily: "Lexend",
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6366F1),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: "Lexend",
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        headlineSmall: TextStyle(
          fontFamily: "Lexend",
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          fontFamily: "Lexend",
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        bodyLarge: TextStyle(
          fontFamily: "Lexend",
        ),
        bodyMedium: TextStyle(
          fontFamily: "Lexend",
        ),
        bodySmall: TextStyle(
          fontFamily: "Lexend",
        ),
        labelLarge: TextStyle(
          fontFamily: "Lexend",
        ),
        labelSmall: TextStyle(
          fontFamily: "Lexend",
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
