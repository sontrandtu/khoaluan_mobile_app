import 'package:khoaluan_mobile_app/base/base_view_model.dart';

import '../../../repository/user_repository.dart';

class MyPostViewModel extends BaseViewModel{

  UserRepository repo;

  String text = "Account Tab";


  MyPostViewModel({required this.repo}) : super(repo);

}