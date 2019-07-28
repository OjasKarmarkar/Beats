import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Now_Playing extends ChangeNotifier {
  bool immersive;
  SharedPreferences prefs_bool;
  Now_Playing(this.immersive) {
    init();
  }

  init() async {
    prefs_bool = await SharedPreferences.getInstance();
    bool x = prefs_bool.getBool("Immersive");
    if (x == false) {
      update(false);
    }
    else if(x==true){
      update(true);
    }
  }

  update(bool x) {
    immersive = x;
    notifyListeners();
  }

  get_Screen() {
    return immersive;
  }

  set_Screen(bool check) {
    immersive = check;
    if (immersive == false) {
      prefs_bool.setBool("Immersive", false);
    } else if (immersive == true) {
      prefs_bool.setBool("Immersive", true);
    }
    notifyListeners();
  }
}
