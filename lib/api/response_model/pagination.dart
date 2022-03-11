import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import '../request_model/paging_request.dart';
part 'pagination.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class Pagination extends PagingRequest {
  int? count;
  int? total;

  Pagination({page, this.count, length, search, this.total}) : super(page: page, length: length, search: search);

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
