import 'package:beats/Animations/transitions.dart';
import 'package:beats/Models/Username.dart';
import 'package:beats/models/ThemeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:provider/provider.dart';
import '../custom_icons.dart';
import 'package:beats/models/SongsModel.dart';
import 'MusicLibrary.dart';
import 'SetttingsSubScreens/Theme.dart';
import 'SetttingsSubScreens/PlayBack.dart';
import 'SetttingsSubScreens/About_Us.dart';
import 'package:share/share.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Username username;
  final subtitles = [
    'Customize The Look and Accent Of The App',
    "Change The Controls Of The Playing Screen",
    "Know More About Us",
  ];
  final titles = [
    'Look ',
    'Playback Screen',
    'About Us',
  ];
  final icons = [
    CustomIcons.paint_brush,
    CustomIcons.music,
    CustomIcons.info_circle,
  ];
  ThemeChanger themeChanger;
  TextEditingController text = new TextEditingController();
  bool err = false;
  SongsModel model;

  @override
  void initState() {
    MediaNotification.setListener('next', () {
      setState(() {
        model.player.stop();
        model.next();
        MediaNotification.showNotification(
            title: model.currentSong.title, author: model.currentSong.artist);
        model.play();
      });
    });

    MediaNotification.setListener('prev', () {
      setState(() {
        model.player.stop();
        model.previous();
        MediaNotification.showNotification(
            title: model.currentSong.title, author: model.currentSong.artist);
        model.play();
      });
    });

    MediaNotification.setListener('pause', () {
      setState(() {
        model.pause();
      });
    });
    MediaNotification.setListener('play', () {
      setState(() {
        model.play();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    username = Provider.of<Username>(context);
    themeChanger = Provider.of<ThemeChanger>(context);
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: <Widget>[
            AppBar(
                leading: Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.012, left: width * 0.03),
                  child: IconButton(
                    iconSize: 35.0,
                    icon: Icon(
                      CustomIcons.share_alt,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Share.share(
                          'https://play.google.com/store/apps/details?id=in.selvasoft.beats');
                    },
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.012, left: width * 0.03),
                    child: IconButton(
                      iconSize: 35.0,
                      icon: Icon(
                        CustomIcons.user,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _displayDialog(context);
                      },
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
            SingleChildScrollView(
              child: Column(
                children: <Widget>[],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Container(
                child: ListView.builder(
                  itemCount: titles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            side: BorderSide(
                                width: 0.45, color: themeChanger.accentColor)),
                        color: Theme.of(context).cardColor,
                        elevation: 5.0,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Navigator.push(
                                        context,
                                        EnterExitRoute(
                                            exitPage: SettingsScreen(),
                                            enterPage: Themes()));
                                    break;
                                  case 1:
                                    Navigator.push(
                                        context,
                                        EnterExitRoute(
                                            exitPage: SettingsScreen(),
                                            enterPage: PlayBack()));
                                    break;
                                  case 2:
                                    Navigator.push(
                                        context,
                                        EnterExitRoute(
                                            exitPage: SettingsScreen(),
                                            enterPage: AboutUs()));
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
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textTheme
                                          .display1
                                          .color),
                                ),
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
      ),
      onWillPop: () {
        return null;
      },
    );
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlertDialog(
              shape: Border.all(color: Colors.greenAccent),
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                'Enter your name!',
                style: Theme.of(context).textTheme.display2,
              ),
              content: TextFormField(
                maxLength: 10,
                controller: text,
                decoration: InputDecoration(
                    errorText: err ? "Whats in a name?" : null,
                    errorStyle: Theme.of(context).textTheme.display2,
                    labelText: "Enter Name",
                    labelStyle: Theme.of(context).textTheme.display2,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    'Set',
                    style: Theme.of(context).textTheme.display2,
                  ),
                  onPressed: () {
                    validate(context);
                  },
                )
              ],
            ),
          );
        });
  }

  void validate(context) {
    setState(() {
      text.text.isEmpty ? err = true : err = false;
    });
    if (text.text.isNotEmpty) {
      username.setName(text.text.toString());
      text.clear();
      Navigator.of(context).pop();
    } else {}
  }
}
