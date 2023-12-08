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
  final TextEditingController _moduleController = TextEditingController();

  @override
  void dispose() {
    _moduleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<SimplifiedModule>> moduleList =
        ref.watch(getAllModulesSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Modules"),
      ),
      body: Center(
        child: moduleList.when(
          data: (modules) => DropdownMenu<SimplifiedModule>(
            controller: _moduleController,
            initialSelection: modules[0],
            dropdownMenuEntries: modules.map((SimplifiedModule module) {
              return DropdownMenuEntry(
                value: module,
                label: module.moduleCode,
              );
            }).toList(),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (err, _) => Text(err.toString()),
        ),
      ),
    );
  }
}
