import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../model/article_response.dart';
import '../model/login_response.dart';

class AuthService {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthService(this._apiService, this._storageService);

  Future<String> login(String email, String password) async {

    
    try {
      // print('Email: $email');
      // print('Password: $password');
      final response = await _apiService.post(
        ApiUrl.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 && response.data != null) {
        final loginResponse = LoginResponse.fromJson(response.data['data']);

        // Save full user data and token
        await _storageService.setString(
            StorageConstants.loginData, jsonEncode(loginResponse.toJson()));
        await _storageService.setString(
            StorageConstants.accessToken, loginResponse.token);

        return 'Login successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> register(String email, String password) async {
    try {
      final response = await _apiService.post(
        ApiUrl.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 && response.data != null) {
        final loginResponse = LoginResponse.fromJson(response.data['data']);

        // Save full user data and token
        await _storageService.setString(
            StorageConstants.loginData, jsonEncode(loginResponse.toJson()));
        await _storageService.setString(
            StorageConstants.accessToken, loginResponse.token);

        return 'Login successful';
      } else {
        return _handleStatusCode(response.statusCode);
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<String> otpSendUrl(String email) async {
    try {
      final response = await _apiService.post(
        ApiUrl.otpSendUrl + email,
      );

      if (response.statusCode == 200 && response.data != null) {
        final loginResponse = LoginResponse.fromJson(response.data['data']);

        // Save full user data and token
        await _storageService.setString(
            StorageConstants.loginData, jsonEncode(loginResponse.toJson()));
        await _storageService.setString(
            StorageConstants.accessToken, loginResponse.token);

        return 'Login successful';
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
