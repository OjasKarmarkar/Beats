import 'package:flutter/material.dart';
import 'package:expanding_bottom_bar/expanding_bottom_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var Index=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 220,
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 130.0, left: 40),
                      child: Text("User,",
                          style: TextStyle(
                              fontFamily: 'sans-serif',
                              fontSize: 45,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 40),
                      child: Text("Welcome",
                          style: TextStyle(
                              letterSpacing: 1.2,
                              fontFamily: 'sans-serif',
                              fontSize: 30,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    bottomNavigationBar: ExpandingBottomBar(
      items: [
        ExpandingBottomBarItem(icon: Icons.bookmark_border, text: "Home", selectedColor: Colors.pinkAccent),
        ExpandingBottomBarItem(icon: Icons.music_note, text: "Library", selectedColor: Colors.red),
        ExpandingBottomBarItem(icon: Icons.settings, text: "Settings", selectedColor: Colors.black)
      ],
      selectedIndex: this.Index,
      onIndexChanged: (i){
        setState(() {
          Index=i;
        });
      }
    )
    );
  }
}
