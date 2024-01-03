import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:schedulenus/src/services/nusmods/data/nusmods_repository.dart';
import 'package:schedulenus/src/services/nusmods/domain/modules.dart';
import 'package:schedulenus/src/services/nusmods/presentation/modules_search_bar.dart';

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
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: modules.when(
              loading: () => const Center(child: Text("Loading")),
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              data: (modules) => ModuleSearchBar(modules: modules),
            )),
      ),
    );
  }
}
