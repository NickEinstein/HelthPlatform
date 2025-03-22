import 'package:dio/dio.dart';
import 'package:greenzone_medical/src/services/api_service.dart';

class AuthService extends ApiService {
  Future<Response> signIn(String url, dynamic data) async {
    final res = await post(url, data: data);
    return res;
  }
}
