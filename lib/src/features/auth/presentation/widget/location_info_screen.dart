import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';

import '../../../../constants/dimens.dart';
import '../../../../constants/helper.dart';

class LocationInfoScreen extends StatefulWidget {
  final VoidCallback onNext;
  const LocationInfoScreen({super.key, required this.onNext});

  @override
  State<LocationInfoScreen> createState() => _LocationInfoScreenState();
}

class _LocationInfoScreenState extends State<LocationInfoScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Location",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black)),
        const SizedBox(height: 10),
        const CustomTextField(
          label: "Home Address",
          hint: "House Number, Street name",
        ),
        smallSpace(),
        const CustomDropdown(
            label: "State", options: ["Lagos", "Abuja", "Kano"]),
        smallSpace(),
        const CustomDropdown(
            label: "LGA", options: ["LGA 1", "LGA 2", "LGA 3"]),
        smallSpace(),
        const CustomDropdown(
            label: "City", options: ["City A", "City B", "City C"]),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Ensure proper alignment
          children: [
            Align(
              alignment: Alignment.topRight, // Center align checkbox
              child: Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
                activeColor: ColorConstant.primaryColor,
                visualDensity: VisualDensity.compact, // Reduce default spacing
              ),
            ),
            const SizedBox(width: 8), // Small space between checkbox and text
            Expanded(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff616060),
                  ),
                  children: [
                    TextSpan(
                      text: "I agree with the ",
                    ),
                    TextSpan(
                      text: "Terms & Conditions",
                      style: TextStyle(
                        color: Color(0xffF04D22),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy statement",
                      style: TextStyle(
                        color: Color(0xffF04D22),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
