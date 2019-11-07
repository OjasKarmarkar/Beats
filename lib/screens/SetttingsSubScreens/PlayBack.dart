import 'package:beats/models/SongsModel.dart';
import 'package:beats/models/ThemeModel.dart';
import 'package:beats/models/Now_Playing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../MusicLibrary.dart';

class PlayBack extends StatefulWidget {
  @override
  _PlayBackState createState() => _PlayBackState();
}

class _PlayBackState extends State<PlayBack> {
  ThemeChanger themeChanger;

  NowPlaying playScreen;

  SongsModel model;

  @override
  Widget build(BuildContext context) {
    playScreen = Provider.of<NowPlaying>(context);
    themeChanger = Provider.of<ThemeChanger>(context);
    model = Provider.of<SongsModel>(context);
    return Scaffold(
        body: Stack(children: <Widget>[
      AppBar(
        leading: Padding(
          padding: EdgeInsets.only(top: height * 0.016, left: width * 0.03),
          child: IconButton(
            iconSize: 25.0,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: height * 0.022),
          child:
              Text("Now Playing", style: Theme.of(context).textTheme.display1),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 120.0, left: width * 0.02),
        child: ListTile(
          leading: Icon(
            Icons.play_circle_outline,
            size: 27.0,
            color: Colors.grey,
          ),
          title: Text("Change Look of Now Playing",
              style: Theme.of(context).textTheme.display2),
          onTap: () {
            _settingModalBottomSheet(context);
          },
        ),
      ),
    ]));
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(
                      Icons.details,
                      color: themeChanger.getAccent(),
                    ),
                    title: new Text(
                      'Immersive',
                      style: Theme.of(context).textTheme.display2,
                    ),
                    onTap: () => {
                          playScreen.setScreen(true),
                          playScreen.getScreen(),
                          Navigator.pop(context)
                        }),
                new ListTile(
                  leading: new Icon(
                    Icons.details,
                    color: themeChanger.getAccent(),
                  ),
                  title: new Text(
                    'Basic',
                    style: Theme.of(context).textTheme.display2,
                  ),
                  onTap: () => {
                    playScreen.setScreen(false),
                    playScreen.getScreen(),
                    Navigator.pop(context)
                  },
                ),
              ],
            ),
          );
        });
  }
}
