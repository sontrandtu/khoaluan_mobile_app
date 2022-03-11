import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
part 'list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListResponse<T> {
  T? items;
  ListResponse({this.items});
  factory ListResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT,) => _$ListResponseFromJson(json, fromJsonT);
}
