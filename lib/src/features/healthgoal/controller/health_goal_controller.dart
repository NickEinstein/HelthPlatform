import 'package:flutter/material.dart';

class HealthGoalController extends ChangeNotifier {
  final TextEditingController otherController = TextEditingController();
  Map<int, String> selectedAllergies = {}; // Stores {id: allergyName}
  Map<int, String> selectedIntellories = {}; // Stores {id: allergyName}

  String _foodAllegy = "";
  String get foodAllegy => _foodAllegy;

  set foodAllegy(String value) {
    _foodAllegy = value;
    notifyListeners();
  }

  String _interllories = "";
  String get interllories => _interllories;

  set interllories(String value) {
    _interllories = value;
    notifyListeners();
  }

  void addAllergy(int id, String name) {
    selectedAllergies[id] = name;
    notifyListeners();
  }

  void removeAllergy(int id) {
    selectedAllergies.remove(id);
    notifyListeners();
  }

  void addIntellory(int id, String name) {
    selectedIntellories[id] = name;
    notifyListeners();
  }

  void removeIntellory(int id) {
    selectedIntellories.remove(id);
    notifyListeners();
  }

  @override
  void dispose() {
    // Only dispose when controller is not in use
    selectedAllergies.clear();
    selectedIntellories.clear();
    otherController.dispose();
    super.dispose();
  }

  // Reset selections without disposing of controllers
  void resetSelections() {
    selectedAllergies.clear();
    selectedIntellories.clear();
    foodAllegy = '';
    interllories = '';
    notifyListeners(); // Notify listeners to update UI
  }
}
