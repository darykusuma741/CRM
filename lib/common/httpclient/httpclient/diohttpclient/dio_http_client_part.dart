import 'dart:async';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:crm/common/ext/load_data_result_ext.dart';
import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;

import '../../../../infrastructure/navigation/routes.dart';
import '../../../environmentconfig/environment_config.dart';
import '../../../helper/login_helper.dart';
import '../../../load_data_result/load_data_result.dart';
import '../../../login_data.dart';
import '../../../responsewrapper/response_wrapper.dart';
import '../http_client_configurator.dart';

class DioHttpClientCreator {
  Dio? _currentDio;

  Dio createDio(DioHttpClientConfigurator configurator) {
    if (_currentDio != null) {
      return _currentDio!;
    }
    final modifiedDioLoggerInterceptor = InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
      String headers = "";
      options.headers.forEach((key, value) {
        headers += "| $key: $value";
      });
      if (kDebugMode) {
        late dynamic dataMap;
        if (options.data is FormData) {
          dataMap = (options.data as FormData).fields.asMap().map<String, dynamic>((key, value) => value);
        } else {
          dataMap = options.data;
        }
        log("┌------------------------------------------------------------------------------");
        log('''| [DIO] Request: ${options.method} ${options.uri}
| $dataMap
| Headers:\n$headers''');
        log("├------------------------------------------------------------------------------");
      }
      handler.next(options);  //continue
    }, onResponse: (Response response, handler) async {
      if (kDebugMode) {
        log("| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
        log("└------------------------------------------------------------------------------");
      }
      handler.next(response);
      // return response; // continue
    }, onError: (DioError error, handler) async {
      if (kDebugMode) {
        log("| [DIO] Error: ${error.error}: ${error.response.toString()}");
        log("└------------------------------------------------------------------------------");
      }
      handler.next(error); //continue
    });
    BaseOptions baseOptions = BaseOptions(
      baseUrl: () {
        var baseUrl = EnvironmentConfig.instance.httpBaseUrl;
        if (baseUrl.isEmptyString) {
          return baseUrl;
        }
        return "${EnvironmentConfig.instance.httpBaseUrl}/";
      }()
    );
    var modifiedDioInterceptor = _ModifiedDioInterceptor();
    configurator._unlock = modifiedDioInterceptor.unlock;
    Dio dio = ModifiedDio(Dio(baseOptions), modifiedDioInterceptor);
    dio.interceptors.add(modifiedDioLoggerInterceptor);
    _currentDio = dio;
    return dio;
  }
}

class DioHttpClientConfigurator extends HttpClientConfigurator {
  void Function()? _unlock;

  @override
  void unlock() {
    if (_unlock != null) {
      _unlock!();
    }
  }
}

class _DioHttpClientOptionsImpl {
  Map<String, dynamic> createTokenHeader(LoginData? loginData) {
    String token = (loginData?.token).toEmptyStringNonNull;
    if (token.isNotEmptyString) {
      token = "Bearer $token";
    }
    return <String, dynamic> {
      if (token.isNotEmptyString) ...{
        "Authorization": token
      },
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
  }

  Options createOptionsWithTokenHeader(LoginData? loginData) {
    return ExtendedOptions(headers: createTokenHeader(loginData));
  }
}

class _ModifiedDioInterceptor {
  Timer? _timer;
  bool _isLocked = false;

  _ModifiedDioInterceptor() {
    // _apiRequestManager = ApiRequestManager();
  }

  void unlock() {
    _isLocked = false;
  }

  void registerToLogout() {
    if (_isLocked) {
      return;
    }
    bool checkIsHasLogin() {
      return (LoginHelper.getLoginData()?.token).isNotEmptyString;
    }
    if (!checkIsHasLogin()) {
      return;
    }
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(
      const Duration(milliseconds: 50),
      () {
        if (!_isLocked) {
          if (checkIsHasLogin()) {
            _isLocked = true;
            _logoutProcess();
          }
        }
      },
    );
  }

  void _logoutProcess() async {
    await LoginHelper.deleteLoginData();
    Get.offNamed(Routes.LOGIN);
  }
}

class ModifiedDio implements Dio {
  final Dio _wrappedDio;
  final _ModifiedDioInterceptor _modifiedDioInterceptor;

  // ignore: library_private_types_in_public_api
  ModifiedDio(this._wrappedDio, this._modifiedDioInterceptor);

  void unlock() {
    _modifiedDioInterceptor.unlock();
  }

  Options get _optionsWithTokenHeader => _DioHttpClientOptions.createOptionsWithTokenHeader(
    LoginHelper.getLoginData()
  );

  @override
  HttpClientAdapter get httpClientAdapter => _wrappedDio.httpClientAdapter;

  @override
  set httpClientAdapter(HttpClientAdapter value) => _wrappedDio.httpClientAdapter = value;

  @override
  BaseOptions get options => _wrappedDio.options;

  @override
  set options(BaseOptions value) => _wrappedDio.options = value;

  @override
  Interceptors get interceptors => _wrappedDio.interceptors;

  @override
  Transformer get transformer => _wrappedDio.transformer;

  @override
  set transformer(Transformer value) => _wrappedDio.transformer = value;

  @override
  void close({bool force = false}) {
    _wrappedDio.close(force: force);
  }

  Future<Response<T>> _interceptDioRequest<T>({
    required Future<Response<T>> Function() onRequest
  }) async {
    try {
      Response<T> interceptDioRequest = await onRequest();
      dynamic responseData = interceptDioRequest.data;
      if (responseData is Map<String, dynamic>) {
        if (responseData.containsKey("title")) {
          String response = ResponseWrapper(responseData["title"]).mapFromResponseToNonNullableString();
          if (response.toLowerCase() == "unauthorized") {
            RequestOptions requestOptions = interceptDioRequest.requestOptions;
            throw DioException(
              requestOptions: requestOptions,
              response: Response(
                data: responseData,
                requestOptions: requestOptions,
              ),
              error: responseData["message"] as String?,
              type: DioExceptionType.badResponse
            );
          }
        }
      }
      return interceptDioRequest;
    } on DioException catch (e) {
      if (FailedLoadDataResult(e: e).isFailedBecauseUnauthenticatedOrRequiredLogin) {
        _modifiedDioInterceptor.registerToLogout();
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<T>> delete<T>(String path, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) {
    return _interceptDioRequest(
      onRequest: () =>_wrappedDio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken
      )
    );
  }

  @override
  Future<Response<T>> deleteUri<T>(Uri uri, {data, Options? options, CancelToken? cancelToken}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.deleteUri(
        uri,
        data: data,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken
      )
    );
  }

  @override
  Future<Response> download(
    String urlPath,
    savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    FileAccessMode fileAccessMode = FileAccessMode.write,
    String lengthHeader = Headers.contentLengthHeader,
    data,
    Options? options
  }) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        data: data,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false)
      )
    );
  }

  @override
  Future<Response> downloadUri(
    Uri uri,
    savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    FileAccessMode fileAccessMode = FileAccessMode.write,
    String lengthHeader = Headers.contentLengthHeader,
    data,
    Options? options
  }) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.downloadUri(
        uri,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        fileAccessMode: fileAccessMode,
        lengthHeader: lengthHeader,
        data: data,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false)
      )
    );
  }

  @override
  Future<Response<T>> fetch<T>(RequestOptions requestOptions) => _interceptDioRequest(
    onRequest: () => _wrappedDio.fetch(requestOptions)
  );

  @override
  Future<Response<T>> get<T>(String path, {Object? data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress
      )
    );
  }

  @override
  Future<Response<T>> getUri<T>(Uri uri, {Object? data, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.getUri(
        uri,
        data: data,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress
      )
    );
  }

  @override
  Future<Response<T>> head<T>(String path, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.head(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken
      )
    );
  }

  @override
  Future<Response<T>> headUri<T>(Uri uri, {data, Options? options, CancelToken? cancelToken}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.headUri(
        uri,
        data: data,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken
      )
    );
  }

  @override
  Future<Response<T>> patch<T>(String path, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress
      )
    );
  }

  @override
  Future<Response<T>> patchUri<T>(Uri uri, {data, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.patchUri(
        uri,
        data: data,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress
      )
    );
  }

  @override
  Future<Response<T>> post<T>(String path, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress
      )
    );
  }

  @override
  Future<Response<T>> postUri<T>(Uri uri, {data, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.postUri(
        uri,
        data: data,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress
      )
    );
  }

  @override
  Future<Response<T>> put<T>(String path, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress
      )
    );
  }

  @override
  Future<Response<T>> putUri<T>(Uri uri, {data, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.putUri(
        uri,
        data: data,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress
      )
    );
  }

  @override
  Future<Response<T>> request<T>(String path, {data, Map<String, dynamic>? queryParameters, CancelToken? cancelToken, Options? options, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress
      )
    );
  }

  @override
  Future<Response<T>> requestUri<T>(Uri uri, {data, CancelToken? cancelToken, Options? options, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) {
    return _interceptDioRequest(
      onRequest: () => _wrappedDio.requestUri(
        uri,
        data: data,
        options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress
      )
    );
  }

  @override
  Dio clone({
    BaseOptions? options,
    Interceptors? interceptors,
    HttpClientAdapter? httpClientAdapter,
    Transformer? transformer
  }) {
    return _wrappedDio.clone(
      options: options,
      interceptors: interceptors,
      httpClientAdapter: httpClientAdapter,
      transformer: transformer
    );
  }
}

// ignore: non_constant_identifier_names
final _DioHttpClientOptions = _DioHttpClientOptionsImpl();

extension on Options {
  Options merge(
    Options? options, {
    bool allowBaseUrlMerging = true,
    bool allowMethodMerging = true,
    bool allowSendTimeoutMerging = true,
    bool allowReceiveTimeoutMerging = true,
    bool allowExtraMerging = true,
    bool allowHeadersMerging = true,
    bool allowPreserveHeaderCase = true,
    bool allowResponseTypeMerging = true,
    bool allowContentTypeMerging = true,
    bool allowValidateStatusMerging = true,
    bool allowReceiveDataWhenStatusErrorMerging = true,
    bool allowFollowRedirectsMethodMerging = true,
    bool allowMaxRedirectsMerging = true,
    bool allowPersistentConnection = true,
    bool allowRequestEncoderMerging = true,
    bool allowResponseDecoderMerging = true,
    bool allowListFormatMerging = true,
  }) {
    if (options == null) {
      return this;
    }
    Map<String, Object?>? mergingMaps() {
      return mergeMaps(headers ?? {}, options.headers ?? {});
    }
    if (this is ExtendedOptions) {
      return (this as ExtendedOptions).copyWith(
        baseUrl: options is ExtendedOptions ? (allowBaseUrlMerging ? options.baseUrl : null) : null,
        method: allowMethodMerging ? options.method : null,
        sendTimeout: allowSendTimeoutMerging ? options.sendTimeout : null,
        receiveTimeout: allowReceiveTimeoutMerging ? options.receiveTimeout : null,
        extra: allowExtraMerging ? options.extra : null,
        headers: allowHeadersMerging ? options.headers : mergingMaps(),
        preserveHeaderCase: allowPreserveHeaderCase ? options.preserveHeaderCase : null,
        responseType: allowResponseTypeMerging ? options.responseType : null,
        contentType: allowContentTypeMerging ? options.contentType : null,
        validateStatus: allowValidateStatusMerging ? options.validateStatus : null,
        receiveDataWhenStatusError: allowReceiveDataWhenStatusErrorMerging ? options.receiveDataWhenStatusError : null,
        followRedirects: allowFollowRedirectsMethodMerging ? options.followRedirects : null,
        maxRedirects: allowMaxRedirectsMerging ? options.maxRedirects : null,
        persistentConnection: allowPersistentConnection ? options.persistentConnection : null,
        requestEncoder: allowRequestEncoderMerging ? options.requestEncoder : null,
        responseDecoder: allowResponseDecoderMerging ? options.responseDecoder : null,
        listFormat: allowListFormatMerging ? options.listFormat : null
      );
    } else {
      return copyWith(
        method: allowMethodMerging ? options.method : null,
        sendTimeout: allowSendTimeoutMerging ? options.sendTimeout : null,
        receiveTimeout: allowReceiveTimeoutMerging ? options.receiveTimeout : null,
        extra: allowExtraMerging ? options.extra : null,
        headers: allowHeadersMerging ? options.headers : mergingMaps(),
        preserveHeaderCase: allowPreserveHeaderCase ? options.preserveHeaderCase : null,
        responseType: allowResponseTypeMerging ? options.responseType : null,
        contentType: allowContentTypeMerging ? options.contentType : null,
        validateStatus: allowValidateStatusMerging ? options.validateStatus : null,
        receiveDataWhenStatusError: allowReceiveDataWhenStatusErrorMerging ? options.receiveDataWhenStatusError : null,
        followRedirects: allowFollowRedirectsMethodMerging ? options.followRedirects : null,
        maxRedirects: allowMaxRedirectsMerging ? options.maxRedirects : null,
        persistentConnection: allowPersistentConnection ? options.persistentConnection : null,
        requestEncoder: allowRequestEncoderMerging ? options.requestEncoder : null,
        responseDecoder: allowResponseDecoderMerging ? options.responseDecoder : null,
        listFormat: allowListFormatMerging ? options.listFormat : null
      );
    }
  }
}

class ExtendedOptions extends Options {
  late Options _wrappedOptions;
  String? baseUrl;

  @override
  String? get method => _wrappedOptions.method;

  @override
  set method(String? value) => _wrappedOptions.method = value;

  @override
  Duration? get sendTimeout => _wrappedOptions.sendTimeout;

  @override
  set sendTimeout(Duration? value) => _wrappedOptions.sendTimeout = value;

  @override
  Duration? get receiveTimeout => _wrappedOptions.receiveTimeout;

  @override
  set receiveTimeout(Duration? value) => _wrappedOptions.receiveTimeout = value;

  @override
  Map<String, Object?>? get extra => _wrappedOptions.extra;

  @override
  set extra(Map<String, Object?>? value) => _wrappedOptions.extra = value;

  @override
  Map<String, Object?>? get headers => _wrappedOptions.headers;

  @override
  set headers(Map<String, Object?>? value) => _wrappedOptions.headers = value;

  @override
  bool? get preserveHeaderCase => _wrappedOptions.preserveHeaderCase;

  @override
  set preserveHeaderCase(bool? value) => _wrappedOptions.preserveHeaderCase = value;

  @override
  ResponseType? get responseType => _wrappedOptions.responseType;

  @override
  set responseType(ResponseType? value) => _wrappedOptions.responseType = value;

  @override
  String? get contentType => _wrappedOptions.contentType;

  @override
  set contentType(String? value) => _wrappedOptions.contentType = value;

  @override
  ValidateStatus? get validateStatus => _wrappedOptions.validateStatus;

  @override
  set validateStatus(ValidateStatus? value) => _wrappedOptions.validateStatus = value;

  @override
  bool? get receiveDataWhenStatusError => _wrappedOptions.receiveDataWhenStatusError;

  @override
  set receiveDataWhenStatusError(bool? value) => _wrappedOptions.receiveDataWhenStatusError = value;

  @override
  bool? get followRedirects => _wrappedOptions.followRedirects;

  @override
  set followRedirects(bool? value) => _wrappedOptions.followRedirects = value;

  @override
  int? get maxRedirects => _wrappedOptions.maxRedirects;

  @override
  set maxRedirects(int? value) => _wrappedOptions.maxRedirects = value;

  @override
  bool? get persistentConnection => _wrappedOptions.persistentConnection;

  @override
  set persistentConnection(bool? value) => _wrappedOptions.persistentConnection = value;

  @override
  RequestEncoder? get requestEncoder => _wrappedOptions.requestEncoder;

  @override
  set requestEncoder(RequestEncoder? value) => _wrappedOptions.requestEncoder = value;

  @override
  ResponseDecoder? get responseDecoder => _wrappedOptions.responseDecoder;

  @override
  set responseDecoder(ResponseDecoder? value) => _wrappedOptions.responseDecoder = value;

  @override
  ListFormat? get listFormat => _wrappedOptions.listFormat;

  @override
  set listFormat(ListFormat? value) => _wrappedOptions.listFormat = value;

  ExtendedOptions({
    this.baseUrl,
    String? method,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    Map<String, Object?>? extra,
    Map<String, Object?>? headers,
    bool? preserveHeaderCase,
    ResponseType? responseType,
    String? contentType,
    ValidateStatus? validateStatus,
    bool? receiveDataWhenStatusError,
    bool? followRedirects,
    int? maxRedirects,
    bool? persistentConnection,
    RequestEncoder? requestEncoder,
    ResponseDecoder? responseDecoder,
    ListFormat? listFormat,
  }) {
    _wrappedOptions = Options(
      method: method,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      extra: extra,
      headers: headers,
      preserveHeaderCase: preserveHeaderCase,
      responseType: responseType,
      contentType: contentType,
      validateStatus: validateStatus,
      receiveDataWhenStatusError: receiveDataWhenStatusError,
      followRedirects: followRedirects,
      maxRedirects: maxRedirects,
      persistentConnection: persistentConnection,
      requestEncoder: requestEncoder,
      responseDecoder: responseDecoder,
      listFormat: listFormat,
    );
  }

  ExtendedOptions._fromOptions(Options options) {
    _wrappedOptions = options;
  }

  @override
  ExtendedOptions copyWith({
    String? baseUrl,
    String? method,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    Map<String, Object?>? extra,
    Map<String, Object?>? headers,
    bool? preserveHeaderCase,
    ResponseType? responseType,
    String? contentType,
    ValidateStatus? validateStatus,
    bool? receiveDataWhenStatusError,
    bool? followRedirects,
    int? maxRedirects,
    bool? persistentConnection,
    RequestEncoder? requestEncoder,
    ResponseDecoder? responseDecoder,
    ListFormat? listFormat,
  }) {
    return ExtendedOptions._fromOptions(
      _wrappedOptions.copyWith(
        method: method ?? this.method,
        sendTimeout: sendTimeout ?? this.sendTimeout,
        receiveTimeout: receiveTimeout ?? this.receiveTimeout,
        extra: extra ?? this.extra,
        headers: headers ?? this.headers,
        preserveHeaderCase: preserveHeaderCase ?? this.preserveHeaderCase,
        responseType: responseType ?? this.responseType,
        contentType: contentType ?? this.contentType,
        validateStatus: validateStatus ?? this.validateStatus,
        receiveDataWhenStatusError: receiveDataWhenStatusError ?? this.receiveDataWhenStatusError,
        followRedirects: followRedirects ?? this.followRedirects,
        maxRedirects: maxRedirects ?? this.maxRedirects,
        persistentConnection: persistentConnection ?? this.persistentConnection,
        requestEncoder: requestEncoder ?? this.requestEncoder,
        responseDecoder: responseDecoder ?? this.responseDecoder,
        listFormat: listFormat ?? this.listFormat,
      )
    )..baseUrl = baseUrl ?? this.baseUrl;
  }

  @override
  RequestOptions compose(
    BaseOptions baseOpt,
    String path, {
      Object? data,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      StackTrace? sourceStackTrace,
    }
  ) {
    RequestOptions requestOptions = super.compose(
      baseOpt,
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      sourceStackTrace: sourceStackTrace
    );
    if (baseUrl != null) {
      requestOptions.baseUrl = baseUrl!;
    }
    return requestOptions;
  }
}