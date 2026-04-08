import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/project_card.dart';
import '../../../../shared/widgets/gradient_button.dart';

class PortfolioPreviewSection extends StatelessWidget {
  const PortfolioPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      padding: EdgeInsets.only(
        left: isMobile ? 24 : 80,
        right: 0,
        top: 100,
        bottom: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: isMobile ? 24 : 80),
            child: Row(
              children: [
                const Expanded(
                  child: SectionHeader(
                    tag: '🚀 Our Work',
                    title: 'Projects We\'re Proud Of',
                    subtitle: 'Real products, real impact. From AI agents to cross-platform apps.',
                    align: TextAlign.left,
                  ),
                ),
                if (!isMobile)
                  GradientButton(
                    label: 'View All Projects',
                    variant: ButtonVariant.outlined,
                    onPressed: () => context.go('/portfolio'),
                    icon: Icons.arrow_forward_rounded,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            height: 460,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: isMobile ? 24 : 80),
              itemCount: AppConstants.portfolio.length,
              itemBuilder: (context, i) {
                final p = AppConstants.portfolio[i];
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ProjectCard(
                    title: p['title'] as String,
                    description: p['description'] as String,
                    tags: List<String>.from(p['tags'] as List),
                    imageUrl: p['image'] as String,
                    category: p['category'] as String,
                    index: i,
                    onTap: () => context.go('/portfolio'),
                  ),
                );
              },
            ),
          ),
          if (isMobile)
            Padding(
              padding: const EdgeInsets.only(top: 28, right: 24),
              child: GradientButton(
                label: 'View All Projects',
                variant: ButtonVariant.outlined,
                onPressed: () => context.go('/portfolio'),
                icon: Icons.arrow_forward_rounded,
              ),
            ),
        ],
      ),
    );
  }
}
