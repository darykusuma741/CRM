import 'dart:convert';

import 'http_client_redirect_record.dart';
import 'http_client_request_option.dart';

class HttpClientResponse<T> {
  T? data;
  late Map<String, List<String>> headers;
  late HttpClientRequestOption requestOptions;
  int? statusCode;
  String? statusMessage;
  late Map<String, dynamic> extra;
  late List<HttpClientRedirectRecord> redirects;
  bool? isRedirect;

  HttpClientResponse({
    this.data,
    Map<String, List<String>>? headers,
    required this.requestOptions,
    this.isRedirect,
    this.statusCode,
    this.statusMessage,
    List<HttpClientRedirectRecord>? redirects
  }) {
    this.headers = headers ?? {};
    this.redirects = redirects ?? [];
  }

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}