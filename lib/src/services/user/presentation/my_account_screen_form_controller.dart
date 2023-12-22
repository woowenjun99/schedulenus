import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:schedulenus/src/services/auth/data/auth_repository.dart';
import 'package:schedulenus/src/services/user/data/user_repository.dart';

part 'my_account_screen_form_controller.g.dart';

@Riverpod(keepAlive: false)
class MyAccountScreenFormController extends _$MyAccountScreenFormController {
  @override
  FutureOr<void> build() {}

  Future<bool> submitUser({
    required String fullName,
    required String major,
    required int semester,
    required String username,
  }) async {
    final UserRepository userRepository = ref.watch(userRepositoryProvider);
    final AuthRepository authRepository = ref.watch(authRepositoryProvider);
    final User currentUser = authRepository.currentUser!;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() => userRepository.updateUser(
          fullName: fullName,
          id: currentUser.uid,
          major: major,
          semester: semester,
          username: username,
        ));

    return state.hasError;
  }
}
