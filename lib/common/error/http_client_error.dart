import '../httpclient/http_client_request_option.dart';
import '../httpclient/http_client_response.dart';

enum HttpClientErrorType {
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badCertificate,
  badResponse,
  cancel,
  connectionError,
  unknown,
}

class HttpClientError extends Error {
  HttpClientRequestOption httpClientRequestOption;
  HttpClientResponse? httpClientResponse;
  HttpClientErrorType httpClientErrorType;
  dynamic error;
  StackTrace? _errorStackTrace;

  HttpClientError({
    required this.httpClientRequestOption,
    this.httpClientResponse,
    this.httpClientErrorType = HttpClientErrorType.unknown,
    this.error,
  });

  set errorStackTrace(StackTrace? stack) => _errorStackTrace = stack;

  StackTrace? get errorStackTrace => _errorStackTrace;

  String get message => (error?.toString() ?? '');

  @override
  String toString() {
    var msg = 'HttpClientError [$httpClientErrorType]: $message';
    if (error is Error) {
      msg += '\n${(error as Error).stackTrace}';
    }
    if (_errorStackTrace != null) {
      msg += '\nSource stack:\n$stackTrace';
    }
    return msg;
  }
}