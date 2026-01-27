import 'package:greenzone_medical/src/features/doctors/models/doctor_available_response.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class DoctorService {
  final ApiService _apiService;
  final StorageService _storageService;

  DoctorService(this._apiService, this._storageService);

  Future<String?> getToken() async {
    return _storageService.getString(StorageConstants.accessToken);
  }

  Future<List<DoctorAvailableResponse>> getDoctorAvailableTimes(
    String doctorId,
  ) async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.getDoctorAvailableTimes(doctorId),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.data);
      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final List<dynamic> data = response.data;

        if (data.isEmpty) {
          debugPrint('⚠️ Not available.');
          return [];
        }

        final doctorAvailableTimes =
            data.map((e) => DoctorAvailableResponse.fromJson(e)).toList();

        return doctorAvailableTimes;
      } else {
        debugPrint(' Failed to fetch articles: ${response.statusCode}');
        throw Exception('Failed to fetch articles: ${response.statusCode}');
      }
    } catch (error, s) {
      debugPrint(' Error fetching articles: $error');
      print(s);
      return [];
    }
  }
}
