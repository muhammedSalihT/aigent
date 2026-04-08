import 'package:flutter/material.dart';
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
                width: 320,
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: hovered ? AppColors.primaryPurple.withOpacity(0.6) : AppColors.borderSubtle,
                  ),
                  boxShadow: hovered
                      ? [BoxShadow(color: AppColors.primaryPurple.withOpacity(0.2), blurRadius: 24)]
                      : [],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Container(color: AppColors.navbarSolid),
                              errorWidget: (_, __, ___) => Container(
                                color: AppColors.navbarSolid,
                                child: const Icon(Icons.image_rounded, color: AppColors.textMuted, size: 48),
                              ),
                            ),
                            // Gradient overlay
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.transparent, AppColors.surfaceCard.withOpacity(0.9)],
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
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryPurple.withOpacity(0.85),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(category, style: AppTypography.caption.copyWith(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: AppTypography.h4.copyWith(color: Colors.white)),
                          const SizedBox(height: 8),
                          Text(description, style: AppTypography.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            children: tags.map((tag) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.electricBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.electricBlue.withOpacity(0.3)),
                              ),
                              child: Text(tag, style: AppTypography.caption.copyWith(color: AppColors.electricBlue)),
                            )).toList(),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                'View Case Study',
                                style: AppTypography.labelMedium.copyWith(color: AppColors.primaryPurple),
                              ),
                              const SizedBox(width: 6),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                transform: Matrix4.translationValues(hovered ? 4 : 0, 0, 0),
                                child: const Icon(Icons.arrow_forward_rounded, color: AppColors.primaryPurple, size: 16),
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
