import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/category_model.dart';
import 'package:khoaluan_mobile_app/repository/category_repository.dart';

class SearchPostViewModel extends BaseViewModel{
  CategoryRepository categoryRepo;

  List<CategoryModel> categories = [];
  SearchPostViewModel({required this.categoryRepo}) : super(categoryRepo){
    loadData();
  }
  Future<void> loadData() async{
    setLoading = true;
    final response = await categoryRepo.getCategories();
    if(response.isOk){
      categories = response.data ?? [];
    }
    setLoading = false;
  }
}