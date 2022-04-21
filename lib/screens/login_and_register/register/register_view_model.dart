import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';

class RegisterViewModel extends BaseViewModel {
  final UserRepository userRepo;
  RegisterViewModel({required this.userRepo}) : super(userRepo);
}
