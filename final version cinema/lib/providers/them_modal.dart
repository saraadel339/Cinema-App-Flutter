import 'package:cinema/shared_preferences/theme_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModal extends ChangeNotifier {

late bool is_Dark ;
late ThemeSharedPreferences themeSharedPreferences;
bool get isDark => is_Dark;
ThemeModal (){
  is_Dark = false ;
  themeSharedPreferences =ThemeSharedPreferences();
  getThemePreferences ();

}
set isDark (bool value){
  is_Dark=value;
  themeSharedPreferences.setTheme(value);
  notifyListeners();
}
getThemePreferences() async{
  is_Dark=await themeSharedPreferences.getTheme();
  notifyListeners();
}

}