import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Background — Pure White
  static const Color background = Color(0xFFFFFFFF);

  // Premium Gold — financial highlights
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFE8D48B);
  static const Color goldDark = Color(0xFFB8960F);

  // Action Red — urgent actions & penalties
  static const Color actionRed = Color(0xFFC1121F);
  static const Color actionRedLight = Color(0xFFE05260);

  // Secondary Light Gray — cards & panels
  static const Color cardBg = Color(0xFFFDFDFD);
  static const Color surface = Color(0xFFF5F5F7);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE0E0E0);

  // Text — Dark for Light theme
  static const Color textPrimary = Color(0xFF121212);
  static const Color textSecondary = Color(0xFF4A4A4A);
  static const Color textMuted = Color(0xFF9E9E9E);

  // Status
  static const Color success = Color(0xFF2E7D32); // Darker green for white bg
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldDark, gold, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient lightGradient = LinearGradient(
    colors: [background, Color(0xFFF0F0F0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8F8F8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient redGradient = LinearGradient(
    colors: [Color(0xFFC1121F), Color(0xFFB00020)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
