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
        return authRepository.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
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
}
