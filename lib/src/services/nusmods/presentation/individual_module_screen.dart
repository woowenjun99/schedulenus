import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:schedulenus/src/common_widgets/button.dart";

import "package:schedulenus/src/services/nusmods/data/nusmods_repository.dart";
import "package:schedulenus/src/services/nusmods/domain/modules.dart";
import "package:schedulenus/src/services/nusmods/presentation/individual_module_info.dart";
import "package:schedulenus/src/services/nusmods/presentation/individual_module_screen_controller.dart";
import "package:schedulenus/src/util/async_value_ui.dart";

class IndividualModuleScreen extends ConsumerWidget {
  final String moduleCode;

  const IndividualModuleScreen({
    super.key,
    required this.moduleCode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Module> module =
        ref.watch(getIndividualModuleProvider(moduleCode: moduleCode));

    ref.listen<AsyncValue>(
      individualModuleScreenControllerProvider,
      (_, state) {
        state.showAlertDialogOnError(context);
      },
    );

    final state = ref.watch(individualModuleScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(moduleCode),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: module.when(
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (data) => IndividualModuleInfo(module: data),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: PrimaryButton(
            buttonText: "Add Module",
            isLoading: state.isLoading,
            onPressed: () => ref
                .watch(individualModuleScreenControllerProvider.notifier)
                .saveModule(
                  moduleCode: moduleCode,
                  semesterTaken: 1,
                ),
          ),
        ),
      ),
    );
  }
}
