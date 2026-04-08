import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/footer_widget.dart';
import '../../../../shared/widgets/nav_bar.dart';
import '../../../../shared/bloc/hover_cubit.dart';
import '../../../../shared/bloc/scroll_cubit.dart';
import '../../../../shared/bloc/portfolio_filter_cubit.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final ScrollCubit _scrollCubit = ScrollCubit();
  final PortfolioFilterCubit _filterCubit = PortfolioFilterCubit();

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
    _filterCubit.close();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFiltered(String filter) {
    if (filter == 'All') return AppConstants.portfolio;
    return AppConstants.portfolio.where((p) {
      final tags = p['tags'] as List;
      return tags.any((t) => t.toString().contains(filter)) ||
          (p['category'] as String).contains(filter);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final filters = ['All', 'AI', 'Flutter', 'Web', 'Automation'];

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 120),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                  child: const SectionHeader(
                    tag: '🚀 Portfolio',
                    title: 'Projects We\'re Proud Of',
                    subtitle: 'A curated selection of the products and solutions we\'ve built for clients worldwide.',
                  ),
                ),
                const SizedBox(height: 32),
                // Filter chips
                BlocBuilder<PortfolioFilterCubit, String>(
                  bloc: _filterCubit,
                  builder: (context, selectedFilter) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                      child: Row(
                        children: filters.map((f) {
                          final active = selectedFilter == f;
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              onTap: () => _filterCubit.setFilter(f),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: active ? AppColors.primaryPurple : AppColors.surfaceCard,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: active ? AppColors.primaryPurple : AppColors.borderSubtle),
                                ),
                                child: Text(f, style: AppTypography.labelMedium.copyWith(
                                  color: active ? Colors.white : AppColors.textMuted,
                                )),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                  child: BlocBuilder<PortfolioFilterCubit, String>(
                    bloc: _filterCubit,
                    builder: (context, selectedFilter) {
                      final filteredList = _getFiltered(selectedFilter);
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          final crossCount = isMobile ? 1 : (constraints.maxWidth < 900 ? 2 : 2);
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossCount,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                              childAspectRatio: isMobile ? 1.2 : 1.5,
                            ),
                            itemCount: filteredList.length,
                            itemBuilder: (context, i) {
                              final p = filteredList[i];
                              return _FullProjectCard(project: p, index: i);
                            },
                          );
                        },
                      );
                    },
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

class _FullProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;
  final int index;
  const _FullProjectCard({required this.project, required this.index});

  @override
  Widget build(BuildContext context) {
    final p = project;
    return BlocProvider(
      create: (_) => HoverCubit(),
      child: BlocBuilder<HoverCubit, bool>(
        builder: (context, hovered) {
          return MouseRegion(
      onEnter: (_) => context.read<HoverCubit>().onHover(true),
      onExit: (_) => context.read<HoverCubit>().onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hovered ? AppColors.primaryPurple.withOpacity(0.6) : AppColors.borderSubtle,
          ),
          boxShadow: hovered ? [BoxShadow(color: AppColors.primaryPurple.withOpacity(0.2), blurRadius: 24)] : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: p['image'] as String,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: AppColors.navbarSolid),
                  errorWidget: (_, __, ___) => Container(
                    color: AppColors.navbarSolid,
                    child: const Icon(Icons.image_rounded, color: AppColors.textMuted, size: 48),
                  ),
                ),
              ),
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.darkBackground.withOpacity(hovered ? 0.95 : 0.75),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: (p['tags'] as List).map((t) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.electricBlue.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.electricBlue.withOpacity(0.3)),
                          ),
                          child: Text(t as String, style: AppTypography.caption.copyWith(color: AppColors.electricBlue)),
                        )).toList(),
                      ),
                      const SizedBox(height: 10),
                      Text(p['title'] as String, style: AppTypography.h4.copyWith(color: Colors.white)),
                      if (hovered)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            p['description'] as String,
                            style: AppTypography.caption,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          .animate(delay: Duration(milliseconds: index * 100))
          .fadeIn(duration: 500.ms)
          .slideY(begin: 0.2),
    );
        },
      ),
    );
  }
}
