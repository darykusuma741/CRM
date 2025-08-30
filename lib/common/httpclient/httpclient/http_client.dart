import '../../processing/future_processing_cancellation/httpclientfutureprocessingcancellation/http_client_future_processing_cancellation.dart';
import '../http_client_header.dart';
import '../http_client_option.dart';
import '../http_client_request_option.dart';
import '../http_client_response.dart';

abstract class HttpClient {
  abstract String baseUrl;

  Future<HttpClientResponse<T>> delete<T>(String path, {data, Map<String, dynamic>? queryParameters, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation});
  Future<HttpClientResponse<T>> deleteUri<T>(Uri uri, {data, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation});
  Future<HttpClientResponse> download(String urlPath, savePath, {ProgressCallback? onReceiveProgress, Map<String, dynamic>? queryParameters, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, bool deleteOnError = true, String lengthHeader = HttpClientHeader.contentLengthHeader, data, HttpClientOption? options});
  Future<HttpClientResponse> downloadUri(Uri uri, savePath, {ProgressCallback? onReceiveProgress, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, bool deleteOnError = true, String lengthHeader = HttpClientHeader.contentLengthHeader, data, HttpClientOption? options});
  Future<HttpClientResponse<T>> fetch<T>(HttpClientRequestOption httpClientRequestOption);
  Future<HttpClientResponse<T>> post<T>(String path, {data, Map<String, dynamic>? queryParameters, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress});
  Future<HttpClientResponse<T>> postUri<T>(Uri uri, {data, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress});
  Future<HttpClientResponse<T>> put<T>(String path, {data, Map<String, dynamic>? queryParameters, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress});
  Future<HttpClientResponse<T>> putUri<T>(Uri uri, {data, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress});
  Future<HttpClientResponse<T>> get<T>(String path, {Map<String, dynamic>? queryParameters, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, ProgressCallback? onReceiveProgress});
  Future<HttpClientResponse<T>> getUri<T>(Uri uri, {HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation, ProgressCallback? onReceiveProgress});
  Future<HttpClientResponse<T>> head<T>(String path, {data, Map<String, dynamic>? queryParameters, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation});
  Future<HttpClientResponse<T>> headUri<T>(Uri uri, {data, HttpClientOption? options, HttpClientFutureProcessingCancellation? httpClientFutureProcessingCancellation});
}