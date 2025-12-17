import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/routes/routes.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/custom_header.dart';
import '../../../utils/custom_toast.dart';
import '../../../utils/pin_input_field.dart';

import 'dart:async';

class OTPPage extends ConsumerStatefulWidget {
  final String email; // Make email immutable

  OTPPage({super.key, required this.email});

  @override
  ConsumerState<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends ConsumerState<OTPPage> {
  bool isButtonEnabled = false;
  int _remainingTime = 59;
  Timer? _timer;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel(); // Prevent multiple timers running
    setState(() {
      _remainingTime = 59; // Reset countdown
      isButtonEnabled = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          isButtonEnabled = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose(); // Clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(
                  onPressed: () => Navigator.pop(context),
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
                            text: "OTP",
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
                  "A four-digit code has been sent to your email",
                  style: TextStyle(
                      color: ColorConstant.secondryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                mediumSpace(),
                PinInputField(
                  length: 4,
                  onChanged: (pin) {
                    otpController.text = pin;
                  },
                  validator: (value) {
                    if ( value.isEmpty) {
                      return "Enter a 4-digit PIN";
                    } else if (value.length < 4) {
                      return "OTP must be exactly 4 digits";
                    }
                    return null;
                  },
                ),
                smallSpace(),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    children: [
                      const TextSpan(
                        text: "Resend code in ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "${_remainingTime}s",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xffE54335),
                        ),
                      ),
                    ],
                  ),
                ),
                mediumSpace(),
                if (isButtonEnabled)
                  GestureDetector(
                    onTap: () async {
                      ref.read(isLoadingProvider.notifier).state = true;

                      final authService = ref.read(authServiceProvider);
                      final result = await authService.otpSendUrl(widget.email);

                      if (!context.mounted) return;
                      ref.read(isLoadingProvider.notifier).state = false;

                      if (result == 'successful') {
                        CustomToast.show(context, "OTP sent successfully",
                            type: ToastType.success);
                        _startCountdown();
                      } else {
                        CustomToast.show(context, result,
                            type: ToastType.error);
                      }
                    },
                    child: Text(
                      "Click here",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ),
                mediumSpace(),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          // context.push(
                          //   Routes.NEWPASSWORD,
                          //   extra: {
                          //     'email': widget.email,
                          //     'otp': otpController.text
                          //   },
                          // );
                          if (otpController.text.length == 4) {
                            ref.read(isLoadingProvider.notifier).state = true;
                            final authService = ref.read(authServiceProvider);

                            final result = await authService.validateOtpUrl(
                                widget.email, otpController.text);

                            if (!context.mounted) return;
                            ref.read(isLoadingProvider.notifier).state = false;

                            if (result == 'OTP successful') {
                              context.push(
                                Routes.NEWPASSWORD,
                                extra: {
                                  'email': widget.email,
                                  'otp': otpController.text
                                },
                              );
                            } else {
                              CustomToast.show(context, result,
                                  type: ToastType.error);
                            }
                          } else {
                            CustomToast.show(context, 'Enter a valid OTP',
                                type: ToastType.error);
                          }
                        },
                        child: const Text(
                          "Verify OTP", // Fix button text
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                smallSpace(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
