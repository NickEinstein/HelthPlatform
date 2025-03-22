import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/dimens.dart';
import '../../../../constants/helper.dart';

class TolerancePage extends StatefulWidget {
  final VoidCallback onNext;
  const TolerancePage({super.key, required this.onNext});

  @override
  State<TolerancePage> createState() => _TolerancePageState();
}

class _TolerancePageState extends State<TolerancePage> {
  bool isChecked = false;
  List<String> options = ["Fish", "Peanut", "Soy", "Others"];
  List<String> selectedOptions = [];
  bool showOtherTextField = false;
  bool _hasText = false;

  TextEditingController otherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    otherController.addListener(() {
      setState(() {
        _hasText = otherController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    otherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      smallSpace(),
      const CustomDropdown(label: "Any Food Alergy", options: ["Yes", "No"]),
      mediumSpace(),
    ]);
  }
}
