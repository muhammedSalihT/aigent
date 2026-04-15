import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      crossAxisAlignment: align == TextAlign.left
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        // Tag pill
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.primaryPurple.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: Text(tag,
              style: AppTypography.labelMedium
                  .copyWith(color: AppColors.primaryPurple)),
        ),
        SizedBox(height: 16.h),
        Text(title, style: AppTypography.h1, textAlign: align),
        SizedBox(height: 8.h),
        // Purple underline
        Container(
          width: 60.w,
          height: 3.h,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          subtitle,
          style: AppTypography.bodyLarge,
          textAlign: align,
        ),
      ],
    );
  }
}
