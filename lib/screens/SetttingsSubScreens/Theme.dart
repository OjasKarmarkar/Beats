import '../../models/ThemeModel.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../HomeScreen.dart';

class Themes extends StatelessWidget {
  ThemeChanger themeChanger;

  @override
  Widget build(BuildContext context) {
    themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBar(
            leading: Padding(
              padding: EdgeInsets.only(top: height * 0.012, left: width * 0.03),
              child: IconButton(
                iconSize: 35.0,
                icon: Icon(
                  LineIcons.arrow_circle_left,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Padding(
              padding: EdgeInsets.only(top: height * 0.022),
              child: Text(
                "Themes",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                    fontFamily: 'sans-serif'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 120.0, left: width * 0.02),
            child: ListTile(
              trailing: Icon(
                Icons.brush,
                size: 25.0,
              ),
              title: Text(
                "Current Theme",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                _settingModalBottomSheet(context);
              },
            ),
          )
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.brush),
                      title: new Text('White'),
                      onTap: () => {themeChanger.setTheme(ThemeData.light())}),
                  new ListTile(
                    leading: new Icon(Icons.brush),
                    title: new Text('Black'),
                    onTap: () => {themeChanger.setTheme(ThemeData.dark())},
                  ),
                  new ListTile(
                    leading: new Icon(Icons.brush),
                    title: new Text('Black AF'),
                    onTap: () => {},
                  ),
                ],
              ),
            ),
          );
        });
  }
}
