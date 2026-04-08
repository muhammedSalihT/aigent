import 'package:flutter/material.dart';
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
      case 'mobile': return Icons.phone_android_rounded;
      case 'web': return Icons.language_rounded;
      case 'ai': return Icons.smart_toy_rounded;
      default: return Icons.star_rounded;
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
        transform: Matrix4.identity()
          ..scale(hovered ? 1.03 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hovered ? AppColors.primaryPurple.withOpacity(0.7) : AppColors.borderSubtle,
            width: hovered ? 2 : 1,
          ),
          boxShadow: hovered
              ? [BoxShadow(color: AppColors.primaryPurple.withOpacity(0.25), blurRadius: 30, spreadRadius: 0)]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon container
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: AppColors.primaryPurple.withOpacity(0.4), blurRadius: 16)],
                ),
                child: Icon(_getIcon(), color: Colors.white, size: 28),
              ),
              const SizedBox(height: 20),
              Text(subtitle, style: AppTypography.caption.copyWith(color: AppColors.primaryPurple, letterSpacing: 1)),
              const SizedBox(height: 6),
              Text(title, style: AppTypography.h3.copyWith(color: Colors.white)),
              const SizedBox(height: 12),
              Text(description, style: AppTypography.bodySmall),
              const SizedBox(height: 20),
              ...features.map((f) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryPurple,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(f, style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                      ],
                    ),
                  )),
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
