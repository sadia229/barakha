// lib/config/app_theme.dart

import 'package:flutter/material.dart';

import 'app.colors.dart';
import 'app.fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    // Primary colors
    primaryColor: AppColors.deepTeal,
    scaffoldBackgroundColor: AppColors.pureWhite,

    // Color scheme
    colorScheme: const ColorScheme.light(
      primary: AppColors.deepTeal,
      secondary: AppColors.richGold,
      surface: AppColors.softCream,
      error: AppColors.error,
      onPrimary: AppColors.pureWhite,
      onSecondary: AppColors.darkNavy,
      onSurface: AppColors.textPrimary,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.pureWhite,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.deepTeal),
      titleTextStyle: AppTextStyles.h2,
    ),

    // Text theme
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heroText,
      headlineLarge: AppTextStyles.h1,
      headlineMedium: AppTextStyles.h2,
      headlineSmall: AppTextStyles.h3,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyRegular,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.button,
      labelSmall: AppTextStyles.caption,
    ),

    // Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepTeal,
        foregroundColor: AppColors.pureWhite,
        textStyle: AppTextStyles.button,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
    ),

    // Card theme
    cardTheme: CardThemeData(
      color: AppColors.pureWhite,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: AppColors.darkNavy.withOpacity(0.1),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.softCream,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.deepTeal, width: 2),
      ),
      labelStyle: AppTextStyles.bodyRegular,
      hintStyle: AppTextStyles.caption,
    ),

    // Bottom navigation theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.pureWhite,
      selectedItemColor: AppColors.deepTeal,
      unselectedItemColor: AppColors.textTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    // Primary colors
    primaryColor: AppColors.deepTeal,
    scaffoldBackgroundColor: AppColors.darkNavy,

    // Color scheme
    colorScheme: const ColorScheme.dark(
      primary: AppColors.deepTeal,
      secondary: AppColors.richGold,
      surface: Color(0xFF2A3454),
      error: AppColors.error,
      onPrimary: AppColors.pureWhite,
      onSecondary: AppColors.darkNavy,
      onSurface: AppColors.pureWhite,
    ),

    // Continue similar pattern for dark theme...
  );
}
