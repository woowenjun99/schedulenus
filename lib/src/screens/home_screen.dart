import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schedulenus/src/common_widgets/options_button.dart';
import 'package:schedulenus/src/routes/app_route.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome Back",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                )),
            const SizedBox(height: 24),
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
    );
  }
}
