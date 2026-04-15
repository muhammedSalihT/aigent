import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

class GlowText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color glowColor;
  final double blurRadius;
  final TextAlign textAlign;

  const GlowText(
    this.text, {
    super.key,
    this.style,
    this.glowColor = AppColors.primaryPurple,
    this.blurRadius = 20,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: (style ?? const TextStyle(color: Colors.white)).copyWith(
        shadows: [
          Shadow(color: glowColor, blurRadius: blurRadius),
          Shadow(color: glowColor.withOpacity(0.5), blurRadius: blurRadius * 2),
        ],
      ),
    );
  }
}
