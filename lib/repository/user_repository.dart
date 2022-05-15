import 'package:khoaluan_mobile_app/api/api_response.dart';
import 'package:khoaluan_mobile_app/api/dio_helper.dart';
import 'package:khoaluan_mobile_app/api/res_client.dart';
import 'package:khoaluan_mobile_app/app_config.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/repository.dart';

class UserRepository extends Repository {
  Future<ApiResponse<dynamic>> login({UserModel? userModel}) async {
    return await apiClient!.login(userModel: userModel).wrap();
  }

  // Future<ApiResponse<dynamic>> getOTP({String? phoneNumber}) async {
  //   return await RestClient(
  //       DioHelper.dioObject!,
  //     baseUrl: AppConfig.prefixUrlOTP
  //   ).getOTP(phoneNumber: phoneNumber).wrap();
  // }

  Future<ApiResponse<dynamic>> getOTP({String? phoneNumber}) async {
    return await apiClient!.getOTP(phoneNumber: phoneNumber).wrap();
  }

  Future<ApiResponse<UserModel>> getInfo() async {
    return await apiClient!.getInfo().wrap();
  }
}


