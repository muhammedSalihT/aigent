import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/bloc/hover_cubit.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final steps = AppConstants.processSteps;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.surfaceCard.withOpacity(0.3), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          const SectionHeader(
            tag: '🔧 How We Work',
            title: 'Our Proven Process',
            subtitle: 'From discovery to launch — a transparent, collaborative five-step journey.',
          ),
          const SizedBox(height: 60),
          isMobile
              ? Column(
                  children: steps.asMap().entries.map((e) {
                    return _MobileStep(step: e.value, index: e.key, isLast: e.key == steps.length - 1);
                  }).toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: steps.asMap().entries.map((e) {
                    return Expanded(
                      child: _DesktopStep(step: e.value, index: e.key, isLast: e.key == steps.length - 1),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}

class _DesktopStep extends StatelessWidget {
  final Map<String, String> step;
  final int index;
  final bool isLast;
  const _DesktopStep({required this.step, required this.index, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HoverCubit(),
      child: BlocBuilder<HoverCubit, bool>(
        builder: (context, hovered) {
          return MouseRegion(
      onEnter: (_) => context.read<HoverCubit>().onHover(true),
      onExit: (_) => context.read<HoverCubit>().onHover(false),
      child: Column(
        children: [
          // Step node + connecting line
          Row(
            children: [
              Expanded(
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: hovered ? AppColors.primaryGradient : null,
                      color: hovered ? null : AppColors.surfaceCard,
                      border: Border.all(
                        color: hovered ? AppColors.primaryPurple : AppColors.borderSubtle,
                        width: 2,
                      ),
                      boxShadow: hovered
                          ? [BoxShadow(color: AppColors.primaryPurple.withOpacity(0.4), blurRadius: 16)]
                          : [],
                    ),
                    child: Center(
                      child: Text(step['step']!, style: AppTypography.labelLarge.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primaryPurple.withOpacity(0.5), AppColors.electricBlue.withOpacity(0.3)],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Text(step['title']!, style: AppTypography.h4.copyWith(color: Colors.white), textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(step['desc']!, style: AppTypography.caption, textAlign: TextAlign.center, maxLines: 4),
              ],
            ),
          ),
        ],
      )
          .animate(delay: Duration(milliseconds: index * 150))
          .fadeIn(duration: 600.ms)
          .slideY(begin: 0.2),
    );
        },
      ),
    );
  }
}

class _MobileStep extends StatelessWidget {
  final Map<String, String> step;
  final int index;
  final bool isLast;
  const _MobileStep({required this.step, required this.index, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              child: Center(
                child: Text(step['step']!, style: AppTypography.labelLarge.copyWith(color: Colors.white, fontSize: 13)),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 72,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryPurple.withOpacity(0.5), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step['title']!, style: AppTypography.h4.copyWith(color: Colors.white)),
                const SizedBox(height: 6),
                Text(step['desc']!, style: AppTypography.caption),
              ],
            ),
          ),
        ),
      ],
    )
        .animate(delay: Duration(milliseconds: index * 120))
        .fadeIn(duration: 500.ms)
        .slideX(begin: -0.2);
  }
}
