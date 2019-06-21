import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:line_icons/line_icons.dart';
import 'SetttingsSubScreens/Theme.dart';
import 'SetttingsSubScreens/PlayBack.dart';
import 'SetttingsSubScreens/About_Us.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final subtitles = [
      'Customize The Look and Accent Of The App',
      "Change The Controls Of The Playing Screen",
      "Know More About Us",
      "Help Devs to Create Such Awesome Apps!"
    ];
    final titles = [
      'Look ',
      'Playback Screen',
      'About Us',
      'Donate us a Coffee!'
    ];
    final icons = [
      LineIcons.paint_brush,
      LineIcons.music,
      LineIcons.info_circle,
      LineIcons.coffee
    ];

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBar(
            leading: Padding(
              padding: EdgeInsets.only(top: height * 0.012, left: width * 0.03),
              child: IconButton(
                    iconSize: 35.0,
                    icon: Icon(
                      LineIcons.share_alt,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
            ),
            actions: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.012, left: width * 0.03),
                child: IconButton(
                  iconSize: 35.0,
                  icon: Icon(
                    LineIcons.user,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              )
            ],
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Padding(
              padding: EdgeInsets.only(top: height * 0.022),
              child: Text(
                "Settings",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                    fontFamily: 'sans-serif'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Container(
              child: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (context) => new Themes()),
                                );
                                break;
                               case 1:  Navigator.of(context).push(
                                new MaterialPageRoute(builder: (context) => new PlayBack())
                              );
                              break;
                              case 2:  Navigator.of(context).push(
                                new MaterialPageRoute(builder: (context) => new About_Us())
                              );
                              break;
                              
                            }
                          },
                          leading: Icon(icons[index]),
                          title: Text(titles[index]),
                          subtitle: Text(subtitles[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
