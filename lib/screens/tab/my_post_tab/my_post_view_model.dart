
import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/my_post_model.dart';
import 'package:khoaluan_mobile_app/repository/post_repository.dart';


class MyPostViewModel extends BaseViewModel{

  PostRepository postRepo;

  MyPostModel? myPostModel = MyPostModel();

  MyPostViewModel({required this.postRepo}) : super(postRepo){
    getData();
  }

  Future<void> getData({VoidCallback? onLoadedCallback, ErrorCallback? errorCallback}) async{
    setLoading = true;
    final response = await postRepo.getPostsByUser();
    if(response.isOk){
      myPostModel = response.data ?? MyPostModel();
    } else{
      errorCallback?.call(response.error);
    }
    onLoadedCallback?.call();
    setLoading = false;
  }

}