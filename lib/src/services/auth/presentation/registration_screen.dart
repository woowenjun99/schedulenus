import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schedulenus/src/common_widgets/button.dart';
import 'package:schedulenus/src/services/auth/presentation/auth_screen_controller.dart';
import 'package:schedulenus/src/util/async_value_ui.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double contentWidth = MediaQuery.of(context).size.width * 0.9;
    ref.listen<AsyncValue>(
      authScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Form(
          key: _form,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: contentWidth,
                  child: Column(
                    children: [
                      Text(
                        "ScheduleNUS",
                        style: GoogleFonts.inter(
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Create a new account and start using ScheduleNUS now.",
                        style: GoogleFonts.inter(),
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromRGBO(143, 148, 251, 1),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, .2),
                          blurRadius: 20.0,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: contentWidth,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey[700]),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator:
                                ValidationBuilder().email().required().build(),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: contentWidth,
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey[700],
                                ),
                                prefixIcon: const Icon(Icons.lock)),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            validator: ValidationBuilder().required().build(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Consumer(builder: (BuildContext context, WidgetRef ref, _) {
                  ref.listen<AsyncValue>(
                    authScreenControllerProvider,
                    (_, state) => state.showAlertDialogOnError(context),
                  );

                  final AsyncValue<void> state =
                      ref.watch(authScreenControllerProvider);

                  return SizedBox(
                    width: contentWidth,
                    child: PrimaryButton(
                      isLoading: state.isLoading,
                      buttonText: "Register new account",
                      onPressed: () async {
                        final bool isValid = _form.currentState!.validate();
                        if (!isValid) return;
                        _form.currentState!.save();
                        await ref
                            .watch(authScreenControllerProvider.notifier)
                            .submit(
                              email: _emailController.text,
                              password: _passwordController.text,
                              formState: AuthScreenFormState.register,
                            );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
