import 'package:flutter/cupertino.dart';

import '../api/api_response.dart';
import '../api/request_model/paging_request.dart';
import '../api/response_model/list_response.dart';
import 'base_view_model.dart';

abstract class LoadMoreMixin<T> {
  List<T> _items = [];
  bool showEmptyLayout = false;
  PagingRequest pagingRequest = PagingRequest.init();

  refreshData({OnLoadedCallback? onLoadedCallback, bool needShowLoading = false}) async {
    pagingRequest = PagingRequest.init()..search = pagingRequest.search;
    _items = [];
    await loadData(needShowLoading: needShowLoading);
    onLoadedCallback?.call();
  }

  loadMore({VoidCallback? onLoadedCallback}) async {
    if (!pagingRequest.reachMaxPage!) {
      pagingRequest.page = pagingRequest.page! + 1;
      await loadData(needShowLoading: false);
      onLoadedCallback?.call();
    }
  }

  search(String query) {
    if (query == pagingRequest.search) return;
    pagingRequest = PagingRequest.search(search: query);
    _items = [];
    loadData(needShowLoading: false);
  }

  loadData({bool needShowLoading = true}) async {
    if (needShowLoading) notifyLoading = true;
    final response = await getData();
    if (response.isOk) {
      final data = response.data?.data as List<T>;
      if (data.isEmpty) {
        pagingRequest.reachMaxPage = true;
        if (pagingRequest.page == 1) {
          showEmptyLayout = true;
        }
      } else {
        showEmptyLayout = false;
        if (pagingRequest.page == 1) {
          _items
            ..clear()
            ..addAll(data);
        } else {
          _items.addAll(data);
        }
        notifyData();
      }
    }
    notifyLoading = false;
  }

  Future<ApiResponse<ListResponse<List<T>>>> getData();

  void notifyData();

  set notifyLoading(bool value);

  List<T> get data => _items;
}
