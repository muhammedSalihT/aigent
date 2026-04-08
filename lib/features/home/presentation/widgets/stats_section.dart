import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/stat_counter.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryPurple.withOpacity(0.1),
            AppColors.electricBlue.withOpacity(0.1),
            AppColors.primaryPurple.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: isMobile
          ? Column(
              children: AppConstants.stats.asMap().entries.map((e) {
                final s = e.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: StatCounter(
                    targetNumber: int.parse(s['number']!),
                    suffix: s['suffix']!,
                    label: s['label']!,
                    uniqueKey: 'stat_${e.key}',
                  ),
                );
              }).toList(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: AppConstants.stats.asMap().entries.map((e) {
                final s = e.value;
                return Expanded(
                  child: Column(
                    children: [
                      StatCounter(
                        targetNumber: int.parse(s['number']!),
                        suffix: s['suffix']!,
                        label: s['label']!,
                        uniqueKey: 'stat_${e.key}',
                      ),
                      if (e.key < 3)
                        Container(
                          width: 1,
                          height: 60,
                          color: AppColors.borderSubtle,
                          margin: const EdgeInsets.only(left: 0, top: 0),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
    )
        .animate()
        .fadeIn(duration: 600.ms);
  }
}
