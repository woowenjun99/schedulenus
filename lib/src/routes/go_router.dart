import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:schedulenus/src/common_widgets/scaffold_with_nested_navigation.dart';
import 'package:schedulenus/src/routes/app_route.dart';
import 'package:schedulenus/src/routes/go_router_refresh_stream.dart';
import 'package:schedulenus/src/screens/home_screen.dart';
import 'package:schedulenus/src/screens/module_list_screen.dart';
import 'package:schedulenus/src/screens/registration_screen.dart';
import 'package:schedulenus/src/services/auth/data/auth_repository.dart';

part 'go_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

@riverpod
GoRouter goRouter(ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  final bool isLoggedIn = authRepository.currentUser != null;

  return GoRouter(
    initialLocation: isLoggedIn ? "/home" : "/auth",
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      final bool isLoggedIn = authRepository.currentUser != null;
      if (!isLoggedIn) {
        return "/auth";
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChange),
    routes: [
      GoRoute(
        path: "/auth",
        name: AppRoute.auth.name,
        builder: (context, state) => const RegistrationScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNestedNavigation(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: "/home",
                name: AppRoute.home.name,
                builder: (context, state) => const MyHomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              GoRoute(
                path: "/allModules",
                name: AppRoute.allModules.name,
                builder: (context, state) => const ModuleListScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
