import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:schedulenus/src/services/auth/presentation/auth_screen_controller.dart';
import 'package:schedulenus/src/util/async_value_ui.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: OutlinedButton.icon(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                    )),
                    onPressed: null,
                    icon: const Icon(Icons.settings),
                    label: const Text("Edit Profile"),
                  ),
                ),
                Consumer(builder: (context, ref, _) {
                  // Listen to error while logging out.
                  ref.listen<AsyncValue>(authScreenControllerProvider,
                      (_, state) {
                    state.showAlertDialogOnError(context);
                  });

                  final AsyncValue state =
                      ref.watch(authScreenControllerProvider);

                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: OutlinedButton.icon(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.red),
                        ),
                        iconColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: ref
                          .watch(authScreenControllerProvider.notifier)
                          .signout,
                      icon: const Icon(Icons.logout),
                      label: state.isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Sign Out",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
