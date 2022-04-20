import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

extension StringExtension on String {
  bool search(String query) {
    final String nonUnicode = toLowerCase().convertToUnsigned;
    final String nonUnicodeQuery = query.trim().toLowerCase().convertToUnsigned;
    return nonUnicode.contains(nonUnicodeQuery);
  }

  String? get extractTraceId {
    final regex = RegExp(r'[a-z0-9]+\.(?:html)$');
    try {
      return regex.stringMatch(this)?.split('.').first ?? '';
    } catch (ex) {
      print(ex);
    }
  }

  bool get isValidUrl {
    final regex = RegExp(r"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:\/?#[\]@!\$&'\(\)\*\+,;=.]+$");
    return regex.hasMatch(this);
  }

  bool get isMarvelTekLink {
    return contains(RegExp(r"^(?:http(s)?:\/\/)?[\w]*\.?htx.marveltek.dev"));
  }

  String get convertToUnsigned {
    const _vietnamese = 'aAeEoOuUiIdDyY';
    final _vietnameseRegex = <RegExp>[
      RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
      RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
      RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
      RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
      RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
      RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
      RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
      RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
      RegExp(r'ì|í|ị|ỉ|ĩ'),
      RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
      RegExp(r'đ'),
      RegExp(r'Đ'),
      RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
      RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
    ];
    var result = this;
    for (var i = 0; i < _vietnamese.length; ++i) {
      result = result.replaceAll(_vietnameseRegex[i], _vietnamese[i]);
    }
    return result;
  }

  bool parseBool() {
    return toLowerCase() == "true";
  }

  bool get isOnlyNumber {
    RegExp regex = RegExp(r'^\d*\.?\d*$');
    return regex.hasMatch(this);
  }

  String get toUpperCaseFirst {
    if (length > 0) {
      return "${this[0].toUpperCase()}${substring(1)}";
    }
    return this;
  }

  String get hidePhoneNumber {
    var phone = this;
    for (int i = 0; i < phone.length - 3; i++) {
      phone = phone.replaceRange(i, i + 1, '*');
    }
    return phone;
  }

  String get onlyMsg => replaceAll(RegExp(r'.[a-z]{2}-[A-Z]{2}$'), '');

  String get removeFirstCharacterIsZero => int.parse(this).toString();

  bool get isValidEmail {
    RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(this);
  }

  bool get isValidPhone {
    RegExp regex = RegExp(r'^([0-9]{9,13}$)');
    return regex.hasMatch(this);
  }

  Future<void> makePhoneCall() async {
    if (await canLaunch('tel:$this')) {
      await launch('tel:$this');
    } else {
      throw 'Could not launch ${'tel:$this'}';
    }
  }

  String get removeFirstZeroInPhoneNumber {
    if (this[0].toString() == '0') {
      return substring(1, length);
    } else {
      return this;
    }
  }

  String get convertCurrency {
    if (length > 9) {
      return '${_toDecimal(this, 1000000000)} tỷ';
    }
    if (length > 6) {
      return '${_toDecimal(this, 1000000)} triệu';
    }
    if (length > 3) {
      return '${_toDecimal(this, 1000)} nghìn';
    }
    if (length > 2) {
      return '${_toDecimal(this, 100)} trăm';
    }
    return this;
  }


  String _toDecimal(String number, int unit) => (double.parse(number) / unit).toStringAsFixed(2);

  String get inCaps => length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get allInCaps => toUpperCase();

  String get capitalizeFirstOfEach => replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.inCaps).join(" ");
}
