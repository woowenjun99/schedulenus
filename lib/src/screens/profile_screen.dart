import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:schedulenus/src/common_widgets/button.dart';
import 'package:schedulenus/src/routes/app_route.dart';
import 'package:schedulenus/src/services/auth/presentation/auth_screen_controller.dart';
import 'package:schedulenus/src/util/async_value_ui.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListTile(
              leading: const Icon(Icons.account_circle),
              trailing: const Icon(Icons.chevron_right_outlined),
              title: const Text("My Profile"),
              onTap: () => context.pushNamed(AppRoute.myAccountScreen.name),
              textColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: const Divider(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              trailing: const Icon(Icons.chevron_right_outlined),
              title: const Text("My Modules"),
              onTap: null,
              textColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          Consumer(builder: (context, ref, _) {
            // Listen to error while logging out.
            ref.listen<AsyncValue>(authScreenControllerProvider, (_, state) {
              state.showAlertDialogOnError(context);
            });

            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: PrimaryButton(
                onPressed:
                    ref.watch(authScreenControllerProvider.notifier).signout,
                isLoading: false,
                buttonText: "Logout",
              ),
            );
          }),
        ],
      ),
    );
  }
}
