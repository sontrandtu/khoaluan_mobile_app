import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/forgot_password_model.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';

class ForgotPasswordViewModel extends BaseViewModel{
  UserRepository userRepo;

  ForgotPasswordModel? newPassword = ForgotPasswordModel();
  String? hash = '';
  String? otp;

  ForgotPasswordViewModel({required this.userRepo}) : super(userRepo);

  getOTP({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    setLoading = true;
    final response = await userRepo.getOTPForgotPassword(phoneNumber: newPassword?.phoneNumber);
    if (response.isOk) {
      hash = response.data?.messages;
      successCallback?.call("Lấy mã xác nhận thành công");
    } else {
      errorCallback?.call(response.messages);
    }
    setLoading = false;
  }

  verifyOTP({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    setLoading = true;
    final response = await userRepo.verifyOTP(phoneNumber: newPassword?.phoneNumber, otp: otp, hash: hash);
    if (response.isOk) {
      successCallback?.call("Tiếp tục điền các thông tin để hoàn thành việc lấy lại mật khẩu");
    } else {
      errorCallback?.call(response.messages);
    }
    setLoading = false;
  }

  forgotPassword({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    setLoading = true;
    final response = await userRepo.forgotPassword(newPassword: newPassword);
    if (response.isOk) {
      successCallback?.call("Mật khẩu đã được thay đổi thành công");
    } else {
      errorCallback?.call(response.messages);
    }
    setLoading = false;
  }

}