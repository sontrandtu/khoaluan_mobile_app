import 'dart:io';

import 'package:khoaluan_mobile_app/api/response_model/list_response.dart';
import 'package:khoaluan_mobile_app/model/add_post_model.dart';
import 'package:khoaluan_mobile_app/model/post_details_model.dart';
import 'package:khoaluan_mobile_app/model/image_model.dart';
import 'package:khoaluan_mobile_app/model/my_post_model.dart';
import 'package:khoaluan_mobile_app/model/update_post_model.dart';

import '../api/api_response.dart';
import '../model/post_model.dart';
import 'repository.dart';

class PostRepository extends Repository {
  Future<ApiResponse<ListResponse<List<PostModel>>>> getListPostByCategory({
    String? categoryId,
  }) async {
    return await apiClient!.getListPostByCategory(categoryId: categoryId).wrap();
  }
  Future<ApiResponse<ListResponse<List<PostModel>>>> getLatestPost() async {
    return await apiClient!.getLatestPost().wrap();
  }

  Future<ApiResponse<MyPostModel>> getPostsByUser({String? userId}) async {
    return await apiClient!.getPostsByUser(userId: userId).wrap();
  }

  Future<ApiResponse<dynamic>> addPost({AddPostModel? post}) async {
    return await apiClient!.addPost(addPostModel: post).wrap();
  }

  Future<ApiResponse<List<ImageModel>>> addMultiImages({required List<File> listImages}) async {
    return await apiClient!.addMultiImages(listImages).wrap();
  }

  Future<ApiResponse<ImageModel>> addImage({File? image}) async {
    return await apiClient!.addImage(image: image).wrap();
  }

  Future<ApiResponse<PostDetailsModel>> getDetailsPostById({String? postId}) async{
    return await apiClient!.getDetailsPostById(postId: postId).wrap();
  }

  Future<ApiResponse<dynamic>> updatePost({String? postId, UpdatePostModel? updatePostModel}) async{
    return await apiClient!.updatePost(postId: postId,updatePostModel: updatePostModel).wrap();
  }

  Future<ApiResponse<dynamic>> deletePost({String? postId}) async{
    return await apiClient!.deletePost(postId: postId).wrap();
  }
}
