import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:greenzone_medical/src/provider/all_providers.dart';
import 'package:greenzone_medical/src/utils/enum.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'account_controller_holder.dart';

class PersonalInfoScreen extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final GlobalKey<FormState> formKey;
  final AccountCreationController controller;

  const PersonalInfoScreen({
    super.key,
    required this.onNext,
    required this.formKey,
    required this.controller,
  });

  @override
  ConsumerState<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends ConsumerState<PersonalInfoScreen> {
  // bool _isValid = false;

  // void _validateForm() {
  //   setState(() {
  //     _isValid = widget.formKey.currentState?.validate() ?? false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        // onChanged: _validateForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text("Personal Information",
            //     style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w400,
            //         color: Colors.black)),
            // const SizedBox(height: 20),
            // CustomTextField(
            //   label: "Username",
            //   hint: "Username",
            //   inputFormatters: [
            //     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
            //   ],
            //   controller: widget.controller.userNameController,
            //   onChanged: (_) => _validateForm(),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return "Username empty";
            //     }
            //     if (value.length < 4) {
            //       return "Enter a valid Username";
            //     }
            //     return null;
            //   },
            // ),

            // smallSpace(),
            CustomTextField(
              label: "First Name",
              hint: "First name",
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              controller: widget.controller.firstNameController,
              // onChanged: (_) => _validateForm(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "First Name cannot be empty";
                }
                if (value.length < 5) {
                  return "Enter a valid First Name";
                }
                return null;
              },
            ),

            smallSpace(),
            CustomTextField(
              label: "Last Name",
              hint: "Last name",
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              controller: widget.controller.lastNameController,
              // onChanged: (_) => _validateForm(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Last Name cannot be empty";
                }
                if (value.length < 5) {
                  return "Enter a valid Last Name";
                }
                return null;
              },
            ),

            smallSpace(),

            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Phone Number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff3C3B3B), // Adjust label color
                ),
              ),
            ),

            IntlPhoneField(
              controller: widget.controller.phoneController,
              flagsButtonPadding: const EdgeInsets.all(8),
              dropdownIconPosition: IconPosition.trailing,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    ColorConstant.primaryLightColor.withValues(alpha: 0.3),
                counterText: "",
                hintText: 'Phone number',
                hintStyle: const TextStyle(
                  color: Color(0xffB3B3B3),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide:
                      const BorderSide(color: Color(0xffB3B3B3), width: 0.8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide:
                      const BorderSide(color: Color(0xffB3B3B3), width: 0.8),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide:
                      const BorderSide(color: Color(0xffB3B3B3), width: 0.8),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide:
                      const BorderSide(color: Color(0xffB3B3B3), width: 0.8),
                ),
              ),
              initialCountryCode: 'NG',
              validator: (phone) {
                if (phone == null || phone.number.isEmpty) {
                  return 'Phone number is required';
                } else if (phone.number.length != 10) {
                  return 'Enter a valid 10-digit phone number';
                } else if (phone.number.startsWith('0')) {
                  return 'Phone number cannot start with 0';
                }
                return null;
              },
              onChanged: (phone) {
                widget.controller.completePhoneNumber = phone.completeNumber;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // ✅ Allow only numbers
                LengthLimitingTextInputFormatter(10), // ✅ Limit to 10 digits
                FilteringTextInputFormatter.allow(
                    RegExp(r'^[1-9]\d*$')), // ✅ No leading "0"
              ],
            ),
            smallSpace(),
            CustomTextField(
              label: "Email Address",
              hint: "example@example.com",
              controller: widget.controller.emailController,
              // onChanged: (_) => _validateForm(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'.*')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                    .hasMatch(value)) {
                  return "Enter a valid email address";
                }
                return null;
              },
            ),
            smallSpace(),
            // const CustomTextField(
            //   label: "Date of Birth",
            //   hint: "Enter your full name",
            // ),
            CustomTextField(
              isDropdown: true,
              onTap: () async {
                final gender = await showDialog<String>(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text('Select Gender'),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'Male');
                        },
                        child: const Text('Male'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'Female');
                        },
                        child: const Text('Female'),
                      ),
                    ],
                  ),
                );
                if (gender != null) {
                  widget.controller.genderController.text = gender;
                  // _validateForm();
                }
              },
              readOnly: true,
              label: "Gender",
              hint: "Select gender",
              controller: widget.controller.genderController,
              // onChanged: (_) => _validateForm(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Gender cannot be empty";
                }
                return null;
              },
            ),

            smallSpace(),
            const Text(
              'Date of Birth',
            ),
            4.height,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hint: "Day",
                    keyboardType: TextInputType.number,
                    controller: widget.controller.dobDayController,
                    // onChanged: (_) => _validateForm(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Day cannot be empty";
                      }
                      if (value.length > 2) {
                        return "Invalid day";
                      }
                      return null;
                    },
                  ),
                ),
                4.width,
                Expanded(
                  child: CustomTextField(
                    isDropdown: true,
                    hint: "Month",
                    readOnly: true,
                    controller: widget.controller.dobMonthController,
                    // onChanged: (_) => _validateForm(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Month cannot be empty";
                      }
                      return null;
                    },
                    onTap: () async {
                      final monthList = AppHelper.monthList;
                      final month = await showDialog<String>(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text('Select Month'),
                          children: List.generate(
                            monthList.length,
                            (index) => SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, monthList[index]);
                              },
                              child: Text(monthList[index]),
                            ),
                          ),
                        ),
                      );
                      if (month != null) {
                        widget.controller.dobMonthController.text = month;
                        // _validateForm();
                      }
                    },
                  ),
                ),
                4.width,
                Expanded(
                  child: CustomTextField(
                    hint: "Year",
                    keyboardType: TextInputType.number,
                    controller: widget.controller.dobYearController,
                    // onChanged: (_) => _validateForm(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Year cannot be empty";
                      }
                      if (value.length < 4 || value.length > 4) {
                        return 'Enter valid year';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            16.height,
            CustomTextField(
              hint: "Enter referral code",
              keyboardType: TextInputType.number,
              controller: widget.controller.referralCodeController,
              label: 'Referral Code (optional)',
            ),
            16.height,
            Text(
              'How would you like to receive your OTP?',
              style: context.textTheme.bodyMedium,
            ),
            8.height,
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (widget.controller.emailController.text.isEmpty) {
                        return;
                      }
                      setState(() {
                        widget.controller.changeOTPChannel(OTPChannel.email);
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
                          color: widget.controller.channel == OTPChannel.email
                              ? ColorConstant.primaryColor
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.email,
                            color: widget.controller.channel == OTPChannel.email
                                ? ColorConstant.primaryColor
                                : Colors.grey,
                          ),
                          4.height,
                          Text(
                            'Email',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color:
                                  widget.controller.channel == OTPChannel.email
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
                            color: widget.controller.channel == OTPChannel.sms
                                ? ColorConstant.primaryColor
                                : Colors.grey,
                          ),
                          4.height,
                          Text(
                            'SMS',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: widget.controller.channel == OTPChannel.sms
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
                        widget.controller.changeOTPChannel(OTPChannel.whatsapp);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: widget.controller.channel == OTPChannel.whatsapp
                            ? ColorConstant.primaryLightColor
                                .withValues(alpha: .4)
                            : Colors.white,
                        border: Border.all(
                          color:
                              widget.controller.channel == OTPChannel.whatsapp
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
                              widget.controller.channel == OTPChannel.whatsapp
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
            16.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: widget.controller.isChecked,
                  onChanged: (value) {
                    widget.controller.isChecked = value!;
                    ref.read(isAgreedProvider.notifier).state =
                        !ref.read(isAgreedProvider.notifier).state;
                  },
                  activeColor: ColorConstant.primaryColor,
                  visualDensity: VisualDensity.compact,
                ),
                8.width,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff616060)),
                      children: [
                        const TextSpan(text: "I agree with the "),
                        TextSpan(
                          text: "Terms & Conditions",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              // CustomToast.show(context, "Coming soon...",
                              //     type: ToastType.error);
                              //               String onTapValue = goal.onTap.toString();

                              // if (Uri.tryParse(onTapValue)?.hasAbsolutePath == true) {
                              //   if (await canLaunchUrl(Uri.parse(onTapValue))) {
                              //     await launchUrl(Uri.parse(onTapValue));
                              //   }
                              // }
                            },
                          style: const TextStyle(
                              color: Color(0xffF04D22),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy statement",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              CustomToast.show(context, "Coming soon...",
                                  type: ToastType.error);
                            },
                          style: const TextStyle(
                              color: Color(0xffF04D22),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // DateOfBirthField(
            //     label: "Date of Birth",
            //     controller: widget.controller.dobController),
          ],
        ),
      ),
    );
  }
}
