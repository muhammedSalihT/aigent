import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String subtitle;
  final TextAlign align;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    required this.subtitle,
    this.align = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align == TextAlign.left ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Tag pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryPurple.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: Text(tag, style: AppTypography.labelMedium.copyWith(color: AppColors.primaryPurple)),
        ),
        const SizedBox(height: 16),
        Text(title, style: AppTypography.h1, textAlign: align),
        const SizedBox(height: 8),
        // Purple underline
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          style: AppTypography.bodyLarge,
          textAlign: align,
        ),
      ],
    );
  }
}
