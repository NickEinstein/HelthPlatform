import 'package:greenzone_medical/src/features/hmo/models/hmo_model.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class HmoService {
  final ApiService _apiService;
  final StorageService _storageService;

  HmoService(this._apiService, this._storageService);

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

  Future<List<HmoModel>> fetchHMOByUserId() async {
    try {
      final token = await getToken();
      final userId = await getUserId();

      if (userId == null || token == null || token.isEmpty) {
        debugPrint('⚠️ No access token found.');
        return [];
      }

      final response = await _apiService.get(
        ApiUrl.userHmo(userId),
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

        final hmoList = data.map((e) => HmoModel.fromJson(e)).toList();

        return hmoList;
      } else {
        debugPrint(' Failed to fetch user HMO: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      debugPrint(' Error fetching user HMO: $error');
      return [];
    }
  }
}
