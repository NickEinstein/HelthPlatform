import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/utils/enum.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

import '../../../../constants/helper.dart';
import '../../../../provider/all_providers.dart';
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

  bool isValid = false;

  void _validateForm() {
    setState(() {
      isValid = widget.formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Matching the UI
      body: SafeArea(
        child: SingleChildScrollView(
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
                  "We've sent a 4-digit verification code via ${widget.controller.channel.name.capitalizeFirst} to ${(widget.controller.channel == OTPChannel.email ? maskEmail(widget.controller.emailController.text) : widget.controller.phoneController.text)}",
                  style: const TextStyle(
                      color: ColorConstant.secondryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                smallSpace(),
                Text(
                  'Change OTP delivery method',
                  style: context.textTheme.bodyMedium,
                ),
                12.height,

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // if (widget.controller.emailController.text.isEmpty) {
                          //   return;
                          // }
                          setState(() {
                            widget.controller
                                .changeOTPChannel(OTPChannel.email);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: widget.controller.channel == OTPChannel.email
                                ? ColorConstant.primaryLightColor
                                    .withValues(alpha: .4)
                                : Colors.white,
                            border: Border.all(
                              color:
                                  widget.controller.channel == OTPChannel.email
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.email,
                                color: widget.controller.channel ==
                                        OTPChannel.email
                                    ? ColorConstant.primaryColor
                                    : Colors.grey,
                              ),
                              4.height,
                              Text(
                                'Email',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: widget.controller.channel ==
                                          OTPChannel.email
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    8.width,
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.controller.changeOTPChannel(OTPChannel.sms);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: widget.controller.channel == OTPChannel.sms
                                ? ColorConstant.primaryLightColor
                                    .withValues(alpha: .4)
                                : Colors.white,
                            border: Border.all(
                              color: widget.controller.channel == OTPChannel.sms
                                  ? ColorConstant.primaryColor
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.phone_android,
                                color:
                                    widget.controller.channel == OTPChannel.sms
                                        ? ColorConstant.primaryColor
                                        : Colors.grey,
                              ),
                              4.height,
                              Text(
                                'SMS',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: widget.controller.channel ==
                                          OTPChannel.sms
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    8.width,
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.controller
                                .changeOTPChannel(OTPChannel.whatsapp);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color:
                                widget.controller.channel == OTPChannel.whatsapp
                                    ? ColorConstant.primaryLightColor
                                        .withValues(alpha: .4)
                                    : Colors.white,
                            border: Border.all(
                              color: widget.controller.channel ==
                                      OTPChannel.whatsapp
                                  ? ColorConstant.primaryColor
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'whatsapp'.toSvg,
                                colorFilter: ColorFilter.mode(
                                  widget.controller.channel ==
                                          OTPChannel.whatsapp
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                                  BlendMode.srcIn,
                                ),
                                height: 24,
                                width: 24,
                              ),
                              4.height,
                              Text(
                                'Whatsapp',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: widget.controller.channel ==
                                          OTPChannel.whatsapp
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                if (widget.controller.emailIsEmpty &&
                    widget.controller.channel == OTPChannel.email) ...[
                  smallSpace(),
                  CustomTextField(
                    label: 'Email',
                    controller: widget.controller.emailController,
                    autoValidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                          .hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                ],
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
                if (_remainingTime > 0)
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
                            color: Color(
                                0xffE54335), // Styled like a clickable link
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
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: _remainingTime > 0
                                ? Colors.grey
                                : ColorConstant.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              if (_remainingTime > 0) return;
                              ref.read(isLoadingProvider.notifier).state = true;

                              final authService = ref.read(authServiceProvider);

                              final email =
                                  widget.controller.emailController.text;

                              final result = await authService.otpSendUrl(
                                email: widget.controller.patientId == null ||
                                        (widget.controller.channel ==
                                                OTPChannel.email &&
                                            widget.controller.emailIsEmpty)
                                    ? email
                                    : null,
                                sendChannel: widget.controller.channel.name,
                                userId: widget.controller.patientId?.toString(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
