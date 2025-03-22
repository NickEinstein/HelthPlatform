
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_pkg.dart';

class DependencyInjection {
  static Future<void> init() async {
  await  SharedPreferencesService.instance.init();
  }
}

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageServiceImpl();
});
final sharePrefProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  // Define your custom interceptor
  // dio.interceptors.add(CustomInterceptor());

  // Configure other Dio settings as needed
  dio.options.baseUrl = 'https://api.example.com'; // Your base URL

  return dio;
});

final apiServiceProvider2 = Provider<ApiService2>((ref) {
  final dio = ref.read(dioProvider);
  return ApiService2(dio);
});

//services
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
