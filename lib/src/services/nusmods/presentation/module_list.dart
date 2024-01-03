import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:schedulenus/src/services/nusmods/domain/modules.dart';

class ModuleList extends StatefulWidget {
  final List<SimplifiedModule> modules;

  const ModuleList({
    super.key,
    required this.modules,
  });

  @override
  State<ModuleList> createState() => _ModuleListPageState();
}

class _ModuleListPageState extends State<ModuleList> {
  final TextEditingController _searchController = TextEditingController();
  List<SimplifiedModule> filteredModules = [];

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void _searchModule(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredModules = [];
      } else {
        filteredModules = widget.modules.where((module) {
          return module.title
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              module.moduleCode
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: 10,
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _searchModule,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _searchController.value = TextEditingValue.empty;
                  setState(() => filteredModules = []);
                },
              ),
              hintText: "Search course",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            itemCount: filteredModules.length,
            itemBuilder: (context, index) {
              final SimplifiedModule currentModule = filteredModules[index];

              return Card(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  tileColor: Theme.of(context).colorScheme.secondary,
                  textColor: Colors.white,
                  title: AutoSizeText(
                    currentModule.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: AutoSizeText(
                    "Module Code ${currentModule.moduleCode}",
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
