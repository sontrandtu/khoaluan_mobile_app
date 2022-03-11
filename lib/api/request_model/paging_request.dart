import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import '../api_config.dart';
part 'paging_request.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class PagingRequest {
  int? page;
  int? length = ApiConfig.pageSize;
  String? search;
  bool? reachMaxPage;

  PagingRequest({this.page, this.length = ApiConfig.pageSize, this.search, this.reachMaxPage = false});

  PagingRequest.init({this.length = ApiConfig.pageSize, this.search})  : reachMaxPage = false, page = 1;

  PagingRequest.search({this.length = ApiConfig.pageSize, this.search})  : reachMaxPage = false, page = 1;

  factory PagingRequest.fromJson(Map<String, dynamic> json) => _$PagingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PagingRequestToJson(this);
}
