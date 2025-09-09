import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/model/user_model.dart';
import 'package:path/path.dart';
import '../api/app_endpoints.dart';
import '../constants/api_url.dart';
import '../constants/storage_constant.dart';
import '../features/account/model/referral_list.dart';
import '../features/appointment/model/appointment_model.dart';
import '../features/appointment/model/doctors_rating.dart';
import '../features/biling/model/billing_response.dart';
import '../features/caregivers/presentation/model/care_giver_response.dart';
import '../features/chats/presentation/model/agora_token_response.dart';
import '../features/chats/presentation/model/chatcontact_model.dart';
import '../features/chats/presentation/model/conversation_mode.dart';
import '../features/chats/presentation/model/unread_chat_model.dart';
import '../features/community/model/all_friends.dart';
import '../features/community/model/receiver_community_model.dart';
import '../features/community/post/model/all_post_model.dart';
import '../features/health_record/model/health_record_model.dart';
import '../features/health_record/model/hmo_model.dart';
import '../features/home/model/all_interest_model.dart';
import '../features/home/model/friend_request_receiver.dart';
import '../features/home/model/friend_request_sender.dart';
import '../features/home/model/group_interest_model.dart';
import '../features/home/model/patient_by_id.dart';
import '../features/notifications/model/notification_model.dart';
import '../features/prescription/models/get_prescriptions_model.dart';
import '../features/prescription/models/media_post_model.dart';
import '../features/prescription/models/prescription_model.dart';
import '../model/all_alergy_response.dart';
import '../model/article_response.dart';
import '../model/banner_response.dart';
import '../model/category_model.dart';
import '../model/community_list_response.dart';
import '../model/contact_model.dart';
import '../model/doctord_list_response.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import 'package:http_parser/http_parser.dart';

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

  Future<String?> getUserType() async {
    try {
      final storedData = _storageService.getString(StorageConstants.loginData);

      if (storedData == null || storedData.isEmpty) {
        debugPrint("⚠️ No access token found in storage.");
        return null;
      }

      // Decode JSON safely
      final decodedData = jsonDecode(storedData);

      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey("userType")) {
        return decodedData["userType"].toString(); // Ensure it's a string
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

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

  Future<List<ImmunizationResponse>> fetchImmunization() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.immunizationUrl + userId!,
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

        final articles =
            data.map((e) => ImmunizationResponse.fromJson(e)).toList();

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

  Future<List<MedicalRecordResponse>> fetchMedicalHistory() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.medicalRecordUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final List<dynamic> data = response.data['data'];

        if (data.isEmpty) {
          debugPrint('⚠️ No treatment found.');
          return [];
        }

        final gottenData =
            data.map((e) => MedicalRecordResponse.fromJson(e)).toList();

        // ✅ Save articles in storage for offline use
        await _storageService.setString(
          StorageConstants.articleData,
          jsonEncode(data),
        );

        return gottenData;
      } else {
        debugPrint(' Failed to fetch articles: ${response.statusCode}');
        throw Exception('Failed to fetch articles: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching articles: $error');
      throw Exception('Error fetching articles: $error');
    }
  }

  Future<List<PrescriptionByIDResponse>> getPrescriptionById(int id) async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.prescriptionByIdUrl + id.toString(),
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

        final gottenData =
            data.map((e) => PrescriptionByIDResponse.fromJson(e)).toList();

        // ✅ Save articles in storage for offline use
        await _storageService.setString(
          StorageConstants.articleData,
          jsonEncode(data),
        );

        return gottenData;
      } else {
        debugPrint(' Failed to fetch articles: ${response.statusCode}');
        throw Exception('Failed to fetch articles: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching articles: $error');
      throw Exception('Error fetching articles: $error');
    }
  }

  Future<List<PrescriptionByIDResponse>> fetchAllPrescription() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allPrescriptionUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final List<dynamic> data = response.data;

        if (data.isEmpty) {
          debugPrint('⚠️ No articles found.');
          return [];
        }

        final gottenData =
            data.map((e) => PrescriptionByIDResponse.fromJson(e)).toList();

        // ✅ Save articles in storage for offline use
        await _storageService.setString(
          StorageConstants.articleData,
          jsonEncode(data),
        );

        return gottenData;
      } else {
        debugPrint(' Failed to fetch articles: ${response.statusCode}');
        throw Exception('Failed to fetch articles: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching articles: $error');
      throw Exception('Error fetching articles: $error');
    }
  }

  Future<UserData> getUserData() async {
    try {
      final token = await getToken();

      final response = await _apiService.get(
        ApiUrl
            .profileGetUrl, // You may want to rename this to something like ApiUrl.userDataUrl
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        final data = response.data['data'];

        if (data == null) {
          debugPrint('⚠️ No user data found.');
          throw Exception('No user data found.');
        }

        final userData = UserData.fromJson(data);

        // ✅ Optionally save userData for offline use
        await _storageService.setString(
          StorageConstants.userInfo,
          jsonEncode(data),
        );

        return userData;
      } else {
        debugPrint('❌ Failed to fetch user data: ${response.statusCode}');
        throw Exception('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('❌ Error fetching user data: $error');
      throw Exception('Error fetching user data: $error');
    }
  }

  Future<UserContact> getContactData() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      final response = await _apiService.get(
        ApiUrl.contactGetUrl +
            userId!, // You may want to rename this to something like ApiUrl.userDataUrl
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        final data = response.data['data'];

        if (data == null) {
          debugPrint('⚠️ No user data found.');
          throw Exception('No user data found.');
        }

        final userData = UserContact.fromJson(data);

        // ✅ Optionally save userData for offline use
        await _storageService.setString(
          StorageConstants.userContact,
          jsonEncode(data),
        );

        return userData;
      } else {
        debugPrint('❌ Failed to fetch user data: ${response.statusCode}');
        throw Exception('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('❌ Error fetching user data: $error');
      throw Exception('Error fetching user data: $error');
    }
  }

  Future<UserEmergency> getEmergencyContactData() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      final response = await _apiService.get(
        ApiUrl.emergencyGetUrl +
            userId!, // You may want to rename this to something like ApiUrl.userDataUrl
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        final data = response.data['data'];

        if (data == null) {
          debugPrint('⚠️ No user data found.');
          throw Exception('No user data found.');
        }

        final userData = UserEmergency.fromJson(data);

        // ✅ Optionally save userData for offline use
        await _storageService.setString(
          StorageConstants.userEmergencyContact,
          jsonEncode(data),
        );

        return userData;
      } else {
        debugPrint('❌ Failed to fetch user data: ${response.statusCode}');
        throw Exception('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('❌ Error fetching user data: $error');
      throw Exception('Error fetching user data: $error');
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

  Future<List<DoctorListResponse>> fetchDoctorListPage(
      int page, int pageSize) async {
    print("Gotteb are::: ${pageSize}");
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allDoctorsUrl(pageSize),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['resultList'];

        if (data.isEmpty) {
          debugPrint('⚠️ No doctors found.');
          return [];
        }

        final doctorList =
            data.map((e) => DoctorListResponse.fromJson(e)).toList();

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

  Future<List<DoctorListResponse>> fetchDoctorList() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allDoctorsUrl(98),
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

  Future<List<AllInterestResponse>> fetchAllInterest() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allInterestUrl + userId!,
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
            data.map((e) => AllInterestResponse.fromJson(e)).toList();

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

  Future<List<PrescriptionByPatientResponse>>
      fetchPrescriptionByPatientId() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.prescriptionByUserIdUrl + userId!,
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
            data.map((e) => PrescriptionByPatientResponse.fromJson(e)).toList();

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

  Future<List<BillingResponse>> fetchBilingList() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.billingRequestUrl(int.parse(userId!)),
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
            data.map((e) => BillingResponse.fromJson(e)).toList();

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

  Future<List<CommunityListResponse>> fetchMyCommunityList() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.myCommunityListUrl,
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

  Future<List<ReferralList>> fetchMyReferredList() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.refferedURL(userId!),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final List<dynamic> data = response.data['data']['recordList'];

        if (data.isEmpty) {
          debugPrint('⚠️ No reffered found.');
          return [];
        }

        final referrealList =
            data.map((e) => ReferralList.fromJson(e)).toList();

        // ✅ Save articles in storage for offline use
        await _storageService.setString(
          StorageConstants.refferedListData,
          jsonEncode(data),
        );

        return referrealList;
      } else {
        debugPrint(' Failed to fetch articles: ${response.statusCode}');
        throw Exception('Failed to fetch articles: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching articles: $error');
      throw Exception('Error fetching articles: $error');
    }
  }

  Future<List<CommunityListResponse>> fetchMyCommunityListByAdminUser() async {
    try {
      final token = await getToken();
      final adminId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.fetchAdminUserCommunityUrl(int.parse(adminId!)),
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

  Future<List<UserAllegiesResponse>> fetchAllergiesByUserID() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.fetchAllergyUrl + userId.toString(),
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
            data.map((e) => UserAllegiesResponse.fromJson(e)).toList();

        // ✅ Save articles in storage for offline use

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

  Future<List<AppointmentResponse>> fetchAppointmentByUserId() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.appointment(int.parse(userId!)),
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
            data.map((e) => AppointmentResponse.fromJson(e)).toList();

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

  Future<List<HmoResponse>> fetchHMOByUserId() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.hmoUrl(int.parse(userId!)),
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

        final allAllegyList = data.map((e) => HmoResponse.fromJson(e)).toList();

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

  Future<List<AllAlergyResponse>> fetchAllergies() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.fetchAllAllergyUrl,
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
        ApiUrl.fetchAllIntolleranceUrl,
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

  Future<Map<String, dynamic>> imageAnalysis(File imageFile) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      final formData = FormData.fromMap({
        'ImageToAnalyze': await MultipartFile.fromFile(
          imageFile.path,
          filename: basename(imageFile.path),
        ),
        'PatientId': userId.toString(),
      });

      final response = await _apiService.post(
        ApiUrl.imageAnalysisUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'text/plain',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data; // ✅ Already a map
      } else {
        return {
          "code": 0,
          "status": "error",
          "message": "Server error: ${response.statusCode}",
        };
      }
    } catch (e) {
      return {
        "code": 0,
        "status": "error",
        "message": "Exception: $e",
      };
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

  Future<String> followFriendRequest(int id) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      final response = await _apiService.post(
          ApiUrl.follorFriendRequestUrl(int.parse(userId.toString())),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          data: {
            "friendRequests": [
              {
                "receiverPatientId": id,
                "receiverEmployeeId": id,
                "isHealthPractitioner": false
              }
            ]
          });

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        return 'Join successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> unFollowFriendRequest(int id) async {
    try {
      final token = await getToken();

      final response = await _apiService.delete(
        ApiUrl.unfollorFriendRequestUrl(int.parse(id.toString())),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> sendInviteRequest(int id, int communityGroupId) async {
    try {
      final token = await getToken();

      final response = await _apiService.post(ApiUrl.sendInviteUrl, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }, data: {
        "communityGroupId": communityGroupId,
        "communityGroupInvites": [
          {
            "receiverPatientId": id,
            "receiverEmployeeId": id,
            "isHealthPractitioner": false
          }
        ]
      });

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        return 'successful';
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
        ApiUrl.updateAllergyUrl,
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
        ApiUrl.updateAllergyUrl,
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

  Future<String> doctorRating(
      {required int doctorEmployeeId,
      required int appointmentId,
      required int howAttentiveWasTheDoctorRate,
      required int howSatisfiedAreYouRate,
      required int recommendationRate,
      required String moreDetails}) async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      // Make the PUT request
      final response = await _apiService.post(
        ApiUrl.doctorRatingUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: {
          "patientId": int.parse(userId.toString()),
          "doctorId": doctorEmployeeId,
          "appointmentId": appointmentId,
          "howAttentiveWasTheDoctorRate": howAttentiveWasTheDoctorRate,
          "howSatisfiedAreYouRate": howSatisfiedAreYouRate,
          "recommendationRate": recommendationRate,
          "moreDetails": moreDetails
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

  Future<List<FriendRequestReceiverResponse>>
      fetchFriendRequestByreceiver() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.friendRequestReceiver(
            // 28),
            int.parse(userId!)),
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
            data.map((e) => FriendRequestReceiverResponse.fromJson(e)).toList();

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

  Future<List<FriendRequestSenderResponse>> fetchFriendRequestBySender() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.friendRequestSender(
            // 28),
            int.parse(userId!)),
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
            data.map((e) => FriendRequestSenderResponse.fromJson(e)).toList();

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

  Future<List<AllFriendRequestResponse>> fetchAllFriends() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allFriendsURL + userId!,
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
            data.map((e) => AllFriendRequestResponse.fromJson(e)).toList();

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

  Future<PatientByIDResponse> getPatientById(patientId) async {
    try {
      final token = await getToken();

      final response = await _apiService.get(
        ApiUrl.patientById(
            patientId), // You may want to rename this to something like ApiUrl.userDataUrl
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        final data = response.data['data'];

        if (data == null) {
          debugPrint('⚠️ No user data found.');
          throw Exception('No user data found.');
        }

        final userData = PatientByIDResponse.fromJson(data);

        return userData;
      } else {
        debugPrint('❌ Failed to fetch user data: ${response.statusCode}');
        throw Exception('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('❌ Error fetching user data: $error');
      throw Exception('Error fetching user data: $error');
    }
  }

  Future<String> friendRequestResponseToRequest(
      {required int id,
      required int receiverPatientId,
      required bool isAccepted}) async {
    try {
      final token = await getToken();

      final response = await _apiService.put(
          ApiUrl.friendrequestResponseRequestURL(id,
              receiverPatientId), // You may want to rename this to something like ApiUrl.userDataUrl
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          data: {
            "isAccepted": isAccepted
          });

      if (response.statusCode == 200 || response.statusCode == 1) {
        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<List<CommunityListResponse>> getGroupInterest(
      List<int> categoryIds) async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final url = ApiUrl.groupInterestURL(categoryIds);
      debugPrint('URL: $url');

      final response = await _apiService.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        final List<dynamic> data = response.data['data'];

        if (data.isEmpty) {
          debugPrint('⚠️ No groups found.');
          return [];
        }

        final allGroupList =
            data.map((e) => CommunityListResponse.fromJson(e)).toList();
        return allGroupList;
      } else {
        debugPrint('Failed to fetch groups: ${response.statusCode}');
        throw Exception('Failed to fetch groups: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error fetching group interests: $error');
      throw Exception('Error fetching group interests: $error');
    }
  }

  Future<List<CommunityGroupReceiverResponse>> fetchRecieverPatientId() async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.communityGroupInviteReceiverURL(int.parse(userId.toString())),
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

        final communityList = data
            .map((e) => CommunityGroupReceiverResponse.fromJson(e))
            .toList();

        // ✅ Save articles in storage for offline use

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

  Future<List<CommunityGroupReceiverResponse>> fetchSenderPatientId() async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.communityGroupInviteSenderURL(int.parse(userId.toString())),
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

        final communityList = data
            .map((e) => CommunityGroupReceiverResponse.fromJson(e))
            .toList();

        // ✅ Save articles in storage for offline use

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

  Future<String> communityRespondToInvite(
      {required int id, required bool isAccepted}) async {
    try {
      final token = await getToken();

      final response = await _apiService.put(
          ApiUrl.responseToInviteURL(
            id,
          ), // You may want to rename this to something like ApiUrl.userDataUrl
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          data: {
            "isAccepted": isAccepted
          });

      if (response.statusCode == 200 || response.statusCode == 1) {
        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> saveFavouriteCategoy(List<int> categoryIds) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      List<Map<String, dynamic>> favoriteCategories = categoryIds.map((id) {
        return {"categoryId": id};
      }).toList();

      final response = await _apiService.post(
        ApiUrl.saveFavouriteCategoyURL,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: {
          "patientId": int.parse(
              userId!), // You can replace 0 with the actual patient ID if needed
          "favoriteCategories":
              favoriteCategories, // Pass the dynamically created list of categories
        },
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

  Future<List<AllPostResponse>> fetchAllPosts(
      int groupId, int pageNumber, int pageSize) async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allPostURL(groupId, pageNumber, pageSize),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['posts'];

        if (data.isEmpty) {
          debugPrint('⚠️ No categories found.');
          return [];
        }

        final category = data.map((e) => AllPostResponse.fromJson(e)).toList();

        // ✅ Save categories for offline use

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

  Future<List<AllPostResponse>> fetchAllFlaggedPosts() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allFlaggedPostURL(userId!),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['posts'];

        if (data.isEmpty) {
          debugPrint('⚠️ No categories found.');
          return [];
        }

        final category = data.map((e) => AllPostResponse.fromJson(e)).toList();

        // ✅ Save categories for offline use

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

  Future<String> likePost(int postId) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      final response = await _apiService.post(
        ApiUrl.likePostUrl(postId, int.parse(userId.toString())),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 1)) {
        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> reactToPost(int postId, int reaction) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      final response = await _apiService.post(ApiUrl.reactToPostUrl, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }, data: {
        "postId": postId,
        "memberId": userId,
        "reaction": reaction
      });

      if ((response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 1)) {
        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> addPostToComment(int postId, String commentText) async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      final response =
          await _apiService.post(ApiUrl.addPostCommentsUrl, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }, data: {
        "postId": postId,
        "memberId": userId,
        "commentText": commentText
      });

      if ((response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 1)) {
        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<List<PostMediaResponse>> getAllPostMedia(int groupId) async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final url = ApiUrl.groupPostMediaURL(groupId);
      debugPrint('URL: $url');

      final response = await _apiService.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        final List<dynamic> data = response.data['posts'];

        if (data.isEmpty) {
          debugPrint('⚠️ No groups found.');
          return [];
        }

        final allGroupList =
            data.map((e) => PostMediaResponse.fromJson(e)).toList();
        return allGroupList;
      } else {
        debugPrint('Failed to fetch groups: ${response.statusCode}');
        throw Exception('Failed to fetch groups: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error fetching group interests: $error');
      throw Exception('Error fetching group interests: $error');
    }
  }

  Future<List<DoctorsRatingResponse>> getAllDoctorsRating() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allDoctorsRatingURL,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        final List<dynamic> data = response.data['data'];

        if (data.isEmpty) {
          debugPrint('⚠️ No groups found.');
          return [];
        }

        final allGroupList =
            data.map((e) => DoctorsRatingResponse.fromJson(e)).toList();
        return allGroupList;
      } else {
        debugPrint('Failed to fetch groups: ${response.statusCode}');
        throw Exception('Failed to fetch groups: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error fetching group interests: $error');
      throw Exception('Error fetching group interests: $error');
    }
  }

  Future<List<CareGiverResponse>> getAllCareGiver() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.careGiverSearch,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        final List<dynamic> data = response.data['resultList'];

        if (data.isEmpty) {
          debugPrint('⚠️ No groups found.');
          return [];
        }

        final allGroupList =
            data.map((e) => CareGiverResponse.fromJson(e)).toList();
        return allGroupList;
      } else {
        debugPrint('Failed to fetch groups: ${response.statusCode}');
        throw Exception('Failed to fetch groups: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error fetching group interests: $error');
      throw Exception('Error fetching group interests: $error');
    }
  }

  Future<List<ChatContact>> fetchChatContactList({
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      final userType = await getUserType();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allChatContactUrl(userId!, userType!,
            pageNumber: pageNumber, pageSize: pageSize),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        final List<dynamic> data = response.data['contacts'];

        return data.map((e) => ChatContact.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch contacts: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❌ Error: $e');
      rethrow;
    }
  }

  Future<List<ConversationResponse>> fetchChatConversationList(
    String userIDTwo,
    String userTypeTwo,
    int pageNumber,
    int pageSize,
  ) async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      final userType = await getUserType();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allChatConversationUrl(
            userId!, userType!, userIDTwo, userTypeTwo, pageNumber, pageSize),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final List<dynamic> data = response.data['chat'];
        return data.map((e) => ConversationResponse.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to fetch conversations: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching conversations: $error');
    }
  }

  Future<String> sendChatWithImage(
      int receiverId, int receiverType, String text, File image) async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      final userType = await getUserType();

      final formData = FormData.fromMap({
        "SenderId": userId.toString(),
        "SenderType": userType.toString(),
        "ReceiverId": receiverId.toString(),
        "ReceiverType": receiverType,
        "Text": text,
        "Image": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
          contentType:
              MediaType("image", "png"), // you may want to dynamically set this
        ),
      });

      final response = await _apiService.post(
        ApiUrl.chatWithImageUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 1) {
        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> sendChatWithText(
      int receiverId, int receiverType, String text) async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      final userType = await getUserType();

      final response = await _apiService.post(ApiUrl.chatWithTextUrl, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }, data: {
        "senderId": userId,
        "senderType": userType,
        "receiverId": receiverId,
        "receiverType": receiverType,
        "text": text,
        "imageUrl": null
      });

      if ((response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 1)) {
        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<UnreadMessageResponse> fetchUnreadChat() async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      final userType = await getUserType();

      final response = await _apiService.get(
        '${ApiUrl.allUnreadChatUrl}${userId!}/$userType',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final data = response.data;
        return UnreadMessageResponse.fromJson(data);
      } else {
        throw Exception(
            'Failed to fetch unread messages: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching unread messages: $error');
    }
  }

  Future<List<NotificationResponse>> fetchNotificationList() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.allNotificationUrl(userId!),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final List<dynamic> data = response.data;
        return data.map((e) => NotificationResponse.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to fetch conversations: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching conversations: $error');
    }
  }

  Future<UnreadNotificationResponse> fetchUnreadNotification() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        throw Exception('No access token found.');
      }

      final response = await _apiService.get(
        ApiUrl.allUnreadNotificationUrl(userId!),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 1) {
        return UnreadNotificationResponse.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to fetch unread notifications: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching unread notifications: $error');
    }
  }

  Future<AgoraTokenResponse?> getAgoraToken(int uid, String channelName) async {
    try {
      final token = await getToken();

      final response = await _apiService.get(
        ApiUrl.generateCallTokenURL(channelName, uid.toString()),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        return AgoraTokenResponse.fromJson(response.data); // ✅ fix here
      } else {
        throw Exception(
            'Failed to fetch unread messages: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching unread messages: $error');
    }
  }

  Future<void> sendCallNotification({
    required String callerId,
    required String callerName,
    required String receiverId,
    required String channelName,
  }) async {
    try {
      final token = await getToken();

      final response = await _apiService.post(ApiUrl.notifyCallURL, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }, data: {
        'callerId': callerId,
        'callerName': callerName,
        'receiverId': receiverId,
        'channelName': channelName,
      });

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        // return AgoraTokenResponse.fromJson(jsonDecode(data));
      } else {
        throw Exception(
            'Failed to fetch unread messages: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching unread messages: $error');
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
      final response = error.response;
      if (response != null) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          final errorData = data['errorData'];
          if (errorData != null && errorData is List && errorData.isNotEmpty) {
            return errorData.first.toString(); // ✅ Real error message
          }
        }
        // If no errorData, fallback to statusCode handling
        return _handleStatusCode(response.statusCode);
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
