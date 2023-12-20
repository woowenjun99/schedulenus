import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:schedulenus/src/common_widgets/button.dart';
import 'package:schedulenus/src/routes/app_route.dart';
import 'package:schedulenus/src/services/auth/presentation/auth_screen_controller.dart';
import 'package:schedulenus/src/util/async_value_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Form(
          key: _form,
          child: SizedBox(
            width: double.infinity,
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 1800),
                      child: SizedBox(
                        width: contentWidth,
                        child: Text(
                          "ScheduleNUS",
                          style: GoogleFonts.inter(
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                    // Form
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1800),
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey[700]),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: ValidationBuilder()
                                      .email()
                                      .required()
                                      .build(),
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
                                  validator:
                                      ValidationBuilder().required().build(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1800),
                      child: SizedBox(
                        width: contentWidth,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: null,
                              child: Text(
                                "Forget password?",
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Login Button
                    Consumer(builder: (BuildContext context, WidgetRef ref, _) {
                      ref.listen<AsyncValue>(
                        authScreenControllerProvider,
                        (_, state) => state.showAlertDialogOnError(context),
                      );

                      final AsyncValue<void> state =
                          ref.watch(authScreenControllerProvider);

                      return FadeInUp(
                        duration: const Duration(milliseconds: 1800),
                        child: SizedBox(
                          width: contentWidth,
                          child: PrimaryButton(
                            isLoading: state.isLoading,
                            buttonText: "Sign In",
                            onPressed: () async {
                              final bool isValid =
                                  _form.currentState!.validate();
                              if (!isValid) return;
                              _form.currentState!.save();
                              await ref
                                  .watch(authScreenControllerProvider.notifier)
                                  .submit(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    formState: AuthScreenFormState.login,
                                  );
                            },
                          ),
                        ),
                      );
                    }),

                    FadeInUp(
                      duration: const Duration(milliseconds: 1800),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 36),
                        width: contentWidth,
                        child: const Divider(),
                      ),
                    ),

                    FadeInUp(
                      duration: const Duration(milliseconds: 1800),
                      child: SizedBox(
                        width: contentWidth,
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () =>
                              context.pushNamed(AppRoute.registration.name),
                          icon: Icon(MdiIcons.accountPlus),
                          label: const Text("Create new account"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
