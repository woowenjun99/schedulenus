import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:schedulenus/src/services/nusmods/domain/modules.dart';

class ModuleList extends StatefulWidget {
  final List<Module> modules;

  const ModuleList({
    super.key,
    required this.modules,
  });

  @override
  State<ModuleList> createState() => _ModuleListPageState();
}

class _ModuleListPageState extends State<ModuleList> {
  final TextEditingController _searchController = TextEditingController();
  List<Module> filteredModules = [];

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
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.025,
            ),
            separatorBuilder: (context, index) => const Divider(
              thickness: 0.3,
              color: Colors.black38,
            ),
            itemCount: filteredModules.length,
            itemBuilder: (context, index) {
              final Module currentModule = filteredModules[index];

              return ListTile(
                trailing: const Icon(Icons.chevron_right),
                title: AutoSizeText(
                  "${currentModule.moduleCode} ${currentModule.title}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  currentModule.description,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
