
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:khoaluan_mobile_app/api/response_model/list_response.dart';
import 'package:khoaluan_mobile_app/api/response_model/login_response.dart';
import 'package:khoaluan_mobile_app/model/add_post_model.dart';
import 'package:khoaluan_mobile_app/model/change_password_model.dart';
import 'package:khoaluan_mobile_app/model/forgot_password_model.dart';
import 'package:khoaluan_mobile_app/model/get_lat_lng_model.dart';
import 'package:khoaluan_mobile_app/model/hash_model.dart';
import 'package:khoaluan_mobile_app/model/post_address_model.dart';
import 'package:khoaluan_mobile_app/model/post_details_model.dart';
import 'package:khoaluan_mobile_app/model/image_model.dart';
import 'package:khoaluan_mobile_app/model/location_model.dart';
import 'package:khoaluan_mobile_app/model/my_post_model.dart';
import 'package:khoaluan_mobile_app/model/register_model.dart';
import 'package:khoaluan_mobile_app/model/result_model.dart';
import 'package:khoaluan_mobile_app/model/update_post_model.dart';
import 'package:khoaluan_mobile_app/model/update_user_model.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:retrofit/retrofit.dart';

import '../app_config.dart';
import '../model/category_model.dart';
import '../model/change_phone_number_model.dart';
import '../model/post_model.dart';
part 'res_client.g.dart';

const int pageSize = 20;

@RestApi(baseUrl: AppConfig.prefixUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/auth/login')
  Future<HttpResponse<LoginResponse>> login({
    @Body() UserModel? userModel,
  });

  @POST('/auth/register')
  Future<HttpResponse<dynamic>> registerUser({
    @Body() RegisterModel? userModel,
  });

  @POST('/auth/forget_password')
  Future<HttpResponse<dynamic>> forgotPassword({
    @Body() ForgotPasswordModel? newPassword,
  });

  @POST('/user/change_phoneNumber')
  Future<HttpResponse<dynamic>> changePhoneNumber({
    @Body() ChangePhoneNumberModel? newPhoneNumber,
  });

  @GET('/auth/send_code_new?phoneNumber={phoneNumber}')
  Future<HttpResponse<HashModel>> getOTPNew({
    @Path('phoneNumber') String? phoneNumber
  });

  @GET('/auth/send_code_current?phoneNumber={phoneNumber}')
  Future<HttpResponse<HashModel>> getOTPForgotPassword({
    @Path('phoneNumber') String? phoneNumber
  });

  @GET('/auth/veryfy?phoneNumber={phoneNumber}&code={otp}&hash={hash}')
  Future<HttpResponse<dynamic>> verifyOTP({
    @Path('phoneNumber') String? phoneNumber,
    @Path('otp') String? otp,
    @Path('hash') String? hash,
  });

  @GET('/user/get_info')
  Future<HttpResponse<UserModel>> getInfo();


  @PUT("/user/update_user/{id}")
  Future<HttpResponse<dynamic>>updateUser({
    @Path('id') String? id,
    @Body() UpdateUserModel? userModel
  });

  @PUT('/user/change_password')
  Future<HttpResponse<ResultModel>> changePassword({
  @Body() ChangePasswordModel? changePasswordModel
});


  @GET('/categories/get_all')
  Future<HttpResponse<List<CategoryModel>>> getCategories();

  @GET('/post/get_post_by_categories/{categoryId}')
  Future<HttpResponse<ListResponse<List<PostModel>>>> getListPostByCategory({
    @Path('categoryId') String? categoryId
  });

  @GET('/post/get_post_by_user/{userId}')
  Future<HttpResponse<MyPostModel>> getPostsByUser({
    @Path('userId') String? userId
  });

  @GET('/post/get_post_lastest_app')
  Future<HttpResponse<ListResponse<List<PostModel>>>> getLatestPost();

  @PUT('/post/update_post/{postId}')
  Future<HttpResponse<dynamic>> updatePost({
    @Path('postId') String? postId,
    @Body() UpdatePostModel? updatePostModel
  });

  @GET('/post/get_post_item/{postId}')
  Future<HttpResponse<PostDetailsModel>> getDetailsPostById({
    @Path('postId') String? postId
  });

  @POST('/post/add_post')
  Future<HttpResponse<dynamic>> addPost({
    @Body() AddPostModel? addPostModel,
  });

  @DELETE('/post/delete_post/{postId}')
  Future<HttpResponse<dynamic>>deletePost({
    @Path('postId') String? postId
  });




  @MultiPart()
  @POST('/images/multiple_upload')
  Future<HttpResponse<List<ImageModel>>> addMultiImages(
      @Part(name: 'file') List<File> listImage,
      );

  @MultiPart()
  @POST('/images/upload')
  Future<HttpResponse<ImageModel>> addImage({
    @Part(name: 'file') File? image,
  });

  @GET('/place/city')
  Future<HttpResponse<LocationModel>> getLocation();

  @POST('/place/geocoder')
  Future<HttpResponse<LatLngModel>> getLatLng({
    @Body() PostAddressModel? address
  });
}
