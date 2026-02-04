import 'package:greenzone_medical/src/features/ekiosk/data/model/drug_model.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class EKioskService {
  final ApiService _apiService;
  final StorageService _storageService;

  EKioskService(this._apiService, this._storageService);

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

  Future<String?> getUserType() async {
    try {
      final storedData = _storageService.getString(StorageConstants.loginData);

      if (storedData.isEmpty) {
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

  //

  Future<Map<String, List<DrugModel>>> getDrugs(String query) async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      if (token == null || token.isEmpty || userId == null) {
        debugPrint('⚠️ No access token found.');
        return {};
      }

      final response = await _apiService.get(
        ApiUrl.getDrugs(query),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 1)) {
        final data = response.data as Map<String, dynamic>;

        if (data.isEmpty) {
          debugPrint('⚠️ No apps found.');
          return {};
        }
        final result = <String, List<DrugModel>>{};
        for (final item in data.entries) {
          final key = item.key;
          final items = item.value['items'] as List<dynamic>;
          final drugList =
              items.map<DrugModel>((item) => DrugModel.fromJson(item)).toList();
          result[key] = drugList;
        }
        return result;
      } else {
        debugPrint(' Failed to fetch drugs: ${response.statusCode}');
        throw Exception('Failed to fetch drugs: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(' Error fetching drugs: $error');
      throw Exception('Error fetching drugs: $error');
    }
  }
}
