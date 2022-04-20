import 'package:intl/intl.dart';

extension DateTimextention on DateTime {
  Duration get minutesFromMidNight {
    return Duration(minutes: minute + hour * 60);
  }

  String? get dateTimeToDayOfWeek {
    String? dayOfWeek;
    switch (weekday) {
      case DateTime.monday:
        dayOfWeek = "Thứ 2";
        break;
      case DateTime.tuesday:
        dayOfWeek = "Thứ 3";
        break;
      case DateTime.wednesday:
        dayOfWeek = "Thứ 4";
        break;
      case DateTime.thursday:
        dayOfWeek = "Thứ 5";
        break;
      case DateTime.friday:
        dayOfWeek = "Thứ 6";
        break;
      case DateTime.saturday:
        dayOfWeek = "Thứ 7";
        break;
      case DateTime.sunday:
        dayOfWeek = "Chủ nhật";
        break;
    }
    return dayOfWeek;
  }

  String? get dateTimeToDayOfWeekVN {
    String? dayOfWeek;
    switch (weekday) {
      case DateTime.monday:
        dayOfWeek = "Thứ Hai";
        break;
      case DateTime.tuesday:
        dayOfWeek = "Thứ Ba";
        break;
      case DateTime.wednesday:
        dayOfWeek = "Thứ Tư";
        break;
      case DateTime.thursday:
        dayOfWeek = "Thứ Năm";
        break;
      case DateTime.friday:
        dayOfWeek = "Thứ Sáu";
        break;
      case DateTime.saturday:
        dayOfWeek = "Thứ Bảy";
        break;
      case DateTime.sunday:
        dayOfWeek = "Chủ Nhật";
        break;
    }
    return dayOfWeek;
  }


  String get dayOfWeekAndDate{
    return '$dateTimeToDayOfWeekVN, $dateTimeToDDMMYYYY';
  }
  String get dayOfWeekAndDateAndTime{
    return '$dateTimeToDayOfWeekVN, $dateTimeToDDMMYYYY, $dateTimeToVnHour24h';
  }

  String get hourAndDateTime{
    return '$dateTimeToVnHour24h, $dateTimeToDDMMYYYY';
  }

  String get dateTimeInTable{
    return '$dateTimeToDDMMYYYY - $dateTimeToVnHour';
  }

  String get dateTimeInWeather{
    return '$dateTimeToDayOfWeek, $dateTimeToDDMMYYYY';
  }

  String get dayOfWeekDateTimeVN {
    return '$dateTimeToDayOfWeekVN $dateTimeToDDMMYYYY - $dateTimeToVnHour24h';
  }

  String get dateTimeString {
    return '$dateTimeToDDMMYYYY - $dateTimeToVnHour24h';
  }

  String get dateString => dateTimeToDDMMYYYY;

  String get dateTimeToDayAndMonth {
    var formatter = DateFormat("dd/MM");
    return formatter.format(this);
  }

  String get dateTimeToDay {
    var formatter = DateFormat("dd");
    return formatter.format(this);
  }

  DateTime addTimeToDate(DateTime hour) {
    return DateTime(year, month, day, hour.hour, hour.minute);
  }

  String get dateTimeToDDMMYYYY {
    var formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(this);
  }

  String get dateTimeToYYYYMMDD {
    var formatter = DateFormat("yyyy-MM-dd");
    return formatter.format(this);
  }

  String get exportName {
    var formatter = DateFormat("dd-MM-yyyy");
    return formatter.format(this);
  }

  String get monthAndYear {
    return 'T${month}/${year}';
  }

  String get dateTimeToVnHour {
    String hour = DateFormat("hh:mm a").format(this);
    return hour.replaceAll("PM", "chiều").replaceAll("AM", "sáng");
  }

  String get dateTimeToVnHour24h {
    String hour = DateFormat("HH:mm").format(this);
    return hour;
  }

  String get dateTimeToWeekdayAndDayMonth {
    return dateTimeToDayOfWeek! + ", " + dateTimeToDayAndMonth;
  }

  String get convertToString {
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    return formatter.format(this);
  }

  String get toUtcString {
    return toUtc().toIso8601String();
  }

  String get toUtcServer {
    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    return formatter.format(toLocal());
  }

  DateTime get onlyUtcDate => DateTime.utc(year, month, day);

  bool isSameDate(DateTime other) {
    try {
      return year == other.year && month == other.month && day == other.day;
    } catch (ex) {
      return false;
    }
  }
}
