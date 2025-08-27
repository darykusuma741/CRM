import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:crm/common/helper/local_storage.dart';
import 'package:crm/config.dart';

class DioClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ConfigEnvironments.getEnvironments()['url']!,
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
        headers: {
          "X-Client-ID": "client_26",
          "Content-Type": "application/json",
        },
      ),
    );

    // Add interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await LocalStorage.getToken(); // implementasi token dari local storage
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      // onResponse: (response, handler) {
      //   return handler.next(response);
      // },
      // onError: (DioException e, handler) {
      //   if (e.response?.statusCode == 401) {
      //     // Handle unauthorized (token expired or invalid)
      //     Get.snackbar('Unauthorized', 'Silakan login kembali');
      //   }
      //   return handler.next(e);
      // },
    ));

    // Log if debug mode
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }

    return dio;
  }
}
