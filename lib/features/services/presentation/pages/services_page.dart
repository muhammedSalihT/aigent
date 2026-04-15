import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/bloc/scroll_cubit.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/footer_widget.dart';
import '../../../../shared/widgets/gradient_button.dart';
import '../../../../shared/widgets/nav_bar.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/service_card.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                    child: const SectionHeader(
                      tag: '⚡ Services',
                      title: 'What We Build For You',
                      subtitle:
                          'End-to-end technology services built for modern businesses that demand AI-first thinking.',
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                    child: isMobile
                        ? Column(
                            children:
                                AppConstants.services.asMap().entries.map((e) {
                              final d = e.value;
                              return Padding(
                                padding: EdgeInsets.only(bottom: 24.h),
                                child: ServiceCard(
                                  title: d['title'] as String,
                                  subtitle: d['subtitle'] as String,
                                  description: d['description'] as String,
                                  features:
                                      List<String>.from(d['features'] as List),
                                  iconType: d['icon'] as String,
                                  index: e.key,
                                ),
                              );
                            }).toList(),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                AppConstants.services.asMap().entries.map((e) {
                              final d = e.value;
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: e.key < 2 ? 20 : 0),
                                  child: ServiceCard(
                                    title: d['title'] as String,
                                    subtitle: d['subtitle'] as String,
                                    description: d['description'] as String,
                                    features: List<String>.from(
                                        d['features'] as List),
                                    iconType: d['icon'] as String,
                                    index: e.key,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                  SizedBox(height: 80.h),
                  _TechStackSection(isMobile: isMobile),
                  SizedBox(height: 80.h),
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
                          Text('Start Your Project',
                              style: AppTypography.h1,
                              textAlign: TextAlign.center),
                          SizedBox(height: 16.h),
                          Text(
                              'Tell us what you need and we\'ll get back within 24 hours.',
                              style: AppTypography.bodyLarge,
                              textAlign: TextAlign.center),
                          SizedBox(height: 28.h),
                          GradientButton(
                              label: 'Get a Free Quote',
                              onPressed: () => context.go('/contact'),
                              icon: Icons.rocket_launch_rounded),
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

class _TechStackSection extends StatelessWidget {
  final bool isMobile;
  const _TechStackSection({required this.isMobile});

  static const List<Map<String, String>> techs = [
    {'name': 'Flutter', 'icon': '📱'},
    {'name': 'Python', 'icon': '🐍'},
    {'name': 'OpenAI', 'icon': '🤖'},
    {'name': 'LangChain', 'icon': '⛓️'},
    {'name': 'Firebase', 'icon': '🔥'},
    {'name': 'FastAPI', 'icon': '⚡'},
    {'name': 'Next.js', 'icon': '▲'},
    {'name': 'Supabase', 'icon': '🗄️'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
      child: Column(
        children: [
          const SectionHeader(
            tag: '🛠️ Tech Stack',
            title: 'Built With Best-in-Class Tools',
            subtitle:
                'We use battle-tested technologies that ensure performance, scalability, and maintainability.',
          ),
          SizedBox(height: 40.h),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: techs.asMap().entries.map((e) {
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(e.value['icon']!,
                        style: TextStyle(fontSize: 20.sp)),
                    SizedBox(width: 10.w),
                    Text(e.value['name']!,
                        style: AppTypography.labelMedium
                            .copyWith(color: Colors.white)),
                  ],
                ),
              )
                  .animate(delay: Duration(milliseconds: e.key * 60))
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
