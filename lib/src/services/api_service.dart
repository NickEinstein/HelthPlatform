import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../app_pkg.dart';

class ApiService {
 late Dio dio;
  ApiService() {
    print('api service call constructor');
    final options = BaseOptions(
      baseUrl: 'https://api.pub.dev',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    dio = Dio(options);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          String? accessToken=SharedPreferencesService.instance.getString(StorageConstants.accessToken);
          if(accessToken!=null){
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          if(options.method!='get'){
            EasyLoading.show(status: 'loading...');
          }
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          EasyLoading.dismiss();
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          print('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
          return handler.next(error);
        },
      ),
    );
  }

 Future<Response<T>> get<T>(
     String path, {
       Map<String, dynamic>? queryParameters,
       Map<String, dynamic>? headers,
     }) async {
   try {
     final options = Options(headers: headers);
     final response = await dio.get<T>(path, queryParameters: queryParameters, options: options);
     return _handleResponse<T>(response);
   } catch (error) {
     throw _handleError(error);
   }
 }

 Future<Response<T>> post<T>(
     String path, {
       dynamic data,
       Map<String, dynamic>? headers,
     }) async {
   try {
     final options = Options(headers: headers);
     final response = await dio.post<T>(path, data: data, options: options);
     return _handleResponse<T>(response);
   } catch (error) {
     throw _handleError(error);
   }
 }

 Future<Response<T>> put<T>(
     String path, {
       dynamic data,
       Map<String, dynamic>? headers,
     }) async {
   try {
     final options = Options(headers: headers);
     final response = await dio.put<T>(path, data: data, options: options);
     return _handleResponse<T>(response);
   } catch (error) {
     throw _handleError(error);
   }
 }

 Future<Response<T>> delete<T>(
     String path, {
       Map<String, dynamic>? headers,
     }) async {
   try {
     final options = Options(headers: headers);
     final response = await dio.delete<T>(path, options: options);
     return _handleResponse<T>(response);
   } catch (error) {
     throw _handleError(error);
   }
 }

 Future<Response<T>> _handleResponse<T>(Response<T> response)async {
   if (response.statusCode == 200) {
     return response;
   } else {
     throw DioException(
       requestOptions: response.requestOptions,
       response: response,
       type: DioExceptionType.badResponse,
       error: 'HTTP ${response.statusCode}',
     );
   }
 }

 dynamic _handleError(error) {
   if (error is DioError) {
     if (error.response != null) {
       // Handle Dio specific errors with response here
       print('Dio Error Response: ${error.response!.statusCode} - ${error.response!.statusMessage}');
       print('Response Data: ${error.response!.data}');
       throw error;
     } else {
       // Handle Dio network errors here
       print('Dio Network Error: ${error.message}');
       throw error;
     }
   } else {
     // Handle other types of errors here
     print('Generic Error: $error');
     throw error;
   }
 }
}



// Example usage
// void main() async {
//   final apiService = ApiService();
//
//   try {
//     // GET request
//     final getResponse = await apiService.getData('https://jsonplaceholder.typicode.com/posts/1');
//     print('GET Response: ${getResponse.data}');
//
//     // POST request
//     final postData = {'title': 'foo', 'body': 'bar', 'userId': 1};
//     final postResponse = await apiService.postData('https://jsonplaceholder.typicode.com/posts', postData);
//     print('POST Response: ${postResponse.data}');
//
//     // PUT request
//     final putData = {'id': 1, 'title': 'foo', 'body': 'bar', 'userId': 1};
//     final putResponse = await apiService.putData('https://jsonplaceholder.typicode.com/posts/1', putData);
//     print('PUT Response: ${putResponse.data}');
//
//     // DELETE request
//     final deleteResponse = await apiService.deleteData('https://jsonplaceholder.typicode.com/posts/1');
//     print('DELETE Response: ${deleteResponse.data}');
//   } catch (e) {
//     print('Error: $e');
//   }
// }



class ApiService2 {
  final Dio _dio;

  ApiService2(this._dio);

  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final options = Options(headers: headers);
      final response = await _dio.get<T>('/$path', queryParameters: queryParameters, options: options);
      return _handleResponse<T>(response);
    } catch (error) {
      throw _handleError(error);
    }
  }

 Future<Response<T>> _handleResponse<T>(Response<T> response)async {
    if (response.statusCode == 200) {
      return response;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: 'HTTP ${response.statusCode}',
      );
    }
  }

  dynamic _handleError(error) {
    if (error is DioError) {
      if (error.response != null) {
        // Handle Dio specific errors with response here
        print('Dio Error Response: ${error.response!.statusCode} - ${error.response!.statusMessage}');
        print('Response Data: ${error.response!.data}');
        throw error;
      } else {
        // Handle Dio network errors here
        print('Dio Network Error: ${error.message}');
        throw error;
      }
    } else {
      // Handle other types of errors here
      print('Generic Error: $error');
      throw error;
    }
  }
}