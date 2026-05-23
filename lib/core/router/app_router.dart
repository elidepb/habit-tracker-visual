import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/animations/page_transitions.dart';
import 'package:habit_tracker_visual/core/router/routes.dart';
import 'package:habit_tracker_visual/features/create_habit/views/habit_form_screen.dart';
import 'package:habit_tracker_visual/features/habit_detail/views/habit_detail_screen.dart';
import 'package:habit_tracker_visual/features/home/views/home_screen.dart';
import 'package:habit_tracker_visual/features/onboarding/views/onboarding_screen.dart';
import 'package:habit_tracker_visual/features/settings/views/settings_screen.dart';
import 'package:habit_tracker_visual/features/splash/views/splash_screen.dart';
import 'package:habit_tracker_visual/features/statistics/views/statistics_screen.dart';
import 'package:habit_tracker_visual/shared/widgets/main_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.splash,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
        path: Routes.splash,
        pageBuilder: (context, state) => AppPageTransitions.fade(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: Routes.onboarding,
        pageBuilder: (context, state) => AppPageTransitions.fade(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                pageBuilder: (context, state) => AppPageTransitions.fade(
                  key: state.pageKey,
                  child: const HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.statistics,
                pageBuilder: (context, state) => AppPageTransitions.fade(
                  key: state.pageKey,
                  child: const StatisticsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.settings,
                pageBuilder: (context, state) => AppPageTransitions.fade(
                  key: state.pageKey,
                  child: const SettingsScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.createHabit,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppPageTransitions.slideFromRight(
          key: state.pageKey,
          child: const HabitFormScreen(),
        ),
      ),
      GoRoute(
        path: '${Routes.editHabit}/:id',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return AppPageTransitions.slideFromRight(
            key: state.pageKey,
            child: HabitFormScreen(habitId: id),
          );
        },
      ),
      GoRoute(
        path: '${Routes.habitDetail}/:id',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return AppPageTransitions.slideFromRight(
            key: state.pageKey,
            child: HabitDetailScreen(habitId: id),
          );
        },
      ),
    ],
  );
});
