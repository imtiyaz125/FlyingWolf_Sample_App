import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String KEY_IS_LOGGEDIN="KEY_IS_LOGGEDIN";
  static SharedPreferences pref;

  static Future<void> init() async {
    if (pref == null) pref = await SharedPreferences.getInstance();
  }

  static void save(String key, var value) async{
     await init();
    if (value is String)
      pref.setString(key, value.toString());
    else if (value is bool)
      pref.setBool(key, value);
  }
  static Future<bool> getBoolean(String key) async{
    await init();
    return pref.containsKey(key) && pref.getBool(key);
  }
  static String getString(String key){
    if(pref!=null && pref.containsKey(key))
      return pref.getString(key)??"";
    else return "";
  }

  static void clearPrefs() {
    pref.clear();
  }
}
