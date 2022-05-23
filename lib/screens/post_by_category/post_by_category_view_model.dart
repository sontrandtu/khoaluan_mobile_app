import 'package:flutter/cupertino.dart';
import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/category_model.dart';
import 'package:khoaluan_mobile_app/repository/post_repository.dart';

import '../../model/post_model.dart';

class PostByCategoryViewModel extends BaseViewModel{
  PostRepository postRepo;
  CategoryModel? category;

  List<PostModel> posts = [];
  PostByCategoryViewModel({required this.postRepo, this.category}) : super(postRepo){
    getData();
  }

  Future<void> getData({VoidCallback? onLoadedCallback, ErrorCallback? errorCallback}) async{
    setLoading = true;
    final response = await postRepo.getListPostByCategory(categoryId: category?.id);
    if(response.isOk){
      posts = response.data?.data ?? [];
    } else{
      errorCallback?.call(response.messages);
    }
    onLoadedCallback?.call();
    setLoading = false;
  }

}