import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/features/profile/model/allergy_list_model.dart';
import 'package:greenzone_medical/src/features/profile/model/emergency_contact_info.dart';
import 'package:greenzone_medical/src/features/profile/model/immunization_result.dart';
import 'package:greenzone_medical/src/features/profile/model/patient_contact_model.dart';
import 'package:greenzone_medical/src/features/profile/model/patient_profile_result.dart';
import 'package:greenzone_medical/src/features/profile/model/update_patient_payload.dart';
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

final allergyProvider =
    FutureProvider.autoDispose<List<UserAllergyModel>?>((ref) async {
  final patientProfileService = ref.watch(profileServiceProvider);
  return patientProfileService.getAllergyResult();
});

class ProfileState {
  final PatientProfileResult? patientProfile;
  final PatientContactModel? patientContact;
  final List<ImmunizationResult>? immunizations;
  final List<UserAllergyModel>? userAllergies;
  final EmergencyContactInfo? emergencyContactInfo;
  final List<AllergyListModel>? allAllergies;
  final bool isLoading;

  ProfileState({
    this.emergencyContactInfo,
    this.patientContact,
    this.patientProfile,
    this.immunizations,
    this.userAllergies,
    this.allAllergies,
    this.isLoading = false,
  });

  ProfileState copyWith({
    PatientProfileResult? patientProfile,
    PatientContactModel? patientContact,
    List<ImmunizationResult>? immunizations,
    List<UserAllergyModel>? allergies,
    EmergencyContactInfo? emergencyContactInfo,
    List<AllergyListModel>? allAllergies,
    bool? isLoading,
  }) {
    return ProfileState(
      allAllergies: allAllergies ?? this.allAllergies,
      patientProfile: patientProfile ?? this.patientProfile,
      patientContact: patientContact ?? this.patientContact,
      immunizations: immunizations ?? this.immunizations,
      userAllergies: allergies ?? this.userAllergies,
      isLoading: isLoading ?? this.isLoading,
      emergencyContactInfo: emergencyContactInfo ?? this.emergencyContactInfo,
    );
  }
}

final profileProvider =
    NotifierProvider<ProfileProvider, ProfileState>(ProfileProvider.new);

class ProfileProvider extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    return ProfileState();
  }

  Future<(bool, String?)> addAllergy(Map<String, dynamic> payload) async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);
      final result = await service.addAllergy(payload);
      state = state.copyWith(isLoading: false);
      await getAllergyResult();
      return (true, result);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return (false, e.toString());
    }
  }

  Future<(bool, String?)> addImmunization(ImmunizationResult payload) async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);
      final result = await service.addImmunization(payload);
      state = state.copyWith(isLoading: false);
      await fetchImmunizationResult();
      return (true, result);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return (false, e.toString());
    }
  }

  Future<void> fetchEmergencyContactInfo() async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);
      final result = await service.getEmergencyContactInfo();
      state = state.copyWith(emergencyContactInfo: result, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchPatientProfile() async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);
      final result = await service.getPatientProfile();
      state = state.copyWith(patientProfile: result, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // Handle error appropriately, potentially adding an error field to state
    }
  }

  Future<void> fetchImmunizationResult() async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);
      final result = await service.getImmunizationResult();
      state = state.copyWith(immunizations: result, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> getAllergyResult() async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);
      final result = await service.getAllergyResult();
      state = state.copyWith(allergies: result, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<(bool, String?)> updateEmergencyContact(
    EmergencyContactInfo payload,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);
      final result = await service.updateEmergencyContactInfo(payload);
      await fetchAll();
      return (true, result);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return (false, e.toString());
    }
  }

  Future<(bool, String?)> updateProfile(UpdatePatientPayload payload) async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);
      final result = await service.updatePatientProfile(payload);
      await fetchAll(); // Refresh data
      return (true, result);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return (false, e.toString());
    }
  }

  Future<(bool, String?)> updateContact(PatientContactModel payload) async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);
      final result = await service.updateContact(payload);
      await fetchAll(); // Refresh data
      return (true, result);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return (false, e.toString());
    }
  }

  Future<void> fetchAllAllergies() async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);
      final result = await service.getAllAllergyList();
      state = state.copyWith(allAllergies: result, isLoading: false);
    } catch (e,s) {
      print(e);
      print(s);
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchAll() async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);

      // Fetch concurrently for better performance
      final results = await Future.wait([
        service.getPatientProfile(),
        service.getImmunizationResult(),
        service.getAllergyResult(),
        service.getPatientContact(),
        service.getEmergencyContactInfo(),
      ]);

      state = state.copyWith(
        patientProfile: results[0] as PatientProfileResult?,
        immunizations: results[1] as List<ImmunizationResult>?,
        allergies: results[2] as List<UserAllergyModel>?,
        patientContact: results[3] as PatientContactModel?,
        emergencyContactInfo: results[4] as EmergencyContactInfo?,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}
