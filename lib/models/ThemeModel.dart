import 'package:flutter/material.dart';
import 'package:beats/themes/Themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;
  SharedPreferences prefs;
  Color accentColor;

  ThemeChanger() {
    this._themeData = lightTheme();
    this.accentColor = Colors.blue;
    init();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    int c = prefs.getInt("color") ?? Colors.blue.value;
    accentColor = Color(c);
    String theme = prefs.getString("theme") ?? "light";
    if (theme == "light") {
      updateTheme(lightTheme());
    } else if (theme == "dark") {
      updateTheme(darkTheme());
    } else if (theme == "darkaf") {
      updateTheme(darkAFTheme());
    }
    
  }

  setAccent(Color c) {
    int testingColorValue = c.value;
    prefs.setInt("color", testingColorValue);
    accentColor = c;
    notifyListeners();
  }

  getAccent() {
    return accentColor;
  }

  getTheme() {
    return _themeData;
  }

  updateTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  setTheme(ThemeData theme) {
    if (theme == lightTheme()) {
      prefs.setString("theme", "light");
    } else if (theme == darkTheme()) {
      prefs.setString("theme", "dark");
    } else if (theme == darkAFTheme()) {
      prefs.setString("theme", "darkaf");
    }
    _themeData = theme;
    notifyListeners();
  }
}
