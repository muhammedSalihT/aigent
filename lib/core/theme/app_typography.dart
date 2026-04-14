import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle poppins({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.poppins(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  // Display
  static TextStyle get displayLarge => poppins(fontSize: 72, fontWeight: FontWeight.w800, height: 1.1);
  static TextStyle get displayMedium => poppins(fontSize: 56, fontWeight: FontWeight.w700, height: 1.15);
  static TextStyle get displaySmall => poppins(fontSize: 40, fontWeight: FontWeight.w700, height: 1.2);

  // Headings
  static TextStyle get h1 => poppins(fontSize: 36, fontWeight: FontWeight.w700);
  static TextStyle get h2 => poppins(fontSize: 28, fontWeight: FontWeight.w600);
  static TextStyle get h3 => poppins(fontSize: 22, fontWeight: FontWeight.w600);
  static TextStyle get h4 => poppins(fontSize: 18, fontWeight: FontWeight.w600);

  // Body
  static TextStyle get bodyLarge => poppins(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.textMuted);
  static TextStyle get bodyMedium => poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textMuted);
  static TextStyle get bodySmall => poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textMuted);

  // Labels
  static TextStyle get labelLarge => poppins(fontSize: 16, fontWeight: FontWeight.w600);
  static TextStyle get labelMedium => poppins(fontSize: 14, fontWeight: FontWeight.w500);
  static TextStyle get caption => poppins(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textMuted);

  // Tagline
  static TextStyle get tagline => poppins(fontSize: 20, fontWeight: FontWeight.w300, color: AppColors.textMuted, height: 1.6);
}
