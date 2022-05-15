enum Gender{ male, female}

extension GenderExtension on Gender{
  String get gender {
    switch(this) {
      case Gender.male:
        return "Nam";
      case Gender.female:
        return "Nữ";
    }
  }
}