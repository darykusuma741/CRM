import 'package:crm/common/ext/future_ext.dart';
import 'package:crm/common/ext/login_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/common_constants.dart';
import '../load_data_result/load_data_result.dart';
import '../login_data.dart';

class LoginHelper {
  // static final SharedPreferences _sharedPreferences = sl();

  static LoginData? memoryLoginData;

  static Future<LoadDataResult<void>> saveLoginData(LoginData loginData, {bool saveInData = true}) async {
    // if (saveInData) {
    //   memoryLoginData = null;
    //   return _sharedPreferences.setString(
    //     const CommonConstants().settingHiveTableKeyLogin,
    //     loginData.toJsonString()
    //   ).getLoadDataResult();
    // } else {
    //   Future<void> writeMemoryLoginData() async {
    //     memoryLoginData = loginData;
    //   }
    //   return await writeMemoryLoginData().getLoadDataResult();
    // }
    if (saveInData) {
      memoryLoginData = null;
      var box = Hive.box(CommonConstants.settingHiveTable);
      return await box.put(CommonConstants.settingHiveTableKeyLogin, loginData.toJsonString()).getLoadDataResult();
    } else {
      Future<void> writeMemoryLoginData() async {
        memoryLoginData = loginData;
      }
      return await writeMemoryLoginData().getLoadDataResult();
    }
  }

  static LoginData? getLoginData() {
    // try {
    //   var jsonString = _sharedPreferences.get(const CommonConstants().settingHiveTableKeyLogin) as String?;
    //   if (jsonString.isEmptyString) {
    //     if (memoryLoginData != null) {
    //       return memoryLoginData;
    //     } else {
    //       return null;
    //     }
    //   } else {
    //     return jsonString!.toLoginData();
    //   }
    // } catch (e) {
    //   return null;
    // }
    try {
      var box = Hive.box(CommonConstants.settingHiveTable);
      var jsonString = box.get(CommonConstants.settingHiveTableKeyLogin) as String?;
      if (jsonString.isEmptyString) {
        if (memoryLoginData != null) {
          return memoryLoginData;
        } else {
          return null;
        }
      } else {
        return jsonString!.toLoginData();
      }
    } catch (e) {
      return null;
    }
  }

  static Future<LoadDataResult<void>> deleteLoginData() async {
    // memoryLoginData = null;
    // return _sharedPreferences.remove(
    //   const CommonConstants().settingHiveTableKeyLogin
    // ).getLoadDataResult();
    memoryLoginData = null;
    var box = Hive.box(CommonConstants.settingHiveTable);
    return box.delete(CommonConstants.settingHiveTableKeyLogin).getLoadDataResult();
  }
}