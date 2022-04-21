import 'package:khoaluan_mobile_app/api/api_response.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/repository.dart';

class UserRepository extends Repository {
  Future<ApiResponse<UserModel>> login({required UserModel userModel}) async {
    return await apiClient!.login(userModel: userModel).wrap();
  }
}
