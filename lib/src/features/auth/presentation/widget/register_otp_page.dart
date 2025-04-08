import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../../constants/helper.dart';
import '../../../../provider/all_providers.dart';
import '../../../../utils/custom_header.dart';
import '../../../../utils/custom_toast.dart';
import '../../../../utils/pin_input_field.dart';
import 'account_controller_holder.dart';

class RegisterOTPPage extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final GlobalKey<FormState> formKey;
  final AccountCreationController controller;

  const RegisterOTPPage({
    super.key,
    required this.onNext,
    required this.formKey,
    required this.controller,
  });

  @override
  ConsumerState<RegisterOTPPage> createState() => _RegisterOTPPageState();
}

class _RegisterOTPPageState extends ConsumerState<RegisterOTPPage> {
  bool isButtonEnabled = false;
  int _remainingTime = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    setState(() {
      isButtonEnabled = false; // Disable button while countdown is active
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          isButtonEnabled = true; // Enable button after countdown ends
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool _isValid = false;

  void _validateForm() {
    setState(() {
      _isValid = widget.formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Matching the UI
      body: SafeArea(
        child: Form(
          key: widget.formKey,
          onChanged: _validateForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & Page Indicator
              // CustomHeader(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              // ),
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
                          text: "OTP",
                          style: TextStyle(
                              color: Color(0xff3C3B3B),
                              fontWeight: FontWeight.w500,
                              fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              smallSpace(),
              Text(
                "A four-digit code has been sent to this email address ${maskEmail(widget.controller.emailController.text)}",
                style: const TextStyle(
                    color: ColorConstant.secondryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              mediumSpace(),
              PinInputField(
                length: 4,
                onChanged: (pin) {},
                onCompleted: (pin) {
                  widget.controller.otpController.text = pin;
                },
                validator: (value) {
                  return value.length < 4 ? "Enter a 4-digit PIN" : null;
                },
              ),

              smallSpace(),

              // Countdown Timer
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  children: [
                    const TextSpan(
                      text: "Resend code in ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: "${_remainingTime}s",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color:
                            Color(0xffE54335), // Styled like a clickable link
                      ),
                    ),
                  ],
                ),
              ),
              mediumSpace(),
              if (isButtonEnabled)
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(
                        text: "Didn’t get a code ",
                        style: TextStyle(
                          color: Color(0xff595959),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: "Click here",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: ColorConstant
                              .primaryColor, // Make it look like a link
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            ref.read(isLoadingProvider.notifier).state = true;

                            final authService = ref.read(authServiceProvider);

                            final email =
                                widget.controller.emailController.text;

                            final result = await authService.otpSendUrl(email);

                            if (!context.mounted)
                              return; // ✅ Prevents using context if unmounted
                            ref.read(isLoadingProvider.notifier).state = false;

                            if (result == 'successful') {
                              CustomToast.show(context, "otp sent Successfully",
                                  type: ToastType.success);
                            } else {
                              CustomToast.show(context, result,
                                  type: ToastType.error);
                            }

                            setState(() {
                              _remainingTime = 59;
                            });
                            _startCountdown();
                            // context.pushReplacement(Routes.SIGNIN);
                          },
                      ),
                    ],
                  ),
                ),

              mediumSpace(),
              smallSpace(),

              // Resend Button (Disabled During Countdown)
              smallSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
