import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:schedulenus/src/common_widgets/button.dart';
import 'package:schedulenus/src/services/user/data/user_repository.dart';
import 'package:schedulenus/src/services/user/domain/user.dart';
import 'package:schedulenus/src/services/user/presentation/my_account_screen_form_controller.dart';
import 'package:schedulenus/src/util/async_value_ui.dart';

class MyAccountScreenForm extends StatefulWidget {
  final User user;

  const MyAccountScreenForm({
    super.key,
    required this.user,
  });

  @override
  State<MyAccountScreenForm> createState() => _MyAccountScreenFormState();
}

class _MyAccountScreenFormState extends State<MyAccountScreenForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.value = TextEditingValue(text: widget.user.email);
    _fullNameController.value = TextEditingValue(text: widget.user.fullName);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contentWidth = MediaQuery.of(context).size.width * 0.9;

    return SizedBox(
      width: double.infinity,
      child: Form(
        child: Column(
          children: [
            SizedBox(
              width: contentWidth,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: contentWidth,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    label: Text("Name"),
                    prefixIcon: Icon(Icons.account_circle),
                  ),
                ),
              ),
            ),
            Consumer(builder: (context, ref, child) {
              final AsyncValue<void> state =
                  ref.watch(myAccountScreenFormControllerProvider);

              ref.listen<AsyncValue>(myAccountScreenFormControllerProvider,
                  (_, state) {
                state.showAlertDialogOnError(context);
              });

              return SizedBox(
                width: contentWidth,
                child: PrimaryButton(
                  onPressed: () async {},
                  isLoading: state.isLoading,
                  buttonText: "Update Particulars",
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
