import 'dart:io';

import 'package:crm/common/ext/future_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoHelper {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> getImeiCode() async {
    return "";
  }

  static Future<String> getDeviceId() async {
    if (Platform.isAndroid) {
      return _deviceInfoPlugin.androidInfo.map<String>(
        onMap: (value) => value.id
      );
    } else if (Platform.isIOS) {
      return _deviceInfoPlugin.iosInfo.map<String>(
        onMap: (value) => value.identifierForVendor.toEmptyStringNonNull
      );
    } else {
      return "";
    }
  }

  static Future<String> getDeviceName() async {
    return _deviceInfoPlugin.androidInfo.map<String>(
      onMap: (value) => value.name
    );
  }

  static Future<String> getDeviceModel() async {
    return _deviceInfoPlugin.androidInfo.map<String>(
      onMap: (value) => value.model
    );
  }
}