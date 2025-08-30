import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

class DefaultHttpLink extends HttpLink {
  // use the hidden _JsonUtf8Decoder obtained by fusing
  // Utf8Decoder and JsonDecoder
  // see https://github.com/dart-lang/sdk/blob/5b2ea0c7a227d91c691d2ff8cbbeb5f7f86afdb9/sdk/lib/_internal/vm/lib/convert_patch.dart#L40
  static final Converter _defaultHttpResponseDecoder =
  const Utf8Decoder().fuse<Object?>(const JsonDecoder());

  static Map<String, dynamic>? _defaultHttpResponseDecode(
      http.Response httpResponse) =>
      _defaultHttpResponseDecoder.convert(httpResponse.bodyBytes)
      as Map<String, dynamic>?;

  DefaultHttpLink(
    super.uri, {
      super.defaultHeaders = const {},
      super.useGETForQueries = false,
      super.httpClient,
      super.serializer = const RequestSerializer(),
      super.parser = const ResponseParser(),
      super.httpResponseDecoder = _defaultHttpResponseDecode,
      super.followRedirects = false,
    }
  );


}