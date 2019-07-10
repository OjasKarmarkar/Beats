import 'package:flutter/material.dart';
import '../custom_icons.dart';
import 'HomeScreen.dart';

class Now_Playing extends ChangeNotifier {
  bool immersive;
  Now_Playing(this.immersive);

  get_Screen() {
    print(immersive.toString());
    return immersive;
  }

  set_Screen(bool check) {
    immersive = check;
    notifyListeners();
  }

}
