import 'package:flutter/material.dart';
import 'package:schedulenus/src/services/nusmods/domain/modules.dart';

class ModuleSearchBar extends StatefulWidget {
  final List<SimplifiedModule> modules;

  const ModuleSearchBar({
    super.key,
    required this.modules,
  });

  @override
  State<ModuleSearchBar> createState() => _ModuleSearchBarState();
}

class _ModuleSearchBarState extends State<ModuleSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text("To Be Implemented");
  }
}
