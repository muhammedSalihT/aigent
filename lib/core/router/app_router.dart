import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/services/presentation/pages/services_page.dart';
import '../../features/portfolio/presentation/pages/portfolio_page.dart';
import '../../features/about/presentation/pages/about_page.dart';
import '../../features/contact/presentation/pages/contact_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => _buildPage(const HomePage(), state),
      ),
      GoRoute(
        path: '/services',
        name: 'services',
        pageBuilder: (context, state) => _buildPage(const ServicesPage(), state),
      ),
      GoRoute(
        path: '/portfolio',
        name: 'portfolio',
        pageBuilder: (context, state) => _buildPage(const PortfolioPage(), state),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        pageBuilder: (context, state) => _buildPage(const AboutPage(), state),
      ),
      GoRoute(
        path: '/contact',
        name: 'contact',
        pageBuilder: (context, state) => _buildPage(const ContactPage(), state),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: const Color(0xFF0D0220),
      body: Center(
        child: Text(
          '404 — Page Not Found',
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    ),
  );

  static CustomTransitionPage<void> _buildPage(Widget child, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
