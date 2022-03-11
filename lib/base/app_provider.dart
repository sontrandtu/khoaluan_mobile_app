import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class AppProvider extends ChangeNotifier {
//  UserInfoModel? userInfoModel;
  //
  // set navigateTo(TabType tabType) {
  //   navigateToTab.add(tabType);
  // }
  //
  // set updateUserInfo(UserInfoModel? userInfoModel) {
  //   this.userInfoModel = userInfoModel;
  //   notifyListeners();
  // }
  //
  // final BehaviorSubject<TabType> navigateToTab = BehaviorSubject<TabType>();
  //
  // Stream<TabType> get navigateToTabStream => navigateToTab.stream;

  @override
  void dispose() {
    //navigateToTab.close();
    super.dispose();
  }
}
