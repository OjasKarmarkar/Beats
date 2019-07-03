import 'package:beats/screens/Bookmarks.dart';
import 'package:flutter/material.dart';
import 'package:expanding_bottom_bar/expanding_bottom_bar.dart';
import 'package:provider/provider.dart';

import '../models/SongsModel.dart';
import 'HomeScreen.dart';
import 'Settings.dart';
import 'MusicLibrary.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var index = 0;
  var screens = [HomeScreen(), Library(), Bookmarks(), SettingsScreen()];
  ThemeData _themeData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: screens[index],
          bottomNavigationBar: ExpandingBottomBar(
            animationDuration: Duration(milliseconds: 700),
            backgroundColor: Theme.of(context).backgroundColor,
              navBarHeight: 75,
              items: [
                ExpandingBottomBarItem(
                    icon: Icons.home,
                    text: "Home",
                    selectedColor: Colors.pinkAccent),
                ExpandingBottomBarItem(
                    icon: Icons.music_note,
                    text: "Library",
                    selectedColor: Colors.red),
                    ExpandingBottomBarItem(
                    icon: Icons.bookmark_border,
                    text: "Bookmarks",
                    selectedColor: Colors.deepPurpleAccent),
                ExpandingBottomBarItem(
                    icon: Icons.settings,
                    text: "Settings",
                    selectedColor: Colors.blueAccent)
              ],
              selectedIndex: index,
              onIndexChanged: (i) {
                setState(() {
                  index = i;
                });
              })
    );
  }
}
