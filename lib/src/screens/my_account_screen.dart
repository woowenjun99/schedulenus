import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:schedulenus/src/services/auth/data/auth_repository.dart';
import 'package:schedulenus/src/services/user/data/user_repository.dart';
import 'package:schedulenus/src/services/user/domain/user.dart';
import 'package:schedulenus/src/services/user/presentation/my_account_screen_form.dart';

class MyAccountScreen extends ConsumerStatefulWidget {
  const MyAccountScreen({super.key});

  @override
  ConsumerState<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends ConsumerState<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final String uid = ref.watch(authRepositoryProvider).currentUser!.uid;
    final AsyncValue<User> getUser = ref.watch(getUserProvider(id: uid));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("My profile")),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: getUser.when(
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (user) => MyAccountScreenForm(user: user),
          ),
        ),
      ),
    );
  }
}
