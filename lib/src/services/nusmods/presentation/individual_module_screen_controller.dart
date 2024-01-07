import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:schedulenus/src/services/nusmods/data/nusmods_repository.dart';

part 'individual_module_screen_controller.g.dart';

@Riverpod(keepAlive: false)
class IndividualModuleScreenController
    extends _$IndividualModuleScreenController {
  @override
  FutureOr build() {}

  Future<void> saveModule({
    required String moduleCode,
    required int semesterTaken,
  }) async {
    state = const AsyncLoading();
    final NusmodsRepository repository = ref.watch(nusmodsRepositoryProvider);
    state = await AsyncValue.guard(
      () => repository.saveModule(
          moduleCode: moduleCode, semesterTaken: semesterTaken),
    );
  }
}
