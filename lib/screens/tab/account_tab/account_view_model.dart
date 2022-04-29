import 'package:khoaluan_mobile_app/base/base_view_model.dart';

import '../../../repository/user_repository.dart';

class AccountViewModel extends BaseViewModel{
  UserRepository repo;

  String text = "Account Tab";


  AccountViewModel({required this.repo}) : super(repo);

}