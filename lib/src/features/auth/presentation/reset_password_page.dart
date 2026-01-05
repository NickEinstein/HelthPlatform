import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../constants/helper.dart';
import '../../../provider/all_providers.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_header.dart';
import '../../../utils/custom_toast.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isValid = false;

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
    }
    super.dispose();
  }

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            onChanged: _validateForm,
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
                            text: "Forgot password",
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
                  "Enter your email address we will send a 4 digit code to reset your password",
                  style: TextStyle(
                      color: ColorConstant.secondryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                mediumSpace(),
                CustomTextField(
                  label: "Email Address",
                  hint: "example@example.com",
                  controller: _emailController,
                  onChanged: (_) => _validateForm(),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'.*')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email cannot be empty";
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                        .hasMatch(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),

                mediumSpace(),
                smallSpace(),

                // PageView for Steps
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isValid
                              ? ColorConstant.primaryColor
                              : const Color(
                                  0xffA8D5BA), // Muted green when disabled
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(
                              0xffA8D5BA), // Ensure disabled color is applied
                          disabledForegroundColor: Colors.white.withValues(
                            alpha: 0.6,
                          ), // Lightened text for disabled state
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _isValid
                            ? () async {
                                ref.read(isLoadingProvider.notifier).state =
                                    true;

                                final authService =
                                    ref.read(authServiceProvider);

                                if (_formKey.currentState!.validate()) {
                                  final email = _emailController.text.trim();

                                  final result = await authService.otpSendUrl(
                                    email: email,
                                  );

                                  if (!context.mounted) {
                                    return;
                                  } // ✅ Prevents using context if unmounted
                                  ref.read(isLoadingProvider.notifier).state =
                                      false;

                                  if (result == 'successful') {
                                    CustomToast.show(
                                        context, "otp sent Successfully",
                                        type: ToastType.success);
                                    context.push(Routes.OTPPAGE,
                                        extra: _emailController.text);
                                  } else {
                                    CustomToast.show(context, result,
                                        type: ToastType.error);
                                  }
                                }
                              }
                            : null,
                        child: const Text(
                          "Send Code",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
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
