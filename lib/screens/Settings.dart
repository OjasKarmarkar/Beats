import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:line_icons/line_icons.dart';
import 'SetttingsSubScreens/Donate.dart';
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
                padding:
                    EdgeInsets.only(top: height * 0.012, left: width * 0.03),
                child: IconButton(
                  iconSize: 35.0,
                  icon: Icon(
                    LineIcons.share_alt,
                    color: Colors.grey,
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
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
              backgroundColor: Theme.of(context).backgroundColor,
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(top: height * 0.022),
                child: Text("Settings",
                    style: Theme.of(context).textTheme.display1),
              )),
          Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Container(
              child: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Theme.of(context).cardColor,
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
                              case 1:
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) => new PlayBack()));
                                break;
                              case 2:
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) => new AboutUs()));
                                break;

                              case 3:
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) =>  Donate()));
                                break;
                            }
                          },
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Icon(icons[index], color: Colors.grey),
                          ),
                          title: Text(
                            titles[index],
                            style: Theme.of(context).textTheme.display3,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              subtitles[index],
                              style: Theme.of(context).textTheme.display2,
                            ),
                          ),
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
