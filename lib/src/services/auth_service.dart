import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../model/login_response.dart';
import '../model/nationality_model.dart';

class AuthService {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthService(this._apiService, this._storageService);

  Future<String> login(String email, String password) async {

   
    try {
       print(email);
    print(password);
      final response = await _apiService.post(
        ApiUrl.login,
        data: {'email': email, 'password': password},
      );


      if (response.statusCode == 200) {
        if (resData['status'] == 'success' && resData['data'] != null) {
          final loginResponse = LoginResponse.fromJson(resData['data']);
          _storageService.setString('saved_email', email);
          _storageService.setString('saved_password', password);

          await _storageService.setString(
              StorageConstants.loginData, jsonEncode(loginResponse.toJson()));
          await _storageService.setString(
              StorageConstants.accessToken, loginResponse.token);

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

  Future<String> register({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String stateOfOrigin,
    required String lga,
    required String placeOfBirth,
    required String nationality,
    required String stateOfResidence,
    required String lgaResidence,
    required String city,
    required String homeAddress,
    required String phone,
    required String email,
  }) async {
    try {
      final response = await _apiService.post(
        ApiUrl.registerUrl,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "weight": 0,
          "dateOfBirth": '${dateOfBirth}T00:00:00.359Z',
          "stateOfOrigin": stateOfOrigin,
          "lga": lga,
          "placeOfBirth": placeOfBirth,
          "nationality": nationality,
          "contact": {
            "stateOfResidence": stateOfResidence,
            "lgaResidence": lgaResidence,
            "city": city,
            "homeAddress": homeAddress,
            "phone": phone,
            "email": email,
          },
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        // otpSendUrl(email);
        return 'Register successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  // Future<List<StateData>> fetchState() async {
  //   try {
  //     final response = await _apiService.get(
  //       'https://edogoverp.com/Connectedhealthonboarding/api/employee/state-list',
  //       headers: {
  //         'accept': '*/*', // Matching the cURL request
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = response.data['data'] ?? [];

  //       if (data.isEmpty) return [];

  //       final stateList = data.map((e) => StateData.fromJson(e)).toList();

  //       await _storageService.setString(
  //         StorageConstants.stateData,
  //         jsonEncode(data),
  //       );

  //       return stateList;
  //     } else {
  //       throw Exception('Failed to fetch state: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     throw Exception('Error fetching state: $error');
  //   }
  // }

  Future<List<NationalityData>> fetchNationality() async {
    try {
      final response = await _apiService.get(
        'https://edogoverp.com/Connectedhealthonboarding/api/employee/nationality/list',
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

  Future<String> otpSendUrl(String email) async {
    try {
      final response = await _apiService.post(
        ApiUrl.otpSendUrl + email,
      );

      if (response.statusCode == 200 && response.data != null) {
        return 'successful';
      } else {
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
          'confirmPassword': confirmPassword
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final loginResponse = LoginResponse.fromJson(response.data['data']);

        // Save full user data and token
        await _storageService.setString(
            StorageConstants.loginData, jsonEncode(loginResponse.toJson()));
        await _storageService.setString(
            StorageConstants.accessToken, loginResponse.token);

        return 'successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> validateOtpUrl(String email, String otp) async {
    try {
      final response = await _apiService.get(
        ApiUrl.verifyOTPPostUrlForAfterReg(otp, email),
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data == true) {
          return 'Otp successful';
        } else {
          return 'Invalid OTP entered';
        }
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
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

  Future<String?> getToken() async {
    return _storageService.getString(StorageConstants.accessToken);
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
