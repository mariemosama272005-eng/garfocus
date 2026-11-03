import 'package:shared_preferences/shared_preferences.dart';

class LocalHelper {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await prefs!.setString(key, value);
  }

  static String? getString(String key) {
    return prefs!.getString(key);
  }

  static Future<bool> setInt(String key, int value) async {
    return await prefs!.setInt(key, value);
  }

  static int? getInt(String key) {
    return prefs!.getInt(key);
  }
}