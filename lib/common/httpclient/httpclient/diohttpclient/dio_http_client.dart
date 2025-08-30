import 'package:crm/common/ext/future_ext.dart';
import 'package:dio/dio.dart' as dio_http_client;
import '../../../error/http_client_error.dart';
import '../../../processing/future_processing_cancellation/httpclientfutureprocessingcancellation/dio_http_client_future_processing_cancellation.dart';
import '../../../processing/future_processing_cancellation/httpclientfutureprocessingcancellation/http_client_future_processing_cancellation.dart';
import '../../../responsewrapper/response_wrapper.dart';
import '../../http_client_header.dart';
import '../../http_client_option.dart';
import '../../http_client_redirect_record.dart';
import '../../http_client_request_option.dart';
import '../../http_client_response.dart';
import '../http_client.dart';

class DioHttpClient extends HttpClient {
  final dio_http_client.Dio dio;

  @override
  String get baseUrl => dio.options.baseUrl;

  @override
  set baseUrl(String value) => dio.options.baseUrl = value;

  DioHttpClient({
    required this.dio
  });

  DioHttpClientFutureProcessingCancellation _getCancellationInstance(HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation) {
    return httpClientFutureProcessingCancellation as DioHttpClientFutureProcessingCancellation;
  }

  dio_http_client.CancelToken _getCancelTokenInstance(HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation) {
    return _getCancellationInstance(httpClientFutureProcessingCancellation).cancelToken;
  }

  @override
  Future<HttpClientResponse<T>> delete<T>(String path, {data, Map<String, dynamic>? queryParameters, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation}) {
    return dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options.toOptions(),
      cancelToken: _getCancelTokenInstance(httpClientFutureProcessingCancellation)
    ).map<HttpClientResponse<T>>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }

  @override
  Future<HttpClientResponse<T>> deleteUri<T>(Uri uri, {data, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation}) {
    return dio.deleteUri<T>(
      uri,
      data: data,
      options: options.toOptions(),
      cancelToken: _getCancelTokenInstance(httpClientFutureProcessingCancellation)
    ).map<HttpClientResponse<T>>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }

  @override
  Future<HttpClientResponse> download(String urlPath, savePath, {ProgressCallback? onReceiveProgress, Map<String, dynamic>? queryParameters, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, bool deleteOnError = true, String lengthHeader = HttpClientHeader.contentLengthHeader, data, HttpClientOption? options}) {
    return dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: _getCancelTokenInstance(httpClientFutureProcessingCancellation),
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      data: data,
      options: options.toOptions(),
    ).map<HttpClientResponse>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }

  @override
  Future<HttpClientResponse> downloadUri(Uri uri, savePath, {ProgressCallback? onReceiveProgress, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, bool deleteOnError = true, String lengthHeader = HttpClientHeader.contentLengthHeader, data, HttpClientOption? options}) {
    return dio.downloadUri(
      uri,
      savePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: _getCancelTokenInstance(httpClientFutureProcessingCancellation),
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      data: data,
      options: options.toOptions(),
    ).map<HttpClientResponse>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }

  @override
  Future<HttpClientResponse<T>> fetch<T>(HttpClientRequestOption httpClientRequestOption) {
    return dio.fetch<T>(
      httpClientRequestOption.toRequestOptions()!
    ).map<HttpClientResponse<T>>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }

  @override
  Future<HttpClientResponse<T>> post<T>(String path, {data, Map<String, dynamic>? queryParameters, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options.toOptions(),
      cancelToken: _getCancelTokenInstance(httpClientFutureProcessingCancellation),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress
    ).map<HttpClientResponse<T>>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }

  @override
  Future<HttpClientResponse<T>> postUri<T>(Uri uri, {data, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) {
    return dio.postUri<T>(
      uri,
      data: data,
      options: options.toOptions(),
      cancelToken: _getCancelTokenInstance(httpClientFutureProcessingCancellation),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress
    ).map<HttpClientResponse<T>>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }

  @override
  Future<HttpClientResponse<T>> put<T>(String path, {data, Map<String, dynamic>? queryParameters, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) {
    return dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options.toOptions(),
      cancelToken: _getCancelTokenInstance(httpClientFutureProcessingCancellation),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress
    ).map<HttpClientResponse<T>>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }

  @override
  Future<HttpClientResponse<T>> putUri<T>(Uri uri, {data, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) {
    return dio.putUri<T>(
      uri,
      data: data,
      options: options.toOptions(),
      cancelToken: _getCancelTokenInstance(httpClientFutureProcessingCancellation),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress
    ).map<HttpClientResponse<T>>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }

  @override
  Future<HttpClientResponse<T>> get<T>(String path, {Map<String, dynamic>? queryParameters, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, ProgressCallback? onReceiveProgress}) {
    return dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options.toOptions(),
      cancelToken: _getCancelTokenInstance(httpClientFutureProcessingCancellation),
      onReceiveProgress: onReceiveProgress
    ).map<HttpClientResponse<T>>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }

  @override
  Future<HttpClientResponse<T>> getUri<T>(Uri uri, {HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, ProgressCallback? onReceiveProgress}) {
    return dio.getUri<T>(
      uri,
      options: options.toOptions(),
      cancelToken: _getCancelTokenInstance(httpClientFutureProcessingCancellation),
      onReceiveProgress: onReceiveProgress
    ).map<HttpClientResponse<T>>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }

  @override
  Future<HttpClientResponse<T>> head<T>(String path, {data, Map<String, dynamic>? queryParameters, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation}) {
    return dio.head<T>(
      path,
      data: queryParameters,
      queryParameters: queryParameters,
      options: options.toOptions(),
      cancelToken: _getCancelTokenInstance(httpClientFutureProcessingCancellation)
    ).map<HttpClientResponse<T>>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }

  @override
  Future<HttpClientResponse<T>> headUri<T>(Uri uri, {data, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation}) {
    return dio.headUri<T>(
      uri,
      data: data,
      options: options.toOptions(),
      cancelToken: _getCancelTokenInstance(httpClientFutureProcessingCancellation)
    ).map<HttpClientResponse<T>>(
      onMap: (value) => value.toHttpResponse()
    ).transformError();
  }
}

extension _DioHttpClientResponseExt<T> on dio_http_client.Response<T> {
  HttpClientResponse<T> toHttpResponse() {
    return HttpClientResponse<T>(
      data: data,
      headers: headers.map,
      requestOptions: requestOptions.toHttpClientRequestOption(),
      isRedirect: isRedirect,
      statusCode: statusCode,
      statusMessage: statusMessage,
      redirects: redirects.map((redirectRecord) => redirectRecord.toHttpClientRedirectRecord()).toList()
    );
  }
}

extension on dio_http_client.RequestOptions {
  HttpClientRequestOption toHttpClientRequestOption() {
    return HttpClientRequestOption(
      method: method,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      connectTimeout: connectTimeout,
      headers: headers,
      data: data,
      path: path,
      queryParameters: queryParameters,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onReceiveProgress,
      httpClientFutureProcessingCancellation: cancelToken != null ? DioHttpClientFutureProcessingCancellation(cancelToken: cancelToken!) : null,
      baseUrl: baseUrl,
    );
  }
}

extension on dio_http_client.RedirectRecord {
  HttpClientRedirectRecord toHttpClientRedirectRecord() {
    return HttpClientRedirectRecord(
      statusCode, method, location
    );
  }
}

extension on HttpClientOption? {
  dio_http_client.Options? toOptions() {
    if (this == null) return null;
    return dio_http_client.Options(
      method: this!.method,
      sendTimeout: this!.sendTimeout,
      receiveTimeout: this!.receiveTimeout,
      headers: this!.headers,
      contentType: this!.contentType
    );
  }
}

extension on HttpClientRequestOption? {
  dio_http_client.RequestOptions? toRequestOptions() {
    if (this == null) return null;
    return dio_http_client.RequestOptions(
      method: this!.method,
      sendTimeout: this!.sendTimeout,
      receiveTimeout: this!.receiveTimeout,
      headers: this!.headers,
      contentType: this!.contentType,
      data: this!.data,
      path: this!.path,
      cancelToken: this!.httpClientFutureProcessingCancellation is DioHttpClientFutureProcessingCancellation ? (this!.httpClientFutureProcessingCancellation as DioHttpClientFutureProcessingCancellation).cancelToken : null,
      onReceiveProgress: this!.onReceiveProgress,
      onSendProgress: this!.onSendProgress,
    );
  }
}

extension on dio_http_client.DioException? {
  HttpClientError? toHttpClientError() {
    if (this == null) return null;
    return HttpClientError(
      httpClientRequestOption: this!.requestOptions.toHttpClientRequestOption(),
      httpClientResponse: this!.response?.toHttpResponse(),
      httpClientErrorType: this!.type.toHttpClientErrorType()!,
      error: this!.error
    );
  }
}

extension on dio_http_client.DioExceptionType? {
  HttpClientErrorType? toHttpClientErrorType() {
    if (this == null) return null;
    if (this! == dio_http_client.DioExceptionType.connectionTimeout) {
      return HttpClientErrorType.connectionTimeout;
    } else if (this! == dio_http_client.DioExceptionType.sendTimeout) {
      return HttpClientErrorType.sendTimeout;
    } else if (this! == dio_http_client.DioExceptionType.receiveTimeout) {
      return HttpClientErrorType.receiveTimeout;
    } else if (this! == dio_http_client.DioExceptionType.badCertificate) {
      return HttpClientErrorType.badCertificate;
    } else if (this! == dio_http_client.DioExceptionType.badResponse) {
      return HttpClientErrorType.badResponse;
    } else if (this! == dio_http_client.DioExceptionType.cancel) {
      return HttpClientErrorType.cancel;
    } else if (this! == dio_http_client.DioExceptionType.connectionError) {
      return HttpClientErrorType.connectionError;
    } else if (this! == dio_http_client.DioExceptionType.unknown) {
      return HttpClientErrorType.unknown;
    } else {
      return null;
    }
  }
}

extension _HttpClientResponseErrorTransformExt<T> on Future<HttpClientResponse<T>> {
  Future<HttpClientResponse<O>> transformError<O>() {
    return then<HttpClientResponse<O>>((httpClientResponse) {
      return HttpClientResponse<O>(
        data: httpClientResponse.data as O,
        headers: httpClientResponse.headers,
        requestOptions: httpClientResponse.requestOptions,
        isRedirect: httpClientResponse.isRedirect,
        statusCode: httpClientResponse.statusCode,
        statusMessage: httpClientResponse.statusMessage,
        redirects: httpClientResponse.redirects
      );
    }).catchError((e, stackTrace) {
      if (e is dio_http_client.DioException) {
        throw e.toHttpClientError()!;
      }
      throw e;
    });
  }
}