import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';

import '../../../../constants/dimens.dart';
import '../../../../constants/helper.dart';

class PersonalInfoScreen extends StatelessWidget {
  final VoidCallback onNext;
  const PersonalInfoScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Personal Information",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black)),
        const SizedBox(height: 20),
        const CustomTextField(
          label: "Full Name",
          hint: "First name, Last name",
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
          flagsButtonPadding: const EdgeInsets.all(8),
          dropdownIconPosition: IconPosition.trailing,
          decoration: InputDecoration(
            filled: true, // Keeps background color
            fillColor: ColorConstant.primaryLightColor
                .withOpacity(0.3), // Background color remains
            counterText: "",
            hintText: 'Phone number',
            hintStyle: const TextStyle(
              color: Color(0xffB3B3B3),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),

            // Ensures border remains the same in all states
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8,
              ),
            ),
            border: OutlineInputBorder(
              // Ensures default border styling
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8,
              ),
            ),
          ),
          initialCountryCode: 'NG',
          onChanged: (phone) {
            print(phone.completeNumber);
          },
        ),
        smallSpace(),
        const CustomTextField(
          label: "Email Address",
          hint: "example@example.com",
        ),
        smallSpace(),
        // const CustomTextField(
        //   label: "Date of Birth",
        //   hint: "Enter your full name",
        // ),

        const DateOfBirthField(label: "Date of Birth"),
      ],
    );
  }
}
