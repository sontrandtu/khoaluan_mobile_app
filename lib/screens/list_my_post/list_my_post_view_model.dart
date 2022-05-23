import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/repository/post_repository.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';

import '../../model/my_post_model.dart';

class ListMyPostViewModel extends BaseViewModel{
  PostRepository postRepo;
  UserRepository userRepo;

  String? userId = '';
  String? postId = '';

  MyPostModel? myPostModel = MyPostModel();

  ListMyPostViewModel({required this.postRepo, required this.userRepo}) : super(postRepo){
    getData();
  }

  Future<void> getData({VoidCallback? onLoadedCallback, ErrorCallback? errorCallback}) async{
    setLoading = true;
    userId = await getUserId();
    final response = await postRepo.getPostsByUser(userId: userId);
    if(response.isOk){
      myPostModel = response.data ?? MyPostModel();
    } else{
      errorCallback?.call(response.error);
    }
    onLoadedCallback?.call();
    setLoading = false;
  }

  Future<String?> getUserId() async{
    String? id;
    final response = await userRepo.getInfo();
    if(response.isOk){
      id = response.data?.id ?? '';
    }
    return id;
  }

  Future<void> deletePost({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async{
    setLoading = true;
    final response = await postRepo.deletePost(postId: postId);
    if(response.isOk){
      successCallback?.call("Xoá bài viết thành công");
    }else{
      errorCallback?.call("Xoá bài viết thất bại, vui lòng thử lại");
    }
  }
}