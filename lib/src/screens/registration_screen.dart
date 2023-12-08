import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schedulenus/src/common_widgets/button.dart';
import 'package:schedulenus/src/routes/app_route.dart';
import 'package:schedulenus/src/services/auth/presentation/registration_screen_controller.dart';
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
      registrationScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _form,
        child: SizedBox(
          width: double.infinity,
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
              const SizedBox(height: 24),
              SizedBox(
                width: contentWidth,
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(label: Text("Email")),
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidationBuilder().email().required().build(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: contentWidth,
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(label: Text("Password")),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: ValidationBuilder().required().build(),
                ),
              ),
              const SizedBox(height: 28),
              Consumer(builder: (BuildContext context, WidgetRef ref, _) {
                final AsyncValue<void> state =
                    ref.watch(registrationScreenControllerProvider);

                return PrimaryButton(
                  buttonText: "Sign In",
                  onTap: () async {
                    final bool? isValid = _form.currentState?.validate();
                    if (isValid == null || isValid == false) return;
                    final bool isSuccess = await ref
                        .watch(registrationScreenControllerProvider.notifier)
                        .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                    if (mounted && isSuccess) {
                      context.goNamed(AppRoute.home.name);
                    }
                  },
                  isLoading: state.isLoading,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
