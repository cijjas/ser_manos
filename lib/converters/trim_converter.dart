import 'package:json_annotation/json_annotation.dart';

class TrimConverter implements JsonConverter<String, dynamic> {
  const TrimConverter();

  @override
  String fromJson(dynamic json) =>
      (json as String).replaceAll(RegExp(r'\s+'), '');

  @override
  String toJson(String object) =>
      object.replaceAll(RegExp(r'\s+'), '');
}