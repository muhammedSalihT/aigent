import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/bloc/hover_cubit.dart';
import '../../../../shared/widgets/section_header.dart';

class WhyChooseUsSection extends StatelessWidget {
  const WhyChooseUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      child: Column(
        children: [
          const SectionHeader(
            tag: '🎯 Why AIgent softwares',
            title: 'Built Different, Delivered Better',
            subtitle:
                'Six reasons top businesses choose AIgent softwares as their technology agent.',
          ),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 3 : 1.6,
            ),
            itemCount: AppConstants.whyChooseUs.length,
            itemBuilder: (context, i) {
              final item = AppConstants.whyChooseUs[i];
              return _FeatureTile(
                icon: item['icon']!,
                title: item['title']!,
                desc: item['desc']!,
                index: i,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;
  final int index;

  const _FeatureTile(
      {required this.icon,
      required this.title,
      required this.desc,
      required this.index});

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
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: hovered
                    ? AppColors.primaryPurple.withOpacity(0.08)
                    : AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: hovered
                      ? AppColors.primaryPurple.withOpacity(0.5)
                      : AppColors.borderSubtle,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(icon, style: const TextStyle(fontSize: 28)),
                  const SizedBox(height: 12),
                  Text(title,
                      style: AppTypography.h4.copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  Text(desc,
                      style: AppTypography.caption,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            )
                .animate(delay: Duration(milliseconds: index * 80))
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.2),
          );
        },
      ),
    );
  }
}
