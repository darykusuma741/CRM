import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: implementation_imports
import 'package:pretty_http_logger/src/middleware/http_methods.dart';
// ignore: implementation_imports
import 'package:pretty_http_logger/src/middleware/middleware_contract.dart';
// ignore: implementation_imports
import 'package:pretty_http_logger/src/middleware/models/request_data.dart';
// ignore: implementation_imports
import 'package:pretty_http_logger/src/middleware/models/response_data.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../helper/logger_helper.dart';
import '../../helper/login_helper.dart';
import '../../helper/string_helper.dart';
import '../../responsewrapper/response_wrapper.dart';

///Class to be used by the user to set up a new `http.Client` with middleware supported.
///call the `build()` constructor passing in the list of middlewares.
///Example:
///```dart
/// HttpClientWithMiddleware httpClient = HttpClientWithMiddleware.build(middlewares: [
///     Logger(),
/// ]);
///```
///
///Then call the functions you want to, on the created `http` object.
///```dart
/// httpClient.get(...);
/// httpClient.post(...);
/// httpClient.put(...);
/// httpClient.delete(...);
/// httpClient.head(...);
/// httpClient.patch(...);
/// httpClient.read(...);
/// httpClient.readBytes(...);
/// httpClient.send(...);
/// httpClient.close();
///```
///Don't forget to close the client once you are done, as a client keeps
///the connection alive with the server.
class ModifiedHttpClientWithMiddleware extends http.BaseClient {
  Timer? _timer;
  bool hasLogout = false;

  List<MiddlewareContract>? middlewares;
  Duration? requestTimeout;

  // final IOClient _client = IOClient();
  static final http.Client _client = http.Client();

  ModifiedHttpClientWithMiddleware._internal(
      {this.middlewares = const [],
      this.requestTimeout = const Duration(seconds: 10)});

  factory ModifiedHttpClientWithMiddleware.build({
    List<MiddlewareContract>? middlewares,
    Duration? requestTimeout,
  }) {
    //Remove any value that is null.
    // middlewares?.removeWhere((middleware) => middleware == null);
    return ModifiedHttpClientWithMiddleware._internal(
      middlewares: middlewares,
      requestTimeout: requestTimeout,
    );
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) =>
      _sendUnstreamed('HEAD', url, headers);

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) =>
      _sendUnstreamed('GET', url, headers);

  @override
  Future<http.Response> post(Uri url,
          {Map<String, String>? headers, body, Encoding? encoding}) =>
      _sendUnstreamed('POST', url, headers, body, encoding);

  @override
  Future<http.Response> put(Uri url,
          {Map<String, String>? headers, body, Encoding? encoding}) =>
      _sendUnstreamed('PUT', url, headers, body, encoding);

  @override
  Future<http.Response> patch(Uri url,
          {Map<String, String>? headers, body, Encoding? encoding}) =>
      _sendUnstreamed('PATCH', url, headers, body, encoding);

  @override
  Future<http.Response> delete(Uri url,
          {Map<String, String>? headers, body, Encoding? encoding}) =>
      _sendUnstreamed('DELETE', url, headers);

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    return get(url, headers: headers).then((response) {
      _checkResponseSuccess(url, response);
      return response.body;
    });
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    return get(url, headers: headers).then((response) {
      _checkResponseSuccess(url, response);
      return response.bodyBytes;
    });
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    LoggerHelper.appLogger.d(
      "Send: ${request.toString()}\r\n${request.headers}\r\n${request.runtimeType}"
    );
    if (request is http.Request) {
      String lastBody = request.body;
      String newBody = "";
      try {
        bool found = false;
        dynamic response = json.decode(lastBody);
        if (response is Map<String, dynamic>) {
          if (response.containsKey("query")) {
            String query = ResponseWrapper(response["query"]).mapFromResponseToNonNullableString();
            response = Map.of(response);
            response["query"] = StringHelper().minifyGraphQuery(query);
            newBody = json.encode(response);
            found = true;
          }
        }
        if (!found) {
          newBody = lastBody;
        }
      } catch(e) {
        newBody = lastBody;
      }
      request.body = newBody;
      LoggerHelper.appLogger.d(request.body);
    }
    final response = await _client.send(request);
    var responseBytes = await response.stream.toBytes();
    var responseJson = utf8.decode(responseBytes);
    try {
      var responseJsonMap = json.decode(responseJson);
      if (responseJsonMap is Map<String, dynamic>) {
        if (responseJsonMap.containsKey("title")) {
          String response = ResponseWrapper(responseJsonMap["title"]).mapFromResponseToNonNullableString();
          if (response.toLowerCase() == "unauthorized") {
            if (!hasLogout) {
              if (_timer != null) {
                _timer!.cancel();
              }
              _timer = Timer(
                const Duration(milliseconds: 33),
                () async {
                  if (!hasLogout) {
                    hasLogout = true;
                    await LoginHelper.deleteLoginData();
                    Get.offNamed(Routes.LOGIN);
                  }
                }
              );
            }
          }
        }
      }
    } catch (e) {
      // nope
    }
    return http.StreamedResponse(
      Stream.fromIterable([responseBytes]),
      response.statusCode,
      headers: response.headers,
      reasonPhrase: response.reasonPhrase,
      request: response.request,
    );
  }

  Future<http.Response> multipart(http.MultipartRequest request) async {
    final fields = request.fields;

    fields.addEntries(request.files.map((el) {
      return MapEntry('FILE->${el.field}', el.filename ?? '');
    }).toList());
    middlewares?.forEach(
      (middleware) => middleware.interceptRequest(
        RequestData(
          method: methodFromString(request.method),
          body: fields,
          url: request.url,
          headers: request.headers,
        ),
      ),
    );

    var stream = requestTimeout == null
        ? await send(request)
        : await send(request).timeout(requestTimeout!);

    return http.Response.fromStream(stream).then((response) {
      var responseData = ResponseData.fromHttpResponse(response);

      middlewares
          ?.forEach((middleware) => middleware.interceptResponse(responseData));

      var resultResponse = http.Response(
        responseData.body,
        responseData.statusCode,
        headers: responseData.headers ?? {},
        persistentConnection: responseData.persistentConnection ?? false,
        isRedirect: responseData.isRedirect ?? false,
        request: http.Request(
          responseData.method.toString().substring(7),
          Uri.parse(responseData.url),
        ),
      );

      return resultResponse;
    }).catchError((err) {
      middlewares?.forEach((middleware) => middleware.interceptError(err));
      throw http.ClientException(
          '${err.toString().replaceAll("Exception:", "")}', request.url);
    });
  }

  Future<http.Response> _sendUnstreamed(
      String method, url, Map<String, String>? headers,
      [dynamic body, Encoding? encoding]) async {
    if (url is String) url = Uri.parse(url);
    var request = http.Request(method, url);

    if (headers != null) request.headers.addAll(headers);
    if (encoding != null) request.encoding = encoding;
    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is List) {
        request.bodyBytes = body.cast<int>();
      } else if (body is Map) {
        request.bodyFields = body.cast<String, String>();
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }

    //Send interception
    middlewares?.forEach(
      (middleware) => middleware.interceptRequest(
        RequestData(
          method: methodFromString(method),
          encoding: encoding,
          body: body,
          url: url,
          headers: headers ?? <String, String>{},
        ),
      ),
    );

    var stream = requestTimeout == null
        ? await send(request)
        : await send(request).timeout(requestTimeout!);

    return http.Response.fromStream(stream).then((response) {
      var responseData = ResponseData.fromHttpResponse(response);

      middlewares
          ?.forEach((middleware) => middleware.interceptResponse(responseData));

      var resultResponse = http.Response(
        responseData.body,
        responseData.statusCode,
        headers: responseData.headers ?? {},
        persistentConnection: responseData.persistentConnection ?? false,
        isRedirect: responseData.isRedirect ?? false,
        request: http.Request(
          responseData.method.toString().substring(7),
          Uri.parse(responseData.url),
        ),
      );

      return resultResponse;
    }).catchError((err) {
      middlewares?.forEach((middleware) => middleware.interceptError(err));
      throw http.ClientException(
          '${err.toString().replaceAll("Exception:", "")}', url);
    });
  }

  void _checkResponseSuccess(url, http.Response response) {
    if (response.statusCode < 400) return;
    var message = 'Request to $url failed with status ${response.statusCode}';
    if (response.reasonPhrase != null) {
      message = '$message: ${response.reasonPhrase}';
    }
    if (url is String) url = Uri.parse(url);
    throw http.ClientException('$message.', url);
  }

  @override
  void close() {
    _client.close();
  }
}