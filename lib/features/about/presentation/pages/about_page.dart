import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/footer_widget.dart';
import '../../../../shared/widgets/gradient_button.dart';
import '../../../../shared/widgets/nav_bar.dart';
import '../../../../shared/bloc/hover_cubit.dart';
import '../../../../shared/bloc/scroll_cubit.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final ScrollController _scrollController = ScrollController();
  final ScrollCubit _scrollCubit = ScrollCubit();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollCubit.checkScroll(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          WebSmoothScroll(
            controller: _scrollController,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _scrollController,
              child: Column(
                children: [
                  SizedBox(height: 120.h),
                  // Story section
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                    child: isMobile
                        ? Column(
                            children: [
                              _StoryText(),
                              SizedBox(height: 40.h),
                              _StoryStats(isMobile: isMobile)
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(flex: 3, child: _StoryText()),
                              SizedBox(width: 60.w),
                              Expanded(
                                  flex: 2,
                                  child: _StoryStats(isMobile: isMobile)),
                            ],
                          ),
                  ),
                  SizedBox(height: 100.h),
                  // Mission values
                  _MissionSection(isMobile: isMobile),
                  SizedBox(height: 100.h),
                  // Team
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                    child: const SectionHeader(
                      tag: 'ðŸ‘¥ Our Team',
                      title: 'The Minds Behind AIgent softwares',
                      subtitle:
                          'Passionate engineers, AI researchers, and designers on a mission to build the future.',
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                    child: isMobile
                        ? Column(
                            children:
                                AppConstants.team.asMap().entries.map((e) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 24.h),
                                child: _TeamCard(member: e.value, index: e.key),
                              );
                            }).toList(),
                          )
                        : Row(
                            children:
                                AppConstants.team.asMap().entries.map((e) {
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: e.key < 2 ? 24 : 0),
                                  child:
                                      _TeamCard(member: e.value, index: e.key),
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                  SizedBox(height: 80.h),
                  // CTA
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                    child: Container(
                      padding: EdgeInsets.all(48.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryPurple.withOpacity(0.2),
                            AppColors.electricBlue.withOpacity(0.1)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: AppColors.borderSubtle),
                      ),
                      child: Column(
                        children: [
                          Text('Join Our Journey',
                              style: AppTypography.h1,
                              textAlign: TextAlign.center),
                          SizedBox(height: 12.h),
                          Text(
                              'We\'re always looking for talented individuals and ambitious clients.',
                              style: AppTypography.bodyLarge,
                              textAlign: TextAlign.center),
                          SizedBox(height: 28.h),
                          GradientButton(
                              label: 'Work With Us',
                              onPressed: () => context.go('/contact'),
                              icon: Icons.handshake_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 80.h),
                  const FooterWidget(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: BlocBuilder<ScrollCubit, bool>(
              bloc: _scrollCubit,
              builder: (context, scrolled) => NavBarWidget(scrolled: scrolled),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          tag: 'ðŸ¢ Our Story',
          title: 'Built on a Bold Belief',
          subtitle: '',
          align: TextAlign.left,
        ),
        Text(
          'AIgent softwares was founded with one belief: every business deserves access to intelligent technology that was once reserved for tech giants.\n\nWe\'re a team of AI engineers, Flutter developers, and product designers who came together to democratize AI-powered software development. Our mission is simple â€” build products that actually work, scale, and deliver measurable value.',
          style: AppTypography.bodyMedium.copyWith(height: 1.8.h),
        ),
        SizedBox(height: 28.h),
        Row(
          children: [
            Container(width: 4.w, height: 40.h, color: AppColors.primaryPurple),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                '"AI isn\'t a feature â€” it\'s the foundation."',
                style: AppTypography.h4
                    .copyWith(color: Colors.white, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1);
  }
}

class _StoryStats extends StatelessWidget {
  final bool isMobile;
  const _StoryStats({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          _StatRow('Year Founded', '2023'),
          Divider(color: AppColors.borderSubtle, height: 32.h),
          _StatRow('Projects Shipped', '50+'),
          Divider(color: AppColors.borderSubtle, height: 32.h),
          _StatRow('Countries Served', '8+'),
          Divider(color: AppColors.borderSubtle, height: 32.h),
          _StatRow('Team Members', '12+'),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.1);
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  const _StatRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.bodySmall),
        Text(value,
            style: AppTypography.h4.copyWith(color: AppColors.primaryPurple)),
      ],
    );
  }
}

class _MissionSection extends StatelessWidget {
  final bool isMobile;
  const _MissionSection({required this.isMobile});

  static const List<Map<String, String>> values = [
    {
      'icon': 'ðŸŽ¯',
      'title': 'Mission',
      'desc':
          'Make AI-powered software accessible to every ambitious business, not just Fortune 500 companies.'
    },
    {
      'icon': 'ðŸŒ',
      'title': 'Vision',
      'desc':
          'A world where every business runs on intelligent automation â€” faster, smarter, leaner.'
    },
    {
      'icon': 'ðŸ’Ž',
      'title': 'Values',
      'desc':
          'Transparency, craftsmanship, client success, and continuous innovation in everything we build.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 60.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withOpacity(0.3),
      ),
      child: Column(
        children: [
          const SectionHeader(
            tag: 'ðŸŽ¯ Purpose',
            title: 'Why We Exist',
            subtitle:
                'Our guiding principles that shape every product we build.',
          ),
          SizedBox(height: 48.h),
          isMobile
              ? Column(
                  children: values.asMap().entries.map((e) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: _ValueCard(item: e.value, index: e.key),
                    );
                  }).toList(),
                )
              : Row(
                  children: values.asMap().entries.map((e) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: e.key < 2 ? 20 : 0),
                        child: _ValueCard(item: e.value, index: e.key),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  final Map<String, String> item;
  final int index;
  const _ValueCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item['icon']!, style: TextStyle(fontSize: 32.sp)),
          SizedBox(height: 12.h),
          Text(item['title']!,
              style: AppTypography.h4.copyWith(color: Colors.white)),
          SizedBox(height: 8.h),
          Text(item['desc']!, style: AppTypography.bodySmall),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: index * 120))
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.2);
  }
}

class _TeamCard extends StatelessWidget {
  final Map<String, String> member;
  final int index;
  const _TeamCard({required this.member, required this.index});

  @override
  Widget build(BuildContext context) {
    final m = member;
    return BlocProvider(
      create: (_) => HoverCubit(),
      child: BlocBuilder<HoverCubit, bool>(
        builder: (context, hovered) {
          return MouseRegion(
            onEnter: (_) => context.read<HoverCubit>().onHover(true),
            onExit: (_) => context.read<HoverCubit>().onHover(false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: hovered
                    ? AppColors.primaryPurple.withOpacity(0.08)
                    : AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: hovered
                      ? AppColors.primaryPurple.withOpacity(0.5)
                      : AppColors.borderSubtle,
                ),
              ),
              child: Column(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: m['avatar']!,
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        width: 80.w,
                        height: 80.h,
                        color: AppColors.navbarSolid,
                        child: const Icon(Icons.person_rounded,
                            color: AppColors.textMuted, size: 40),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        width: 80.w,
                        height: 80.h,
                        color: AppColors.navbarSolid,
                        child: const Icon(Icons.person_rounded,
                            color: AppColors.textMuted, size: 40),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(m['name']!,
                      style: AppTypography.h4.copyWith(color: Colors.white)),
                  SizedBox(height: 4.h),
                  Text(m['role']!,
                      style: AppTypography.labelMedium
                          .copyWith(color: AppColors.primaryPurple)),
                  SizedBox(height: 12.h),
                  Text(m['bio']!,
                      style: AppTypography.caption,
                      textAlign: TextAlign.center),
                ],
              ),
            )
                .animate(delay: Duration(milliseconds: index * 120))
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.2),
          );
        },
      ),
    );
  }
}
