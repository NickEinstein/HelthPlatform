import 'package:flutter/material.dart';

import '../../../../constants/helper.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PasswordTextField(
          label: "Password",
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
        ),
        const SizedBox(height: 20),
        ConfirmPasswordTextField(
          label: "Confirm Password",
          password: password,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
