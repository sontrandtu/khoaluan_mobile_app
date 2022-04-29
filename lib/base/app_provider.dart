import 'package:flutter/cupertino.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:rxdart/rxdart.dart';

import '../enum/tab_type.dart';

class AppProvider extends ChangeNotifier {
 UserModel? userInfoModel;

  set navigateTo(TabType tabType) {
    navigateToTab.add(tabType);
  }

  set updateUserInfo(UserModel? userInfoModel) {
    this.userInfoModel = userInfoModel;
    notifyListeners();
  }

  final BehaviorSubject<TabType> navigateToTab = BehaviorSubject<TabType>();

  Stream<TabType> get navigateToTabStream => navigateToTab.stream;

  @override
  void dispose() {
    navigateToTab.close();
    super.dispose();
  }
}
