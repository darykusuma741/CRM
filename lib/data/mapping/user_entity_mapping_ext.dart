import 'package:crm/common/ext/response_wrapper_ext.dart';

import '../../common/error/message_error.dart';
import '../../common/responsewrapper/response_wrapper.dart';
import '../models/check_device_approval_result.dart';
import '../models/check_device_exist_result.dart';
import '../models/checkdeviceapproval/check_device_approval_response.dart';
import '../models/checkdeviceexist/check_device_exist_response.dart';
import '../models/employee.dart';
import '../models/employeebaseduser/employee_based_user_response.dart';
import '../models/getuserid/get_user_id_response.dart';
import '../models/getuserlist/get_user_list_response.dart';
import '../models/getuserlist/user.dart';
import '../models/login/login_response.dart';
import '../models/registernewdevice/register_new_device_response.dart';
import '../models/userdetail/user_detail_response.dart';

extension UserEntityMappingExt on ResponseWrapper {
  LoginResponse mapFromResponseToLoginResponse() {
    String token = ResponseWrapper(response["token"]).mapFromResponseToNonNullableString();
    return LoginResponse(
      token: token
    );
  }

  UserDetailResponse mapFromResponseToUserDetailResponse() {
    ResponseWrapper resUsersResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "ResUsers");
    var userDetailResponseList = resUsersResponseWrapper.mapFromResponseToList(
      (userResponse) => UserDetailResponse(
        id: ResponseWrapper(userResponse["id"]).mapFromResponseToNonNullableString(),
        name: ResponseWrapper(userResponse["name"]).mapFromResponseToNonNullableString(),
        login: ResponseWrapper(userResponse["login"]).mapFromResponseToNonNullableString(),
        email: ResponseWrapper(userResponse["email"]).mapFromResponseToNonNullableString(),
        imageUrl: ResponseWrapper(userResponse["image_url"]).mapFromResponseToNonNullableString(),
        base64Image: ResponseWrapper(userResponse["image_1920"]).mapFromResponseToNonNullableString(),
      )
    );
    return userDetailResponseList.first;
  }

  GetUserListResponse mapFromResponseToGetUserListResponse() {
    ResponseWrapper resUsersResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "ResUsers");
    var userList = resUsersResponseWrapper.mapFromResponseToList(
      (userResponse) => User(
        id: ResponseWrapper(userResponse["id"]).mapFromResponseToNonNullableString(),
        name: ResponseWrapper(userResponse["name"]).mapFromResponseToNonNullableString(),
        email: ResponseWrapper(userResponse["login"]).mapFromResponseToNonNullableString()
      )
    );
    return GetUserListResponse(
      userList: userList
    );
  }

  GetUserIdResponse mapFromResponseToGetUserIdResponse() {
    ResponseWrapper dataResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "ResUsers");
    List<dynamic> responseList = dataResponseWrapper.mapFromResponseToList(
      (response) => response
    );
    if (responseList.isEmpty) {
      throw MessageError(
        title: "User Not Found",
        message: "User is not found"
      );
    }
    dynamic getUserIdResponse = responseList.first;
    String currencySymbol = "";
    if (getUserIdResponse["company_id"] != null) {
      dynamic companyResponse = getUserIdResponse["company_id"];
      if (companyResponse["currency_id"] != null) {
        dynamic currencyResponse = companyResponse["currency_id"];
        if (currencyResponse["symbol"] != null) {
          currencySymbol = ResponseWrapper(currencyResponse["symbol"]).mapFromResponseToNonNullableString();
        }
      }
    }
    return GetUserIdResponse(
      userId: ResponseWrapper(getUserIdResponse["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(getUserIdResponse["name"]).mapFromResponseToNonNullableString(),
      email: ResponseWrapper(getUserIdResponse["login"]).mapFromResponseToNonNullableString(),
      base64Image: ResponseWrapper(getUserIdResponse["image_1920"]).mapFromResponseToNonNullableString(),
      currencySymbol: currencySymbol
    );
  }

  CheckDeviceApprovalResponse mapFromResponseToCheckDeviceApprovalResponse() {
    ResponseWrapper dataResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    List<dynamic> responseList = dataResponseWrapper.mapFromResponseToList(
      (response) => response
    );
    late CheckDeviceApprovalResult checkDeviceApprovalResult;
    if (responseList.isNotEmpty) {
      dynamic checkDeviceApprovalResponse = responseList.first;
      String state = ResponseWrapper(checkDeviceApprovalResponse["state"])
        .mapFromResponseToNonNullableString()
        .toLowerCase();
      if (state == "approved") {
        checkDeviceApprovalResult = ApprovedCheckDeviceApprovalResult(
          id: ResponseWrapper(checkDeviceApprovalResponse["id"]).mapFromResponseToNonNullableString(),
          deviceId: ResponseWrapper(checkDeviceApprovalResponse["device_id"]).mapFromResponseToNonNullableString(),
          deviceName: ResponseWrapper(checkDeviceApprovalResponse["device_name"]).mapFromResponseToNonNullableString(),
          createdDate: ResponseWrapper(checkDeviceApprovalResponse["create_date"]).mapFromResponseToNonNullableString(),
        );
      } else if (state == "rejected") {
        checkDeviceApprovalResult = RejectedCheckDeviceApprovalResult(
          createdDate: ResponseWrapper(checkDeviceApprovalResponse["create_date"]).mapFromResponseToNonNullableString()
        );
      } else {
        checkDeviceApprovalResult = NotApprovedCheckDeviceApprovalResult();
      }
    } else {
      checkDeviceApprovalResult = NotApprovedCheckDeviceApprovalResult();
    }
    return CheckDeviceApprovalResponse(
      checkDeviceApprovalResult: checkDeviceApprovalResult
    );
  }

  CheckDeviceExistResponse mapFromResponseToCheckDeviceExistResponse() {
    ResponseWrapper dataResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    List<dynamic> responseList = dataResponseWrapper.mapFromResponseToList(
      (response) => response
    );
    late CheckDeviceExistResult checkDeviceExistResult;
    if (responseList.isNotEmpty) {
      dynamic checkDeviceApprovalResponse = responseList.first;
      String state = ResponseWrapper(checkDeviceApprovalResponse["state"]).mapFromResponseToNonNullableString();
      void updateCheckDeviceExistResult(
        void Function({
          required String id,
          required String deviceId,
          required String deviceName
        }) onUpdate
      ) {
        onUpdate(
          id: ResponseWrapper(checkDeviceApprovalResponse["id"]).mapFromResponseToNonNullableString(),
          deviceId: ResponseWrapper(checkDeviceApprovalResponse["device_id"]).mapFromResponseToNonNullableString(),
          deviceName: ResponseWrapper(checkDeviceApprovalResponse["device_name"]).mapFromResponseToNonNullableString()
        );
      }
      updateCheckDeviceExistResult(({
        required String id, required String deviceId, required String deviceName
      }) {
        if (state == "approved") {
          checkDeviceExistResult = ApprovedExistCheckDeviceExistResult(
            id: id,
            deviceId: deviceId,
            deviceName: deviceName,
          );
        } else if (state == "rejected") {
          checkDeviceExistResult = RejectedExistCheckDeviceExistResult(
            id: id,
            deviceId: deviceId,
            deviceName: deviceName,
          );
        } else {
          checkDeviceExistResult = WaitingExistCheckDeviceExistResult(
            id: id,
            deviceId: deviceId,
            deviceName: deviceName,
            createdDate: ResponseWrapper(checkDeviceApprovalResponse["create_date"]).mapFromResponseToNonNullableString()
          );
        }
      });
    } else {
      checkDeviceExistResult = NotExistCheckDeviceExistResult();
    }
    return CheckDeviceExistResponse(
      checkDeviceExistResult: checkDeviceExistResult
    );
  }

  RegisterNewDeviceResponse mapFromResponseToRegisterNewDeviceResponse() {
    return RegisterNewDeviceResponse(
      createdDate: ResponseWrapper(response["create_date"]).mapFromResponseToNonNullableString()
    );
  }

  EmployeeBasedUserResponse mapFromResponseToEmployeeBasedUserResponse() {
    ResponseWrapper dataResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    List<dynamic> responseList = dataResponseWrapper.mapFromResponseToList(
      (response) => response
    );
    if (responseList.isEmpty) {
      throw MessageError(
        title: "User Not Found",
        message: "User is not found"
      );
    }
    dynamic getEmployeeResponse = responseList.first;
    return EmployeeBasedUserResponse(
      employee: ResponseWrapper(getEmployeeResponse).mapFromResponseToEmployee(),
    );
  }

  Employee mapFromResponseToEmployee() {
    var jobIdResponseWrapper = ResponseWrapper(response["job_id"]);
    return Employee(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      jobId: jobIdResponseWrapper.getArrayData(0).mapFromResponseToNonNullableString(),
      jobName: jobIdResponseWrapper.getArrayData(1).mapFromResponseToNonNullableString(),
    );
  }
}