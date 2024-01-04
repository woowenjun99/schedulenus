import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schedulenus/src/common_widgets/skeleton_loader.dart';

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
    final AsyncValue<List<Module>> modules = ref.watch(getAllModulesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const AutoSizeText("Find Modules"),
      ),
      body: SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: modules.when(
              loading: () => const SkeletonLoader(),
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              data: (modules) => ModuleList(modules: modules),
            )),
      ),
    );
  }
}
