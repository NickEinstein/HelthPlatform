import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/dimens.dart';
import '../../../../constants/helper.dart';

class FoodAlergy extends StatefulWidget {
  final VoidCallback onNext;
  const FoodAlergy({super.key, required this.onNext});

  @override
  State<FoodAlergy> createState() => _FoodAlergyState();
}

class _FoodAlergyState extends State<FoodAlergy> {
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "If yes, Select options",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff3C3B3B),
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              _showMultiSelectDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffB3B3B3)),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      selectedOptions.isEmpty
                          ? "Select an option"
                          : selectedOptions.join(", "),
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xffB3B3B3)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6.0,
            children: selectedOptions.map((option) {
              return Chip(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                label: Text(option),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () {
                  setState(() {
                    selectedOptions.remove(option);
                    if (option == "Others") {
                      showOtherTextField = false;
                      otherController.clear();
                    }
                  });
                },
              );
            }).toList(),
          ),
          if (showOtherTextField) ...[
            const SizedBox(height: 10),
            const Text("Others"),
            TextField(
              controller: otherController,
              decoration: InputDecoration(
                hintText: "Type in your answer",
                hintStyle: const TextStyle(
                  color: Color(0xffB3B3B3),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(
                    color: Color(0xffB3B3B3),
                    width: 0.8, // Tiny green border
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(
                    color: Color(0xffB3B3B3),
                    width: 0.8, // Thicker when focused
                  ),
                ),
                filled: true, // Enable background color
                fillColor: _hasText
                    ? ColorConstant.primaryLightColor.withOpacity(0.3)
                    : Colors.transparent, // Background color
              ),
            ),
          ],
        ],
      )
    ]);
  }

  void _showMultiSelectDialog(BuildContext context) async {
    List<String> tempSelected = List.from(selectedOptions);
    bool tempShowOtherTextField = showOtherTextField;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: const Text("Select options"),
              content: SingleChildScrollView(
                child: Column(
                  children: options.map((option) {
                    return CheckboxListTile(
                      title: Text(option, overflow: TextOverflow.ellipsis),
                      value: tempSelected.contains(option),
                      onChanged: (bool? value) {
                        setDialogState(() {
                          if (value == true) {
                            tempSelected.add(option);
                            if (option == "Others")
                              tempShowOtherTextField = true;
                          } else {
                            tempSelected.remove(option);
                            if (option == "Others")
                              tempShowOtherTextField = false;
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    setState(() {
                      selectedOptions = List.from(tempSelected);
                      showOtherTextField = tempShowOtherTextField;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
