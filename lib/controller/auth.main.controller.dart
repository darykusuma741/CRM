import 'package:crm/common/components/my_snack_bar.dart';
import 'package:crm/common/helper/dio_error_handler.dart';
import 'package:crm/data/service/auth.service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthMainController extends GetxController {
  final AuthService authService = AuthService();

  Future login({required String email, required String password}) async {
    try {
      await authService.login(email: email, password: password);
      // if (resultUsers?.token == null) throw 'Incorrect email or password.';
      // await LocalStorage.setToken(token: resultUsers!.token!);
      // await _saveUser(resultUsers);
      // currentUser.value = resultUsers;
      // return true;
    } on DioException catch (e) {
      final message = DioErrorHandler.handle(e);
      MySnackBar.error(Get.context!, title: 'Login Failed', subTitle: message);
    } catch (e) {
      MySnackBar.error(Get.context!, title: 'Login Failed', subTitle: e.toString());
    }
  }
}
