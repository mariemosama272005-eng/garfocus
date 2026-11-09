import 'package:shared_preferences/shared_preferences.dart';

class LocalHelper {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      prefs = null;
    }
  }

  static Future<bool> setString(String key, String value) async {
    if (prefs == null) return false;
    return await prefs!.setString(key, value);
  }

  static String? getString(String key) {
    return prefs?.getString(key);
  }

  static Future<bool> setInt(String key, int value) async {
    if (prefs == null) return false;
    return await prefs!.setInt(key, value);
  }

  static int? getInt(String key) {
    return prefs?.getInt(key);
  }
}
