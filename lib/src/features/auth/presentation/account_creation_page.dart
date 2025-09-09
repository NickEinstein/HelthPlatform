import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/helper.dart';
import '../../../provider/all_providers.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_toast.dart';
import 'upload_selfie_screen.dart';
import 'widget/account_controller_holder.dart';
import 'widget/location_info_screen.dart';
import 'widget/password_screen.dart';
import 'widget/personal_info_screen.dart';
import 'widget/register_otp_page.dart';

class AccountCreationScreen extends ConsumerStatefulWidget {
  const AccountCreationScreen({super.key});

  @override
  ConsumerState<AccountCreationScreen> createState() =>
      _AccountCreationScreenState();
}

class _AccountCreationScreenState extends ConsumerState<AccountCreationScreen> {
  final PageController _pageController = PageController();
  final AccountCreationController _controller = AccountCreationController();

  int _currentIndex = 0;
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  //   selectedAllergies: selectedAllergies,  // The selected allergies from the state
  //   otherController: otherController,  // Pass the TextEditingController for "Others"
  // );
  String? passwordValidator(String password) {
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSpecialChar = password.contains(RegExp(r'[!@#\$&*~]'));

    if (!hasUppercase) return "Password must contain Uppercase";
    if (!hasLowercase) return "Password must contain Lowercase";
    if (!hasNumber) return "Password must contain a Number";
    if (!hasSpecialChar) {
      return "Password must contain a Special Character (!@#\$&*~)";
    }

    return null; // ✅ All checks passed
  }

  void _nextPage() async {
    final currentFormState = _formKeys[_currentIndex].currentState;
    if (currentFormState != null && currentFormState.validate()) {
      if (_currentIndex == 4) {
        // Ensure password and confirm password are filled and match
        if (_controller.passwordController.text.isEmpty ||
            _controller.confirmPasswordController.text.isEmpty) {
          CustomToast.show(context, 'Passwords cannot be empty',
              type: ToastType.error);
          return;
        }
        if (!canProceed(_controller.passwordController.text,
            _controller.confirmPasswordController.text)) {
          CustomToast.show(context, 'Kindly Check password strength',
              type: ToastType.error);
        }

        final passwordStrengthError =
            passwordValidator(_controller.passwordController.text);
        if (passwordStrengthError != null) {
          CustomToast.show(context, passwordStrengthError,
              type: ToastType.error);
          return;
        }
        if (_controller.passwordController.text !=
            _controller.confirmPasswordController.text) {
          CustomToast.show(context, 'Passwords do not match',
              type: ToastType.error);
          return;
        }

        _submitForm();
      } else if (_currentIndex == 1) {
        if (_controller.isChecked == false) {
          CustomToast.show(context, 'Kindly agree to the terms and conditions',
              type: ToastType.error);
          return;
        } else {
          ref.read(isLoadingProvider.notifier).state = true;
          final authService = ref.read(authServiceProvider);

          final result = await authService.register(
            firstName: _controller.firstNameController.text.split(' ')[0],
            lastName: _controller.firstNameController.text.split(' ')[1],
            city: _controller.cityController.text,
            dateOfBirth: _controller.dobController.text,
            email: _controller.emailController.text,
            homeAddress: _controller.addressController.text,
            lga: _controller.lgaController.text,
            lgaResidence: _controller.lgaController.text,
            username: _controller.userNameController.text,
            nationality: 'Nigeria',
            phone: _controller.phoneController.text,
            placeOfBirth: _controller.addressController.text,
            stateOfOrigin: _controller.stateController.text,
            stateOfResidence: _controller.stateController.text,
          );

          if (!context.mounted) return;
          ref.read(isLoadingProvider.notifier).state = false;

          if (result != null && result.isSuccess && result.statusCode == 200) {
            final patientId = result.data?.patientId;
            _controller.patientId = patientId;
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            final errorMessage = result?.data?.emailResult?.message ??
                result?.error?['message'] ??
                'Registration failed';

            CustomToast.show(context, errorMessage, type: ToastType.error);
          }
        }
      } else if (_currentIndex == 2) {
        // _pageController.nextPage(
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        // );
        if (_controller.otpController.text.length < 4) {
          CustomToast.show(context, 'Enter a valid OTP', type: ToastType.error);
          return;
        } else {
          ref.read(isLoadingProvider.notifier).state = true;
          final authService = ref.read(authServiceProvider);

          final result = await authService.validateOtpUrl(
              _controller.emailController.text, _controller.otpController.text);

          if (!context.mounted) return; // ✅ Prevents using context if unmounted
          ref.read(isLoadingProvider.notifier).state = false;
          if (result == 'OTP successful') {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            CustomToast.show(context, result, type: ToastType.error);
          }
        }
      } else if (_currentIndex == 3) {
        // _pageController.nextPage(
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        // );

        if (_controller.imageFile == null) {
          CustomToast.show(context, 'Kindly upload profile picture',
              type: ToastType.error);
          return;
        } else {
          ref.read(isLoadingProvider.notifier).state = true;
          final authService = ref.read(authServiceProvider);

          final result =
              await authService.uploadProfileUrl(_controller.imageFile!);

          if (!context.mounted) return; // ✅ Prevents using context if unmounted
          ref.read(isLoadingProvider.notifier).state = false;
          if (result["data"] != null) {
            final String imageUrl = result["data"]["imageUrl"];
            _controller.pictureUrl = imageUrl;

            ref.read(isLoadingProvider.notifier).state = true;

            final uploadResult = await authService.photoUpdate(
                _controller.patientId!, _controller.pictureUrl!);

            if (!context.mounted) {
              return; // ✅ Prevents using context if unmounted
            }
            ref.read(isLoadingProvider.notifier).state = false;
            if (uploadResult == 'successful') {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              CustomToast.show(context, "Error uploading",
                  type: ToastType.error);
            }
            // _pageController.nextPage(
            //   duration: const Duration(milliseconds: 300),
            //   curve: Curves.easeInOut,
            // );
          } else {
            CustomToast.show(context, "Error uploading", type: ToastType.error);
          }
        }
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      CustomToast.show(context, 'Please fill all fields before proceeding',
          type: ToastType.error);
    }
  }

  void _submitForm() async {
    // Retrieve all values
    ref.read(isLoadingProvider.notifier).state = true;
    final authService = ref.read(authServiceProvider);

    final result = await authService.createPasswordUrl(
        _controller.emailController.text,
        _controller.passwordController.text,
        _controller.confirmPasswordController.text);

    if (!context.mounted) return; // ✅ Prevents using context if unmounted
    ref.read(isLoadingProvider.notifier).state = false;
    if (result == 'successful') {
      CustomToast.show(context, 'Registered Successfully',
          type: ToastType.success);
      context.pushReplacement(Routes.BOTTOMNAV);
    } else {
      CustomToast.show(context, result, type: ToastType.error);
    }

    // Proceed with API submission or next step
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  _isAgree() {
    if (_currentIndex == 1) {
      if (_controller.isChecked) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    final isAgreed = ref.watch(isAgreedProvider);

    return Scaffold(
      backgroundColor: Colors.white, // Matching the UI
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title & Page Indicator
                if (_currentIndex != 3)
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
                              text: "Create ",
                              style: TextStyle(
                                  color: Color(0xff3C3B3B),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24),
                            ),
                            TextSpan(
                              text: "Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: ColorConstant.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: 4,
                        effect: const ExpandingDotsEffect(
                          dotColor: ColorConstant.primaryLightColor,
                          activeDotColor: ColorConstant.primaryColor,
                          dotHeight: 6,
                          dotWidth: 6,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                if (_currentIndex != 3)
                  const Text(
                    "Please provide the following information to get started",
                    style: TextStyle(
                        color: ColorConstant.secondryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                if (_currentIndex != 3) const SizedBox(height: 20),
                // PageView for Steps
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height * 0.6, // Adjust height
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    children: [
                      PersonalInfoScreen(
                        onNext: _nextPage,
                        formKey: _formKeys[0],
                        controller: _controller,
                      ),
                      LocationInfoScreen(
                          controller: _controller,
                          onNext: _nextPage,
                          formKey: _formKeys[1]),
                      RegisterOTPPage(
                        onNext: _nextPage,
                        formKey: _formKeys[2],
                        controller: _controller,
                      ),
                      UploadSelfieScreen(
                        onNext: _nextPage,
                        formKey: _formKeys[3],
                        controller: _controller,
                      ),
                      PasswordScreen(
                        formKey: _formKeys[4],
                        controller: _controller,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Navigation Buttons
                // if (_currentIndex != 2)
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _currentIndex == 1 && !isAgreed
                                    ? ColorConstant.primaryLightColor
                                        .withOpacity(0.3)
                                    : ColorConstant.primaryColor,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: _nextPage,
                              child: Text(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                  _currentIndex == 4
                                      ? "Create Account"
                                      : _currentIndex == 2
                                          ? "Verify OTP"
                                          : "Proceed"),
                            ),
                            if (_currentIndex == 1)
                              TextButton(
                                onPressed: _previousPage,
                                child: const Text(
                                  "Back",
                                  style: TextStyle(
                                      color: ColorConstant.primaryColor),
                                ),
                              ),
                            const SizedBox(height: 10),
                            if (_currentIndex != 3)
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: "I have an account? ",
                                      style: TextStyle(
                                        color: Color(0xff595959),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Log in",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ColorConstant.primaryColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context
                                              .pushReplacement(Routes.SIGNIN);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
