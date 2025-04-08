import 'package:flutter/material.dart';

class AccountCreationController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController lgaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController emefirstNameController = TextEditingController();
  final TextEditingController emelastNameController = TextEditingController();
  final TextEditingController emeemailController = TextEditingController();
  final TextEditingController emephoneController = TextEditingController();
  final TextEditingController emeaddressController = TextEditingController();
  final TextEditingController emestateController = TextEditingController();
  final TextEditingController emelgaController = TextEditingController();
  final TextEditingController emecityController = TextEditingController();

  bool isChecked = false;

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    dobController.dispose();

    confirmPasswordController.dispose();
    otpController.dispose();
  }
}