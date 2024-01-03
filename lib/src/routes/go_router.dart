import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:schedulenus/src/common_widgets/scaffold_with_nested_navigation.dart';
import 'package:schedulenus/src/routes/app_route.dart';
import 'package:schedulenus/src/routes/go_router_refresh_stream.dart';
import 'package:schedulenus/src/screens/module_catalogue_screen.dart';
import 'package:schedulenus/src/screens/my_account_screen.dart';
import 'package:schedulenus/src/screens/profile_screen.dart';
import 'package:schedulenus/src/screens/home_screen.dart';
import 'package:schedulenus/src/screens/login_screen.dart';
import 'package:schedulenus/src/screens/registration_screen.dart';
import 'package:schedulenus/src/services/auth/data/auth_repository.dart';

part 'go_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

@riverpod
GoRouter goRouter(ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: "/home",
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      final bool isLoggedIn = authRepository.currentUser != null;
      if (!isLoggedIn &&
          (state.fullPath != "/registration" && state.fullPath != "/login")) {
        return "/login";
      }

      // Login logic: If the user is logged in but still at the login and
      // registration page, push him to home.
      if (isLoggedIn &&
          (state.fullPath == "/login" || state.fullPath == "/registration")) {
        return "/home";
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChange),
    routes: [
      GoRoute(
        path: "/registration",
        name: AppRoute.registration.name,
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: "/login",
        name: AppRoute.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/my_account",
        name: AppRoute.myAccountScreen.name,
        builder: (context, state) => const MyAccountScreen(),
      ),
      GoRoute(
        path: "/modules",
        name: AppRoute.allModules.name,
        builder: (context, state) => const ModuleCatalogueScreen(),
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
                path: "/profile",
                name: AppRoute.profile.name,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
