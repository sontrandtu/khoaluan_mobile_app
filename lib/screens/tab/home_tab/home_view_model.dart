import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/api/api_response.dart';
import 'package:khoaluan_mobile_app/api/response_model/list_response.dart';
import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/category_model.dart';
import 'package:khoaluan_mobile_app/model/post_model.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/category_repository.dart';
import 'package:khoaluan_mobile_app/repository/post_repository.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';

class HomeViewModel extends BaseViewModel{
  UserRepository userRepository;
  CategoryRepository categoryRepo;
  UserRepository repo;
  PostRepository postRepo;

  List<CategoryModel> categories = [];
  List<PostModel> latestPost = [];
  UserModel user = UserModel();
  HomeViewModel({required this.userRepository, required this.repo, required this.categoryRepo, required this.postRepo}) : super(repo) {
    loadData();
  }

  Future<void> loadData({VoidCallback? onLoadedCallback, ErrorCallback? errorCallback}) async{
    setLoading = true;
    final response = await Future.wait([categoryRepo.getCategories(),postRepo.getListPostByCategory(categoryId: "all"), userRepository.getInfo()]);
    if(response[0].isOk){
      categories = response[0].data as List<CategoryModel>;
    }else{
      errorCallback?.call(response[0].messages);
    }
    if(response[1].isOk){
      latestPost = (response[1] as ApiResponse<ListResponse<List<PostModel>>>).data?.data ?? [];
    }else{
      errorCallback?.call(response[0].messages);
    }
    if(response[2].isOk){
      user = response[2].data as UserModel;
    }
    setLoading = false;
    onLoadedCallback?.call();
  }

}