import 'dart:async';

import 'package:crm/common/ext/load_data_result_ext.dart';
import 'package:crm/data/service/base_service.dart';

import '../../common/error/message_error.dart';
import '../../common/helper/login_helper.dart';
import '../../common/load_data_result/load_data_result.dart';
import '../../common/login_data.dart';
import '../models/check_device_approval_result.dart';
import '../models/check_device_exist_result.dart';
import '../models/checkdeviceapproval/check_device_approval_parameter.dart';
import '../models/checkdeviceexist/check_device_exist_parameter.dart';
import '../models/getuserid/get_user_id_parameter.dart';
import '../models/login/login_parameter.dart';
import '../models/login/login_response.dart';
import '../models/login_state.dart';
import '../models/registernewdevice/register_new_device_parameter.dart';
import '../models/registernewdevice/register_new_device_response.dart';
import '../repositories/user_repository.dart';

class AuthService extends BaseService {
  final UserRepository userRepository;
  final String Function() email;
  final String Function() password;
  final Future<String> Function() imeiCode;
  final Future<String> Function() deviceId;
  final Future<String> Function() deviceName;
  final Future<String> Function() deviceModel;
  final bool Function() isSaveForFutureLogin;

  Timer? _checkDeviceApprovalTimer;
  void Function(LoadDataResult<LoginResultState>)? _onUpdateLoginResultStateLoadDataResult;

  AuthService({
    required this.userRepository,
    required this.email,
    required this.password,
    required this.imeiCode,
    required this.deviceId,
    required this.deviceName,
    required this.deviceModel,
    required this.isSaveForFutureLogin
  });

  void login({
    required void Function(LoadDataResult<LoginResultState>) onUpdateLoginResultStateLoadDataResult
  }) async {
    _onUpdateLoginResultStateLoadDataResult = onUpdateLoginResultStateLoadDataResult;
    onUpdateLoginResultStateLoadDataResult(
      IsLoadingLoadDataResult<LoginResultState>()
    );
    var loginResponseLoadDataResult = await userRepository.login(
      LoginParameter(
        serverUrl: "",
        username: email(),
        password: password()
      )
    ).future(
      parameter: apiRequestManager.addRequestToCancellationPart(
        "login",
        httpClientCancellationCreator
      ).value
    );
    if (loginResponseLoadDataResult.isSuccess) {
      LoginResponse loginResponse = loginResponseLoadDataResult.resultIfSuccess!;
      await LoginHelper.saveLoginData(
        LoginData(
          id: "",
          token: loginResponse.token
        ),
        saveInData: false
      );
      var getUserIdResponseLoadDataResult = await userRepository.getUserId(
        GetUserIdParameter(
          username: email(),
        )
      ).future(
        parameter: graphQLFutureProcessingCancellationCreator.createGraphQLFutureProcessingCancellation()
      );
      if (getUserIdResponseLoadDataResult.isSuccess) {
        var getUserIdResponse = getUserIdResponseLoadDataResult.resultIfSuccess!;
        await LoginHelper.saveLoginData(
          LoginData(
            id: getUserIdResponse.userId,
            token: loginResponse.token
          ),
          saveInData: false
        );
        _checkDeviceApproval(
          getUserIdResponse.userId,
          true,
          (checkDeviceApprovalResponseLoadDataResult) {
            if (checkDeviceApprovalResponseLoadDataResult.isSuccess) {
              var checkDeviceApprovalResult = checkDeviceApprovalResponseLoadDataResult.resultIfSuccess!;
              if (checkDeviceApprovalResult is ApprovedCheckDeviceApprovalResult) {
                _finishingLoginFlow(getUserIdResponse.userId, loginResponse.token);
              } else if (checkDeviceApprovalResult is NotApprovedCheckDeviceApprovalResult) {
                void checkingDeviceExist({bool ignoreRegister = false}) {
                  _checkDeviceExist(
                    getUserIdResponse.userId,
                    (checkDeviceExistResponseLoadDataResult) {
                      if (checkDeviceExistResponseLoadDataResult.isSuccess) {
                        var checkDeviceExistResult = checkDeviceExistResponseLoadDataResult.resultIfSuccess!;
                        if (checkDeviceExistResult is ApprovedExistCheckDeviceExistResult) {
                          _finishingLoginFlow(getUserIdResponse.userId, loginResponse.token);
                        } else if (checkDeviceExistResult is RejectedExistCheckDeviceExistResult) {
                          _rejectingLoginFlow();
                        } else if (checkDeviceExistResult is WaitingExistCheckDeviceExistResult) {
                          _checkDeviceApprovalEveryIntervalTime(
                            getUserIdResponse.userId,
                            loginResponse.token,
                            checkDeviceExistResult.deviceId
                          );
                        } else if (checkDeviceExistResult is NotExistCheckDeviceExistResult) {
                          if (!ignoreRegister) {
                            _registerNewDevice(
                              getUserIdResponse.userId,
                              (registerNewDeviceResponseLoadDataResult) {
                                if (registerNewDeviceResponseLoadDataResult.isSuccess) {
                                  checkingDeviceExist(ignoreRegister: true);
                                } else {
                                  onUpdateLoginResultStateLoadDataResult(
                                    registerNewDeviceResponseLoadDataResult.map<LoginResultState>(
                                      (_) => throw UnimplementedError()
                                    )
                                  );
                                }
                              }
                            );
                          }
                        } else {
                          onUpdateLoginResultStateLoadDataResult(
                            checkDeviceExistResponseLoadDataResult.map<LoginResultState>(
                              (_) => throw UnimplementedError()
                            )
                          );
                        }
                      } else {
                        onUpdateLoginResultStateLoadDataResult(
                          checkDeviceExistResponseLoadDataResult.map<LoginResultState>(
                            (_) => throw UnimplementedError()
                          )
                        );
                      }
                    }
                  );
                }
                checkingDeviceExist();
              } else {
                onUpdateLoginResultStateLoadDataResult(
                  FailedLoadDataResult(
                    e: MessageError(
                      title: "Check Device Approval Failed",
                      message: "Check Device Approval is failed"
                    )
                  )
                );
              }
            } else {
              onUpdateLoginResultStateLoadDataResult(
                checkDeviceApprovalResponseLoadDataResult.map<LoginResultState>(
                  (_) => throw UnimplementedError()
                )
              );
            }
          }
        );
      } else {
        onUpdateLoginResultStateLoadDataResult(
          getUserIdResponseLoadDataResult.map<LoginResultState>(
            (_) => throw UnimplementedError()
          )
        );
      }
    } else {
      onUpdateLoginResultStateLoadDataResult(
        loginResponseLoadDataResult.map<LoginResultState>(
          (_) => throw UnimplementedError()
        )
      );
    }
  }

  void _checkDeviceApproval(
    String userId,
    bool filterOnlyApproved,
    void Function(LoadDataResult<CheckDeviceApprovalResult>) result
  ) async {
    var checkDeviceApprovalResponseLoadDataResult = await userRepository.checkDeviceApproval(
      CheckDeviceApprovalParameter(
        imeiCode: await imeiCode(),
        userId: userId,
        deviceId: await deviceId(),
        deviceName: await deviceName(),
        deviceModel: await deviceModel(),
        filterOnlyApproved: filterOnlyApproved
      )
    ).future(
      parameter: graphQLFutureProcessingCancellationCreator.createGraphQLFutureProcessingCancellation()
    );
    result(
      checkDeviceApprovalResponseLoadDataResult.map<CheckDeviceApprovalResult>(
        (value) => value.checkDeviceApprovalResult
      )
    );
  }

  void _checkDeviceExist(
    String userId,
    void Function(LoadDataResult<CheckDeviceExistResult>) result
  ) async {
    var checkDeviceExistResponseLoadDataResult = await userRepository.checkDeviceExist(
      CheckDeviceExistParameter(
        imeiCode: await imeiCode(),
        userId: userId,
        deviceId: await deviceId(),
        deviceName: await deviceName(),
        deviceModel: await deviceModel(),
      )
    ).future(
      parameter: graphQLFutureProcessingCancellationCreator.createGraphQLFutureProcessingCancellation()
    );
    result(
      checkDeviceExistResponseLoadDataResult.map<CheckDeviceExistResult>(
        (value) => value.checkDeviceExistResult
      )
    );
  }

  void _registerNewDevice(
    String userId,
    void Function(LoadDataResult<RegisterNewDeviceResponse>) result
  ) async {
    var registerNewDeviceResponseLoadDataResult = await userRepository.registerNewDevice(
      RegisterNewDeviceParameter(
        imeiCode: await imeiCode(),
        userId: userId,
        deviceId: await deviceId(),
        deviceName: await deviceName(),
        deviceModel: await deviceModel(),
      )
    ).future(
      parameter: graphQLFutureProcessingCancellationCreator.createGraphQLFutureProcessingCancellation()
    );
    result(
      registerNewDeviceResponseLoadDataResult
    );
  }

  void _checkDeviceApprovalEveryIntervalTime(
    String userId,
    String token,
    String createdDate
  ) {
    if (_onUpdateLoginResultStateLoadDataResult != null) {
      _onUpdateLoginResultStateLoadDataResult!(
        SuccessLoadDataResult<LoginResultState>(
          value: WaitingForApprovalLoginResultState()
        )
      );
    }
    void action() {
      _checkDeviceApproval(
        userId,
        false,
        (checkDeviceApprovalResponseLoadDataResult) {
          try {
            _checkDeviceApprovalTimer?.cancel();
          } catch (_) {
            // No catch exception
          }
          bool restartTimer = true;
          if (checkDeviceApprovalResponseLoadDataResult.isSuccess) {
            var checkDeviceApprovalResult = checkDeviceApprovalResponseLoadDataResult.resultIfSuccess!;
            if (checkDeviceApprovalResult is ApprovedCheckDeviceApprovalResult) {
              restartTimer = false;
              _finishingLoginFlow(userId, token);
            } else if (checkDeviceApprovalResult is RejectedCheckDeviceApprovalResult) {
              if (checkDeviceApprovalResult.createdDate != createdDate) {
                restartTimer = false;
                _rejectingLoginFlow();
              }
            }
          }
          if (restartTimer) {
            _checkDeviceApprovalTimer = Timer(const Duration(seconds: 5), action);
          }
        }
      );
    }
    action();
  }

  void _finishingLoginFlow(String userId, String token) async {
    await LoginHelper.saveLoginData(
      LoginData(
        id: userId,
        token: token
      ),
      saveInData: isSaveForFutureLogin()
    );
    if (_onUpdateLoginResultStateLoadDataResult != null) {
      _onUpdateLoginResultStateLoadDataResult!(
        SuccessLoadDataResult<LoginResultState>(
          value: FinalLoginResultState()
        )
      );
    }
  }

  void _rejectingLoginFlow() async {
    if (_onUpdateLoginResultStateLoadDataResult != null) {
      _onUpdateLoginResultStateLoadDataResult!(
        SuccessLoadDataResult<LoginResultState>(
          value: RejectLoginResultState()
        )
      );
    }
  }
}
