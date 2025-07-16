import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

class HealthGoalBottomSheet extends StatefulWidget {
  @override
  _HealthGoalBottomSheetState createState() => _HealthGoalBottomSheetState();
}

class _HealthGoalBottomSheetState extends State<HealthGoalBottomSheet> {
  String? selectedGoal = 'Low Sodium to improve heart conditions';
  String? selectedMedicalConcern;
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icon/hego.png', height: 53, width: 53),
            mediumSpace(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "What’s your health goal?",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff181819)),
              ),
            ),
            smallSpace(),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              value: selectedGoal,
              items: const [
                DropdownMenuItem(
                    value: 'Low Sodium to improve heart conditions',
                    child: Text(
                      'Low Sodium to improve heart conditions',
                      style: TextStyle(
                          color: Color(0xff424045),
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    )),
                DropdownMenuItem(
                    value: 'Weight Loss',
                    child: Text('Weight Loss',
                        style: TextStyle(
                            color: Color(0xff424045),
                            fontSize: 14,
                            fontWeight: FontWeight.w300))),
                DropdownMenuItem(
                    value: 'Improve Fitness',
                    child: Text(
                      'Improve Fitness',
                      style: TextStyle(
                          color: Color(0xff424045),
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    )),
              ],
              onChanged: (value) {
                setState(() {
                  selectedGoal = value;
                });
              },
            ),
            const SizedBox(height: 10),
            mediumSpace(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tell us more about your health goal.",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff424045),
                    fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Color(0xffEAFFEB),
                      border: Border.all(color: ColorConstant.primaryColor),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                      ),
                    ),
                    height: 48,
                    child: const Text('Age:'),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Color(0xffEAFFEB),
                      border: Border.all(color: ColorConstant.primaryColor),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                      ),
                    ),
                    height: 48,
                    child: const Text('Weight:'),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: TextField(
                    controller: weightController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              hint: const Text('Any known medical concerns',
                  style: TextStyle(
                      color: Color(0xff424045),
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
              value: selectedMedicalConcern,
              items: const [
                DropdownMenuItem(
                    value: 'Diabetes',
                    child: Text('Diabetes',
                        style: TextStyle(
                            color: Color(0xff424045),
                            fontSize: 14,
                            fontWeight: FontWeight.w300))),
                DropdownMenuItem(
                    value: 'Hypertension',
                    child: Text('Hypertension',
                        style: TextStyle(
                            color: Color(0xff424045),
                            fontSize: 14,
                            fontWeight: FontWeight.w300))),
              ],
              onChanged: (value) {
                setState(() {
                  selectedMedicalConcern = value;
                });
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  // Handle the update logic here
                  Navigator.pop(context);
                  print("Updated health goal: $selectedGoal");
                  print("Age: ${ageController.text}");
                  print("Weight: ${weightController.text}");
                  print("Medical Concern: $selectedMedicalConcern");
                },
                child: const Text(
                  'Update Records',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
