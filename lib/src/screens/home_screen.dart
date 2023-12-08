import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schedulenus/src/common_widgets/options_button.dart';

import 'package:schedulenus/src/routes/app_route.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <OptionsButton>[
                  OptionsButton(
                    buttonName: "Timetable",
                    color: const Color.fromRGBO(255, 197, 197, 0.6),
                    routeName: AppRoute.allModules.name,
                    svgPath: "images/calendar-svgrepo-com.svg",
                  ),
                  OptionsButton(
                    buttonName: "Modules",
                    color: const Color.fromRGBO(255, 227, 187, 0.6),
                    routeName: AppRoute.allModules.name,
                    svgPath: "images/book-closed-svgrepo-com.svg",
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
