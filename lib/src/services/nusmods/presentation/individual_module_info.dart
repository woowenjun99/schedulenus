import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:readmore/readmore.dart";

import "package:schedulenus/src/services/nusmods/domain/modules.dart";

class IndividualModuleInfo extends StatelessWidget {
  final Module module;
  final List<Widget> tabs = const [
    Tab(text: "About"),
    Tab(text: "Teaching Team"),
    Tab(text: "Reviews"),
  ];

  const IndividualModuleInfo({
    required this.module,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Module Title
            AutoSizeText(
              module.title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 20,
              overflow: TextOverflow.clip,
            ),
            // Department
            AutoSizeText(
              module.department,
              overflow: TextOverflow.clip,
              style: GoogleFonts.inter(),
            ),
            AutoSizeText("${module.moduleCredit} MCs"),

            TabBar(tabs: tabs),
            Flexible(
              child: TabBarView(
                children: [
                  // Screen 1: About screen
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AutoSizeText(
                          "Description",
                          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ReadMoreText(
                        module.description,
                        trimExpandedText: "Read less",
                        trimCollapsedText: "Read more",
                        moreStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        lessStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Column(children: []),
                  const Column(children: []),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
