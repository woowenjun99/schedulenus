import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:schedulenus/src/routes/go_router_refresh_stream.dart';
import 'package:schedulenus/src/screens/home_screen.dart';
import 'package:schedulenus/src/screens/registration_screen.dart';
import 'package:schedulenus/src/services/auth/data/auth_repository.dart';

part 'go_router.g.dart';

@riverpod
GoRouter goRouter(ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: "/auth",
    redirect: (context, state) {
      final bool isLoggedIn = authRepository.currentUser != null;
      if (!isLoggedIn) {
        return "/auth";
      }
      return "/home";
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChange),
    routes: [
      GoRoute(
        path: "/auth",
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: "/home",
        builder: (context, state) => const MyHomePage(title: "Flutter App"),
      ),
    ],
  );
}
