import 'dart:convert';

import '../login_data.dart';

extension LoginDataExt on LoginData {
  String toJsonString() {
    return json.encode(
      <String, dynamic>{
        "id": id,
        "token": token
      }
    );
  }
}

extension LoginDataStringExt on String {
  LoginData toLoginData() {
    Map<String, dynamic> jsonMap = json.decode(this);
    return LoginData(
      id: jsonMap["id"],
      token: jsonMap["token"]
    );
  }
}