import 'dart:async';

import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';
import 'package:khoaluan_mobile_app/utils/toast_utils.dart';

const int timerOTP = 60;

class RegisterViewModel extends BaseViewModel {
  final UserRepository userRepo;

  UserModel userModel = UserModel();
  String otp = '';
  bool isSuccess = false;
  RegisterViewModel({required this.userRepo}) : super(userRepo);

  set updateOtp(String value) {
    otp = value;
    notifyListeners();
  }

   Timer? _timer;
  int start = timerOTP;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start == 0) {
          notifyListeners();
          timer.cancel();
        } else {
          notifyListeners();
          start--;
        }
      },
    );
  }
  String get remainingTime {
    return start < 10 ? '0$start' : '$start';
  }

  bool get isExpired {
    return start == 0;
  }

  getOTP() async {
    setLoading = true;
    start = timerOTP;
    startTimer();
    final response = await userRepo.getOTP(phoneNumber: userModel.phoneNumber);
    if (response.isOk) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    setLoading = false;
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
