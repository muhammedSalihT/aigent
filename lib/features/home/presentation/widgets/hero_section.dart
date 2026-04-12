import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/animated_neural_background.dart';
import '../../../../shared/widgets/gradient_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      child: Stack(
        children: [
          // Neural network background
          const Positioned.fill(child: AnimatedNeuralBackground()),

          // Dark overlay gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xCC0D0220),
                    Color(0x800D0220),
                    Color(0xCC0D0220),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // AI badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryPurple,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'AI-First Software Development',
                          style: AppTypography.labelMedium
                              .copyWith(color: AppColors.primaryPurple),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms, curve: Curves.easeOutCubic)
                      .slideY(
                          begin: 0.4,
                          end: 0,
                          duration: 800.ms,
                          curve: Curves.easeOutCubic)
                      .scale(
                          begin: const Offset(0.9, 0.9),
                          end: const Offset(1, 1),
                          duration: 800.ms,
                          curve: Curves.easeOutCubic),

                  const SizedBox(height: 28),

                  // Company name
                  _HeroTitle(isMobile: isMobile),

                  const SizedBox(height: 24),

                  // Tagline with shimmer
                  Text(
                    'We automate workflows, reduce manual effort, and ship\nAI-powered apps & web that scale with your business.',
                    style: AppTypography.tagline.copyWith(
                      fontSize: isMobile ? 15 : 20,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  )
                      .animate(delay: 400.ms)
                      .fadeIn(duration: 800.ms, curve: Curves.easeOutCubic)
                      .slideY(
                          begin: 0.2,
                          end: 0,
                          duration: 800.ms,
                          curve: Curves.easeOutCubic)
                      .shimmer(
                          delay: 1200.ms,
                          duration: 1500.ms,
                          color: AppColors.textMuted),

                  const SizedBox(height: 44),

                  // CTA Buttons
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      GradientButton(
                        label: 'Start Your Project',
                        onPressed: () => context.go('/contact'),
                        icon: Icons.rocket_launch_rounded,
                      ),
                      GradientButton(
                        label: 'See Our Work',
                        variant: ButtonVariant.outlined,
                        onPressed: () => context.go('/portfolio'),
                        icon: Icons.play_arrow_rounded,
                      ),
                    ],
                  )
                      .animate(delay: 600.ms)
                      .fadeIn(duration: 800.ms, curve: Curves.easeOutCubic)
                      .slideY(
                          begin: 0.3,
                          end: 0,
                          duration: 800.ms,
                          curve: Curves.easeOutCubic)
                      .scale(
                          begin: const Offset(0.9, 0.9),
                          end: const Offset(1, 1),
                          duration: 800.ms,
                          curve: Curves.easeOutCubic),
                ],
              ),
            ),
          ),

          // Scroll indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _bounceController,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0, _bounceController.value * 8),
                  child: Column(
                    children: [
                      Text('Scroll to explore', style: AppTypography.caption),
                      const SizedBox(height: 8),
                      const Icon(Icons.keyboard_arrow_down_rounded,
                          color: AppColors.primaryPurple, size: 28),
                    ],
                  ),
                );
              },
            ).animate(delay: 1200.ms).fadeIn(),
          ),
        ],
      ),
    );
  }
}

class _HeroTitle extends StatelessWidget {
  final bool isMobile;
  const _HeroTitle({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Your business software\n',
            style: AppTypography.displayLarge.copyWith(
              fontSize: isMobile ? 28 : 50,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          TextSpan(
            text: 'A',
            style: AppTypography.displayLarge.copyWith(
              fontSize: isMobile ? 42 : 80,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          TextSpan(
            text: 'I',
            style: AppTypography.displayLarge.copyWith(
              fontSize: isMobile ? 42 : 80,
              color: AppColors.primaryPurple,
              height: 1.2,
              shadows: [
                const Shadow(color: AppColors.primaryPurple, blurRadius: 25),
                Shadow(
                    color: AppColors.primaryPurple.withOpacity(0.4),
                    blurRadius: 50),
              ],
            ),
          ),
          TextSpan(
            text: 'GENT',
            style: AppTypography.displayLarge.copyWith(
              fontSize: isMobile ? 42 : 80,
              color: Colors.white,
              height: 1.2,
            ),
          ),
        ],
      ),
    )
        .animate(delay: 200.ms)
        .fadeIn(duration: 1000.ms, curve: Curves.easeOutCubic)
        .slideY(
            begin: 0.2, end: 0, duration: 1000.ms, curve: Curves.easeOutCubic)
        .scale(
            begin: const Offset(0.9, 0.9),
            end: const Offset(1, 1),
            duration: 1000.ms,
            curve: Curves.easeOutCubic)
        .shimmer(delay: 1200.ms, duration: 1500.ms, color: Colors.white12);
  }
}
