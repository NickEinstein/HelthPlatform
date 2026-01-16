import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/utils/enum.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

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
  OTPChannel _channel = OTPChannel.email;

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
    }
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _formKey.currentState?.validate() ?? false;
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
            child: SingleChildScrollView(
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
                    "Select a delivery method and we will send a 4 digit code to reset your password",
                    style: TextStyle(
                        color: ColorConstant.secondryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  mediumSpace(),
                  Text(
                    'Select OTP delivery method',
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
                              _channel = OTPChannel.email;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: _channel == OTPChannel.email
                                  ? ColorConstant.primaryLightColor
                                      .withValues(alpha: .4)
                                  : Colors.white,
                              border: Border.all(
                                color: _channel == OTPChannel.email
                                    ? ColorConstant.primaryColor
                                    : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: _channel == OTPChannel.email
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                                ),
                                4.height,
                                Text(
                                  'Email',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: _channel == OTPChannel.email
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
                              _channel = OTPChannel.sms;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: _channel == OTPChannel.sms
                                  ? ColorConstant.primaryLightColor
                                      .withValues(alpha: .4)
                                  : Colors.white,
                              border: Border.all(
                                color: _channel == OTPChannel.sms
                                    ? ColorConstant.primaryColor
                                    : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  color: _channel == OTPChannel.sms
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                                ),
                                4.height,
                                Text(
                                  'SMS',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: _channel == OTPChannel.sms
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
                              _channel = OTPChannel.whatsapp;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: _channel == OTPChannel.whatsapp
                                  ? ColorConstant.primaryLightColor
                                      .withValues(alpha: .4)
                                  : Colors.white,
                              border: Border.all(
                                color: _channel == OTPChannel.whatsapp
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
                                    _channel == OTPChannel.whatsapp
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
                                    color: _channel == OTPChannel.whatsapp
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
                  // smallSpace(),
                  // CustomTextField(
                  //   label: _channel == OTPChannel.sms
                  //       ? "Phone Number"
                  //       : _channel == OTPChannel.whatsapp
                  //           ? "Whatsapp Number"
                  //           : "Email Address",
                  //   hint: _channel == OTPChannel.sms
                  //       ? "Phone Number"
                  //       : _channel == OTPChannel.whatsapp
                  //           ? "Whatsapp Number"
                  //           : "Email Address",
                  //   controller: _emailController,
                  //   onChanged: (_) => _validateForm(),
                  //   inputFormatters: [
                  //     FilteringTextInputFormatter.allow(RegExp(r'.*')),
                  //   ],
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "Email cannot be empty";
                  //     }
                  //     if (!RegExp(
                  //             r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                  //         .hasMatch(value)) {
                  //       return "Enter a valid email address";
                  //     }
                  //     return null;
                  //   },
                  // ),

                  // mediumSpace(),
                  smallSpace(),

                  // PageView for Steps
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                // _isValid
                                // ?
                                ColorConstant.primaryColor
                            // : const Color(
                            // 0xffA8D5BA)
                            , // Muted green when disabled
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
                          onPressed:
                              // _isValid ?
                              () async {
                            ref.read(isLoadingProvider.notifier).state = true;

                            final authService = ref.read(authServiceProvider);

                            final user =
                                await ref.read(authServiceProvider).getUser();
                            final result = await authService.otpSendUrl(
                              sendChannel: _channel,
                              userId: user?.userId.toString() ?? '',
                            );

                            if (!context.mounted) {
                              return;
                            } // ✅ Prevents using context if unmounted
                            ref.read(isLoadingProvider.notifier).state = false;

                            if (result == 'successful') {
                              CustomToast.show(
                                context,
                                "otp sent Successfully",
                                type: ToastType.success,
                              );
                              context.push(Routes.OTPPAGE, extra: {
                                'email': user?.email,
                                'channel': _channel
                              });
                            } else {
                              CustomToast.show(context, result,
                                  type: ToastType.error);
                            }
                          }
                          // : null
                          ,
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
      ),
    );
  }
}
