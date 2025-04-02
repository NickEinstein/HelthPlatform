import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../constants/helper.dart';
import '../../../provider/all_providers.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_toast.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isValid = false;

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
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
      backgroundColor: Colors.white,
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
                            text: "Login ",
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
                                color: ColorConstant.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                smallSpace(),
                const Text(
                  "Please provide the following information to get started",
                  style: TextStyle(
                      color: ColorConstant.secondryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                mediumSpace(),

                // Email Address Field
                CustomTextField(
                  label: "Email Address",
                  hint: "example@example.com",
                  controller: _emailController,
                  onChanged: (_) => _validateForm(),
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
                const SizedBox(height: 20),

                LoginPasswordTextField(
                  label: "Password",
                  controller: _passwordController,
                  onChanged: (_) => _validateForm(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (value.length < 5) {
                      return "Password must be at least 5 characters";
                    }
                    return null;
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        context.push(Routes.RESETPASSWORD);
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                            color: Color(0xffFFA500),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                mediumSpace(),

                // Proceed Button
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isValid
                                  ? ColorConstant.primaryColor
                                  : const Color(
                                      0xffA8D5BA), // Muted green when disabled
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: const Color(
                                  0xffA8D5BA), // Ensure disabled color is applied
                              disabledForegroundColor: Colors.white.withOpacity(
                                  0.6), // Lightened text for disabled state
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
                                      final email =
                                          _emailController.text.trim();
                                      final password = _passwordController.text;

                                      final result = await authService.login(
                                          email, password);

                                      if (!context.mounted)
                                        return; // ✅ Prevents using context if unmounted
                                      ref
                                          .read(isLoadingProvider.notifier)
                                          .state = false; // ✅ Stop loading

                                      if (result == 'Login successful') {
                                        context
                                            .pushReplacement(Routes.BOTTOMNAV);
                                      } else {
                                        CustomToast.show(context, result,
                                            type: ToastType.error);
                                      }
                                    }
                                  }
                                : null,
                            child: const Text(
                              "Proceed",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          smallSpace(),

                          // Sign Up Prompt
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: "Do not have an account? ",
                                      style: TextStyle(
                                          color: Color(0xff595959),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: "Create Account",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.pushReplacement(
                                              Routes.ACCOUNTCREATION);
                                        },
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
