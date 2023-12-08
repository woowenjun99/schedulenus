import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schedulenus/src/common_widgets/options_button.dart';

import 'package:schedulenus/src/routes/app_route.dart';
import 'package:schedulenus/src/services/auth/data/auth_repository.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    ref.watch(authRepositoryProvider).signout();
  }

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = ref.watch(authRepositoryProvider);
    final User user = authRepository.currentUser!;

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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
