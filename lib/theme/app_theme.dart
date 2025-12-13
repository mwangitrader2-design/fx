import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF00B2A9);
  static const Color secondaryColor = Color(0xFF00736C);
  static const Color accentColor = Color(0xFF5AE5D8);
  static const Color backgroundColor = Color(0xFF000000);
  static const Color surfaceColor = Color(0xFF101010);
  static const Color cardColor = Color(0xFF161616);

  // Text Colors
  static const Color textPrimaryColor = Color(0xFFFFFFFF);
  static const Color textSecondaryColor = Color(0xFFB2FFF7);
  static const Color textMutedColor = Color(0xFF66A09C);

  // Status Colors
  static const Color successColor = Color(0xFF00D4C7);
  static const Color errorColor = Color(0xFF004D47);
  static const Color warningColor = Color(0xFF00958C);
  static const Color infoColor = Color(0xFF5AE5D8);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF00B2A9),
    Color(0xFF007F79),
  ];

  static const List<Color> successGradient = [
    Color(0xFF00D4C7),
    Color(0xFF00958C),
  ];

  static const List<Color> dangerGradient = [
    Color(0xFF00635D),
    Color(0xFF003C38),
  ];

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryColor,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundColor,
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimaryColor,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimaryColor,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textPrimaryColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: textPrimaryColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textSecondaryColor,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: textMutedColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: const TextStyle(color: textMutedColor),
      ),
      iconTheme: const IconThemeData(
        color: textSecondaryColor,
        size: 24,
      ),
    );
  }

  // Helper methods for gradients
  static BoxDecoration primaryGradientDecoration({
    double borderRadius = 12,
  }) {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: primaryGradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  static BoxDecoration successGradientDecoration({
    double borderRadius = 12,
  }) {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: successGradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  static BoxDecoration dangerGradientDecoration({
    double borderRadius = 12,
  }) {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: dangerGradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }
}
