import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Username with ChangeNotifier{

String name;
SharedPreferences prefs;

Username(){
  this.name = "Welcome";
  init();
}
init() async{
  prefs = await SharedPreferences.getInstance();
 String temp =  prefs.getString("user") ?? "User";
  name = temp;
}

setName(String x){
  prefs.setString("user", x);
  name = x;
  notifyListeners();

}
getName(){
  return name;
}

}
