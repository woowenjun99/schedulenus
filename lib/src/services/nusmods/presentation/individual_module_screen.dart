import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:schedulenus/src/services/nusmods/data/nusmods_repository.dart";
import "package:schedulenus/src/services/nusmods/domain/modules.dart";
import "package:schedulenus/src/services/nusmods/presentation/individual_module_info.dart";

class IndividualModuleScreen extends ConsumerStatefulWidget {
  final String moduleCode;

  const IndividualModuleScreen({
    super.key,
    required this.moduleCode,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualModuleScreenState();
}

class _IndividualModuleScreenState
    extends ConsumerState<IndividualModuleScreen> {
  bool hasLoaded = false;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Module> module =
        ref.watch(getIndividualModuleProvider(moduleCode: widget.moduleCode));

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(widget.moduleCode),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: module.when(
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (data) {
              setState(() => hasLoaded = true);
              return IndividualModuleInfo(module: data);
            }),
      ),
    );
  }
}
