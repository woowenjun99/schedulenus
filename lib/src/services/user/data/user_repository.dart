import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:schedulenus/src/services/user/domain/user.dart';

part 'user_repository.g.dart';

class UserRepository {
  FirebaseFunctions functions;

  UserRepository({required this.functions});

  Future<User> getUser({required String id}) async {
    final HttpsCallableResult result =
        await functions.httpsCallable("getUser").call({"id": id});

    return User.fromJson(result.data);
  }

  Future<void> updateUser({
    required String email,
    required String fullName,
    required String id,
    required String major,
    required int semester,
    required String username,
  }) async {
    final HttpsCallableResult result =
        await functions.httpsCallable("editUser").call({
      "email": email,
      "fullName": fullName,
      "id": id,
      "major": major,
      "semester": semester,
      "username": username,
    });

    final data = Map<String, dynamic>.from(result.data);

    if (!data["success"]) throw Exception(data["error"]);
  }
}

@riverpod
UserRepository userRepository(ref) {
  return UserRepository(
    functions: FirebaseFunctions.instanceFor(region: "asia-southeast1"),
  );
}

@Riverpod(keepAlive: false)
Future<User> getUser(ref, {required String id}) {
  final UserRepository userRepository = ref.watch(userRepositoryProvider);
  return userRepository.getUser(id: id);
}
