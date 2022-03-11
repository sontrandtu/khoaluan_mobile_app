// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagingResponse<T> _$PagingResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return PagingResponse<T>(
    entries: _$nullableGenericFromJson(json['entries'], fromJsonT),
    pagination: json['pagination'] == null
        ? null
        : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PagingResponseToJson<T>(
  PagingResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'entries': _$nullableGenericToJson(instance.entries, toJsonT),
      'pagination': instance.pagination,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
