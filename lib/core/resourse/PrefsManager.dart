import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences prefs;

  static  init() async {
    prefs = await SharedPreferences.getInstance();
  }
  static setStart(bool value) async {
    await prefs.setBool('onBoardingStart', value);
  }

  static bool getStart() {
    return prefs.getBool('onBoardingStart') ?? false;
  }
  static setItems(bool value) async {
    await prefs.setBool('onBoardingActive', value);
  }

  static bool getItems() {
    return prefs.getBool('onBoardingActive') ?? false;
  }
}
