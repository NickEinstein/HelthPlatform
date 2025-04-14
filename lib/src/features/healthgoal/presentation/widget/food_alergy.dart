import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/features/healthgoal/controller/health_goal_controller.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/dimens.dart';
import '../../../../constants/helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/all_alergy_response.dart';
import '../../../../provider/all_providers.dart';

class FoodAlergy extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final GlobalKey<FormState> formKey;
  final HealthGoalController controller;
  const FoodAlergy({
    super.key,
    required this.onNext,
    required this.formKey,
    required this.controller,
  });

  @override
  ConsumerState<FoodAlergy> createState() => _FoodAlergyState();
}

class _FoodAlergyState extends ConsumerState<FoodAlergy> {
  bool _isValid = false;

  void _validateForm() {
    setState(() {
      _isValid = widget.formKey.currentState?.validate() ?? false;
    });
  }

  String displaySelectedAllergies() {
    final items = widget.controller.selectedAllergies.entries
        .map((entry) {
          if (entry.key == 0) {
            return "Others";
          }
          return entry.value;
        })
        .where((v) => v.trim().isNotEmpty)
        .toList();

    return items.isEmpty ? "Select an option" : items.join(", ");
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.controller.otherController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allergyList = ref.watch(allAllegyListProvider);

    return Form(
      key: widget.formKey,
      onChanged: _validateForm,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        smallSpace(),
        NoSearchDropdown(
          label: "Any Food Allergy",
          options: const ["Yes", "No"],
          onChanged: (value) {
            widget.controller.foodAllegy = value!;
            widget.controller.selectedIntellories.clear();
            widget.controller.otherController.clear();
          },
        ),
        mediumSpace(),
        if (widget.controller.foodAllegy == "Yes")
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                onTap: () => _showDropdownMenu(context, allergyList),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffB3B3B3)),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          displaySelectedAllergies(),

                          // widget.controller.selectedAllergies.isEmpty
                          //     ? "Select an option"
                          //     : widget.controller.selectedAllergies.values.join(", "),
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
              if (widget.controller.selectedAllergies.containsKey(0)) ...[
                const SizedBox(height: 10),
                const Text("Others"),
                TextField(
                  controller: widget.controller.otherController,
                  decoration: InputDecoration(
                    hintText: "Type in your answer",
                    hintStyle: const TextStyle(
                      color: Color(0xffB3B3B3),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(
                        color: Color(0xffB3B3B3),
                        width: 0.8,
                      ),
                    ),
                  ),
                  onChanged: (text) {
                    setState(() {
                      widget.controller
                          .updateAllergies(); // Custom method to notify listeners

                      widget.controller.selectedAllergies[0] =
                          text; // Update Others allergy source
                    });
                  },
                ),
              ],
            ],
          ),
      ]),
    );
  }

  void _showDropdownMenu(BuildContext context,
      AsyncValue<List<AllAlergyResponse>> allergyList) async {
    if (allergyList is AsyncLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Loading allergies...")),
      );
      return;
    }

    if (allergyList is AsyncError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load allergies")),
      );
      return;
    }

    List<AllAlergyResponse> options = allergyList.value ?? [];

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
                          bool isSelected = widget.controller.selectedAllergies
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
                                          .selectedAllergies[option.id!] =
                                      option.allergyOrIntolleranceSource!;
                                } else {
                                  widget.controller.selectedAllergies
                                      .remove(option.id);
                                }
                              });
                            },
                          );
                        }),
                        CheckboxListTile(
                          title: const Text("Others"),
                          value: widget.controller.selectedAllergies
                              .containsKey(0),
                          activeColor: Colors.green,
                          tileColor:
                              widget.controller.selectedAllergies.containsKey(0)
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.transparent,
                          onChanged: (bool? value) {
                            setDialogState(() {
                              if (value == true) {
                                widget.controller.selectedAllergies[0] = "";
                              } else {
                                widget.controller.selectedAllergies.remove(0);
                                widget.controller.otherController.clear();
                              }
                            });
                          },
                        ),
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
                      // Instead of calling notifyListeners here, call the method in the controller
                      widget.controller
                          .updateAllergies(); // Custom method to notify listeners

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
      // Trigger any further state updates here if necessary
      setState(() {});
    });
  }
}
