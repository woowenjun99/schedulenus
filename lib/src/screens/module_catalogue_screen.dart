import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:schedulenus/src/services/nusmods/data/nusmods_repository.dart';
import 'package:schedulenus/src/services/nusmods/domain/modules.dart';
import 'package:schedulenus/src/services/nusmods/presentation/module_list.dart';

class ModuleCatalogueScreen extends ConsumerStatefulWidget {
  const ModuleCatalogueScreen({super.key});

  @override
  ConsumerState<ModuleCatalogueScreen> createState() =>
      _ModuleCatalogueScreenState();
}

class _ModuleCatalogueScreenState extends ConsumerState<ModuleCatalogueScreen> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<SimplifiedModule>> modules =
        ref.watch(getAllModulesSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const AutoSizeText("Module Catalogue"),
      ),
      body: SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: modules.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              data: (modules) => ModuleList(modules: modules),
            )),
      ),
    );
  }
}
