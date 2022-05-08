import 'dart:async';

import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';

const int timerOTP = 60;

class RegisterViewModel extends BaseViewModel {
  final UserRepository userRepo;

  UserModel userModel = UserModel();
  String otp = '';
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

  resendOTP() async {
    start = timerOTP;
    startTimer();
    // final response = await repo.login(phoneNumber);
    // if (response.isOk) {
    //   otp = response.data!.otp!;
    // } else {}
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
