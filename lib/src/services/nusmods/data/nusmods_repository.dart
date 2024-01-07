import 'package:cloud_functions/cloud_functions.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:schedulenus/src/services/nusmods/domain/modules.dart';

part 'nusmods_repository.g.dart';

/// This class is used to pull all the information from the NUS Mods API. The
/// dio has been configured to pass in parameters. Refer to
/// https://api.nusmods.com/v2/#/ for more infomration about the api
class NusmodsRepository {
  final Dio dio;
  final FirebaseFunctions functions;

  const NusmodsRepository({
    required this.dio,
    required this.functions,
  });

  /// Gets all the information about the modules including the description and
  /// faculty
  Future<List<Module>> getAllModules(String academicYear) async {
    final response = await dio.request(
      "/$academicYear/moduleInfo.json",
      options: Options(method: "GET"),
    );

    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(response.data);

    return data.map((d) => Module.fromJson(d)).toList();
  }

  /// Gets the specific information about the module.
  Future<Module> getIndividualModule(
    String academicYear,
    String moduleCode,
  ) async {
    final response = await dio.request(
      "/$academicYear/modules/$moduleCode.json",
      options: Options(method: "GET"),
    );

    final data = Map<String, dynamic>.from(response.data);

    return Module.fromJson(data);
  }

  Future<void> saveModule({
    required String moduleCode,
    required int semesterTaken,
  }) async {
    final HttpsCallableResult result =
        await functions.httpsCallable("saveModule").call({
      "moduleCode": moduleCode,
      "semesterTaken": semesterTaken,
    });

    final data = Map<String, dynamic>.from(result.data);

    if (!data["success"]) throw Exception(data["error"] as String);
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
    functions: FirebaseFunctions.instanceFor(region: "asia-southeast1"),
  );
}

@Riverpod(keepAlive: false)
Future<Module> getIndividualModule(
  ref, {
  required String moduleCode,
}) {
  final NusmodsRepository repository = ref.watch(nusmodsRepositoryProvider);
  return repository.getIndividualModule("2023-2024", moduleCode);
}

// Set keepAlive to be true to cache the data.
@riverpod
Future<List<Module>> getAllModules(ref) {
  final NusmodsRepository repository = ref.watch(nusmodsRepositoryProvider);
  return repository.getAllModules("2023-2024");
}
