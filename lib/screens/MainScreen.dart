import 'package:flutter/material.dart';
import 'package:expanding_bottom_bar/expanding_bottom_bar.dart';
import 'HomeScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  var index=0;
  var screens = [HomeScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: ExpandingBottomBar(
        items: [
          ExpandingBottomBarItem(icon: Icons.bookmark_border, text: "Home", selectedColor: Colors.pinkAccent),
          ExpandingBottomBarItem(icon: Icons.music_note, text: "Library", selectedColor: Colors.red),
          ExpandingBottomBarItem(icon: Icons.settings, text: "Settings", selectedColor: Colors.black)
        ],
        selectedIndex: index,
        onIndexChanged: (i){
          setState(() {
            index=i;
          });
        }
      )
    );
  }
}
