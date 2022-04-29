import 'dart:developer';

import 'package:khoaluan_mobile_app/api/response_model/login_response.dart';
import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';

class LoginViewModel extends BaseViewModel {
  final UserRepository userRepo;

  String? userName;
  String? password;

  LoginViewModel({required this.userRepo}) : super(userRepo);

  login(
      {SuccessCallback? successCallback, ErrorCallback? errorCallback}) async {
    final response = await userRepo.login(
        loginResponse: LoginResponse(userName: userName ?? '', password: password ?? ''));
    if (response.isOk) {
      log(userName ?? "Null");
      log(password ?? "null");
      successCallback?.call(response.message);
    }
  }
}
