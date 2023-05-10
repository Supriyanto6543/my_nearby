import 'package:shared_preferences/shared_preferences.dart';

class CommonShared {
  static late final SharedPreferences preferences;
  static Future<SharedPreferences> init() async =>
      preferences = await SharedPreferences.getInstance();

  static Future<bool> currentPosition(String lat, String long, String address) {
    return preferences.setStringList("currentPosition", [lat, long, address]);
  }

  static List<String>? get getCurPos =>
      preferences.getStringList("currentPosition");
}
