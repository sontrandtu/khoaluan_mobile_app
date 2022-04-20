
import 'package:khoaluan_mobile_app/api/api_response.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/repository.dart';

class UserRepository extends Repository{

  Future<ApiResponse<UserModel>> login({required String email, required String password}) async{
    return apiClient!.login(email, password).wrap();
  }

}