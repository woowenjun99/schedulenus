import 'package:auto_size_text/auto_size_text.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Welcome back text
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Center(
              child: AutoSizeText(
                "Welcome Back",
                overflow: TextOverflow.clip,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
          ),

          // TODO: Announcement section

          // Explore section
          TextButton(
            onPressed: null,
            child: AutoSizeText(
              "Explore",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
          ),

          Flexible(
            child: GridView.count(
              primary: false,
              crossAxisCount: 3,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              children: [
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
          ),
        ],
      ),
    );
  }
}
