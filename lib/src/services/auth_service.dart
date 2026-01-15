import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/features/account/model/account_activity_model.dart';
import 'package:greenzone_medical/src/features/account/model/submit_feedback_response.dart';
import 'package:greenzone_medical/src/features/account/model/track_feedback_response.dart';
import 'package:greenzone_medical/src/utils/enum.dart';
import 'package:path/path.dart';

import '../features/auth/model/register_response.dart';
import '../features/notifications/messaging/firebase_messaging_config.dart';
import '../model/login_response.dart';
import '../model/nationality_model.dart';

class AuthService {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthService(this._apiService, this._storageService);

  Future<String?> getToken() async {
    return _storageService.getString(StorageConstants.accessToken);
  }

  Future<bool> authenticateUserLocally(String password) async {
    final savedPassword =
        _storageService.getString(StorageConstants.savedPassword);
    if (savedPassword == password) {
      return true;
    }
    return false;
  }

  Future<LoginResponse?> getUser() async {
    try {
      final storedData = _storageService.getString(StorageConstants.loginData);

      if (storedData.isEmpty) {
        return null;
      }

      final decodedData = jsonDecode(storedData);

      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey("userID")) {
        final loginResponse = LoginResponse.fromJson(decodedData);
        return loginResponse;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<TrackFeedbackResponse> trackFeedback(String trackId) async {
    try {
      final token = await getToken();
      if (token == null) {
        return TrackFeedbackResponse(
          isSuccess: false,
          statusCode: 401,
          data: null,
          error: 'No token found',
        );
      }
      print('Before');
      final response = await _apiService.get(
        ApiUrl.trackFeedback(trackId),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'X-Api-Key': '072e71ab-a109-404d-ae9e-3978699d4f2e',
        },
      );

      print('After : ${response.data}');
      final resData = response.data;
      if (response.statusCode == 200) {
        return TrackFeedbackResponse.fromJson(resData);
      }
      return TrackFeedbackResponse(
        isSuccess: false,
        statusCode: response.statusCode ?? 404,
        data: null,
        error: response.data,
      );
    } catch (error) {
      return TrackFeedbackResponse(
        isSuccess: false,
        statusCode: 500,
        data: null,
        error: error.toString(),
      );
    }
  }

  Future<SubmitFeedbackResponse> submitFeedback(
      Map<String, dynamic> body) async {
    try {
      final user = await getUser();
      final token = await getToken();
      if (token == null) {
        return SubmitFeedbackResponse(
          isSuccess: false,
          statusCode: 401,
          data: null,
          error: 'No token found',
        );
      }
      final fullBody = {
        ...body,
        "contactEmail": user?.email,
        "externalUserId": user?.userId,
        "externalUserName": user?.name,
      };

      final response = await _apiService.post(
        ApiUrl.submitFeedback,
        data: fullBody,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'X-Api-Key': '2c059132-966b-4bc2-ab9f-f69e31eeb717',
        },
      );

      final resData = response.data;
      if (response.statusCode == 200) {
        return SubmitFeedbackResponse.fromJson(resData);
      }
      return SubmitFeedbackResponse(
        isSuccess: false,
        statusCode: response.statusCode ?? 404,
        data: null,
        error: response.data,
      );
    } catch (error) {
      return SubmitFeedbackResponse(
        isSuccess: false,
        statusCode: 500,
        data: null,
        error: error.toString(),
      );
    }
  }

  Future<List<AccountActivityModel>> getAccountActivity() async {
    try {
      final userId = await getUser();
      if (userId?.userId == null) {
        return [];
      }
      final response = await _apiService
          .get(ApiUrl.accountActivity(userId?.userId.toString() ?? ''));

      final resData = response.data;
      if (response.statusCode == 200) {
        if (resData is List) {
          final List<AccountActivityModel> accountActivityList =
              resData.map((x) => AccountActivityModel.fromJson(x)).toList();

          return accountActivityList;
        }
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        ApiUrl.login,
        data: {'email': email, 'password': password},
      );
      final resData = response.data;

      if (response.statusCode == 200) {
        if (resData['status'] == 'success' && resData['data'] != null) {
          final loginResponse = LoginResponse.fromJson(resData['data']);

          _storageService.setString(StorageConstants.savedEmail, email);
          _storageService.setString(StorageConstants.savedPassword, password);

          await _storageService.setString(
              StorageConstants.loginData, jsonEncode(loginResponse.toJson()));
          await _storageService.setString(
              StorageConstants.accessToken, loginResponse.token);

          final notificationRepo = NotificationRepositoryImpl();
          final fcmToken = await notificationRepo.getFCMToken();

          if (fcmToken != null && fcmToken.isNotEmpty) {
            await _storageService.setString('fcm_token', fcmToken);
            await updateDeviceID(loginResponse.userId, fcmToken);
          }

          return 'Login successful';
        } else if (resData['status'] == 'Failed') {
          return resData['message'] ?? 'Login failed';
        }
      }

      return _handleStatusCode(response.statusCode);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;
  }

  Future<void> signInWithApple() async {
    // final credential = await SignInWithApple.getAppleIDCredential(
    //   scopes: [
    //     AppleIDAuthorizationScopes.email,
    //     AppleIDAuthorizationScopes.fullName,
    //   ],
    // );

    // send credential.identityToken or credential.authorizationCode to backend
  }

  Future<String> socialLogin(String provider, String accessToken) async {
    try {
      final response = await _apiService.post(
        ApiUrl.socialLogin,
        data: {'provider': provider, 'accessToken': accessToken},
      );
      final resData = response.data;

      if (response.statusCode == 200) {
        if (resData['status'] == 'success' && resData['data'] != null) {
          final loginResponse = LoginResponse.fromJson(resData['data']);

          await _storageService.setString(
              StorageConstants.loginData, jsonEncode(loginResponse.toJson()));
          await _storageService.setString(
              StorageConstants.accessToken, loginResponse.token);

          final notificationRepo = NotificationRepositoryImpl();
          final fcmToken = await notificationRepo.getFCMToken();

          if (fcmToken != null && fcmToken.isNotEmpty) {
            await _storageService.setString('fcm_token', fcmToken);
            await updateDeviceID(loginResponse.userId, fcmToken);
          }

          return 'Login successful';
        } else if (resData['status'] == 'Failed') {
          return resData['message'] ?? 'Login failed';
        }
      }

      return _handleStatusCode(response.statusCode);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> updateDeviceID(int userId, String deviceToken) async {
    try {
      final response = await _apiService.post(
        ApiUrl.updateDeviceTokenUrl, // ✅ Ensure this is the correct endpoint
        data: {
          'userId': userId,
          'deviceToken': deviceToken,
        },
      );

      if (response.statusCode == 200) {
        return 'successful';
      }

      return _handleStatusCode(response.statusCode);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<RegisterResponse?> register({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    String? stateOfOrigin,
    String? lga,
    String? placeOfBirth,
    String? nationality,
    String? stateOfResidence,
    String? lgaResidence,
    String? city,
    String? homeAddress,
    required String phone,
    required String email,
    String? username,
    int? referralCode,
  }) async {
    try {
      final data = {
        "firstName": firstName,
        "lastName": lastName,
        "weight": 0,
        "dateOfBirth": '${dateOfBirth}T00:00:00.359Z',
        "stateOfOrigin": stateOfOrigin,
        "lga": lga,
        "placeOfBirth": placeOfBirth,
        "nationality": nationality,
        "username": username,
        "contact": {
          "stateOfResidence": stateOfResidence,
          "lgaResidence": lgaResidence,
          "city": city,
          "homeAddress": homeAddress,
          "phone": phone,
          "email": email,
        },
        if (referralCode != null) "reffererId": referralCode,
      };

      final response = await _apiService.post(
        ApiUrl.registerUrl,
        data: data,
      );

      if (response.statusCode == 200 && response.data != null) {
        return RegisterResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      // 👇 unwrap backend error response
      if (e.response != null && e.response?.data != null) {
        final errorJson = e.response?.data;

        try {
          final result = RegisterResponse.fromJson(errorJson);
          return result; // you’ll get errorData here
        } catch (_) {
          // fallback if parsing fails
          return RegisterResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode ?? 0,
            message: e.response?.statusMessage,
          );
        }
      } else {
        return RegisterResponse(
          isSuccess: false,
          statusCode: 0,
          message: e.message,
        );
      }
    } catch (error) {
      return RegisterResponse(
        isSuccess: false,
        statusCode: 0,
        message: error.toString(),
      );
    }
  }

  Future<List<NationalityData>> fetchNationality() async {
    try {
      final response = await _apiService.get(
        'https://api.greenzonetechnologies.com.ng/Connectedhealthonboarding/api/employee/nationality/list',
        headers: {
          'accept': '*/*', // Matching the cURL request
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];

        if (data.isEmpty) return [];

        final nationalityList =
            data.map((e) => NationalityData.fromJson(e)).toList();

        await _storageService.setString(
          StorageConstants.nationalityData,
          jsonEncode(data),
        );

        return nationalityList;
      } else {
        throw Exception('Failed to fetch state: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching state: $error');
    }
  }

  Future<String> photoUpdate(int patientId, String pictureUrl) async {
    try {
      final response = await _apiService.put(
        ApiUrl.uploadProfileUrl, // ✅ Ensure this is the correct endpoint
        data: {
          'patientId': patientId,
          'pictureUrl': pictureUrl,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'successful';
      }

      return _handleStatusCode(response.statusCode);
    } catch (error) {
      return _handleError(error);
    }
  }

  // Future<String> otpSendUrl(String email) async {
  //   try {
  //     final response = await _apiService.post(
  //       ApiUrl.otpSendUrl + email,
  //     );
  //     if (response.statusCode == 200 && response.data != null) {
  //       return 'successful';
  //     } else {
  //       return _handleStatusCode(response.statusCode);
  //     }
  //   } catch (error) {
  //     return _handleError(error);
  //   }
  // }
  Future<String> otpSendUrl({
    String? userId,
    OTPChannel? sendChannel,
    String? email,
  }) async {
    try {
      final url = email == null
          ? ApiUrl.otpSendUrlWithChannel(userId ?? '', sendChannel?.name ?? '')
          : ApiUrl.otpSendUrl(email);
      final response = await _apiService.post(
        url,
      );
      // print('Url: $url');
      // print('Response: ${response.data}');
      // Check if the status code is 200 and the response body has a failure code
      if (response.statusCode == 200 && response.data != null) {
        if (response.data['code'] == 4) {
          // Return the failure message from the response
          return 'Failed: ${response.data['message']}';
        } else {
          // Return success if no failure code is present
          return 'successful';
        }
      } else {
        // If the status code is not 200, handle it as a different error
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> createPasswordUrl(
      String email, String password, String confirmPassword) async {
    try {
      final response = await _apiService.post(
        ApiUrl.createPasswordUrl,
        data: {
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final loginResponse = LoginResponse.fromJson(response.data['data']);

        await _storageService.setString(
            StorageConstants.loginData, jsonEncode(loginResponse.toJson()));
        await _storageService.setString(
            StorageConstants.accessToken, loginResponse.token);

        // 🔁 Get FCM token from NotificationRepositoryImpl
        final notificationRepo = NotificationRepositoryImpl();
        final fcmToken = await notificationRepo.getFCMToken();

        if (fcmToken != null && fcmToken.isNotEmpty) {
          await _storageService.setString('fcm_token', fcmToken);
          await updateDeviceID(loginResponse.userId, fcmToken);
        }

        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  // Future<String> validateOtpUrl(String email, String otp) async {
  //   try {
  //     final response = await _apiService.get(
  //       ApiUrl.verifyOTPPostUrlForAfterReg(otp, email),
  //     );

  //     if (response.statusCode == 200 && response.data != null) {
  //       if (response.data == true) {
  //         return 'Otp successful';
  //       } else {
  //         return 'Invalid OTP entered';
  //       }
  //     } else {
  //       return _handleStatusCode(response.statusCode);
  //     }
  //   } catch (error) {
  //     return _handleError(error);
  //   }
  // }
  Future<String> validateOtpUrl(String email, String otp) async {
    try {
      final response = await _apiService.get(
        ApiUrl.verifyOTPPostUrlForAfterReg(otp, email),
      );

      if (response.statusCode == 200 && response.data != null) {
        // If the response data is a boolean indicating success/failure
        if (response.data == true) {
          return 'OTP successful';
        } else if (response.data == false) {
          return 'Invalid OTP entered';
        } else {
          // If the response.data doesn't match expected values, handle as unexpected
          return 'Unexpected response data';
        }
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<Map<String, dynamic>> uploadProfileUrl(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'imageFile': await MultipartFile.fromFile(
          imageFile.path,
          filename: basename(imageFile.path),
        ),
      });

      final response = await _apiService.post(
        ApiUrl.imageUploadUrl,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data;
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

  Future<String> forgotPasswordUrl(
      String email, String otp, String password, String confirmPassword) async {
    try {
      final response =
          await _apiService.post(ApiUrl.forgetPasswordPostUrl, data: {
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "otp": otp
      });

      if (response.statusCode == 200 && response.data != null) {
        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> resetPasswordUrl(
      String email, String oldPassword, String password) async {
    try {
      final response =
          await _apiService.post(ApiUrl.resetPasswordPostUrl, data: {
        "email": email,
        "oldPassword": oldPassword,
        "newPassword": password,
      });

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;

        // Check if API returned failure inside body
        if (data is Map && data['status'] == 'Failed') {
          return data['message'] ?? 'Request failed';
        }

        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<bool> isUserLoggedIn() async {
    final token = await getToken(); // Check if token exists
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _storageService.remove(StorageConstants.loginData);
    await _storageService.remove(StorageConstants.accessToken);
  }

  Future<LoginResponse?> getStoredUser() async {
    final userDataString =
        _storageService.getString(StorageConstants.loginData);
    if (userDataString.isNotEmpty) {
      return LoginResponse.fromJson(jsonDecode(userDataString));
    }
    return null;
  }

  Future<String?> getLoginData() async {
    return _storageService.getString(StorageConstants.loginData);
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
        final statusCode = response.statusCode;
        final data = response.data;

        // Optional: log server error response

        // If you expect a message from the server
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          return data['message'];
        }

        return _handleStatusCode(statusCode);
      } else {
        return 'Network error. Please check your connection.';
      }
    }

    return 'An unknown error occurred.';
  }
}

// final authServiceProvider = Provider<AuthService>((ref) {
//   final apiService = ref.watch(apiServiceProvider);
//   final storageService = ref.watch(storageServiceProvider);
//   return AuthService(apiService, storageService);
// });

// final AuthServiceProvider = Provider<AuthService>((ref) {
//   final apiService =
//       ref.watch(apiServiceProvider); // Get ApiService from Provider
//   final storageService =
//       ref.watch(storageServiceProvider); // Get StorageService from Provider
//   return AuthService(apiService, storageService);
// });
