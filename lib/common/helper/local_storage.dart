import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  static Future setToken({required String token}) async {
    return await _storage.write(key: 'access_token', value: token);
  }

  static Future removeToken() async {
    return await _storage.delete(key: 'access_token');
  }

  static Future setListQuickAccessById({required List<int> listId}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('quick_access_id_select', listId.map((e) => e.toString()).toList());
  }

  static Future<List<int>> getListQuickAccessById() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? getList = prefs.getStringList('quick_access_id_select');
    if (getList != null) {
      if (getList.isEmpty) {
        return [];
      } else {
        return getList.map((e) => int.parse(e)).toList();
      }
    } else {
      return [];
    }
  }

  static Future<bool> removeListQuickAccess() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('quick_access_id_select');
  }
}
