import 'package:dio/dio.dart';
import 'package:crm/data/model/location_geocoding.model.dart';

class LocationService {
  static const String _apiKey = 'AIzaSyANlIK3m1olWVgVwJkECAed0ht5B3NvY5M';
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json';

  final Dio _dio = Dio();

  // Fungsi untuk mencari alamat berdasarkan teks
  Future<List<LocationGeocodingModel>> searchAddress(String query) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'address': query,
          'input': query,
          'key': _apiKey,
          // 'types': 'address',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final results = data['results'] as List;

        // Ambil daftar alamat dari hasil pencarian
        return results.map<LocationGeocodingModel>((result) => LocationGeocodingModel.fromJson(result)).toList();
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<String?> getAddress(double latitude, double longitude) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'latlng': '$latitude,$longitude',
          'key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final results = data['results'] as List;
        // Ambil alamat pertama dari hasil reverse geocoding
        if (results.isNotEmpty) {
          return results[0]['formatted_address'] as String;
        } else {
          throw Exception('Tidak ada hasil yang ditemukan');
        }
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<double?> getElevation(double lat, double lng) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/elevation/json',
        queryParameters: {
          'locations': '$lat,$lng',
          'key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['results'][0]['elevation'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class LocationFormat {}
