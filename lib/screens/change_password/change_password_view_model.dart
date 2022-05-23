import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/change_password_model.dart';
import 'package:khoaluan_mobile_app/preference/preference.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';

class ChangePasswordViewModel extends BaseViewModel{
  UserRepository userRepo;

  ChangePasswordModel changePasswordModel = ChangePasswordModel();
  String token = '';

  ChangePasswordViewModel({required this.userRepo}) : super(userRepo);

  Future<void> changePassword({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async{
    setLoading = true;
    final response = await userRepo.changePassword(changePasswordModel: changePasswordModel);
    if(response.isOk){
      successCallback?.call("Mật khẩu đã được thay đổi");
      token = response.data?.token ?? '';
      if(token.isNotEmpty){
        await PreferenceManager.setValue(PreferenceManager.KEY_TOKEN, token);
      }
    }else{
      errorCallback?.call(response.messages);
    }
    setLoading = false;

  }

}