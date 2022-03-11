// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PaginationCopyWith on Pagination {
  Pagination copyWith({
    int? count,
    dynamic? length,
    dynamic? page,
    dynamic? search,
    int? total,
  }) {
    return Pagination(
      count: count ?? this.count,
      length: length ?? this.length,
      page: page ?? this.page,
      search: search ?? this.search,
      total: total ?? this.total,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map json) {
  return Pagination(
    page: json['page'],
    count: json['count'] as int?,
    length: json['length'],
    search: json['search'],
    total: json['total'] as int?,
  )..reachMaxPage = json['reachMaxPage'] as bool?;
}

Map<String, dynamic> _$PaginationToJson(Pagination instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('length', instance.length);
  writeNotNull('search', instance.search);
  writeNotNull('reachMaxPage', instance.reachMaxPage);
  writeNotNull('count', instance.count);
  writeNotNull('total', instance.total);
  return val;
}
