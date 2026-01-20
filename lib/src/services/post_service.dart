// import 'package:greenzone_medical/src/app_pkg.dart';

// class PostService {
//   final ApiService _apiService;
//   final StorageService _storageService;

//   PostService(this._apiService, this._storageService);

//   /// Retrieves the stored authentication token.
//   Future<String?> getToken() async {
//     return _storageService.getString(StorageConstants.accessToken);
//   }

//   Future<String?> getUserId() async {
//     try {
//       final storedData = _storageService.getString(StorageConstants.loginData);

//       if (storedData.isEmpty) {
//         debugPrint("⚠️ No access token found in storage.");
//         return null;
//       }

//       // Decode JSON safely
//       final decodedData = jsonDecode(storedData);
//       // print('Login Data: $decodedData');

//       if (decodedData is Map<String, dynamic> &&
//           decodedData.containsKey("userID")) {
//         return decodedData["userID"].toString(); // Ensure it's a string
//       } else {
//         debugPrint("⚠️ userID not found in stored data: $decodedData");
//         return null;
//       }
//     } catch (error) {
//       debugPrint(" Error decoding userID: $error");
//       return null;
//     }
//   }

//   Future getUserPosts() async {
//     final result = await _apiService.get(ApiUrl.friendsPost);

//     if (result.statusCode == 200) {
//       return result.data['posts'] as List';
//     } else {
//       return null;
//     }
//   }
// }
