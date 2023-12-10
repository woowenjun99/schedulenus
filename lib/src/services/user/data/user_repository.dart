import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_functions/cloud_functions.dart';

part 'user_repository.g.dart';

class UserRepository {
  final FirebaseFunctions functions;

  const UserRepository({
    required this.functions,
  });

  /// Modifies the user record in the database with the [email], [fullName] and
  /// [semester].
  Future<HttpsCallableResult> createUser({
    required String email,
    required String fullName,
    required String uid,
    required int semester,
  }) async {
    final result = await functions.httpsCallable("createUser").call({
      "email": email,
      "fullName": fullName,
      "id": uid,
      "semester": semester.toString(),
    });

    return result;
  }

  /// Gets the user object from the database. The result is an object containing
  /// the following:
  ///
  /// hasCompletedVerification: boolean
  /// email: String
  /// fullName: String
  /// semester: int
  /// uid: String
  Future<HttpsCallableResult> getUserInformation({
    required String uid,
  }) {
    return functions.httpsCallable("getUser").call({
      "uid": uid,
    });
  }
}

@riverpod
UserRepository userRepository(ref) {
  return UserRepository(
    functions: FirebaseFunctions.instanceFor(region: "asia-southeast1"),
  );
}
