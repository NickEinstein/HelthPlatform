import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';

import '../../../../constants/dimens.dart';
import '../../../../constants/helper.dart';
import '../../../../model/state_model.dart';
import '../../../../utils/custom_toast.dart';
import 'account_controller_holder.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, rootBundle;

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
  // bool isChecked = false;
  bool _isValid = false;

  List<StateModel> states = [];
  List<String> stateNames = [];
  List<String> lgaNames = [];
  List<String> cityNames = [];

  String? selectedState;
  String? selectedLga;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    loadStateData();
  }

  Future<void> loadStateData() async {
    final String response =
        await rootBundle.loadString('assets/json/state_lga.json');
    final List<dynamic> jsonData = json.decode(response);
    List<StateModel> loadedStates =
        jsonData.map((data) => StateModel.fromJson(data)).toList();

    setState(() {
      states = loadedStates;
      stateNames =
          states.map((e) => e.name).toSet().toList(); // Ensure uniqueness
    });
  }

  void _onStateSelected(String? value) {
    if (value != null && stateNames.contains(value)) {
      final state = states.firstWhere((s) => s.name == value);

      setState(() {
        selectedState = value;

        // Reset LGA and City selections when State changes
        selectedLga = null;
        selectedCity = null;
        widget.controller.lgaController.text = "";

        // Update LGA and City lists
        lgaNames = state.locals.map((lga) => lga.name).toSet().toList();
      });
    } else {
      print('Error: Selected state value is not in the state names list.');
    }
  }

  void _onLgaSelected(String? value) {
    if (value != null && lgaNames.contains(value)) {
      setState(() {
        selectedLga = value;
        selectedCity = null; // Reset city when LGA changes
        widget.controller.lgaController.text = value;
      });
    }
  }

  void _validateForm() {
    setState(() {
      _isValid = widget.formKey.currentState?.validate() ?? false;
    });
  }

  bool _isFormValid() {
    return _isValid &&
        selectedState != null &&
        selectedLga != null &&
        selectedCity != null;
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'.*')),
              ],
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
              options: stateNames,
              value: selectedState, // Set selected value for State
              onChanged: _onStateSelected,
            ),
            smallSpace(),
            CustomDropdown(
              label: "LGA",
              controller: widget.controller.lgaController,
              options: lgaNames,
              value: selectedLga, // Set selected value for LGA
              onChanged: _onLgaSelected,
            ),
            smallSpace(),
            CustomTextField(
              label: "City",
              hint: "City",
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'.*')),
              ],
              controller: widget.controller.cityController,
              onChanged: (_) => _validateForm(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "City cannot be empty";
                }
                if (value.length < 2) {
                  return "Enter a valid City";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: widget.controller.isChecked,
                  onChanged: (value) {
                    setState(() {
                      widget.controller.isChecked = value!;
                    });
                  },
                  activeColor: ColorConstant.primaryColor,
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff616060)),
                      children: [
                        TextSpan(text: "I agree with the "),
                        TextSpan(
                          text: "Terms & Conditions",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              CustomToast.show(context, "Coming soon...",
                                  type: ToastType.error);
                            },
                          style: TextStyle(
                              color: Color(0xffF04D22),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy statement",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              CustomToast.show(context, "Coming soon...",
                                  type: ToastType.error);
                            },
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
            smallSpace(),
          ],
        ),
      ),
    );
  }
}