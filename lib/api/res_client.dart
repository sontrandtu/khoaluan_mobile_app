
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

  @GET('post/get_post_lastest_app')
  Future<HttpResponse<PostModel>> getLatestPost();

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
//
// @GET('/comments-by-article?article_id={id}')
// Future<HttpResponse<ListResponse<List<CommentModel>>>> getCommentsByLevel(@Path('id') int? articleId, @Query('level') int level);
//
// @POST('/form-data')
// Future<HttpResponse<FormDataModel>> postFormData(
//     @Part(name: "name") String username,
//     @Part(name: "phone") String phone,
//     @Part(name: "email") String email,
//     @Part(name: "note") String note,
//     @Part(name: "category_id") int categoryId,
//     );
//
// @GET('/widgets/popup-khuyen-mai')
// Future<HttpResponse<PopUpModel>> getPopUpDetails();
//
// @GET('/posts?')
// Future<HttpResponse<List<NewModel>>> getNewsByCategory(
//     @Query('categories') int? categories,
//     @Query('page') int? page,
//     @Query('per_page') int? perPage,
//     @Query('orderBy') String? orderBy,
//     @Query('order') String? order,
//     );
//
// @GET('/posts/{id}')
// Future<HttpResponse<NewModel>> getNewDetails({
//   @Path('id') int? id,
// });
//
// @MultiPart()
// @GET('/posts?')
// Future<HttpResponse<List<NewModel>>> getListNewsData({
//   @Query('categories') int? categories,
//   @Query('page') int? page,
//   @Query('per_page') int? perPage,
//   @Query('orderBy') String? orderBy,
//   @Query('order') String? order,
// });
//
// @GET('/posts?')
// Future<HttpResponse<List<NewModel>>> getNewsByCategories(
//     @Query('categories') String? categories,
//     @Query('page') int? page,
//     @Query('per_page') int? perPage,
//     @Query('orderBy') String? orderBy,
//     @Query('order') String? order,
//     );
//
// @GET('/slider/options')
// Future<HttpResponse<SliderListResponse<List<SliderModel>>>> getSlider();
//
// @GET('/companies')
// Future<HttpResponse<ListResponse<List<CompanyModel>>>> getCompanies();
//
// @GET('/branches')
// Future<HttpResponse<ListResponse<List<BranchModel>>>> getBranches(
//     @Query('children') int? children,
//     );
//
// @GET('/time-slot')
// Future<HttpResponse<ListResponse<List<TimeSlotModel>>>> getTimeSlots();
//
// @MultiPart()
// @POST('/login')
// Future<HttpResponse<LoginResponse>> login(@Part(name: "phone") String phone);
//
// @MultiPart()
// @POST('/doctor-login')
// Future<HttpResponse<LoginDoctorResponse>> loginDoctor(@Part(name: "email") String email, @Part(name: "password") String password);
//
// @MultiPart()
// @POST('/verify-otp')
// Future<HttpResponse<UserInfoModel>> verifyOTP(@Part(name: "phone") String phone, @Part(name: "otp") String otp);
//
// @MultiPart()
// @POST('/bookings')
// Future<HttpResponse<BookingModel>> bookingTreament(
//     @Part(name: "branch_id") int branchId,
//     @Part(name: "doctor") int? doctor,
//     @Part(name: "time_slot") int timeSlot,
//     @Part(name: "type_id") int typeId,
//     @Part(name: "username") String username,
//     @Part(name: "phone") String phone,
//     @Part(name: "birthday") String birthday,
//     @Part(name: "appointment_date") String appointmentDate,
//     @Part(name: "reason") String reason);
//
// @GET('/booking-type')
// Future<HttpResponse<ListResponse<List<BookingTypeModel>>>> getListBookingType();
//
// @GET('/branch/{id}/doctors?')
// Future<HttpResponse<ListResponse<List<DoctorModel>>>>getDoctorsByBranch(@Path('id') int? id);
//
// @MultiPart()
// @POST('/logout')
// Future<HttpResponse> logOut();
//
// @GET('/category-list/{id}')
// Future<HttpResponse<ListResponse<List<CategoryModel>>>> getListCategory(@Path('id') int? id);
//
// @GET('/categories/{id}')
// Future<HttpResponse<CategoryModel>> getCategoryDetail(@Path('id') int? id);
//
// @GET('/categories/{id}/articles')
// Future<HttpResponse<ListResponse<List<ArticleModel>>>> getArticleByCategory(
//     @Path('id') int? id,
//     @Query('page') int page,
//     @Query('limit') int limit
//     );
//
// @GET('/article-related/{id}')
// Future<HttpResponse<ListResponse<List<ArticleModel>>>> getArticleRelated(
//     @Path('id') int? id,
//     @Query('page') int page,
//     @Query('limit') int limit
//     );
//
// @GET('/categories/{id}/articles')
// Future<HttpResponse<ListResponse<List<ArticleModel>>>> getArticleByCategoryAndType({
//   @Path('id') int? id,
//   @Query('page') int? page,
//   @Query('limit') int? limit,
//   @Query('type') String? type,
//   @Query('keyword') String? keyword
// });
//
// @GET('/article-type/{type}/articles')
// Future<HttpResponse<ListResponse<List<ArticleModel>>>> getArticleByType({
//   @Path('type') String? type,
//   @Query('page') int? page,
//   @Query('limit') int? limit,
//   @Query('keyword') String? keyword
// });
//
// @GET('/articles/{id}')
// Future<HttpResponse<ArticleModel>> getArticleDetail(@Path('id') int? id);
//
// @GET('/search?')
// Future<HttpResponse<ListResponse<List<VideoModel>>>> getYoutubeVideoByPart({
//   @Query('key') String? key,
//   @Query('channelId') String? channelID,
//   @Query('part') String? part,
//   @Query('oder') String? oder,
//   @Query('maxResult') int? maxResults,
// });
//
// @GET('/search?')
// Future<HttpResponse<VideoModel>> getVideoDetail({
//   @Query('part') String? part,
//   @Query('channelId') String? channelID,
//   @Query('key') String? key,
// });
//
// @GET('/doctors')
// Future<HttpResponse<ListResponse<List<DoctorModel>>>> getListDoctor(@Query('page') int page, @Query('limit') int limit);
//
// @GET('/doctors')
// Future<HttpResponse<ListResponse<List<DoctorModel>>>> getListDoctorByBranch(@Query('branch_id') int branchId);
//
// @GET('/doctors-form')
// Future<HttpResponse<ListResponse<List<DoctorModel>>>> getAllDoctor();
//
// @GET('/doctors/{id}')
// Future<HttpResponse<DoctorModel>> getDoctorDetail(@Path('id') int? id);
//
// @GET('/doctors/{id}')
// Future<HttpResponse<DoctorModel>> getDoctorData(@Path('id') String id);
//
// @GET('/orders')
// Future<HttpResponse<ListResponse<List<OrderModel>>>> getListOder(@Query('examination_card_id') int? examinationCardId, @Query('page') int page, @Query('limit') int limit);
//
// @GET('/examination-card')
// Future<HttpResponse<ListResponse<List<ExaminationCardModel>>>>
// getListExaminationCard(
//     @Query('page') int page, @Query('limit') int limit);
//
// @GET('/bookings')
// Future<HttpResponse<ListResponse<List<HistoryModel>>>> getListHistory(@Query('page') int page, @Query('limit') int limit);
//
// @GET('/accounts')
// Future<HttpResponse<UserInfoModel>> getUserInfo();
//
// @GET('/doctors')
// Future<HttpResponse<ListResponse<List<DoctorChatModel>>>> getListDoctorChat({@Query('page') int? page, @Query('limit') int? limit, @Query('keyword') String? search = ''});
//
// @GET('/account-list')
// Future<HttpResponse<ListResponse<List<UserChatModel>>>> getListUserChat({@Query('page') int? page, @Query('limit') int? limit, @Query('keyword') String? search = ''});
//
// @MultiPart()
// @PUT('/accounts')
// Future<HttpResponse<UserInfoModel>> updateUserInfo({
//   @Part(name: "username") String? username,
//   @Part(name: "phone") String? phone,
//   @Part(name: "birthday") String? birthday,
//   @Part(name: "address") String? address,
//   @Part(name: "gender") String? gender,
//   @Part(name: "image") String? image,
//   @Part(name: 'province_id') int? provinceId,
//   @Part(name: 'district_id') int? districtId,
//   @Part(name: 'ward_id') int? wardId,
// });
//
// @GET('/account-related-list')
// Future<HttpResponse<ListResponse<List<UserInfoModel>>>> getListRelative(@Query('page') int page, @Query('limit') int limit);
//
// @GET('/account-related-list')
// Future<HttpResponse<ListResponse<List<UserInfoModel>>>> getAllRelative();
//
// @MultiPart()
// @POST('/account-related')
// Future<HttpResponse<UserInfoModel>> createRelative(
//     @Part(name: 'username') String username,
//     @Part(name: 'phone') String phone,
//     @Part(name: 'birthday') String birthday,
//     @Part(name: 'address') String address,
//     @Part(name: 'gender') String gender,
//     @Part(name: 'province_id') int? provinceId,
//     @Part(name: 'district_id') int? districtId,
//     @Part(name: 'ward_id') int? wardId,
//     );
//
// @MultiPart()
// @PUT('/account-related/{id}')
// Future<HttpResponse<UserInfoModel>> updateRelativeInfo(
//     @Path('id') int relativeId,
//     @Part(name: "username") String username,
//     @Part(name: "phone") String phone,
//     @Part(name: "birthday") String birthday,
//     @Part(name: "address") String address,
//     @Part(name: "gender") String gender,
//     @Part(name: 'province_id') int? provinceId,
//     @Part(name: 'district_id') int? districtId,
//     @Part(name: 'ward_id') int? wardId,
//     );
//
// @DELETE('/account-related/{id}')
// Future<HttpResponse<UserInfoModel>> deleteRelative(@Path('id') int id);
//
// @GET('/account-related/{id}')
// Future<HttpResponse<UserInfoModel>> getRelativeDetail(@Path('id') int? id);
//
// //------------------------------------------- order medicine
//
// @MultiPart()
// @POST('/order-medicine')
// Future<HttpResponse<OrderMedicineModel>> createOrderMedicine({
//   @Part(name: 'category_id') int? categoryId,
//   @Part(name: 'quantity') int? quantity,
//   @Part(name: 'province_id') int? provinceId,
//   @Part(name: 'district_id') int? districtId,
//   @Part(name: 'ward_id') int? wardId,
//   @Part(name: 'is_have_prescription') bool? isHavePrescription,
//   @Part(name: 'state') String? state,
//   @Part(name: 'receiver_name') String? receiverName,
//   @Part(name: 'receiver_phone') String? receiverPhone,
//   @Part(name: 'payment_type') String? paymentType,
//   @Part(name: 'address') String? address,
//   @Part(name: 'note') String? note,
//   @Part(name: 'delivery_note') String? deliveryNote,
//   @Part(name: 'prescription_image') File? prescriptionImage,
// });
//
// @GET('/order-medicine-list')
// Future<HttpResponse<ListResponse<List<HistoryOrderMedicineModel>>>> getListOrderMedicine(@Query('page') int page, @Query('limit') int limit);
//
// @GET('/location-list-province')
// Future<HttpResponse<ListResponse<List<LocationModel>>>> getListProvince();
//
// @GET('/location-list-district?province_id={id}')
// Future<HttpResponse<ListResponse<List<LocationModel>>>> getListDistrict(@Path('id') int provinceId);
//
// @GET('/location-list-ward?district_id={id}')
// Future<HttpResponse<ListResponse<List<LocationModel>>>> getListWard(@Path('id') int districtId);
//
// @GET('/form-data-category')
// Future<HttpResponse<ListResponse<List<FormCategoryModel>>>> getFormCategory();
//
// @GET('/form-data-list')
// Future<HttpResponse<ListResponse<List<HistoryFormDataModel>>>> getListFormData(@Query('page') int page, @Query('limit') int limit, @Query('category_id') int formCategoryId);
//
// @MultiPart()
// @PUT('/update-avatar')
// Future<HttpResponse<UserInfoModel>> updateAvatar(@Part() File image, {@SendProgress() ProgressCallback? callback});
//
// @MultiPart()
// @POST('/registration-device-token')
// Future<HttpResponse<dynamic>> registerFCMToken(@Part(name: 'registration_id') String? fcmToken);
//
// @PUT('/accounts')
// Future<HttpResponse<UserInfoModel>> registerTopic(
//     @Part(name: "topic_of_interest_ids") List<String> topicOfInterestIds
//     );
//
// @GET('/notify-topics')
// Future<HttpResponse<ListResponse<List<CategoryModel>>>> getListTopic();
//
// @GET('/configs')
// Future<HttpResponse<ConfigModel>> getConfigs();
}
