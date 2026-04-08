import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../bloc/hover_cubit.dart';
import 'gradient_button.dart';

/// A floating navbar that responds to scroll position.
/// Wrap your page's Scaffold body in a Stack and place this as a Positioned widget.
class NavBarWidget extends StatelessWidget {
  final bool scrolled;
  const NavBarWidget({super.key, required this.scrolled});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: scrolled
          ? AppColors.navbarSolid.withOpacity(0.97)
          : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: isMobile ? _MobileNavContent() : _DesktopNavContent(),
    );
  }
}

class _DesktopNavContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    return Row(
      children: [
        const LogoWidget(),
        const Spacer(),
        ...AppConstants.navLinks.map((link) => _NavLink(
              label: link['label']!,
              route: link['route']!,
              isActive: location == link['route'],
            )),
        const SizedBox(width: 24),
        GradientButton(
          label: 'Get a Quote',
          onPressed: () => context.go('/contact'),
          icon: Icons.arrow_forward_rounded,
        ),
      ],
    );
  }
}

class _MobileNavContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const LogoWidget(),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 28),
          onPressed: () => _openDrawer(context),
        ),
      ],
    );
  }

  void _openDrawer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) => const _DrawerWidget(),
      transitionBuilder: (context, anim, _, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
          child: child,
        );
      },
    );
  }
}

class _DrawerWidget extends StatelessWidget {
  const _DrawerWidget();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 280,
        height: double.infinity,
        color: AppColors.navbarSolid,
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const LogoWidget(),
              const SizedBox(height: 40),
              ...AppConstants.navLinks.map((link) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        context.go(link['route']!);
                      },
                      child: Text(link['label']!,
                          style:
                              AppTypography.h4.copyWith(color: Colors.white)),
                    ),
                  )),
              const Spacer(),
              GradientButton(
                label: 'Get a Quote',
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go('/contact');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String route;
  final bool isActive;
  const _NavLink(
      {required this.label, required this.route, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HoverCubit(),
      child: BlocBuilder<HoverCubit, bool>(
        builder: (context, hovered) {
          return MouseRegion(
            onEnter: (_) => context.read<HoverCubit>().onHover(true),
            onExit: (_) => context.read<HoverCubit>().onHover(false),
            child: GestureDetector(
              onTap: () => context.go(route),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: AppTypography.labelMedium.copyWith(
                    color: (isActive || hovered)
                        ? AppColors.primaryPurple
                        : AppColors.textMuted,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                  child: Text(label),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Public logo widget, can be used anywhere
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/'),
      child: Image.asset(
        'assets/images/logo.jpeg',
        height: 90,
        width: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Text(
          'AIgent softwares',
          style: AppTypography.h3
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
