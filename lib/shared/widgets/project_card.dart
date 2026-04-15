import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../bloc/hover_cubit.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;
  final String imageUrl;
  final String category;
  final int index;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.imageUrl,
    required this.category,
    required this.index,
    this.onTap,
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
            child: GestureDetector(
              onTap: onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 320.w,
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: hovered
                        ? AppColors.primaryPurple.withOpacity(0.6)
                        : AppColors.borderSubtle,
                  ),
                  boxShadow: hovered
                      ? [
                          BoxShadow(
                              color: AppColors.primaryPurple.withOpacity(0.2),
                              blurRadius: 24)
                        ]
                      : [],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:  BorderRadius.vertical(
                          top: Radius.circular(16.r)),
                      child: SizedBox(
                        height: 180.h,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (_, __) =>
                                  Container(color: AppColors.navbarSolid),
                              errorWidget: (_, __, ___) => Container(
                                color: AppColors.navbarSolid,
                                child: const Icon(Icons.image_rounded,
                                    color: AppColors.textMuted, size: 48),
                              ),
                            ),
                            // Gradient overlay
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    AppColors.surfaceCard.withOpacity(0.9)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            // Category chip
                            Positioned(
                              top: 12,
                              left: 12,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryPurple.withOpacity(0.85),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(category,
                                    style: AppTypography.caption
                                        .copyWith(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: AppTypography.h4
                                  .copyWith(color: Colors.white)),
                          SizedBox(height: 8.h),
                          Text(description,
                              style: AppTypography.caption,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis),
                          SizedBox(height: 16.h),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: tags
                                .map((tag) => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.electricBlue
                                            .withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        border: Border.all(
                                            color: AppColors.electricBlue
                                                .withOpacity(0.3)),
                                      ),
                                      child: Text(tag,
                                          style: AppTypography.caption.copyWith(
                                              color: AppColors.electricBlue)),
                                    ))
                                .toList(),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Text(
                                'View Case Study',
                                style: AppTypography.labelMedium
                                    .copyWith(color: AppColors.primaryPurple),
                              ),
                              SizedBox(width: 6.w),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                transform: Matrix4.translationValues(
                                    hovered ? 4 : 0, 0, 0),
                                child: const Icon(Icons.arrow_forward_rounded,
                                    color: AppColors.primaryPurple, size: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  .animate(delay: Duration(milliseconds: index * 120))
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.3, end: 0),
            ),
          );
        },
      ),
    );
  }
}
