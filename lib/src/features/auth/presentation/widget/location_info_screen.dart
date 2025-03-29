import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';

import '../../../../constants/dimens.dart';
import '../../../../constants/helper.dart';
import 'account_controller_holder.dart';

class LocationInfoScreen extends StatefulWidget {
  final VoidCallback onNext;
  final GlobalKey<FormState> formKey;
  final AccountCreationController controller;

  const LocationInfoScreen(
      {super.key,
      required this.onNext,
      required this.formKey,
      required this.controller});

  @override
  State<LocationInfoScreen> createState() => _LocationInfoScreenState();
}

class _LocationInfoScreenState extends State<LocationInfoScreen> {
  bool isChecked = false;
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
            const Text(
              "Location",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: "Home Address",
              hint: "House Number, Street name",
              controller: widget.controller.addressController,
              onChanged: (_) => _validateForm(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Home Address cannot be empty";
                }
                if (value.length < 5) {
                  return "Enter a valid Home Address";
                }
                return null;
              },
            ),
            smallSpace(),
            CustomDropdown(
              label: "State",
              controller: widget.controller.stateController,
              options: const ["Lagos", "Abuja", "Kano"],
              onChanged: (value) {
                print("Selected: $value");
              },
            ),
            smallSpace(),
            CustomDropdown(
                label: "LGA",
                controller: widget.controller.lgaController,
                options: const ["LGA 1", "LGA 2", "LGA 3"]),
            smallSpace(),
            CustomDropdown(
                label: "City",
                controller: widget.controller.cityController,
                options: const ["City A", "City B", "City C"]),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                  activeColor: ColorConstant.primaryColor,
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff616060)),
                      children: [
                        TextSpan(text: "I agree with the "),
                        TextSpan(
                          text: "Terms & Conditions",
                          style: TextStyle(
                              color: Color(0xffF04D22),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy statement",
                          style: TextStyle(
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
          ],
        ),
      ),
    );
  }
}
