enum TabType {home,  roommates, myPost, account}

extension TabTypeExtension on TabType{
  String get label {
    switch(this) {
      case TabType.home:
        return "Trang chủ";
      case TabType.roommates:
        return "Ở ghép";
      case TabType.myPost:
        return "Bài viết";
      case TabType.account:
        return "Tài khoản";
    }
  }
}