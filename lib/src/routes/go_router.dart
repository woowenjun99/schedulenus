import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:schedulenus/src/routes/app_route.dart';
import 'package:schedulenus/src/routes/go_router_refresh_stream.dart';
import 'package:schedulenus/src/screens/home_screen.dart';
import 'package:schedulenus/src/screens/module_list_screen.dart';
import 'package:schedulenus/src/screens/registration_screen.dart';
import 'package:schedulenus/src/services/auth/data/auth_repository.dart';

part 'go_router.g.dart';

@riverpod
GoRouter goRouter(ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  final bool isLoggedIn = authRepository.currentUser != null;

  return GoRouter(
    initialLocation: isLoggedIn ? "/home" : "/auth",
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
      GoRoute(
        path: "/home",
        name: AppRoute.home.name,
        builder: (context, state) => const MyHomePage(title: "Flutter App"),
      ),
      GoRoute(
        path: "/allModules",
        name: AppRoute.allModules.name,
        builder: (context, state) => const ModuleListScreen(),
      ),
    ],
  );
}
