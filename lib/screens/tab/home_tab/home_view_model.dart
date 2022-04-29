import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';

class HomeViewModel extends BaseViewModel{
  UserRepository repo;

  String text = "Home Page";
  UserModel userModel = UserModel.demo;
  HomeViewModel({required this.repo}) : super(repo);

}