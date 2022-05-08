import 'package:khoaluan_mobile_app/model/category_model.dart';

import '../api/api_response.dart';
import 'repository.dart';

class CategoryRepository extends Repository {
  Future<ApiResponse<List<CategoryModel>>> getCategories() async {
    return await apiClient!.getCategories().wrap();
  }
}