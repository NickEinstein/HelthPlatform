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

  Future<List<MyAppModel>> getMyApps() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.getMyApps,
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
