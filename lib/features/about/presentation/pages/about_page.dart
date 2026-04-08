import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 120),
                // Story section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                  child: isMobile
                      ? Column(
                          children: [_StoryText(), const SizedBox(height: 40), _StoryStats(isMobile: isMobile)],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(flex: 3, child: _StoryText()),
                            const SizedBox(width: 60),
                            Expanded(flex: 2, child: _StoryStats(isMobile: isMobile)),
                          ],
                        ),
                ),
                const SizedBox(height: 100),
                // Mission values
                _MissionSection(isMobile: isMobile),
                const SizedBox(height: 100),
                // Team
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                  child: const SectionHeader(
                    tag: '👥 Our Team',
                    title: 'The Minds Behind AIgent softwares',
                    subtitle: 'Passionate engineers, AI researchers, and designers on a mission to build the future.',
                  ),
                ),
                const SizedBox(height: 60),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                  child: isMobile
                      ? Column(
                          children: AppConstants.team.asMap().entries.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: _TeamCard(member: e.value, index: e.key),
                            );
                          }).toList(),
                        )
                      : Row(
                          children: AppConstants.team.asMap().entries.map((e) {
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: e.key < 2 ? 24 : 0),
                                child: _TeamCard(member: e.value, index: e.key),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                const SizedBox(height: 80),
                // CTA
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                  child: Container(
                    padding: const EdgeInsets.all(48),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primaryPurple.withOpacity(0.2), AppColors.electricBlue.withOpacity(0.1)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Column(
                      children: [
                        Text('Join Our Journey', style: AppTypography.h1, textAlign: TextAlign.center),
                        const SizedBox(height: 12),
                        Text('We\'re always looking for talented individuals and ambitious clients.', style: AppTypography.bodyLarge, textAlign: TextAlign.center),
                        const SizedBox(height: 28),
                        GradientButton(label: 'Work With Us', onPressed: () => context.go('/contact'), icon: Icons.handshake_rounded),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                const FooterWidget(),
              ],
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
          tag: '🏢 Our Story',
          title: 'Built on a Bold Belief',
          subtitle: '',
          align: TextAlign.left,
        ),
        Text(
          'AIgent softwares was founded with one belief: every business deserves access to intelligent technology that was once reserved for tech giants.\n\nWe\'re a team of AI engineers, Flutter developers, and product designers who came together to democratize AI-powered software development. Our mission is simple — build products that actually work, scale, and deliver measurable value.',
          style: AppTypography.bodyMedium.copyWith(height: 1.8),
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            Container(width: 4, height: 40, color: AppColors.primaryPurple),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                '"AI isn\'t a feature — it\'s the foundation."',
                style: AppTypography.h4.copyWith(color: Colors.white, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideX(begin: -0.1);
  }
}

class _StoryStats extends StatelessWidget {
  final bool isMobile;
  const _StoryStats({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          _StatRow('Year Founded', '2023'),
          const Divider(color: AppColors.borderSubtle, height: 32),
          _StatRow('Projects Shipped', '50+'),
          const Divider(color: AppColors.borderSubtle, height: 32),
          _StatRow('Countries Served', '8+'),
          const Divider(color: AppColors.borderSubtle, height: 32),
          _StatRow('Team Members', '12+'),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.1);
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
        Text(value, style: AppTypography.h4.copyWith(color: AppColors.primaryPurple)),
      ],
    );
  }
}

class _MissionSection extends StatelessWidget {
  final bool isMobile;
  const _MissionSection({required this.isMobile});

  static const List<Map<String, String>> values = [
    {'icon': '🎯', 'title': 'Mission', 'desc': 'Make AI-powered software accessible to every ambitious business, not just Fortune 500 companies.'},
    {'icon': '🌍', 'title': 'Vision', 'desc': 'A world where every business runs on intelligent automation — faster, smarter, leaner.'},
    {'icon': '💎', 'title': 'Values', 'desc': 'Transparency, craftsmanship, client success, and continuous innovation in everything we build.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 60),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withOpacity(0.3),
      ),
      child: Column(
        children: [
          const SectionHeader(
            tag: '🎯 Purpose',
            title: 'Why We Exist',
            subtitle: 'Our guiding principles that shape every product we build.',
          ),
          const SizedBox(height: 48),
          isMobile
              ? Column(
                  children: values.asMap().entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
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
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item['icon']!, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 12),
          Text(item['title']!, style: AppTypography.h4.copyWith(color: Colors.white)),
          const SizedBox(height: 8),
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: hovered ? AppColors.primaryPurple.withOpacity(0.08) : AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hovered ? AppColors.primaryPurple.withOpacity(0.5) : AppColors.borderSubtle,
          ),
        ),
        child: Column(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: m['avatar']!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.navbarSolid,
                  child: const Icon(Icons.person_rounded, color: AppColors.textMuted, size: 40),
                ),
                errorWidget: (_, __, ___) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.navbarSolid,
                  child: const Icon(Icons.person_rounded, color: AppColors.textMuted, size: 40),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(m['name']!, style: AppTypography.h4.copyWith(color: Colors.white)),
            const SizedBox(height: 4),
            Text(m['role']!, style: AppTypography.labelMedium.copyWith(color: AppColors.primaryPurple)),
            const SizedBox(height: 12),
            Text(m['bio']!, style: AppTypography.caption, textAlign: TextAlign.center),
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
