import 'package:flutter/material.dart';

class HealthGoalController {
  final TextEditingController otherController = TextEditingController();
  Map<int, String> selectedAllergies = {}; // Stores {id: allergyName}
  Map<int, String> selectedIntellories = {}; // Stores {id: allergyName}

  String foodAllegy = "";
  String interllories = "";

  void dispose() {
    selectedAllergies.clear();
    selectedIntellories.clear();
    otherController.dispose();
  }
}
