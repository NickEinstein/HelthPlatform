import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../constants/helper.dart';
import '../../../provider/all_providers.dart';
import '../../../utils/custom_header.dart';
import '../../../utils/custom_toast.dart';

class NewPasswordPage extends ConsumerStatefulWidget {
  String email;
  String otp;
  NewPasswordPage({super.key, required this.email, required this.otp});

  @override
  ConsumerState<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends ConsumerState<NewPasswordPage> {
  String password = "";
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordsMatch = false;
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;

  void _validateForm() {
    setState(() {
      _isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: Colors.white, // Matching the UI
      body: Form(
        key: _formKey,
        onChanged: _validateForm,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title & Page Indicator
                CustomHeader(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                smallSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "Reset password",
                            style: TextStyle(
                                color: Color(0xff3C3B3B),
                                fontWeight: FontWeight.w500,
                                fontSize: 24),
                          ),
                          TextSpan(
                            text: "",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: ColorConstant
                                    .primaryColor), // Change color here
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                smallSpace(),
                const Text(
                  "Enter your preferred password",
                  style: TextStyle(
                      color: ColorConstant.secondryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                mediumSpace(),
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
                  password: _confirmPasswordController.text,
                  onMatchChanged: (isMatching) {
                    setState(() {
                      _passwordsMatch = isMatching;
                    });
                  },
                ),
                // ConfirmPasswordTextField(
                //   label: "Confirm Password",
                //   password: password,
                // ),

                mediumSpace(),
                smallSpace(),

                // PageView for Steps
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          foregroundColor: ColorConstant.primaryColor,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          // context.push(Routes.OTPPAGE);
                          if (_isValid && _passwordsMatch) {
                            ref.read(isLoadingProvider.notifier).state = true;

                            final authService = ref.read(authServiceProvider);

                            if (_formKey.currentState!.validate()) {
                              final email = widget.email;

                              final result =
                                  await authService.forgotPasswordUrl(
                                      email,
                                      widget.otp,
                                      password,
                                      _confirmPasswordController.text);

                              if (!context.mounted)
                                return; // ✅ Prevents using context if unmounted
                              ref.read(isLoadingProvider.notifier).state =
                                  false;

                              if (result == 'successful') {
                                CustomToast.show(context,
                                    "New password updated successfully",
                                    type: ToastType.success);
                              } else {
                                CustomToast.show(context, result,
                                    type: ToastType.error);
                              }
                            }
                          } else {
                            CustomToast.show(
                                context, 'Enter a prefered Password',
                                type: ToastType.error);
                          }
                        },
                        child: const Text(
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.white),
                            "Reset password"),
                      ),
                smallSpace(),

                // Navigation Buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
