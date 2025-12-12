import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/features/profile/model/immunization_result.dart';
import 'package:greenzone_medical/src/features/profile/model/patient_profile_result.dart';
import 'package:greenzone_medical/src/provider/all_providers.dart';
import 'package:greenzone_medical/src/services/profile_service.dart';

final profileServiceProvider = Provider<ProfileService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final apiService = ref.watch(apiServiceProvider);

  return ProfileService(apiService, storageService);
});

final patientProfileProvider =
    FutureProvider.autoDispose<PatientProfileResult?>((ref) async {
  final patientProfileService = ref.watch(profileServiceProvider);
  return patientProfileService.getPatientProfile();
});

final immunizationProvider =
    FutureProvider.autoDispose<List<ImmunizationResult>?>((ref) async {
  final patientProfileService = ref.watch(profileServiceProvider);
  return patientProfileService.getImmunizationResult();
});


