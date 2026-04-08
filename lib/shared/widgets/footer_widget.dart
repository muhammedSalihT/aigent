import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';
import '../bloc/hover_cubit.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.footerDark,
        border: Border(
          top: BorderSide(color: AppColors.borderSubtle, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 60),
      child: Column(
        children: [
          isMobile ? _FooterMobile() : _FooterDesktop(),
          const SizedBox(height: 40),
          Container(height: 1, color: AppColors.borderSubtle),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© ${DateTime.now().year} AIgent softwares. All rights reserved.',
                style: AppTypography.caption,
              ),
              Text(
                'AI-First Software Development',
                style: AppTypography.caption.copyWith(color: AppColors.primaryPurple),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _BrandColumn()),
        const SizedBox(width: 60),
        Expanded(child: _LinksColumn(title: 'Services', links: [
          'App Development', 'Web Development', 'AI Workflow Agents',
        ])),
        Expanded(child: _LinksColumn(title: 'Company', links: [
          'About Us', 'Portfolio', 'Contact', 'Get a Quote',
        ])),
        Expanded(child: _ContactColumn()),
      ],
    );
  }
}

class _FooterMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BrandColumn(),
        const SizedBox(height: 32),
        _LinksColumn(title: 'Services', links: ['App Development', 'Web Development', 'AI Agents']),
        const SizedBox(height: 32),
        _ContactColumn(),
      ],
    );
  }
}

class _BrandColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'Soft', style: AppTypography.h3.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
            TextSpan(text: 'AI', style: AppTypography.h3.copyWith(color: AppColors.primaryPurple, fontWeight: FontWeight.w800)),
            TextSpan(text: 'gent', style: AppTypography.h3.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
          ]),
        ),
        const SizedBox(height: 12),
        Text(AppConstants.taglineShort, style: AppTypography.bodySmall, maxLines: 3),
        const SizedBox(height: 20),
        Row(
          children: [
            _SocialIcon(icon: Icons.code_rounded, url: 'https://github.com'),
            const SizedBox(width: 12),
            _SocialIcon(icon: Icons.link_rounded, url: 'https://linkedin.com'),
            const SizedBox(width: 12),
            _SocialIcon(icon: Icons.alternate_email_rounded, url: 'mailto:${AppConstants.contactEmail}'),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;
  const _SocialIcon({required this.icon, required this.url});

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
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: hovered ? AppColors.primaryPurple : AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
        },
      ),
    );
  }
}

class _LinksColumn extends StatelessWidget {
  final String title;
  final List<String> links;
  const _LinksColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.labelLarge.copyWith(color: Colors.white)),
        const SizedBox(height: 20),
        ...links.map((l) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(l, style: AppTypography.bodySmall),
            )),
      ],
    );
  }
}

class _ContactColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Get in Touch', style: AppTypography.labelLarge.copyWith(color: Colors.white)),
        const SizedBox(height: 20),
        Row(
          children: [
            const Icon(Icons.email_outlined, color: AppColors.primaryPurple, size: 16),
            const SizedBox(width: 8),
            Text(AppConstants.contactEmail, style: AppTypography.bodySmall),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.language_rounded, color: AppColors.primaryPurple, size: 16),
            const SizedBox(width: 8),
            Text(AppConstants.websiteUrl, style: AppTypography.bodySmall),
          ],
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () => context.go('/contact'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('Start a Project', style: AppTypography.labelMedium.copyWith(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
