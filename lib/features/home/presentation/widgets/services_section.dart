import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/service_card.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      child: Column(
        children: [
          const SectionHeader(
            tag: '⚡ What We Build',
            title: 'Our Core Services',
            subtitle: 'From mobile apps to intelligent AI agents — we deliver end-to-end solutions that transform how your business operates.',
          ),
          const SizedBox(height: 60),
          isMobile
              ? Column(
                  children: AppConstants.services.asMap().entries.map((e) {
                    final data = e.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: ServiceCard(
                        title: data['title'] as String,
                        subtitle: data['subtitle'] as String,
                        description: data['description'] as String,
                        features: List<String>.from(data['features'] as List),
                        iconType: data['icon'] as String,
                        index: e.key,
                      ),
                    );
                  }).toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AppConstants.services.asMap().entries.map((e) {
                    final data = e.value;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: e.key < 2 ? 20 : 0),
                        child: ServiceCard(
                          title: data['title'] as String,
                          subtitle: data['subtitle'] as String,
                          description: data['description'] as String,
                          features: List<String>.from(data['features'] as List),
                          iconType: data['icon'] as String,
                          index: e.key,
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
