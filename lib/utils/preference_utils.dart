import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static const String languageCode = 'selected_language';

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  /// get value
  static String getStringValue(String key, [String? defValue]) {
    return _prefsInstance?.getString(key) ?? defValue ?? "";
  }

  static int? getIntValue(String key, [int? defValue]) {
    return _prefsInstance?.getInt(key) ?? defValue ?? 0;
  }

  static bool getBoolValue(String key, [bool? defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue ?? true;
  }

  /// set value
  static setStringValue(String key, String value) async {
    var prefs = await _instance;
    prefs.setString(key, value);
  }

  static setIntValue(String key, int value) async {
    var prefs = await _instance;
    prefs.setInt(key, value);
  }

  static setBoolValue(String key, bool value) async {
    var prefs = await _instance;
    prefs.setBool(key, value);
  }
  static Future<void> removeValue(String key) async {
    var prefs = await _instance;
    await prefs.remove(key);
  }

  static Future<void> clear() async {
    var prefs = await _instance;
    await prefs.clear();
  }
}
