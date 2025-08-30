import 'package:crm/common/ext/future_ext.dart';
import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:crm/data/mapping/user_entity_mapping_ext.dart';

import '../../../../common/constants/graph_ql_query_constants.dart';
import '../../../../common/graphql/graph_ql.dart';
import '../../../../common/graphql/graph_ql_mutate_parameter.dart';
import '../../../../common/graphql/graph_ql_query_parameter.dart';
import '../../../../common/helper/string_helper.dart';
import '../../../../common/httpclient/httpclient/http_client.dart';
import '../../../../common/processing/future_processing.dart';
import '../../../../common/processing/graph_ql_client_future_processing.dart';
import '../../../../common/processing/http_client_future_processing.dart';
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
import 'user_remote_data_source.dart';

class DefaultUserRemoteDataSource implements UserRemoteDataSource {
  final HttpClient httpClient;
  final GraphQL graphQL;

  DefaultUserRemoteDataSource({
    required this.httpClient,
    required this.graphQL
  });

  @override
  FutureProcessing<LoginResponse> login(LoginParameter loginParameter) {
    return HttpClientFutureProcessing((httpClientFutureProcessingCancellation) {
      if (loginParameter.serverUrl.isNotEmptyString) {
        httpClient.baseUrl = StringHelper().toApiEndpointFromBaseUrl(loginParameter.serverUrl);
      }
      return httpClient.post(
        "/jwt/auth/login",
        data: <String, dynamic>{
          "login": loginParameter.username,
          "password": loginParameter.password
        },
        httpClientFutureProcessingCancellation: httpClientFutureProcessingCancellation
      ).map<LoginResponse>(
        onMap: (value) => value.wrapResponse().mapFromResponseToLoginResponse()
      );
    });
  }

  @override
  FutureProcessing<GetUserListResponse> getUserList(GetUserListParameter getUserListParameter) {
    return GraphQLFutureProcessing((graphQLFutureProcessingCancellation) {
      return graphQL.query(
        GraphQLQueryParameter(
          queryString: GraphQLQueryConstants().queryUserList,
        )
      ).map<GetUserListResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToGetUserListResponse()
      );
    });
  }

  @override
  FutureProcessing<GetUserIdResponse> getUserId(GetUserIdParameter getUserIdParameter) {
    return GraphQLFutureProcessing((graphQLFutureProcessingCancellation) {
      return graphQL.query(
        GraphQLQueryParameter(
          queryString: GraphQLQueryConstants().queryUserId(getUserIdParameter.username),
        )
      ).map<GetUserIdResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToGetUserIdResponse()
      );
    });
  }

  @override
  FutureProcessing<CheckDeviceApprovalResponse> checkDeviceApproval(CheckDeviceApprovalParameter checkDeviceApprovalParameter) {
    return GraphQLFutureProcessing((graphQLFutureProcessingCancellation) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCheckDeviceApproval(
            userId: checkDeviceApprovalParameter.userId,
            imeiCode: checkDeviceApprovalParameter.imeiCode,
            deviceId: checkDeviceApprovalParameter.deviceId,
            deviceModel: checkDeviceApprovalParameter.deviceModel,
            deviceName: checkDeviceApprovalParameter.deviceName,
            filterOnlyApproved: checkDeviceApprovalParameter.filterOnlyApproved
          ),
        )
      ).map<CheckDeviceApprovalResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCheckDeviceApprovalResponse()
      );
    });
  }

  @override
  FutureProcessing<CheckDeviceExistResponse> checkDeviceExist(CheckDeviceExistParameter checkDeviceExistParameter) {
    return GraphQLFutureProcessing((graphQLFutureProcessingCancellation) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCheckDeviceExist(
            userId: checkDeviceExistParameter.userId,
            imeiCode: checkDeviceExistParameter.imeiCode,
            deviceId: checkDeviceExistParameter.deviceId,
            deviceModel: checkDeviceExistParameter.deviceModel,
            deviceName: checkDeviceExistParameter.deviceName
          )
        )
      ).map<CheckDeviceExistResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCheckDeviceExistResponse()
      );
    });
  }

  @override
  FutureProcessing<UserDetailResponse> userDetail(UserDetailParameter userDetailParameter) {
    return GraphQLFutureProcessing((graphQLFutureProcessingCancellation) {
      return graphQL.query(
        GraphQLQueryParameter(
          queryString: GraphQLQueryConstants().queryUserDetail(userDetailParameter.id)
        )
      ).map<UserDetailResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToUserDetailResponse()
      );
    });
  }

  @override
  FutureProcessing<RegisterNewDeviceResponse> registerNewDevice(RegisterNewDeviceParameter registerNewDeviceParameter) {
    return GraphQLFutureProcessing((graphQLFutureProcessingCancellation) {
      return graphQL.query(
        GraphQLQueryParameter(
          queryString: GraphQLQueryConstants().mutationRegisterNewDevice(
            userId: registerNewDeviceParameter.userId,
            imeiCode: registerNewDeviceParameter.imeiCode,
            deviceId: registerNewDeviceParameter.deviceId,
            deviceModel: registerNewDeviceParameter.deviceModel,
            deviceName: registerNewDeviceParameter.deviceName
          ),
        )
      ).map<RegisterNewDeviceResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToRegisterNewDeviceResponse()
      );
    });
  }

  @override
  FutureProcessing<EmployeeBasedUserResponse> employeeBasedUser(EmployeeBasedUserParameter employeeBasedUserParameter) {
    return GraphQLFutureProcessing((graphQLFutureProcessingCancellation) {
      return graphQL.query(
        GraphQLQueryParameter(
          queryString: GraphQLQueryConstants().mutationEmployeeBasedUserId(
            employeeBasedUserParameter.userId
          ),
        )
      ).map<EmployeeBasedUserResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToEmployeeBasedUserResponse()
      );
    });
  }
}