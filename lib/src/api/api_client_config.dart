import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';

import 'api_response.dart';
import 'app_endpoints.dart';
import 'bad_certificate_fixer.dart';
import 'default_time_response_interceptor.dart';
import 'error_handler.dart';
import 'form_data_interceptor.dart';
import 'local_data/local_data.dart';

class CustomHeaders {
  static const removeEmptyStringsList = 'RemoveEmptyStringsList';
  static const removeEmptyStrings = 'RemoveEmptyStrings';
  static const removeNullValues = 'RemoveNullValues';
  static const removeEmptyLists = 'RemoveEmptyLists';

  static const all = [
    removeEmptyStringsList,
    removeEmptyStrings,
    removeNullValues,
    removeEmptyLists,
  ];
}

class BackendService {
  final Dio _dio;
  final String? otherBaseUrl;
  final bool jsonEncodeAllData;
  final bool shouldLog;
  final String? token;

  BackendService(
    this._dio, {
    this.otherBaseUrl,
    this.token,
    this.shouldLog = false,
    this.jsonEncodeAllData = true,
  }) {
    initializeDio();
  }

  void initializeDio() {
    //
    _dio.options = BaseOptions(
      baseUrl: otherBaseUrl ?? AppEndpoints.baseUrl,
      connectTimeout: const Duration(milliseconds: 50000),
      receiveTimeout: const Duration(milliseconds: 50000),
    );

    _dio.options.baseUrl = otherBaseUrl ?? AppEndpoints.baseUrl;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: executeCustomHeaders,
      ),
    );

    _dio.interceptors.addAll([
      // DefaultAPIInterceptor(dio: _dio),
      RetryInterceptor(
        dio: dio,
        // logPrint: talker.log,
        retries: 3,
        retryDelays: [
          const Duration(seconds: 2),
          const Duration(seconds: 4),
          const Duration(seconds: 6),
        ],
      ),
    ]);
    fixBadCertificate(dio: dio);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: authRequestInterceptors,
      ),
    );
    if (kDebugMode) {
      _dio.interceptors.add(TimeResponseInterceptor());

      _dio.interceptors.add(FormDataInterceptor());
      // _dio.interceptors.add(
      //   TalkerDioLogger(
      //     talker: talker,
      //     settings: const TalkerDioLoggerSettings(
      //       printRequestHeaders: true,
      //       printResponseHeaders: false,
      //       printResponseData: true,
      //       printResponseMessage: true,
      //     ),
      //   ),
      // );
    }
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: jsonRequestInterceptor,
        onResponse: (response, handler) {
          if (response.data is Map) {
            if (response.data['status'] == 'Access_Denied') {
              handler.next(response = Response(
                data: apiResponse(
                  message: response.data['message'],
                ),
                statusCode: 401,
                requestOptions: response.requestOptions,
              ));
              return;
            }
            if (response.data['status'] != 'success') {
              handler.next(response = Response(
                data: apiResponse(
                  message: response.data['message'],
                ),
                statusCode: 400,
                requestOptions: response.requestOptions,
              ));
              return;
            }
          }
          handler.next(response);
        },
      ),
    );
  }

  void jsonRequestInterceptor(
    RequestOptions options,
    RequestInterceptorHandler requestInterceptorHandler,
  ) {
    if (jsonEncodeAllData && options.data != null && options.data is Map) {
      options.data = jsonEncode(options.data);
      options.headers.addAll({'Content-Type': 'application/json'});
    }

    for (var i in CustomHeaders.all) {
      options.headers.remove(i);
    }

    return requestInterceptorHandler.next(options);
  }

  void executeCustomHeaders(
    RequestOptions options,
    RequestInterceptorHandler requestInterceptorHandler,
  ) {
    options.headers.addAll({CustomHeaders.removeNullValues: true});

    if (options.headers.containsKey(CustomHeaders.removeNullValues)) {
      if (options.data != null && options.data is Map) {
        options.data.removeWhere((key, value) => value == null);
      }
    }

    if (options.headers.containsKey(CustomHeaders.removeEmptyLists)) {
      if (options.data != null && options.data is Map) {
        options.data
            .removeWhere((key, value) => value is List && value.isEmpty);
      }
    }

    if (options.headers.containsKey(CustomHeaders.removeEmptyStrings)) {
      if (options.data != null && options.data is Map) {
        options.data
            .removeWhere((key, value) => value is String && value.isEmpty);
      }
    }

    if (options.headers.containsKey(CustomHeaders.removeEmptyStringsList)) {
      if (options.data != null && options.data is Map) {
        options.data.removeWhere((key, value) =>
            value is List &&
            value.every((element) => element is String && element.isEmpty));
      }
    }

    // if (jsonEncodeAllData && options.data != null && options.data is Map) {
    // options.data = jsonEncode(options.data);
    // options.headers.addAll({'Content-Type': 'application/json'});
    // }

    return requestInterceptorHandler.next(options);
  }

  void authRequestInterceptors(
    RequestOptions options,
    RequestInterceptorHandler requestInterceptorHandler,
  ) {
    final token = this.token ?? LocalData.token;
    if (token != null) {
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    return requestInterceptorHandler.next(options);
  }

  Dio get dio => _dio;

  // Returns the same instance of dio throughout the application
  BackendService clone() => BackendService(_dio);

  dynamic runCall(Future<Response> data) async {
    try {
      return await data;
    } on DioException catch (e) {
      return handleError(e);
    } catch (e) {
      log('Something happened $e');
      rethrow;
    }
  }
}
