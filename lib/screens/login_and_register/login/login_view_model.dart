import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/preference/preference.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';

class LoginViewModel extends BaseViewModel {
  final UserRepository userRepo;

  String? userName;
  String? password;

  LoginViewModel({required this.userRepo}) : super(userRepo);

  login(
      {SuccessCallback? successCallback, ErrorCallback? errorCallback}) async {
    final response = await userRepo.login(
        userModel: UserModel(userName: userName ?? '', password: password ?? ''),
    );
    if (response.isOk) {
      successCallback?.call("Đăng nhập thành công");
      await PreferenceManager.setValue<String>(PreferenceManager.KEY_TOKEN, response.data?.token);
    }else{
      errorCallback?.call(response.message.toString());
    }
  }
}
