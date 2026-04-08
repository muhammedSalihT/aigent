import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/footer_widget.dart';
import '../../../../shared/widgets/gradient_button.dart';
import '../../../../shared/widgets/nav_bar.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/hero_section.dart';
import '../widgets/services_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/why_choose_us_section.dart';
import '../widgets/portfolio_preview_section.dart';
import '../widgets/process_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = sl<HomeBloc>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    _homeBloc.add(HomeScrollChanged(_scrollController.offset));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeBloc,
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: const Column(
                children: [
                  HeroSection(),
                  ServicesSection(),
                  StatsSection(),
                  WhyChooseUsSection(),
                  PortfolioPreviewSection(),
                  ProcessSection(),
                  _CtaSection(),
                  FooterWidget(),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) => NavBarWidget(scrolled: state.isScrolled),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CtaSection extends StatelessWidget {
  const _CtaSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 40),
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryPurple.withOpacity(0.3), AppColors.electricBlue.withOpacity(0.2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          Text(
            'Ready to Build Something Amazing?',
            style: AppTypography.h1.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s turn your vision into an AI-powered product that delivers real results.',
            style: AppTypography.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),
          GradientButton(
            label: 'Start Your Project Today',
            onPressed: () => context.go('/contact'),
            icon: Icons.rocket_launch_rounded,
          ),
        ],
      ),
    );
  }
}
