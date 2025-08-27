import 'package:crm/data/service/base_service.dart';
import 'package:crm/data/service/device.service.dart';

class AuthService extends BaseService {
  Future login({required String email, required String password}) async {
    final devicewInfo = await DeviceService.getDeviceInfo();
    final result = await dio.post('user/login', data: {
      "login": email,
      "password": password,
      ...devicewInfo,
    });
    if (result.statusCode == 401) {
      // return UsersModel.fromJson(result.data['data']);
    }
    return null;
  }
}
