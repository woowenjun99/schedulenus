import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:schedulenus/src/services/auth/data/auth_repository.dart';

part 'registration_screen_controller.g.dart';

@Riverpod(keepAlive: false)
class RegistrationScreenController extends _$RegistrationScreenController {
  @override
  FutureOr build() {}

  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final AuthRepository authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.createUserWithEmailAndPassword(
          email: email, password: password),
    );
    return state.hasError == false;
  }
}
