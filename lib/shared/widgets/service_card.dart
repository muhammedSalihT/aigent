import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../bloc/hover_cubit.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final List<String> features;
  final String iconType;
  final int index;

  const ServiceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.features,
    required this.iconType,
    required this.index,
  });

  IconData _getIcon() {
    switch (iconType) {
      case 'mobile':
        return Icons.phone_android_rounded;
      case 'web':
        return Icons.language_rounded;
      case 'ai':
        return Icons.smart_toy_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HoverCubit(),
      child: BlocBuilder<HoverCubit, bool>(
        builder: (context, hovered) {
          return MouseRegion(
            onEnter: (_) => context.read<HoverCubit>().onHover(true),
            onExit: (_) => context.read<HoverCubit>().onHover(false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              transform: Matrix4.identity()..scale(hovered ? 1.03 : 1.0),
              transformAlignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: hovered
                      ? AppColors.primaryPurple.withOpacity(0.7)
                      : AppColors.borderSubtle,
                  width: hovered ? 2.0 : 1.0, // Use double here for explicitness
                ),
                boxShadow: hovered
                    ? [
                        BoxShadow(
                            color: AppColors.primaryPurple.withOpacity(0.25),
                            blurRadius: 30,
                            spreadRadius: 0)
                      ]
                    : [],
              ),
              child: Padding(
                // Remove const; .w is not const expression
                padding: EdgeInsets.all(28.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon container
                    Container(
                      width: 56.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.primaryPurple.withOpacity(0.4),
                              blurRadius: 16)
                        ],
                      ),
                      child: Icon(_getIcon(), color: Colors.white, size: 28),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      subtitle,
                      style: AppTypography.caption.copyWith(
                          color: AppColors.primaryPurple, letterSpacing: 1),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      title,
                      style: AppTypography.h3.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      description,
                      style: AppTypography.bodySmall,
                    ),
                    SizedBox(height: 20.h),
                    ...features.map(
                      (f) => Padding(
                        // Remove const; .h is not const
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          children: [
                            Container(
                              width: 6.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                color: AppColors.primaryPurple,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              f,
                              style: AppTypography.bodySmall
                                  .copyWith(color: AppColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                .animate(delay: Duration(milliseconds: index * 150))
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.2, end: 0),
          );
        },
      ),
    );
  }
}
