// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:geolocator/geolocator.dart';

class BasePosition {
  bool isError;
  String message;
  Position? position;

  BasePosition({
    required this.isError,
    required this.message,
    this.position,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isError': isError,
      'message': message,
      'position': position?.toJson(),
    };
  }

  factory BasePosition.fromMap(Map<String, dynamic> map) {
    return BasePosition(
      isError: map['isError'] as bool,
      message: map['message'] as String,
      position: map['position'] != null
          ? Position.fromMap(map['position'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BasePosition.fromJson(String source) =>
      BasePosition.fromMap(json.decode(source) as Map<String, dynamic>);
}
