import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schedulenus/src/routes/go_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(25, 4, 130, 1),
          onPrimary: Colors.white,
          onBackground: Color.fromRGBO(29, 30, 37, 1),
          background: Color.fromRGBO(248, 249, 250, 1),
        ),
        useMaterial3: true,
      ),
      routerConfig: goRouter,
    );
  }
}
