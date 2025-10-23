import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences sharedPreferences;
  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static setStart(bool value) async {
    await sharedPreferences.setBool('onBoardingStart', value);
  }
  static setTheme(ThemeMode mode){
    sharedPreferences.setString("theme",mode==ThemeMode.dark?"dark": "light");
  }
  static ThemeMode getTheme(){
    String saved = sharedPreferences.getString("theme")??"light";
    if(saved == "dark"){
      return ThemeMode.dark;
    }else{
      return ThemeMode.light;
    }
  }
  static bool getStart() {
    return sharedPreferences.getBool('onBoardingStart') ?? false;
  }
  static setItems(bool value) async {
    await sharedPreferences.setBool('onBoardingActive', value);
  }

  static bool getItems() {
    return sharedPreferences.getBool('onBoardingActive') ?? false;
  }
}
