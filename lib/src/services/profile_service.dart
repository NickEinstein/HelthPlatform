import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/features/profile/model/allergy_result.dart';
import 'package:greenzone_medical/src/features/profile/model/immunization_result.dart';
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

  Future<String?> updatePatientProfile(UpdatePatientPayload payload) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return null;
      }

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

  Future<List<AllergyResult>?> getAllergyResult() async {
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
        final List<AllergyResult> allergyResult =
            (response.data['data'] as List)
                .map((e) => AllergyResult.fromJson(e))
                .toList();

        return allergyResult;
      } else {
        return [];
      }
    } catch (error) {
      debugPrint(' Error fetching get immunization: $error');
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
