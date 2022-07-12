import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreference;

  static Future<SharedPreferences> init() async {
    return sharedPreference = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(
      {required String key, required bool value}) async {
    return await sharedPreference!.setBool(key, value);
  }

  static bool? getData({required String key}) {
    if (sharedPreference != null) {
      return sharedPreference!.getBool(key);
    } else {
      return null;
    }
  }
}
