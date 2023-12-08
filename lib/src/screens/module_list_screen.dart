import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schedulenus/src/services/nusmods/data/nusmods_repository.dart';

import 'package:schedulenus/src/services/nusmods/domain/modules.dart';

class ModuleListScreen extends ConsumerStatefulWidget {
  const ModuleListScreen({super.key});

  @override
  ConsumerState<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends ConsumerState<ModuleListScreen> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<SimplifiedModule>> moduleList =
        ref.watch(getAllModulesSummaryProvider);

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          moduleList.when(
            data: (modules) {
              return ListView.builder(
                  itemCount: modules.length,
                  itemBuilder: (context, index) {
                    return Text(modules[index].title);
                  });
            },
            loading: () => const CircularProgressIndicator(),
            error: (err, _) => Text(err.toString()),
          )
        ],
      ),
    ));
  }
}
