import 'package:dio/dio.dart';

class DioErrorHandler {
  static String handle(DioException error) {
    try {
      final response = error.response;

      if (response != null && response.data != null) {
        // Coba baca dari response.data["message"]
        final data = response.data;
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          return data['message'];
        }
      }

      // Jika tidak ada message, fallback ke pesan dio
      return error.message ?? 'Unexpected error';
    } catch (_) {
      return 'Unknown error occurred';
    }
  }
}
