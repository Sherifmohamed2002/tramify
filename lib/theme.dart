import 'package:flutter/material.dart';

// Define app colors
class AppColors {
  static const primary = Color(0xFF1976D2); // Blue
  static const accent = Color(0xFF0D47A1); // Dark Blue
  static const background = Color(0xFFF5F5F5); // Light Gray
  static const surface = Color(0xFFFFFFFF); // White
  static const error = Color(0xFFD32F2F); // Red
  static const onPrimary = Colors.white; // White text on primary background
  static const onSurface = Colors.black; // Black text on surface background
  static const onError = Colors.white; // White text on error background
  static const shadow = Color(0x29000000); // Shadow color with opacity
}

// Define text styles
class AppTextStyles {
  static const headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );
  static const subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );
  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );
  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.onSurface,
  );
  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.onSurface,
  );
  static const button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.onPrimary,
  );
  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );
}

// Define the AppTheme
ThemeData appTheme = ThemeData(
  // Colors
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.primary,
    secondary: AppColors.accent,
    surface: AppColors.surface,
    error: AppColors.error,
    onPrimary: AppColors.onPrimary,
    onSurface: AppColors.onSurface,
    onError: AppColors.onError,
  ),

  // AppBar theme
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    elevation: 2,
    iconTheme: const IconThemeData(color: AppColors.onPrimary),
    titleTextStyle: AppTextStyles.headline.copyWith(color: AppColors.onPrimary),
  ),

  // Text theme
  textTheme: TextTheme(
    displayLarge: AppTextStyles.headline,
    headlineMedium: AppTextStyles.headline.copyWith(fontSize: 22),
    headlineSmall: AppTextStyles.headline.copyWith(fontSize: 20),
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.caption,
    labelLarge: AppTextStyles.button,
  ),

  // Input decoration
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    hintStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
  ),

  // ElevatedButton theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      textStyle: AppTextStyles.button,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  // Floating action button theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
  ),

  // Card theme
  cardTheme: CardTheme(
    color: AppColors.surface,
    shadowColor: AppColors.shadow,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  // Bottom navigation bar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.primary,
    selectedItemColor: AppColors.onPrimary,
    unselectedItemColor: AppColors.onSurface.withOpacity(0.6),
  ),

  // SnackBar theme
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.primary,
    contentTextStyle: AppTextStyles.bodyMedium.copyWith(
      color: AppColors.onPrimary,
    ),
  ),
);
