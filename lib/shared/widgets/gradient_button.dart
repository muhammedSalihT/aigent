import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../bloc/hover_cubit.dart';

enum ButtonVariant { filled, outlined }

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? icon;

  const GradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.filled,
    this.icon,
  });

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
              duration: const Duration(milliseconds: 200),
              decoration: variant == ButtonVariant.filled
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryPurple,
                          AppColors.electricBlue
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: hovered
                          ? [
                              BoxShadow(
                                color: AppColors.primaryPurple.withOpacity(0.5),
                                blurRadius: 20,
                                spreadRadius: 2,
                              )
                            ]
                          : [],
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: hovered
                            ? AppColors.primaryPurple
                            : AppColors.borderSubtle,
                        // width can't be const when using .w extension
                        width: 2.w,
                      ),
                    ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(10.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 28.w, vertical: 14.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(icon, color: Colors.white, size: 18),
                          SizedBox(width: 8.w),
                        ],
                        Text(
                          label,
                          style: AppTypography.labelLarge.copyWith(
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
