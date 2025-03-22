import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/routes/routes.dart';

import '../../../constants/helper.dart';
import '../../../utils/custom_header.dart';
import '../../../utils/pin_input_field.dart';

import 'dart:async';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Matching the UI
      body: SafeArea(
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
              const Text(
                "A four-digit code has been sent to this email address examp****@gmail.com",
                style: TextStyle(
                    color: ColorConstant.secondryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              mediumSpace(),
              PinInputField(
                length: 4,
                onChanged: (value) {
                  print("Entered PIN: $value");
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
                          ..onTap = () {
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButtonEnabled
                      ? ColorConstant.primaryColor
                      : ColorConstant.primaryLightColor
                          .withOpacity(0.2), // Disable color
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  context.push(Routes.NEWPASSWORD);
                },
                child: Text(
                  "Resend Code",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: isButtonEnabled ? Colors.white : Colors.grey[300],
                  ),
                ),
              ),
              smallSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
