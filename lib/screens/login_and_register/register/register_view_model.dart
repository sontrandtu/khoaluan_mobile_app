import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/register_model.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';

const int timerOTP = 60;

class RegisterViewModel extends BaseViewModel {
  final UserRepository userRepo;

  RegisterModel userModel = RegisterModel();
  String otp = '';
  String? hash = '';
  RegisterViewModel({required this.userRepo}) : super(userRepo);

  getOTP({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    setLoading = true;
    final response = await userRepo.getOTPNew(phoneNumber: userModel.phoneNumber);
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
    final response = await userRepo.verifyOTP(phoneNumber: userModel.phoneNumber, otp: otp, hash: hash);
    if (response.isOk) {
      successCallback?.call("Tiếp tục điền các thông tin để hoàn thành đăng kí tài khoản");
    } else {
      errorCallback?.call(response.messages);
    }
    setLoading = false;
  }

  registerUser({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    setLoading = true;
    final response = await userRepo.registerUser(userModel: userModel);
    if (response.isOk) {
      successCallback?.call("Đăng ksi tài khoản thành công, quay lại trang đăng nhập để tiếp tục");
    } else {
      errorCallback?.call(response.messages);
    }
    setLoading = false;
  }
  clearData(){
    userModel.email = '';
    userModel.password = '';
    userModel.phoneNumber = '';
    userModel.name = '';
    userModel.userName = '';
  }
}
