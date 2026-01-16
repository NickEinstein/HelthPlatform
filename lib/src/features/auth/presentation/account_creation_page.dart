import 'package:flutter/gestures.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../provider/all_providers.dart';
import 'widget/account_controller_holder.dart';
import 'widget/password_screen.dart';
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
      if (_currentIndex == 0) {
        if (_controller.isChecked == false) {
          CustomToast.show(
            context,
            'Kindly agree to the terms and conditions',
            type: ToastType.error,
          );
          return;
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      } else if (_currentIndex == 1) {
        if ((_controller.passwordController.text !=
                _controller.confirmPasswordController.text) ||
            _controller.passwordController.text.isEmpty ||
            _controller.confirmPasswordController.text.isEmpty) {
          CustomToast.show(
            context,
            'Passwords do not match',
            type: ToastType.error,
          );
          return;
        }
        _submitForm();
      } else if (_currentIndex == 2) {
        if (_controller.otpController.text.length < 4) {
          CustomToast.show(context, 'Enter a valid OTP', type: ToastType.error);
          return;
        } else {
          ref.read(isLoadingProvider.notifier).state = true;
          final authService = ref.read(authServiceProvider);

          final result = await authService.validateOtpUrl(
            _controller.emailController.text,
            _controller.otpController.text,
          );
          if (!context.mounted) return; // ✅ Prevents using context if unmounted
          ref.read(isLoadingProvider.notifier).state = false;
          if (mounted) {
            if (result == 'OTP successful') {
              context.pushReplacement(Routes.BOTTOMNAV);
            } else {
              CustomToast.show(context, result, type: ToastType.error);
            }
          }
        }
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      CustomToast.show(
        context,
        'Please fill all fields before proceeding',
        type: ToastType.error,
      );
    }
  }

  void _submitForm() async {
    // Retrieve all values
    ref.read(isLoadingProvider.notifier).state = true;
    final authService = ref.read(authServiceProvider);
    final dobYear = int.parse(_controller.dobYearController.text);
    final dobMonth =
        AppHelper.monthToNumber(_controller.dobMonthController.text);
    final dobDay = int.parse(_controller.dobDayController.text);
    final dob =
        "${dobYear.toString().padLeft(4, '0')}-${dobMonth.toString().padLeft(2, '0')}-${dobDay.toString().padLeft(2, '0')}";

    final registerResult = await authService.register(
      firstName: _controller.firstNameController.text,
      lastName: _controller.lastNameController.text,
      dateOfBirth: dob,
      email: _controller.emailController.text,
      referralCode: _controller.referralCodeController.text.isNotEmpty
          ? int.parse(_controller.referralCodeController.text)
          : null,
      nationality: '',
      phone: _controller.completePhoneNumber,
      // homeAddress: _controller.addressController.text,
      // lga: _controller.lgaController.text,
      // lgaResidence: _controller.lgaController.text,
      // username: _controller.userNameController.text,
      // city: _controller.cityController.text,
      // placeOfBirth: _controller.addressController.text,
      // stateOfOrigin: _controller.stateController.text,
      // stateOfResidence: _controller.stateController.text,
    );

    if (!context.mounted) return; // ✅ Prevents using context if unmounted
    if (registerResult != null &&
        registerResult.isSuccess &&
        registerResult.statusCode == 200) {
      final result = await authService.createPasswordUrl(
        _controller.emailController.text,
        _controller.passwordController.text,
        _controller.confirmPasswordController.text,
      );

      ref.read(isLoadingProvider.notifier).state = false;
      if (mounted) {
        if (result == 'successful') {
          CustomToast.show(
            context,
            'Registered Successfully',
            type: ToastType.success,
          );
        } else {
          CustomToast.show(context, result, type: ToastType.error);
        }
      }
      final patientId = registerResult.data?.patientId;
      _controller.patientId = patientId;
      if (_controller.emailController.text.isNotEmpty) {
        _controller.emailIsEmpty = false;
      }

      // Sending Otp
      await authService.otpSendUrl(
        // email: _controller.patientId == null
        //     ? _controller.emailController.text
        //     : null,
        sendChannel: _controller.channel,
        userId: _controller.patientId?.toString(),
      );
      //
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      if (mounted) {
        CustomToast.show(
          context,
          registerResult?.errorMessage ?? "Something went wrong",
          type: ToastType.error,
        );
      }
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    final isAgreed = ref.watch(isAgreedProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (context.mediaQuery.viewInsets.bottom > 0) {
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white, // Matching the UI
        body: SafeArea(
          child: SizedBox(
            // physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  smallSpace(),
                  // Title & Page Indicator
                  Text(_controller.completePhoneNumber),
                  if (_currentIndex != 2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              const TextSpan(
                                text: "Create ",
                                style: TextStyle(
                                    color: Color(0xff3C3B3B),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24),
                              ),
                              TextSpan(
                                text:
                                    _currentIndex == 0 ? "Account" : "Password",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    color: ColorConstant.primaryColor),
                              ),
                            ],
                          ),
                        ),
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: 3,
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
                  if (_currentIndex != 2)
                    Text(
                      _currentIndex == 0
                          ? "Let's get you started immediately"
                          : "Please provide the following information to get started",
                      style: const TextStyle(
                          color: ColorConstant.secondryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  if (_currentIndex == 2)
                    InkWell(
                      onTap: () {
                        _previousPage();
                      },
                      child: Container(
                        width: 40,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFB4F0B6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  // PageView for Steps
                  Expanded(
                    // height:
                    //     MediaQuery.of(context).size.height * 0.6, // Adjust height
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
                        PasswordScreen(
                          formKey: _formKeys[1],
                          controller: _controller,
                        ),
                        RegisterOTPPage(
                          onNext: _nextPage,
                          formKey: _formKeys[2],
                          controller: _controller,
                        ),
                        // LocationInfoScreen(
                        //     controller: _controller,
                        //     onNext: _nextPage,
                        //     formKey: _formKeys[1]),
                        // UploadSelfieScreen(
                        //   onNext: _nextPage,
                        //   formKey: _formKeys[3],
                        //   controller: _controller,
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Navigation Buttons
                  // if (_currentIndex != 2)
                  isLoading
                      ? Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: ColorConstant.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _currentIndex == 1 && !isAgreed
                                          ? ColorConstant.primaryLightColor
                                              .withValues(alpha: 0.3)
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
                                    fontSize: 14,
                                  ),
                                  _currentIndex == 0
                                      ? 'Proceed'
                                      : _currentIndex == 1
                                          ? "Create Account"
                                          : _currentIndex == 2
                                              ? "Verify OTP"
                                              : "Proceed",
                                ),
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
                              if (_currentIndex != 2)
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
                                                .pushReplacement(Routes.AUTHLANDINGPAGE);
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              (context.padding.bottom + 12).height,
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
