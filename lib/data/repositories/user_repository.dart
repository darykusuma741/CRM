import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../../data/models/checkdeviceapproval/check_device_approval_parameter.dart';
import '../../data/models/checkdeviceapproval/check_device_approval_response.dart';
import '../../data/models/checkdeviceexist/check_device_exist_parameter.dart';
import '../../data/models/checkdeviceexist/check_device_exist_response.dart';
import '../../data/models/employeebaseduser/employee_based_user_parameter.dart';
import '../../data/models/employeebaseduser/employee_based_user_response.dart';
import '../../data/models/getuserid/get_user_id_parameter.dart';
import '../../data/models/getuserid/get_user_id_response.dart';
import '../../data/models/getuserlist/get_user_list_parameter.dart';
import '../../data/models/getuserlist/get_user_list_response.dart';
import '../../data/models/login/login_parameter.dart';
import '../../data/models/login/login_response.dart';
import '../../data/models/registernewdevice/register_new_device_parameter.dart';
import '../../data/models/registernewdevice/register_new_device_response.dart';
import '../../data/models/userdetail/user_detail_parameter.dart';
import '../../data/models/userdetail/user_detail_response.dart';

abstract class UserRepository {
  FutureProcessing<LoadDataResult<LoginResponse>> login(LoginParameter loginParameter);
  FutureProcessing<LoadDataResult<GetUserListResponse>> getUserList(GetUserListParameter getUserListParameter);
  FutureProcessing<LoadDataResult<GetUserIdResponse>> getUserId(GetUserIdParameter getUserIdParameter);
  FutureProcessing<LoadDataResult<CheckDeviceApprovalResponse>> checkDeviceApproval(CheckDeviceApprovalParameter checkDeviceApprovalParameter);
  FutureProcessing<LoadDataResult<CheckDeviceExistResponse>> checkDeviceExist(CheckDeviceExistParameter checkDeviceExistParameter);
  FutureProcessing<LoadDataResult<RegisterNewDeviceResponse>> registerNewDevice(RegisterNewDeviceParameter registerNewDeviceParameter);
  FutureProcessing<LoadDataResult<UserDetailResponse>> userDetail(UserDetailParameter userDetailParameter);
  FutureProcessing<LoadDataResult<EmployeeBasedUserResponse>> employeeBasedUser(EmployeeBasedUserParameter employeeBasedUserParameter);
}