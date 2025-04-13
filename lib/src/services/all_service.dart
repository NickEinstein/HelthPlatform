import 'dart:convert';
import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../api/app_endpoints.dart';
import '../constants/api_url.dart';
import '../constants/storage_constant.dart';
import '../features/prescription/models/get_prescriptions_model.dart';
import '../model/all_alergy_response.dart';
import '../model/article_response.dart';
import '../model/banner_response.dart';
import '../model/category_model.dart';
import '../model/community_list_response.dart';
import '../model/doctord_list_response.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class AllService {
  final ApiService _apiService;
  final StorageService _storageService;

  AllService(this._apiService, this._storageService);

  /// Retrieves the stored authentication token.
  Future<String?> getToken() async {
    return _storageService.getString(StorageConstants.accessToken);
  }

  Future<String?> getUserId() async {
    try {
      final storedData = _storageService.getString(StorageConstants.loginData);

      if (storedData == null || storedData.isEmpty) {
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

  /// Fetches articles from the API and caches them.
  Future<List<ArticleResponse>> fetchArticles() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allArticleUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final List<dynamic> data = response.data['data'];

        if (data.isEmpty) {
          debugPrint('⚠️ No articles found.');
          return [];
        }

        final articles = data.map((e) => ArticleResponse.fromJson(e)).toList();

        // ✅ Save articles in storage for offline use
        await _storageService.setString(
          StorageConstants.articleData,
          jsonEncode(data),
        );

        return articles;
      } else {
        debugPrint(' Failed to fetch articles: ${response.statusCode}');
        throw Exception('Failed to fetch articles: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching articles: $error');
      throw Exception('Error fetching articles: $error');
    }
  }

  Future<List<BannerResponse>> fetchBanners() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allBannersUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200)) {
        final List<dynamic> data = response.data;

        if (data.isEmpty) {
          debugPrint('⚠️ No articles found.');
          return [];
        }

        final banners = data.map((e) => BannerResponse.fromJson(e)).toList();

        // ✅ Save articles in storage for offline use
        await _storageService.setString(
          StorageConstants.bannerData,
          jsonEncode(data),
        );

        return banners;
      } else {
        debugPrint(' Failed to fetch Banners: ${response.statusCode}');
        throw Exception('Failed to fetch banners: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching articles: $error');
      throw Exception('Error fetching banners: $error');
    }
  }

  Future<List<CategoryResponse>> fetchCategories() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allCategoriesUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        if (data.isEmpty) {
          debugPrint('⚠️ No categories found.');
          return [];
        }

        final category = data.map((e) => CategoryResponse.fromJson(e)).toList();

        // ✅ Save categories for offline use
        await _storageService.setString(
          StorageConstants.categoryData,
          jsonEncode(data),
        );

        return category;
      } else {
        debugPrint(' Failed to fetch categories: ${response.statusCode}');
        throw Exception('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching categories: $error');
      throw Exception('Error fetching categories: $error');
    }
  }

  Future<List<DoctorListResponse>> fetchDoctorList() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allDoctorsUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final List<dynamic> data = response.data['resultList'];

        if (data.isEmpty) {
          debugPrint('⚠️ No articles found.');
          return [];
        }

        final doctorList =
            data.map((e) => DoctorListResponse.fromJson(e)).toList();

        // ✅ Save articles in storage for offline use
        await _storageService.setString(
          StorageConstants.doctorListData,
          jsonEncode(data),
        );

        return doctorList;
      } else {
        debugPrint(' Failed to fetch doctorList: ${response.statusCode}');
        throw Exception('Failed to fetch doctorList: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching doctorList: $error');
      throw Exception('Error fetching doctorList: $error');
    }
  }

  Future<List<CommunityListResponse>> fetchCommunityList() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.communityListUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final List<dynamic> data = response.data['data'];

        if (data.isEmpty) {
          debugPrint('⚠️ No articles found.');
          return [];
        }

        final communityList =
            data.map((e) => CommunityListResponse.fromJson(e)).toList();

        // ✅ Save articles in storage for offline use
        await _storageService.setString(
          StorageConstants.communityListData,
          jsonEncode(data),
        );

        return communityList;
      } else {
        debugPrint(' Failed to fetch articles: ${response.statusCode}');
        throw Exception('Failed to fetch articles: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching articles: $error');
      throw Exception('Error fetching articles: $error');
    }
  }

  Future<List<AllAlergyResponse>> fetchAllergies() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        'https://edogoverp.com/Connectedhealthonboarding/api/employee/get-allergies',
        // ApiUrl.allAllergyUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final List<dynamic> data = response.data['data'];

        if (data.isEmpty) {
          debugPrint('⚠️ No articles found.');
          return [];
        }

        final allAllegyList =
            data.map((e) => AllAlergyResponse.fromJson(e)).toList();

        // ✅ Save articles in storage for offline use
        await _storageService.setString(
          StorageConstants.allegyListData,
          jsonEncode(data),
        );

        return allAllegyList;
      } else {
        debugPrint(' Failed to fetch allAllegyList: ${response.statusCode}');
        throw Exception(
            'Failed to fetch allAllegyList: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching allAllegyList: $error');
      throw Exception('Error fetching allAllegyList: $error');
    }
  }

  Future<List<AllAlergyResponse>> fetchIntollerance() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        'https://edogoverp.com/Connectedhealthonboarding/api/employee/get-intollerance',
        // ApiUrl.allAllergyUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final List<dynamic> data = response.data['data'];

        if (data.isEmpty) {
          debugPrint('⚠️ No articles found.');
          return [];
        }

        final allAllegyList =
            data.map((e) => AllAlergyResponse.fromJson(e)).toList();

        // ✅ Save articles in storage for offline use
        await _storageService.setString(
          StorageConstants.allegyListData,
          jsonEncode(data),
        );

        return allAllegyList;
      } else {
        debugPrint(' Failed to fetch allAllegyList: ${response.statusCode}');
        throw Exception(
            'Failed to fetch allAllegyList: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching allAllegyList: $error');
      throw Exception('Error fetching allAllegyList: $error');
    }
  }

  Future<String> joinCommunity(int id) async {
    try {
      final token = await getToken();

      final response = await _apiService.put(
        ApiUrl.joinCommunityUrl(id),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        return 'Join successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<List<GetPrescriptionModel>> getPrescriptions() async {
    try {
      final String? loginData = _storageService.getString('loginData');

      if (loginData == null || loginData.isEmpty) {
        debugPrint('⚠️ No login data found.');
        return [];
      }

      final decodedData = jsonDecode(loginData);
      final userId = decodedData["userID"];

      final response = await _apiService.get(
        '${AppEndpoints.baseUrl}/${AppEndpoints.suffix}/api/Prescription/patient/$userId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        if (data.isEmpty) {
          debugPrint('⚠️ No prescriptions found.');
          return [];
        }

        final prescriptionList =
            data.map((e) => GetPrescriptionModel.fromJson(e)).toList();

        // ✅ Save prescriptions in storage for offline use
        await _storageService.setString(
          StorageConstants.prescriptionListData,
          jsonEncode(data),
        );

        return prescriptionList;
      } else {
        debugPrint(' Failed to fetch prescriptions: ${response.statusCode}');
        throw Exception(
            'Failed to fetch prescriptions: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching prescriptions: $error');
      throw Exception('Error fetching prescriptions: $error');
    }
  }

  /// Fetches cached articles from local storage (useful for offline mode).
  ///
  ///

  Future<String> updateAllergies({
    required Map<int, String> selectedAllergies,
    required TextEditingController otherController, // Add otherController
  }) async {
    try {
      final token = await getToken();

      final userId = await getUserId();
      // Build the payload for allergies list
      final allergiesList = selectedAllergies.entries
          .where((entry) => entry.key != 0) // Exclude 'others' key (0)
          .map((entry) => {
                "userId": int.parse(userId.toString()), // Use the passed userId
                "allergyId":
                    entry.key, // Assuming allergyId is the same as the key
                "allergicTo": entry.value, // Allergy name
              })
          .toList();

      // Build the payload for others list if the "Other" text is not empty
      final othersList = otherController.text.isNotEmpty
          ? [
              {
                "userId": int.parse(userId.toString()), // Use the passed userId
                "allergyId": 0, // Assuming allergyId for "others" is 0
                "allergicTo":
                    otherController.text, // Other allergy entered by the user
              }
            ]
          : [];

      // Combine both lists into one payload
      final payload = {
        "allergies": allergiesList,
        if (othersList.isNotEmpty)
          "others": othersList, // Include "others" only if not empty
      };

      // Make the PUT request
      final response = await _apiService.put(
        'https://edogoverp.com/Connectedhealthonboarding/api/employee/update-allergies',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: jsonEncode(payload), // Pass the payload as the request body
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> updateIntollerance({
    required Map<int, String> selectedIntollerance,
  }) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      // Build the payload for allergies list
      final allergiesList = selectedIntollerance.entries
          .where((entry) => entry.key != 0) // Exclude 'others' key (0)
          .map((entry) => {
                // "id": entry.key,
                "userId": int.parse(userId.toString()), // Use the passed userId
                "intolleranceId":
                    entry.key, // Assuming allergyId is the same as the key
                "intolleranceTo": entry.value, // Allergy name
              })
          .toList();

      // Combine both lists into one payload
      final payload = {
        "allergies": allergiesList,
      };

      // Make the PUT request
      final response = await _apiService.put(
        'https://edogoverp.com/Connectedhealthonboarding/api/employee/update-allergies',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: jsonEncode(payload), // Pass the payload as the request body
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> bookAppointment(
      {required int doctorEmployeeId,
      required String appointDate,
      required String appointTime,
      required int healthCareProviderId,
      required String description}) async {
    try {
      final token = await getToken();

      // Make the PUT request
      final response = await _apiService.post(
        ApiUrl.bookAppointmentUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: {
          "doctorEmployeeId": doctorEmployeeId,
          "appointDate": appointDate,
          "appointTime": appointTime,
          "healthCareProviderId": healthCareProviderId,
          "description": description
        }, // Pass the payload as the request body
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check your input.';
      case 401:
        return 'Unauthorized. Please check your credentials.';
      case 403:
        return 'Access denied. You do not have permission to access this resource.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Unexpected error occurred. Please try again.';
    }
  }

  String _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        return _handleStatusCode(error.response!.statusCode);
      } else {
        return 'Network error. Please check your connection.';
      }
    }
    return 'An unknown error occurred.';
  }

  /// Cancels an appointment by ID
  Future<bool> cancelAppointment({
    required int appointmentId,
    required int healthCareProviderId,
    required String canceledDate,
    required String canceledTime,
  }) async {
    try {
      final response = await _apiService.put(
        ApiUrl.cancelAppointment,
        data: {
          "id": appointmentId,
          "isCanceled": true,
          "healthCareProviderId": healthCareProviderId,
          "canceledDate": canceledDate,
          "canceledTime": canceledTime,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint(' Failed to cancel appointment: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint(' Error cancelling appointment: $error');
      return false;
    }
  }
}
