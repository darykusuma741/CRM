import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

class DeviceService {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<Map<String, String>> getDeviceInfo() async {
    String deviceId = "";
    String deviceName = "";
    String deviceModel = "";
    try {
      if (Platform.isAndroid) {
        final info = await deviceInfoPlugin.androidInfo;
        deviceId = info.id; // kalau kosong, generate UUID
        deviceName = info.device;
        deviceModel = info.model;
      } else if (Platform.isIOS) {
        final info = await deviceInfoPlugin.iosInfo;
        deviceId = info.identifierForVendor ?? const Uuid().v4();
        deviceName = info.name;
        deviceModel = info.utsname.machine;
      } else {
        // fallback untuk web/desktop
        deviceId = const Uuid().v4();
        deviceName = "Unknown Device";
        deviceModel = "Unknown Model";
      }
    } catch (e) {
      print("==============================${e.toString()}==============================");
      deviceName = "Unknown Device";
      deviceModel = "Unknown Model";
    }

    return {
      "device_id": deviceId,
      "device_name": deviceName,
      "device_model": deviceModel,
    };
  }
}
