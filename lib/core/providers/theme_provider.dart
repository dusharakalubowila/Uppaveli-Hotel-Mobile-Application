import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

/// App color constants
class AppColors {
  static const Color gold = Color(0xFFC9A633);
  static const Color goldDark = Color(0xFFB8962E);
  static const Color background = Color(0xFFF9F8F3);
  static const Color fieldBackground = Color(0xFFF6F6F6);
  static const Color fieldBorder = Color(0xFFE7D7B2);
  static const Color buttonSecondary = Color(0xFF8FAFB2);
  static const Color orange = Color(0xFFE38A2F);
  static const Color tagOrange = Color(0xFFF0A46A);
  static const Color refundGreen = Color(0xFF57B88A);
  static const Color teal1 = Color(0xFF185E6C);
  static const Color teal2 = Color(0xFF0B3E4A);
}

/// Theme provider - provides app theme configuration
@riverpod
ThemeData appTheme(AppThemeRef ref) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.gold,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.gold,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.fieldBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
    ),
  );
}




