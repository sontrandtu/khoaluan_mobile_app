import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PreferenceManager {
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static bool checkInit() {
    return _prefsInstance != null;
  }

  static Future<bool> setValue<T>(String key, T value) async {
    var pref = await _instance;
    switch (T) {
      case bool:
        return pref.setBool(key, value as bool);
      case String:
        return pref.setString(key, value as String);
      case int:
        return pref.setInt(key, value as int);
      default:
        throw Exception('Unsupported Type');
    }
  }

  static T? getValue<T>(String key) {
    switch (T) {
      case bool:
        return _prefsInstance!.getBool(key) as T?;
      case String:
        return _prefsInstance!.getString(key) as T?;
      case int:
        return _prefsInstance!.getInt(key) as T?;
      default:
        throw Exception('Unsupported Type');
    }
  }

  static bool getBoolean(String key, [bool? defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue ?? false;
  }

  static clear() async {
    await _prefsInstance?.clear();
  }

  static setObject(String key, value) async {
    _prefsInstance?.setString(key, jsonEncode(value));
  }

  static logOut() async {
    await _prefsInstance?.setString(KEY_CURRENT_USER, '');
    await _prefsInstance?.setString(KEY_FCM_TOKEN, '');
    await _prefsInstance?.setString(KEY_ACCESS_TOKEN, '');
    await _prefsInstance?.setString(KEY_USER_ID, '');
    await _prefsInstance?.setString(KEY_DOCTOR_ID, '');
    await _prefsInstance?.setString(KEY_PHYSICIAN_ID, '');
    await _prefsInstance?.setString(KEY_LINK_MESSAGE, '');
    await _prefsInstance?.setString(KEY_LINK_ZALO, '');
  }

  static const String KEY_FIRST_LAUNCH = 'first_launch';
  static const String KEY_USER_ID = 'user_id';
  static const String KEY_CURRENT_USER = 'current_user';
  static const String KEY_DOCTOR_ID = 'doctor_id';
  static const String KEY_PHYSICIAN_ID = 'physician_id';
  static const String KEY_ACCESS_TOKEN = 'access_token';
  static const String KEY_SAVED_TOKEN = 'article_saved';
  static const String KEY_WATCHED = 'watched';
  static const String KEY_UNREAD_MESSAGE = 'unread_message';
  static const String KEY_FCM_TOKEN = 'fcm_token';
  static const String KEY_LINK_MESSAGE = 'link_message';
  static const String KEY_LINK_ZALO = 'link_zalo';
  static const String IS_RELOAD_HOME_TOPIC = 'is_reload_home';
  static const String IS_RELOAD_USER_INFO = 'is_reload_user_info';
  static const String IS_RELOAD_FAVORITE = 'is_reload_favorite';

}
