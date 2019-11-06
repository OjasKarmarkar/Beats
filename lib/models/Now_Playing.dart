import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NowPlaying extends ChangeNotifier {
  bool immersive;
  SharedPreferences prefsBool;
  NowPlaying(this.immersive) {
    init();
  }

  init() async {
    prefsBool = await SharedPreferences.getInstance();
    bool x = prefsBool.getBool("Immersive");
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

  getScreen() {
    return immersive;
  }

  setScreen(bool check) {
    immersive = check;
    if (immersive == false) {
      prefsBool.setBool("Immersive", false);
    } else if (immersive == true) {
      prefsBool.setBool("Immersive", true);
    }
    notifyListeners();
  }
}
