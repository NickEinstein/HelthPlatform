import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../constants/api_url.dart';
import '../constants/storage_constant.dart';
import '../model/article_response.dart';
import '../model/banner_response.dart';
import '../model/category_model.dart';
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
        debugPrint('❌ Failed to fetch articles: ${response.statusCode}');
        throw Exception('Failed to fetch articles: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('❌ Error fetching articles: $error');
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
        debugPrint('❌ Failed to fetch Banners: ${response.statusCode}');
        throw Exception('Failed to fetch banners: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('❌ Error fetching articles: $error');
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
          StorageConstants.articleData,
          jsonEncode(data),
        );

        return category;
      } else {
        debugPrint('❌ Failed to fetch categories: ${response.statusCode}');
        throw Exception('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('❌ Error fetching categories: $error');
      throw Exception('Error fetching categories: $error');
    }
  }

  /// Fetches cached articles from local storage (useful for offline mode).
  Future<List<ArticleResponse>> getCachedArticles() async {
    try {
      final cachedData =
          _storageService.getString(StorageConstants.articleData);
      if (cachedData == null || cachedData.isEmpty) return [];

      final List<dynamic> data = jsonDecode(cachedData);
      return data.map((e) => ArticleResponse.fromJson(e)).toList();
    } catch (error) {
      debugPrint('❌ Error reading cached articles: $error');
      return [];
    }
  }


   Future<List<dynamic>> fetchAppointments(int userId) async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.appointment(userId),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        if (data.isEmpty) {
          debugPrint('⚠️ No appointments found.');
          return [];
        }

        return data;
      } else {
        debugPrint('❌ Failed to fetch appointments: ${response.statusCode}');
        throw Exception('Failed to fetch appointments: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('❌ Error fetching appointments: $error');
      throw Exception('Error fetching appointments: $error');
    }
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
        debugPrint('❌ Failed to cancel appointment: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('❌ Error cancelling appointment: $error');
      return false;
    }
  }

}
