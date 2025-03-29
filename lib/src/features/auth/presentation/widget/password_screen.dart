import 'package:flutter/material.dart';

import '../../../../constants/helper.dart';
import 'account_controller_holder.dart';

class PasswordScreen extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final AccountCreationController controller;

  const PasswordScreen(
      {super.key, required this.formKey, required this.controller});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String password = "";

  bool _passwordsMatch = false;
  bool _isValid = false;

  void _validateForm() {
    setState(() {
      _isValid = widget.formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        onChanged: _validateForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PasswordTextField(
              label: "Password",
              controller: widget.controller.passwordController,
              onChanged: (value) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      password = value;
                    });
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            ConfirmPasswordTextField(
              label: "Confirm Password",
              controller: widget.controller.confirmPasswordController,
              password:
                  password, // Use `password` instead of `_confirmPasswordController.text`
              onMatchChanged: (isMatching) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _passwordsMatch = isMatching;
                    });
                  }
                });
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
