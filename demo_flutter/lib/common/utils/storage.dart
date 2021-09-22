import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

///本地存储

class StorageUtil {
  StorageUtil._internal();
  static final StorageUtil _instance = StorageUtil._internal();

  factory StorageUtil() {
    return _instance;
  }

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///存取JSON字符串
  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return _prefs.setString(key, jsonString);
  }

  dynamic getJSON(String key) {
    String? jsonString = _prefs.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  ///存储bool
  Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  ///移除某个键值对
  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }
}
