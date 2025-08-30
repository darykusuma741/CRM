import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../models/checkdeviceapproval/check_device_approval_parameter.dart';
import '../models/checkdeviceapproval/check_device_approval_response.dart';
import '../models/checkdeviceexist/check_device_exist_parameter.dart';
import '../models/checkdeviceexist/check_device_exist_response.dart';
import '../models/employeebaseduser/employee_based_user_parameter.dart';
import '../models/employeebaseduser/employee_based_user_response.dart';
import '../models/getuserid/get_user_id_parameter.dart';
import '../models/getuserid/get_user_id_response.dart';
import '../models/getuserlist/get_user_list_parameter.dart';
import '../models/getuserlist/get_user_list_response.dart';
import '../models/login/login_parameter.dart';
import '../models/login/login_response.dart';
import '../models/registernewdevice/register_new_device_parameter.dart';
import '../models/registernewdevice/register_new_device_response.dart';
import '../models/userdetail/user_detail_parameter.dart';
import '../models/userdetail/user_detail_response.dart';
import '../remotedatasources/userremotedatasource/user_remote_data_source.dart';
import '../repositories/user_repository.dart';

class DefaultUserRepository implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  DefaultUserRepository({
    required this.userRemoteDataSource
  });

  @override
  FutureProcessing<LoadDataResult<LoginResponse>> login(LoginParameter loginParameter) {
    return userRemoteDataSource.login(loginParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<GetUserListResponse>> getUserList(GetUserListParameter getUserListParameter) {
    return userRemoteDataSource.getUserList(getUserListParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<GetUserIdResponse>> getUserId(GetUserIdParameter getUserIdParameter) {
    return userRemoteDataSource.getUserId(getUserIdParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CheckDeviceApprovalResponse>> checkDeviceApproval(CheckDeviceApprovalParameter checkDeviceApprovalParameter) {
    return userRemoteDataSource.checkDeviceApproval(checkDeviceApprovalParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CheckDeviceExistResponse>> checkDeviceExist(CheckDeviceExistParameter checkDeviceExistParameter) {
    return userRemoteDataSource.checkDeviceExist(checkDeviceExistParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<RegisterNewDeviceResponse>> registerNewDevice(RegisterNewDeviceParameter registerNewDeviceParameter) {
    return userRemoteDataSource.registerNewDevice(registerNewDeviceParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<UserDetailResponse>> userDetail(UserDetailParameter userDetailParameter) {
    return userRemoteDataSource.userDetail(userDetailParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<EmployeeBasedUserResponse>> employeeBasedUser(EmployeeBasedUserParameter employeeBasedUserParameter) {
    return userRemoteDataSource.employeeBasedUser(employeeBasedUserParameter).mapToLoadDataResult();
  }
}