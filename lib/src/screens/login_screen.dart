import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:schedulenus/src/routes/app_route.dart';
import 'package:schedulenus/src/services/auth/presentation/auth_screen_controller.dart';
import 'package:schedulenus/src/util/async_value_ui.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _form,
        child: SizedBox(
          width: double.infinity,
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ScheduleNUS",
                    style: GoogleFonts.inter(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: contentWidth,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(label: Text("Email")),
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidationBuilder().email().required().build(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: contentWidth,
                    child: TextFormField(
                      controller: _passwordController,
                      decoration:
                          const InputDecoration(label: Text("Password")),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: ValidationBuilder().required().build(),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Consumer(builder: (BuildContext context, WidgetRef ref, _) {
                    final AsyncValue<void> state =
                        ref.watch(authScreenControllerProvider);

                    return SizedBox(
                      width: contentWidth,
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primary,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final bool isValid = _form.currentState!.validate();
                          if (!isValid) return;
                          final bool isSuccess = await ref
                              .watch(authScreenControllerProvider.notifier)
                              .submit(
                                email: _emailController.text,
                                password: _passwordController.text,
                                formState: AuthScreenFormState.login,
                              );
                          if (mounted && isSuccess) {
                            context.pushNamed(AppRoute.home.name);
                          }
                        },
                        child: state.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Sign In",
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    );
                  }),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: contentWidth,
                    child: const Divider(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: contentWidth,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.background,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          context.pushNamed(AppRoute.registration.name),
                      icon: Icon(MdiIcons.accountPlus),
                      label: const Text("Create an account"),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
