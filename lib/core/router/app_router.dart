// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/compliment/presentation/pages/compliment_page.dart';
import '../../features/date_planning/presentation/pages/date_planning_page.dart';
import '../../features/explore/presentation/pages/explore_page.dart';
import '../../features/home/domain/entities/user_entity.dart';
import '../../features/home/presentation/pages/home_page.dart';

import '../../features/messages/presentation/pages/messages_page.dart';
import '../../features/messages/presentation/pages/chat_detail_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/user_detail_page.dart';
import '../../features/profile/presentation/pages/admirers_page.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return _ShellPage(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => _fadeScalePage(
              state: state,
              child: const HomePage(),
            ),
          ),
          GoRoute(
            path: '/explore',
            pageBuilder: (context, state) => _fadeScalePage(
              state: state,
              child: const ExplorePage(),
            ),
          ),
          GoRoute(
            path: '/admirers',
            pageBuilder: (context, state) => _fadeScalePage(
              state: state,
              child: const AdmirersPage(),
            ),
          ),
          GoRoute(
            path: '/messages',
            pageBuilder: (context, state) => _fadeScalePage(
              state: state,
              child: const MessagesPage(),
            ),
          ),

          GoRoute(
            path: '/events',
            pageBuilder: (context, state) => _fadeScalePage(
              state: state,
              child: const DatePlanningPage(),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => _fadeScalePage(
              state: state,
              child: const ProfilePage(),
            ),
          ),
        ],
      ),

      GoRoute(
        path: '/user/:id',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final user = state.extra as UserEntity;
          return CustomTransitionPage(
            key: state.pageKey,
            child: UserDetailPage(user: user),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/chat/:id',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final user = state.extra as UserEntity;
          return CustomTransitionPage(
            key: state.pageKey,
            child: ChatDetailPage(user: user),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0), // Slide from right
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              );
            },
          );
        },
      ),
      // Date planning page
      GoRoute(
        path: '/date-planning',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const DatePlanningPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              );
            },
          );
        },
      ),

      // Notifications page
      GoRoute(
        path: '/notifications',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const NotificationsPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0), // Slide from right
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              );
            },
          );
        },
      ),
      // Compliment modal
      GoRoute(
        path: '/compliment',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            opaque: false,
            barrierColor: Colors.black54,
            child: const Scaffold(
              backgroundColor: Colors.transparent,
              body: Align(
                alignment: Alignment.bottomCenter,
                child: ComplimentPage(),
              ),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              );
            },
          );
        },
      ),
    ],
  );

  static CustomTransitionPage<void> _fadeScalePage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.96, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          ),
        );
      },
    );
  }
}

class _ShellPage extends StatefulWidget {
  final Widget child;
  const _ShellPage({required this.child});

  @override
  State<_ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<_ShellPage> {
  int _currentIndex = 0;

  // Maps bottom nav tabs: Home, Date Now, Admirers, Chat, Events
  static const List<String> _routes = [
    '/home',
    '/explore',
    '/admirers',
    '/messages',
    '/events',
  ];

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
