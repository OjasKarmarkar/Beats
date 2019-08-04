import 'package:beats/models/ThemeModel.dart';
import 'package:beats/models/Now_Playing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../custom_icons.dart';
import '../MusicLibrary.dart';

class PlayBack extends StatelessWidget {

ThemeChanger themeChanger;
Now_Playing Play_Screen;

  @override
  Widget build(BuildContext context) {
    Play_Screen = Provider.of<Now_Playing>(context);
    themeChanger  = Provider.of<ThemeChanger>(context);
    return Scaffold(
       body: Stack(
        children: <Widget>[
          AppBar(
            leading: Padding(
              padding: EdgeInsets.only(top: height * 0.012, left: width * 0.03),
              child: IconButton(
                iconSize: 35.0,
                icon: Icon(
                  CustomIcons.arrow_circle_o_left,
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
                  Play_Screen.set_Screen(true),
                    Play_Screen.get_Screen(),
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
                    Play_Screen.set_Screen(false),
                    Play_Screen.get_Screen(),
                    Navigator.pop(context)
                  },
                ),
               
              ],
            ),
          );
        });
  }
  } 

