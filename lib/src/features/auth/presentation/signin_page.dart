import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/helper.dart';
import '../../../provider/all_providers.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_toast.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
  // ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController(
    text: kDebugMode ? 'Admin@123' : '',
  );
  bool _isValid = false;
  bool _isBiometricAvailable = false;
  BiometricType? _biometricType; // Store which biometric is available

  final LocalAuthentication _localAuth = LocalAuthentication();

  // @override
  // void dispose() {
  //   if (mounted) {
  //     _emailController.dispose();
  //     _passwordController.dispose();
  //   }
  //   super.dispose();
  // }

  void _validateForm() {
    setState(() {
      _isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkBiometricSupport();
    _loadSavedCredentials();
  }

  Future<void> _checkBiometricSupport() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email') ?? "";
    final savedPassword = prefs.getString('saved_password') ?? "";

    if (savedEmail.isNotEmpty && savedPassword.isNotEmpty) {
      final bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final List<BiometricType> availableBiometrics =
          await _localAuth.getAvailableBiometrics();

      if (canCheckBiometrics && availableBiometrics.isNotEmpty) {
        setState(() {
          _isBiometricAvailable = true;
          if (availableBiometrics.contains(BiometricType.face)) {
            _biometricType = BiometricType.face;
          } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
            _biometricType = BiometricType.fingerprint;
          }
        });
      }
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      final bool authenticated = await _localAuth.authenticate(
        localizedReason:
            'Scan your ${_biometricType == BiometricType.face ? "face" : "fingerprint"} to log in',
        // options: const AuthenticationOptions(
        biometricOnly: true,
        persistAcrossBackgrounding: true,
        // stickyAuth: true,
        // ),
      );

      if (authenticated) {
        final prefs = await SharedPreferences.getInstance();
        _emailController.text = prefs.getString('saved_email') ?? "";
        _passwordController.text = prefs.getString('saved_password') ?? "";
        _signIn(); // Trigger login automatically
      }
    } catch (e) {
      print("Biometric authentication failed: $e");
    }
  }

  Future<void> _signIn() async {
    FocusScope.of(context).requestFocus(
        FocusNode()); // Request focus on a dummy node to dismiss the keyboard

    await Future.delayed(const Duration(milliseconds: 100));

    // Now, unfocus
    FocusScope.of(context).unfocus();

    ref.read(isLoadingProvider.notifier).state = true;

    final authService = ref.read(authServiceProvider);
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final result = await authService.login(email, password);

    if (!mounted) return;
    ref.read(isLoadingProvider.notifier).state = false;

    if (result == 'Login successful') {
      context.pushReplacement(Routes.BOTTOMNAV);
    } else {
      CustomToast.show(context, result, type: ToastType.error);
    }
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email') ?? "";

    setState(() {
      _emailController.text = savedEmail;
      // _passwordController.text = savedPassword;
    });

    _validateForm();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
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
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  mediumSpace(),

                  // Email Address Field
                  CustomTextField(
                    label: "Username Email Address",
                    hint: "example@example.com",
                    controller: _emailController,
                    onChanged: (_) => _validateForm(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'.*')),
                    ],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Field cannot be empty";
                      }

                      final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );
                      final phoneRegex = RegExp(
                        r'^\+?[0-9]{7,15}$', // allows +234..., 080..., etc. with 7–15 digits
                      );
                      final usernameRegex = RegExp(
                        r'^[a-zA-Z0-9._-]{3,}$', // min 3 chars, alphanumeric with . _ -
                      );

                      if (!(emailRegex.hasMatch(value) ||
                          phoneRegex.hasMatch(value) ||
                          usernameRegex.hasMatch(value))) {
                        return "Enter a valid email, phone number, or username";
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
                              color: Color(0xff818181),
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
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _isValid
                                          ? ColorConstant.primaryColor
                                          : const Color(
                                              0xffA8D5BA), // Muted green when disabled
                                      foregroundColor: Colors.white,
                                      disabledBackgroundColor: const Color(
                                          0xffA8D5BA), // Ensure disabled color is applied
                                      disabledForegroundColor: Colors.white
                                          .withValues(
                                              alpha:
                                                  0.6), // Lightened text for disabled state
                                      minimumSize:
                                          const Size(double.infinity, 55),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: _isValid
                                        ? () async {
                                            ref
                                                .read(
                                                    isLoadingProvider.notifier)
                                                .state = true;

                                            final authService =
                                                ref.read(authServiceProvider);

                                            if (_formKey.currentState!
                                                .validate()) {
                                              final email =
                                                  _emailController.text.trim();
                                              final password =
                                                  _passwordController.text;

                                              final result = await authService
                                                  .login(email, password);

                                              if (!context.mounted)
                                                return; // ✅ Prevents using context if unmounted
                                              ref
                                                      .read(isLoadingProvider
                                                          .notifier)
                                                      .state =
                                                  false; // ✅ Stop loading

                                              if (result ==
                                                  'Login successful') {
                                                context.pushReplacement(
                                                    Routes.BOTTOMNAV);
                                              } else {
                                                CustomToast.show(
                                                    context, result,
                                                    type: ToastType.error);
                                              }
                                            }
                                          }
                                        : null,
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: Text(
                                        "Proceed",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Biometric Icon Button (if available)
                                if (_isBiometricAvailable)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorConstant.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: IconButton(
                                        icon: Icon(
                                          _biometricType == BiometricType.face
                                              ? Icons.face
                                              : Icons.fingerprint,
                                          size: 36,
                                          color: Colors.white,
                                        ),
                                        onPressed: _authenticateWithBiometrics,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            smallSpace(),
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
                                            color: Color(0xff17631A)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(context, 0.05),
                            if (Platform.isAndroid)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 1, // Thickness of the line
                                          color: const Color(
                                              0xffD8D8D8), // Line color
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text('OR',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color(
                                                  0xff8C8C8C), // Line color
                                            )),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 1, // Thickness of the line
                                          color: const Color(
                                              0xffD8D8D8), // Line color
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            verticalSpace(context, 0.03),
                            // if (Platform.isIOS)
                            //   Center(
                            //     child: Row(
                            //       children: [
                            //         Expanded(
                            //             child: InkWell(
                            //           onTap: () async {
                            //             ref
                            //                 .read(isLoadingProvider.notifier)
                            //                 .state = true;

                            //             final authService =
                            //                 ref.read(authServiceProvider);
                            //             final userCredential = await authService
                            //                 .signInWithGoogle();

                            //             if (!mounted) return;
                            //             ref
                            //                 .read(isLoadingProvider.notifier)
                            //                 .state = false;

                            //             if (userCredential != null) {
                            //               final idToken = await userCredential
                            //                   .user
                            //                   ?.getIdToken();

                            //               if (idToken != null) {
                            //                 final result = await authService
                            //                     .socialLogin('google', idToken);

                            //                 if (result == 'Login successful') {
                            //                   context.pushReplacement(
                            //                       Routes.BOTTOMNAV);
                            //                 } else {
                            //                   CustomToast.show(context, result,
                            //                       type: ToastType.error);
                            //                 }
                            //               } else {
                            //                 CustomToast.show(
                            //                     context, 'Token not found',
                            //                     type: ToastType.error);
                            //               }
                            //             } else {
                            //               CustomToast.show(
                            //                   context, 'Google Sign-in failed',
                            //                   type: ToastType.error);
                            //             }
                            //           },
                            //           child: Image.asset(
                            //               'assets/icon/login_google.png'),
                            //         )),
                            //         Expanded(
                            //             child: Image.asset(
                            //                 'assets/icon/login_apple.png')),
                            //       ],
                            //     ),
                            //   ),
                            if (Platform.isAndroid)
                              InkWell(
                                onTap: () async {
                                  ref.read(isLoadingProvider.notifier).state =
                                      true;

                                  final authService =
                                      ref.read(authServiceProvider);
                                  final userCredential =
                                      await authService.signInWithGoogle();

                                  if (!mounted) return;
                                  ref.read(isLoadingProvider.notifier).state =
                                      false;

                                  if (userCredential != null) {
                                    final idToken =
                                        await userCredential.user?.getIdToken();

                                    if (idToken != null) {
                                      final result = await authService
                                          .socialLogin('google', idToken);

                                      if (result == 'Login successful') {
                                        context
                                            .pushReplacement(Routes.BOTTOMNAV);
                                      } else {
                                        CustomToast.show(context, result,
                                            type: ToastType.error);
                                      }
                                    } else {
                                      CustomToast.show(
                                          context, 'Token not found',
                                          type: ToastType.error);
                                    }
                                  } else {
                                    CustomToast.show(
                                        context, 'Google Sign-in failed',
                                        type: ToastType.error);
                                  }
                                },
                                child: Image.asset(
                                    width: width(context),
                                    height: height(context) * 0.09,
                                    'assets/icon/login_google.png'),
                              ),

                            // tinySpace(),
                            // InkWell(
                            //   onTap: () async {
                            //     final LoginResult result =
                            //         await FacebookAuth.instance.login();
                            //     if (result.status == LoginStatus.success) {
                            //       final accessToken = result.accessToken;
                            //       // Use accessToken to authenticate with backend or Firebase
                            //     }
                            //   },
                            //   child: Padding(
                            //     padding:
                            //         const EdgeInsets.symmetric(horizontal: 10),
                            //     child: Image.asset(
                            //         'assets/icon/login_facebook.png'),
                            //   ),
                            // ),
                          ],
                        ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
