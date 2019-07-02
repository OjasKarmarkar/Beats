import 'package:flutter/widgets.dart';

class ProgressModel extends ChangeNotifier{
  var duration;
  var position;
  setDuration(d){
    duration = d;
    notifyListeners();
  }
  setPosition(p){
    position = p;
    notifyListeners();
  }
}