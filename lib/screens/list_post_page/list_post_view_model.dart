import 'package:khoaluan_mobile_app/api/api_response.dart';
import 'package:khoaluan_mobile_app/api/response_model/list_response.dart';
import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/base/loadmore_mixin.dart';

import '../../repository/post_repository.dart';

class ListPostViewModel extends BaseViewModel with LoadMoreMixin{
  final PostRepository postRepo;
  final String? categoryId;

  ListPostViewModel({required this.postRepo, this.categoryId}) : super(postRepo){
    refreshData(needShowLoading: true);
  }

  @override
  Future<ApiResponse<ListResponse<List>>> getData() {
    return postRepo.getListPostByCategory(categoryId: categoryId ?? "all");
  }

  @override
  void notifyData() {
    notifyListeners();
  }

  @override
  set notifyLoading(bool value) {
    setLoading = value;
  }

}