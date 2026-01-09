import 'dart:convert';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/model/my_app_category_model.dart';
import 'package:greenzone_medical/src/model/my_app_model.dart';
import 'package:greenzone_medical/src/model/regular_app_model.dart';

class GoalService {
  final ApiService _apiService;
  final StorageService _storageService;

  GoalService(this._apiService, this._storageService);

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

  Future<(bool, String?)> createGoal({
    required String appId,
    required String category,
    required int currentValue,
    required String deadlineDate,
    required String deadlineTime,
    required String desc,
    int specialistId = 0,
    required int targetValue,
    required String title,
    required String unit,
  }) async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return (false, 'No access token found');
      }
      //2026-01-30T12:00
      final deadline = '${deadlineDate}T$deadlineTime';
      final payload = {
        'appId': appId,
        'category': category,
        'currentValue': currentValue,
        'deadline': deadline,
        'description': desc,
        'patientId': userId,
        'specialistId': specialistId,
        'target': targetValue,
        'title': title,
        'unit': unit,
      };
      print(payload);
      final response = await _apiService.post(
        ApiUrl.userGoals,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: payload,
      );

      if (response.statusCode == 200) {
        debugPrint('Goal created successfully: ${response.data}');
        return (true, null);
      } else {
        debugPrint(' Failed to create goal: ${response.statusCode}');
        return (false, 'Failed to create goal');
      }
    } catch (error) {
      debugPrint(' Error creating goal: $error');
      return (false, 'Error creating goal');
    }
  }

  Future<(bool, String?)> createPlan({
    required String appId,
    required String goal,
    required String startDate,
    required String timeOfDay,
  }) async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return (false, 'No access token found');
      }

      final response = await _apiService.post(
        ApiUrl.appPlan,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: {
          'userId': userId,
          'appId': appId,
          'goal': goal,
          'startDate': startDate,
          'timeOfDay': timeOfDay,
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Plan created successfully: ${response.data}');
        return (true, null);
      } else {
        debugPrint(' Failed to create plan: ${response.statusCode}');
        return (false, 'Failed to create plan');
      }
    } catch (error) {
      debugPrint(' Error creating plan: $error');
      return (false, 'Error creating plan');
    }
  }

  Future<List<MyAppModel>> getMyApps() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.appPlan,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final List<dynamic> data = response.data;

        if (data.isEmpty) {
          debugPrint('⚠️ No apps found.');
          return [];
        }

        final myApps = data.map((e) => MyAppModel.fromJson(e)).toList();

        return myApps;
      } else {
        debugPrint(' Failed to fetch my apps: ${response.statusCode}');
        throw Exception('Failed to my apps: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching my apps: $error');
      throw Exception('Error fetching my apps: $error');
    }
  }

  Future<List<RegularAppModel>> getAllApps() async {
    final response = await _apiService.get(
      ApiUrl.getAllApps,
    );
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => RegularAppModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load apps');
    }
  }

  Future<List<RegularAppModel>> getAppsByCategory(int? id) async {
    final response = await _apiService.get(
      id == null ? ApiUrl.getAllApps : ApiUrl.getAppsByCategory(id),
    );
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => RegularAppModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load apps by category');
    }
  }

  Future<List<MyAppCategoryModel>> getAppCategories() async {
    final response = await _apiService.get(ApiUrl.getAppsCategories);
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => MyAppCategoryModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load apps categories');
    }
  }
}
