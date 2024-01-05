import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:schedulenus/src/services/nusmods/data/nusmods_repository.dart";
import "package:schedulenus/src/services/nusmods/domain/modules.dart";
import "package:schedulenus/src/services/nusmods/presentation/individual_module_info.dart";

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
    );
  }
}
