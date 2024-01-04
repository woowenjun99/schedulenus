import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:schedulenus/src/services/nusmods/domain/modules.dart';

part 'nusmods_repository.g.dart';

/// This class is used to pull all the information from the NUS Mods API. The
/// dio has been configured to pass in parameters. Refer to
/// https://api.nusmods.com/v2/#/ for more infomration about the api
class NusmodsRepository {
  final Dio dio;

  const NusmodsRepository({required this.dio});

  Future<List<Module>> getAllModules(String academicYear) async {
    final response = await dio.request(
      "/$academicYear/moduleInfo.json",
      options: Options(method: "GET"),
    );

    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(response.data);

    return data.map((d) => Module.fromJson(d)).toList();
  }
}

@riverpod
NusmodsRepository nusmodsRepository(ref) {
  return NusmodsRepository(
    dio: Dio(BaseOptions(
      baseUrl: "https://api.nusmods.com/v2",
      sendTimeout: const Duration(seconds: 5),
      connectTimeout: const Duration(seconds: 5),
    )),
  );
}

// Set keepAlive to be true to cache the data.
@riverpod
Future<List<Module>> getAllModules(ref) {
  final NusmodsRepository repository = ref.watch(nusmodsRepositoryProvider);
  return repository.getAllModules("2023-2024");
}
