import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/features/profile/model/allergy_result.dart';
import 'package:greenzone_medical/src/features/profile/model/immunization_result.dart';
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
    FutureProvider.autoDispose<List<AllergyResult>?>((ref) async {
  final patientProfileService = ref.watch(profileServiceProvider);
  return patientProfileService.getAllergyResult();
});

class ProfileState {
  final PatientProfileResult? patientProfile;
  final List<ImmunizationResult>? immunizations;
  final List<AllergyResult>? allergies;
  final bool isLoading;

  ProfileState({
    this.patientProfile,
    this.immunizations,
    this.allergies,
    this.isLoading = false,
  });

  ProfileState copyWith({
    PatientProfileResult? patientProfile,
    List<ImmunizationResult>? immunizations,
    List<AllergyResult>? allergies,
    bool? isLoading,
  }) {
    return ProfileState(
      patientProfile: patientProfile ?? this.patientProfile,
      immunizations: immunizations ?? this.immunizations,
      allergies: allergies ?? this.allergies,
      isLoading: isLoading ?? this.isLoading,
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

  Future<void> fetchAll() async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);

      // Fetch concurrently for better performance
      final results = await Future.wait([
        service.getPatientProfile(),
        service.getImmunizationResult(),
        service.getAllergyResult(),
      ]);

      state = state.copyWith(
        patientProfile: results[0] as PatientProfileResult?,
        immunizations: results[1] as List<ImmunizationResult>?,
        allergies: results[2] as List<AllergyResult>?,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> updateProfile(UpdatePatientPayload payload) async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(profileServiceProvider);
      await service.updatePatientProfile(payload);
      await fetchAll(); // Refresh data
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }
}
