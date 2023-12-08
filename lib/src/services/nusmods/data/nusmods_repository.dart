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

  Future<List<SimplifiedModule>> getAllModulesSummary(
      String academicYear) async {
    final response = await dio.request(
      "/$academicYear/moduleList.json",
      options: Options(method: "GET"),
    );

    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(response.data);

    return data.map((d) => SimplifiedModule.fromJson(d)).toList();
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

@Riverpod(keepAlive: false)
Future<List<SimplifiedModule>> getAllModulesSummary(ref) {
  final NusmodsRepository repository = ref.watch(nusmodsRepositoryProvider);
  return repository.getAllModulesSummary("2023-2024");
}
