import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/features/profile/model/allergy_list_model.dart';
import 'package:greenzone_medical/src/features/profile/model/emergency_contact_info.dart';
import 'package:greenzone_medical/src/features/profile/model/immunization_result.dart';
import 'package:greenzone_medical/src/features/profile/model/patient_contact_model.dart';
import 'package:greenzone_medical/src/features/profile/model/patient_profile_result.dart';
import 'package:greenzone_medical/src/features/profile/model/update_patient_payload.dart';

class ProfileService {
  final ApiService _apiService;
  final StorageService _storageService;

  ProfileService(this._apiService, this._storageService);

  /// Retrieves the stored authentication token.
  Future<String?> getToken() async {
    return _storageService.getString(StorageConstants.accessToken);
  }

  Future<String?> getUserId() async {
    try {
      final storedData = _storageService.getString(StorageConstants.loginData);

      if (storedData.isEmpty) {
        debugPrint("⚠️ No access token found in storage.");
        return null;
      }

      // Decode JSON safely
      final decodedData = jsonDecode(storedData);
      // print('Login Data: $decodedData');

      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey("userID")) {
        return decodedData["userID"].toString(); // Ensure it's a string
      } else {
        debugPrint("⚠️ userID not found in stored data: $decodedData");
        return null;
      }
    } catch (error) {
      debugPrint(" Error decoding userID: $error");
      return null;
    }
  }
  Future<String?> addAllergy(Map<String, dynamic> payload) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return null;
      }
      final endpoint = ApiUrl.addAllergy(userId);
      final response = await _apiService.post(
        endpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: payload,
      );
      if ((response.statusCode == 200 || response.statusCode == 1)) {
        return response.data['data']['message'];
      } else {
        debugPrint(' Failed to add allergy: ${response.statusCode}');
        throw Exception('Failed to add allergy: ${response.statusCode}');
      }
    } catch (error, s) {
      debugPrint(' Error adding allergy: $error');
      print(s);
      throw Exception('Error adding allergy: $error');
    }
  }



  Future<List<AllergyListModel>> getAllAllergyList() async {
    try {
      final response = await _apiService.get(
        ApiUrl.getAllAllergies,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if ((response.statusCode == 200 || response.data['code'] == 1)) {
        final List<AllergyListModel> allAllergies =
            (response.data['data'] as List)
                .map((e) => AllergyListModel.fromJson(e))
                .toList();

        return allAllergies;
      } else {
        return [];
      }
    } catch (error,s) {
      debugPrint(' Error getting all allergies: $error');
      print(s);
      return [];
    }
  }

  Future<String?> addImmunization(ImmunizationResult payload) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return null;
      }
      final endpoint = ApiUrl.addImmunization(userId);
      final response = await _apiService.post(
        endpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: payload.toJson(),
      );
      if ((response.statusCode == 200 || response.statusCode == 1)) {
        return response.data['data']['message'];
      } else {
        debugPrint(' Failed to add immunization: ${response.statusCode}');
        throw Exception('Failed to add immunization: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error adding immunization: $error');
      throw Exception('Error adding immunization: $error');
    }
  }

  Future<EmergencyContactInfo?> getEmergencyContactInfo() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return null;
      }

      final response = await _apiService.get(
        ApiUrl.getEmergencyContactInfo(userId),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final EmergencyContactInfo emergencyContactInfo =
            EmergencyContactInfo.fromJson(response.data);
        return emergencyContactInfo;
      } else {
        debugPrint(' Failed to get emergency contact: ${response.statusCode}');
        throw Exception(
            'Failed to get emergency contact: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching get emergency contact: $error');
      throw Exception('Error fetching get emergency contact: $error');
    }
  }

  Future<String?> updateEmergencyContactInfo(
      EmergencyContactInfo payload) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return null;
      }
      // payload.toJson().entries.forEach(print);

      final response = await _apiService.put(
        ApiUrl.updateEmergencyContactInfo(userId),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: payload.toJson(),
      );
      if ((response.statusCode == 200 || response.statusCode == 1)) {
        return response.data['data']['message'];
      } else {
        debugPrint(
            ' Failed to update emergency contact: ${response.statusCode}');
        throw Exception(
            'Failed to update emergency contact: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching update emergency contact: $error');
      throw Exception('Error fetching update emergency contact: $error');
    }
  }

  Future<PatientContactModel?> getPatientContact() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return null;
      }

      final response = await _apiService.get(
        ApiUrl.getPatientContact(userId),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final PatientContactModel patientContact =
            PatientContactModel.fromJson(response.data);
        return patientContact;
      } else {
        debugPrint(' Failed to get contact: ${response.statusCode}');
        throw Exception('Failed to get contact: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching get contact: $error');
      throw Exception('Error fetching get contact: $error');
    }
  }

  Future<String?> updateContact(PatientContactModel payload) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return null;
      }
      // payload.toJson().entries.forEach(print);

      final response = await _apiService.put(
        ApiUrl.updatePatientContact(userId),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: payload.toJson(),
      );
      if ((response.statusCode == 200 || response.statusCode == 1)) {
        return response.data['data']['message'];
      } else {
        debugPrint(' Failed to update profile: ${response.statusCode}');
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching update profile: $error');
      throw Exception('Error fetching update profile: $error');
    }
  }

  Future<String?> updatePatientProfile(UpdatePatientPayload payload) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return null;
      }
      // payload.toJson().entries.forEach(print);

      final response = await _apiService.put(
        ApiUrl.updatePatientProfile(userId),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: payload.toJson(),
      );
      if ((response.statusCode == 200 || response.statusCode == 1)) {
        return response.data['message'];
      } else {
        debugPrint(' Failed to update profile: ${response.statusCode}');
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching update profile: $error');
      throw Exception('Error fetching update profile: $error');
    }
  }

  Future<List<UserAllergyModel>?> getAllergyResult() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return null;
      }

      final response = await _apiService.get(
        ApiUrl.getAllergyResult(userId),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if ((response.statusCode == 200 || response.data['code'] == 1)) {
        final List<UserAllergyModel> allergyResult =
            (response.data['data'] as List)
                .map((e) => UserAllergyModel.fromJson(e))
                .toList();

        return allergyResult;
      } else {
        return [];
      }
    } catch (error,s) {
      debugPrint(' Error getting allergy: $error');
      print(s);
      return [];
    }
  }

  Future<List<ImmunizationResult>?> getImmunizationResult() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return null;
      }

      final response = await _apiService.get(
        ApiUrl.getImmunizationResult(userId),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if ((response.statusCode == 200 || response.data['code'] == 1)) {
        final List<ImmunizationResult> immunizationResult =
            (response.data['data'] as List)
                .map((e) => ImmunizationResult.fromJson(e))
                .toList();

        return immunizationResult;
      } else {
        debugPrint(' Failed to get immunization: ${response.statusCode}');
        throw Exception('Failed to get immunization: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching get immunization: $error');
      throw Exception('Error fetching get immunization: $error');
    }
  }

  Future<PatientProfileResult?> getPatientProfile() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return null;
      }

      final response = await _apiService.get(
        ApiUrl.getPatientProfile(userId),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final PatientProfileResult profileResult =
            PatientProfileResult.fromJson(response.data);
        return profileResult;
      } else {
        debugPrint(' Failed to get profile: ${response.statusCode}');
        throw Exception('Failed to get profile: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching get profile: $error');
      throw Exception('Error fetching get profile: $error');
    }
  }
}
