import 'package:flutter/material.dart';

import '../resourse/PrefsManager.dart';

class ThemeProvider extends ChangeNotifier{
ThemeMode mode = ThemeMode.light;
  init(){
  mode = PrefsManager.getTheme();
  }
   changeTheme(ThemeMode newMode){
  mode=newMode;
  notifyListeners();
}
}