import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primaryPurple = Color(0xFF6B3FA0);
  static const Color electricBlue = Color(0xFF4A90D9);
  static const Color darkBackground = Color(0xFF0D0220);
  static const Color surfaceCard = Color(0xFF1A0A35);
  static const Color navbarSolid = Color(0xFF12042A);
  static const Color footerDark = Color(0xFF08011A);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFFA78BCA);

  // Accent
  static const Color glowPurple = Color(0x806B3FA0);
  static const Color borderSubtle = Color(0x4D6B3FA0);
  static const Color borderHover = Color(0xCC6B3FA0);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, electricBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [darkBackground, Color(0xFF150530), darkBackground],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
