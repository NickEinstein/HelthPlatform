import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';

import '../../../../constants/dimens.dart';
import '../../../../constants/helper.dart';
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
  bool _isValid = false;

  void _validateForm() {
    setState(() {
      _isValid = widget.formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        onChanged: _validateForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Personal Information",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black)),
            const SizedBox(height: 20),
            CustomTextField(
              label: "Username",
              hint: "Username",
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              controller: widget.controller.userNameController,
              onChanged: (_) => _validateForm(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username empty";
                }
                if (value.length < 4) {
                  return "Enter a valid Username";
                }
                return null;
              },
            ),

            smallSpace(),
            CustomTextField(
              label: "Full Name",
              hint: "First name, Last name",
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              controller: widget.controller.firstNameController,
              onChanged: (_) => _validateForm(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Full Name cannot be empty";
                }
                if (value.length < 5) {
                  return "Enter a valid full name";
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
                fillColor: ColorConstant.primaryLightColor.withOpacity(0.3),
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
                print(phone.completeNumber);
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
              onChanged: (_) => _validateForm(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'.*')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email cannot be empty";
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

            DateOfBirthField(
                label: "Date of Birth",
                controller: widget.controller.dobController),
          ],
        ),
      ),
    );
  }
}
