import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:schedulenus/src/services/auth/data/auth_repository.dart';

part 'auth_screen_controller.g.dart';

enum AuthScreenFormState {
  login,
  register,
}

@Riverpod(keepAlive: false)
class AuthScreenController extends _$AuthScreenController {
  @override
  FutureOr build() {}

  Future<dynamic> _authenticate({
    required String email,
    required String password,
    required AuthScreenFormState formState,
  }) async {
    final AuthRepository authRepository = ref.watch(authRepositoryProvider);

    switch (formState) {
      case AuthScreenFormState.login:
        return authRepository.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      default:
        final UserCredential credential =
            await authRepository.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        return credential;
    }
  }

  Future<bool> submit({
    required String email,
    required String password,
    required AuthScreenFormState formState,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _authenticate(
        email: email,
        password: password,
        formState: formState,
      ),
    );
    return state.hasError == false;
  }

  Future<bool> signout() async {
    state = const AsyncLoading();
    final AuthRepository authRepository = ref.watch(authRepositoryProvider);
    state = await AsyncValue.guard(authRepository.signout);
    return state.hasError == false;
  }
}
