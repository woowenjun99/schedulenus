import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:schedulenus/src/services/user/domain/user.dart';
import 'package:schedulenus/src/util/my_dio.dart';

part 'user_repository.g.dart';

class UserRepository {
  Dio dio;

  UserRepository({required this.dio});

  Future<User?> getUser({required String userId}) async {
    final response = await dio.request(
      "/get_user",
      options: Options(method: "GET"),
      queryParameters: {
        "userId": userId,
      },
    );

    final Map<String, dynamic> json = Map<String, dynamic>.from(response.data);

    if (json["result"] == null) return null;

    return User.fromJson(json);
  }
}

@riverpod
UserRepository userRepository(ref) {
  final Dio dio = ref.watch(dioProvider);
  return UserRepository(dio: dio);
}

@Riverpod(keepAlive: false)
Future<User?> getUser(ref, {required String userId}) {
  final UserRepository userRepository = ref.watch(userRepositoryProvider);
  return userRepository.getUser(userId: userId);
}
