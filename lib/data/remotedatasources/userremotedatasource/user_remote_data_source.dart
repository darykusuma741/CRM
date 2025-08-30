import '../../../../common/processing/future_processing.dart';
import '../../models/checkdeviceapproval/check_device_approval_parameter.dart';
import '../../models/checkdeviceapproval/check_device_approval_response.dart';
import '../../models/checkdeviceexist/check_device_exist_parameter.dart';
import '../../models/checkdeviceexist/check_device_exist_response.dart';
import '../../models/employeebaseduser/employee_based_user_parameter.dart';
import '../../models/employeebaseduser/employee_based_user_response.dart';
import '../../models/getuserid/get_user_id_parameter.dart';
import '../../models/getuserid/get_user_id_response.dart';
import '../../models/getuserlist/get_user_list_parameter.dart';
import '../../models/getuserlist/get_user_list_response.dart';
import '../../models/login/login_parameter.dart';
import '../../models/login/login_response.dart';
import '../../models/registernewdevice/register_new_device_parameter.dart';
import '../../models/registernewdevice/register_new_device_response.dart';
import '../../models/userdetail/user_detail_parameter.dart';
import '../../models/userdetail/user_detail_response.dart';

abstract class UserRemoteDataSource {
  FutureProcessing<LoginResponse> login(LoginParameter loginParameter);
  FutureProcessing<GetUserListResponse> getUserList(GetUserListParameter getUserListParameter);
  FutureProcessing<GetUserIdResponse> getUserId(GetUserIdParameter getUserIdParameter);
  FutureProcessing<CheckDeviceApprovalResponse> checkDeviceApproval(CheckDeviceApprovalParameter checkDeviceApprovalParameter);
  FutureProcessing<CheckDeviceExistResponse> checkDeviceExist(CheckDeviceExistParameter checkDeviceExistParameter);
  FutureProcessing<RegisterNewDeviceResponse> registerNewDevice(RegisterNewDeviceParameter registerNewDeviceParameter);
  FutureProcessing<UserDetailResponse> userDetail(UserDetailParameter userDetailParameter);
  FutureProcessing<EmployeeBasedUserResponse> employeeBasedUser(EmployeeBasedUserParameter employeeBasedUserParameter);
}