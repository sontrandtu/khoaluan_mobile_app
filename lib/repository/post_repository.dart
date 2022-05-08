import 'package:khoaluan_mobile_app/api/response_model/list_response.dart';

import '../api/api_response.dart';
import '../model/post_model.dart';
import 'repository.dart';

class PostRepository extends Repository {
  Future<ApiResponse<ListResponse<List<PostModel>>>> getListPostByCategory({
    String? categoryId,
  }) async {
    return await apiClient!.getListPostByCategory(categoryId: categoryId).wrap();
  }
}
