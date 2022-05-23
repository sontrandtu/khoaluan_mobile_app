import 'package:khoaluan_mobile_app/api/api_response.dart';
import 'package:khoaluan_mobile_app/model/change_phone_number_model.dart';
import 'package:khoaluan_mobile_app/model/forgot_password_model.dart';
import 'package:khoaluan_mobile_app/model/hash_model.dart';
import 'package:khoaluan_mobile_app/model/register_model.dart';
import 'package:khoaluan_mobile_app/model/update_user_model.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/repository.dart';

import '../model/change_password_model.dart';
import '../model/result_model.dart';

class UserRepository extends Repository {
  Future<ApiResponse<dynamic>> login({UserModel? userModel}) async {
    return await apiClient!.login(userModel: userModel).wrap();
  }

  Future<ApiResponse<dynamic>> updateUser({UpdateUserModel? updateUser, String? id}) async{
    return await apiClient!.updateUser(userModel: updateUser, id: id).wrap();
  }

  // Future<ApiResponse<dynamic>> getOTP({String? phoneNumber}) async {
  //   return await RestClient(
  //       DioHelper.dioObject!,
  //     baseUrl: AppConfig.prefixUrlOTP
  //   ).getOTP(phoneNumber: phoneNumber).wrap();
  // }

  Future<ApiResponse<HashModel>> getOTPNew({String? phoneNumber}) async {
    return await apiClient!.getOTPNew(phoneNumber: phoneNumber).wrap();
  }

  Future<ApiResponse<HashModel>> getOTPForgotPassword({String? phoneNumber}) async {
    return await apiClient!.getOTPForgotPassword(phoneNumber: phoneNumber).wrap();
  }

  Future<ApiResponse<dynamic>> verifyOTP({String? phoneNumber, String? otp, String? hash}) async {
    return await apiClient!.verifyOTP(phoneNumber: phoneNumber,hash: hash, otp: otp).wrap();
  }

  Future<ApiResponse<UserModel>> getInfo() async {
    return await apiClient!.getInfo().wrap();
  }

  Future<ApiResponse<dynamic>> registerUser({RegisterModel? userModel}) async {
    return await apiClient!.registerUser(userModel: userModel).wrap();
  }

  Future<ApiResponse<dynamic>> forgotPassword({ForgotPasswordModel? newPassword}) async {
    return await apiClient!.forgotPassword(newPassword: newPassword).wrap();
  }

  Future<ApiResponse<ResultModel>> changePassword({ChangePasswordModel? changePasswordModel}) async {
    return await apiClient!.changePassword(changePasswordModel: changePasswordModel).wrap();
  }

  Future<ApiResponse<dynamic>> changePhoneNumber({ChangePhoneNumberModel? newPhoneNumber}) async {
    return await apiClient!.changePhoneNumber(newPhoneNumber: newPhoneNumber).wrap();
  }
}


