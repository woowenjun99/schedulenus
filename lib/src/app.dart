import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schedulenus/src/routes/go_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: const Color.fromRGBO(59, 83, 173, 1),
          secondary: const Color.fromRGBO(0, 153, 101, 1),
          onBackground: const Color.fromRGBO(29, 30, 37, 1),
          background: const Color.fromRGBO(248, 249, 250, 1),
          seedColor: Colors.purple,
        ),
        useMaterial3: true,
      ),
      routerConfig: goRouter,
    );
  }
}
