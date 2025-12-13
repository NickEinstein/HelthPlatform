import 'package:greenzone_medical/src/utils/packages.dart';

class ProfileManagementScreenModel {
  final AsyncValue profile;
  final AsyncValue immunization;
  final AsyncValue allergies;

  ProfileManagementScreenModel({
    required this.profile,
    required this.immunization,
    required this.allergies,
  });
}
