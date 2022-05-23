import 'package:khoaluan_mobile_app/base/base_view_model.dart';

import '../../../repository/user_repository.dart';

class AccountViewModel extends BaseViewModel{
  UserRepository repo;

  String text = "Account Tab";

  String image = '';
  AccountViewModel({required this.repo}) : super(repo){
    getData();
  }

  Future<void> getData()async{
    setLoading = true;
    final response = await repo.getInfo();
    if(response.isOk){
      image = response.data?.avatarUrl ?? '';
    }
    setLoading = false;
  }
}