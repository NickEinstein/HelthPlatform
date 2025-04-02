import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/provider/all_providers.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/dimens.dart';
import '../../../../constants/helper.dart';
import '../../../../model/all_alergy_response.dart';
import '../../controller/health_goal_controller.dart';

class TolerancePage extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final GlobalKey<FormState> formKey;
  final HealthGoalController controller;
  const TolerancePage({
    super.key,
    required this.onNext,
    required this.formKey,
    required this.controller,
  });

  @override
  ConsumerState<TolerancePage> createState() => _TolerancePageState();
}

class _TolerancePageState extends ConsumerState<TolerancePage> {
  bool isChecked = false;
  List<String> selectedOptions = [];
  bool showOtherTextField = false;

  bool _isValid = false;

  void _validateForm() {
    setState(() {
      _isValid = widget.formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final allergyList = ref.watch(allAllegyListProvider);
    final intolleanceList = ref.watch(allIntolleranceListProvider);

    return Form(
      key: widget.formKey,
      onChanged: _validateForm,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        smallSpace(),
        CustomDropdown(
          label: "Any Histmine Tolerance",
          options: const ["Yes", "No"],
          onChanged: (value) {
            widget.controller.interllories = value!;
          },
        ),
        mediumSpace(),
        const Text(
          "If yes, Select option",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff3C3B3B),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _showDropdownMenu(context, intolleanceList),
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
                    widget.controller.selectedIntellories.isEmpty
                        ? "Select option"
                        : widget.controller.selectedIntellories.values
                            .join(", "),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff3C3B3B),
                    ),
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
      ]),
    );
  }

  void _showDropdownMenu(BuildContext context,
      AsyncValue<List<AllAlergyResponse>> interlloriesList) async {
    if (interlloriesList is AsyncLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Loading intollerance...")),
      );
      return;
    }

    if (interlloriesList is AsyncError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load intollerance")),
      );
      return;
    }

    List<AllAlergyResponse> options = interlloriesList.value ?? [];

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...options.map((option) {
                          bool isSelected = widget
                              .controller.selectedIntellories
                              .containsKey(option.id);

                          return CheckboxListTile(
                            title: Text(option.allergyOrIntolleranceSource!),
                            value: isSelected,
                            activeColor: Colors.green,
                            tileColor: isSelected
                                ? Colors.green.withOpacity(0.2)
                                : Colors.transparent,
                            onChanged: (bool? value) {
                              setDialogState(() {
                                if (value == true) {
                                  widget.controller
                                          .selectedIntellories[option.id!] =
                                      option.allergyOrIntolleranceSource!;
                                } else {
                                  widget.controller.selectedIntellories
                                      .remove(option.id);
                                }
                              });
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                    },
                    child: const Text("Done"),
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      setState(() {});
    });
  }
}
