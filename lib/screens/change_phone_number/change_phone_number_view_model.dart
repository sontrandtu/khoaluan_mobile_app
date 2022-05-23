import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/change_phone_number_model.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';

class ChangePhoneNumberViewModel extends BaseViewModel{
  UserRepository userRepo;

  UserModel userModel = UserModel();
  ChangePhoneNumberModel newPhoneNumber = ChangePhoneNumberModel();
  String otp = '';
  String? hash = '';

  ChangePhoneNumberViewModel({required this.userRepo}) : super(userRepo){
    getData();
  }

  getOTP({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    setLoading = true;
    final response = await userRepo.getOTPNew(phoneNumber: newPhoneNumber.phoneNumber);
    if (response.isOk) {
      hash = response.data?.messages;
      successCallback?.call("Lấy mã xác nhận thành công");
    } else {
      errorCallback?.call(response.messages);
    }
    setLoading = false;
  }

  Future<bool> changePhoneNumber() async{
    newPhoneNumber.id = userModel.id;
    final response = await userRepo.changePhoneNumber(newPhoneNumber: newPhoneNumber);
    if(response.isOk){
      return true;
    }
    return false;
  }

  verifyOTP({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    setLoading = true;
    final response = await userRepo.verifyOTP(phoneNumber: newPhoneNumber.phoneNumber, otp: otp, hash: hash);
    if (response.isOk) {
      final bool check = await changePhoneNumber();
      if(check){
        successCallback?.call("Đổi số điện thoại thành công");
      } else{
        errorCallback?.call("Có lỗi xảy ra,  vui lòng thử lại");
      }
    } else {
      errorCallback?.call(response.messages);
    }
    setLoading = false;
  }

  Future<void> getData() async{
    setLoading = true;
    final response = await userRepo.getInfo();
    if (response.isOk) {
      userModel = response.data ?? UserModel();
    }
    setLoading = false;
  }

}