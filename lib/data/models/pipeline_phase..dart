// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

enum PipelinePhaseStatus { onInit, onProgress, done }

class PipelinePhase {
  int id;
  String name;
  dynamic value;
  PipelinePhaseStatus status;
  Color? color;
  TextStyle? fontStyle;

  PipelinePhase(
      {required this.id, required this.name, required this.status, this.color, this.fontStyle, this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'color': color?.value,
    };
  }

  factory PipelinePhase.fromMap(Map<String, dynamic> map) {
    return PipelinePhase(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as PipelinePhaseStatus,
      color: map['color'] != null ? Color(map['color'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PipelinePhase.fromJson(String source) =>
      PipelinePhase.fromMap(json.decode(source) as Map<String, dynamic>);

  PipelinePhase copyWith({
    int? id,
    String? name,
    PipelinePhaseStatus? status,
    Color? color,
    TextStyle? fontStyle
  }) {
    return PipelinePhase(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      color: color ?? this.color,
      fontStyle: fontStyle ?? this.fontStyle
    );
  }
}
