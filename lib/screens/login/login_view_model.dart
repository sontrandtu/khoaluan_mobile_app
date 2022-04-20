
import 'package:khoaluan_mobile_app/api/api_response.dart';
import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';

class LoginViewModel extends BaseViewModel{
  final UserRepository userRepo;

  String? email;
  String? password;

  LoginViewModel({required this.userRepo}): super(userRepo);

  login({SuccessCallback? successCallback, ErrorCallback? errorCallback}) async{
    final response = await userRepo.login(email: email!, password: password!);
    if(response.isOk){
      successCallback?.call(response.message);
    }
  }

}