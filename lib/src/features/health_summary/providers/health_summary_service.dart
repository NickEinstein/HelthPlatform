import 'package:greenzone_medical/src/utils/packages.dart';

class HealthSummaryService {
  final ApiService _apiService;
  final StorageService _storageService;

  HealthSummaryService(this._apiService, this._storageService);

  /// Retrieves the stored authentication token.
  Future<String?> getToken() async {
    return _storageService.getString(StorageConstants.accessToken);
  }

  Future<String?> getUserId() async {
    try {
      final storedData = _storageService.getString(StorageConstants.loginData);

      if (storedData.isEmpty) {
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

  Future<List<String>> getTestStatistics() async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      final response = await _apiService.get(
        ApiUrl.getTestStatistics(userId!),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response);
      return [];
    } catch (e) {
      debugPrint(" Error fetching test statistics: $e");
      return [];
    }
  }

  Future<List<String>> getVitalsHistory() async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      final response = await _apiService.get(
        ApiUrl.getVitalsHistory(userId!),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response);
      return [];
    } catch (e) {
      debugPrint(" Error fetching vitals history: $e");
      return [];
    }
  }

  Future<List<String>> getCurrentMedications() async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      final response = await _apiService.get(
        ApiUrl.getCurrentMedications(userId!),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response);
      return [];
    } catch (e) {
      debugPrint(" Error fetching current medications: $e");
      return [];
    }
  }
}
