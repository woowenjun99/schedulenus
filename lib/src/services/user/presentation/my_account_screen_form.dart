import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schedulenus/src/common_widgets/alert_dialog.dart';

import 'package:schedulenus/src/common_widgets/button.dart';
import 'package:schedulenus/src/services/auth/data/auth_repository.dart';
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
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final List<int> semesterSelection = List.generate(8, (index) => index + 1);
  late int selectedSemester = semesterSelection.first;

  @override
  void initState() {
    super.initState();
    _fullNameController.value = TextEditingValue(text: widget.user.fullName);
    _usernameController.value =
        TextEditingValue(text: widget.user.username ?? "");
    selectedSemester = widget.user.semester;
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
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
                  keyboardType: TextInputType.text,
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    label: Text("Username"),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 24,
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
            const SizedBox(height: 24),
            DropdownMenu<int>(
              width: contentWidth,
              label: const Text("Your Current Semester"),
              initialSelection: selectedSemester,
              onSelected: (value) => setState(() => selectedSemester = value!),
              dropdownMenuEntries: semesterSelection
                  .map(
                    (semester) => DropdownMenuEntry(
                      value: semester,
                      label: semester.toString(),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
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
                  onPressed: () async {
                    await ref
                        .watch(myAccountScreenFormControllerProvider.notifier)
                        .submitUser(
                          email: ref
                              .watch(authRepositoryProvider)
                              .currentUser!
                              .email!,
                          fullName: _fullNameController.text,
                          major: "",
                          semester: selectedSemester,
                          username: _usernameController.text,
                        );

                    if (!mounted) return;

                    await showAlertDialog(
                      context: context,
                      title: "Successfully updated!",
                      content:
                          "Your particulars have been successfully updated!",
                    );
                  },
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
