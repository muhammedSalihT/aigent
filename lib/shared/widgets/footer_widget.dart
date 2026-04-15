import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      decoration: BoxDecoration(
        color: AppColors.footerDark,
        border: Border(
          top: BorderSide(color: AppColors.borderSubtle, width: 1.w),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 60.h),
      child: Column(
        children: [
          isMobile ? _FooterMobile() : _FooterDesktop(),
          SizedBox(height: 40.h),
          Container(height: 1.h, color: AppColors.borderSubtle),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© ${DateTime.now().year} AIgent softwares. All rights reserved.',
                style: AppTypography.caption,
              ),
              Text(
                'AI-First Software Development',
                style:
                    AppTypography.caption.copyWith(color: AppColors.primaryPurple),
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
        SizedBox(width: 60.w),
        Expanded(
          child: _LinksColumn(title: 'Services', links: [
            'App Development',
            'Web Development',
            'AI Workflow Agents',
          ]),
        ),
        Expanded(
          child: _LinksColumn(title: 'Company', links: [
            'About Us',
            'Portfolio',
            'Contact',
            'Get a Quote',
          ]),
        ),
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
        SizedBox(height: 32.h),
        _LinksColumn(
          title: 'Services',
          links: ['App Development', 'Web Development', 'AI Agents'],
        ),
        SizedBox(height: 32.h),
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
            TextSpan(
                text: 'Soft',
                style: AppTypography.h3.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w700)),
            TextSpan(
                text: 'AI',
                style: AppTypography.h3.copyWith(
                    color: AppColors.primaryPurple,
                    fontWeight: FontWeight.w800)),
            TextSpan(
                text: 'gent',
                style: AppTypography.h3.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w700)),
          ]),
        ),
        SizedBox(height: 12.h),
        Text(AppConstants.taglineShort,
            style: AppTypography.bodySmall, maxLines: 3),
        SizedBox(height: 20.h),
        Row(
          children: [
            _SocialIcon(icon: Icons.code_rounded, url: 'https://github.com'),
            SizedBox(width: 12.w),
            _SocialIcon(icon: Icons.link_rounded, url: 'https://linkedin.com'),
            SizedBox(width: 12.w),
            _SocialIcon(
                icon: Icons.alternate_email_rounded,
                url: 'mailto:${AppConstants.contactEmail}'),
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
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color:
                    hovered ? AppColors.primaryPurple : AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(10.r),
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
        Text(title,
            style: AppTypography.labelLarge.copyWith(color: Colors.white)),
        SizedBox(height: 20.h),
        ...links.map((l) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
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
        Text('Get in Touch',
            style: AppTypography.labelLarge.copyWith(color: Colors.white)),
        SizedBox(height: 20.h),
        Row(
          children: [
            Icon(Icons.email_outlined,
                color: AppColors.primaryPurple, size: 16),
            SizedBox(width: 8.w),
            Text(AppConstants.contactEmail, style: AppTypography.bodySmall),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Icon(Icons.language_rounded,
                color: AppColors.primaryPurple, size: 16),
            SizedBox(width: 8.w),
            Text(AppConstants.websiteUrl, style: AppTypography.bodySmall),
          ],
        ),
        SizedBox(height: 24.h),
        GestureDetector(
          onTap: () => context.go('/contact'),
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text('Start a Project',
                style: AppTypography.labelMedium.copyWith(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
