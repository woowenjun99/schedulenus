import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_fonts/google_fonts.dart";
import "package:readmore/readmore.dart";

import "package:schedulenus/src/common_widgets/button.dart";
import "package:schedulenus/src/services/nusmods/data/nusmods_repository.dart";
import "package:schedulenus/src/services/nusmods/domain/modules.dart";

class IndividualModuleScreen extends ConsumerStatefulWidget {
  final String moduleCode;

  const IndividualModuleScreen({
    super.key,
    required this.moduleCode,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualModuleScreenState();
}

class _IndividualModuleScreenState
    extends ConsumerState<IndividualModuleScreen> {
  bool hasLoaded = false;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Module> module =
        ref.watch(getIndividualModuleProvider(moduleCode: widget.moduleCode));

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(widget.moduleCode),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: module.when(
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (data) {
              setState(() => hasLoaded = true);
              return IndividualModule(module: data);
            }),
      ),
      bottomSheet: hasLoaded
          ? Container(
              padding: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryButton(
                    onPressed: () {},
                    isLoading: false,
                    buttonText: "Enroll",
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class IndividualModule extends StatelessWidget {
  final Module module;

  const IndividualModule({
    required this.module,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 8,
            ),
            child: AutoSizeText(
              module.title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 20,
              overflow: TextOverflow.clip,
            ),
          ),
          const TabBar(tabs: [
            Tab(text: "About"),
          ]),
          Flexible(
            child: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "Description",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
