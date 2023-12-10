import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schedulenus/src/common_widgets/button.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(label: Text("Name")),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(label: Text("Email")),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: 24),
          const PrimaryButton(
            buttonText: "Edit Information",
            onTap: null,
            isLoading: false,
          )
        ],
      ),
    );
  }
}
