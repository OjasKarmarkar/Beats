import 'package:flutter/material.dart';

class Theme_Model with ChangeNotifier{

   ThemeData _themeData;

  Theme_Model(this._themeData);

  getTheme() => _themeData;
  setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }

}