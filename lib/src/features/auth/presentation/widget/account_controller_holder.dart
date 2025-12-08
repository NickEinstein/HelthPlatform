import 'dart:io';

import 'package:flutter/material.dart';

class AccountCreationController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobDayController = TextEditingController();
  final TextEditingController dobMonthController = TextEditingController();
  final TextEditingController dobYearController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

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
  final TextEditingController referralCodeController = TextEditingController();
  bool rememberMe = false;

  toggleRememberMe() {
    rememberMe = !rememberMe;
  }

  File? imageFile;
  int? patientId;
  String? pictureUrl;

  bool isChecked = false;

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    genderController.dispose();
    phoneController.dispose();
    referralCodeController.dispose();
    addressController.dispose();
    passwordController.dispose();
    dobDayController.dispose();
    dobMonthController.dispose();
    dobYearController.dispose();

    confirmPasswordController.dispose();
    otpController.dispose();

    imageFile = null;
    patientId = null;
    pictureUrl = null;
  }
}
