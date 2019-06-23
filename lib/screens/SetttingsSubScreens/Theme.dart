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
                  color: IconThemeData().color,
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
                  Text("Themes", style: Theme.of(context).textTheme.display1),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 120.0, left: width * 0.02),
            child: ListTile(
              trailing: Icon(
                Icons.brush,
                size: 25.0,
                color: IconThemeData().color,
              ),
              title: Text("Current Theme",
                  style: Theme.of(context).textTheme.display1),
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
                      onTap: () => {
                            themeChanger.setTheme(ThemeData(
                                textTheme: TextTheme(
                                  display1: TextStyle(
                                      color: Colors.black, fontSize: 20.0),
                                ),
                                iconTheme: IconThemeData(color: Colors.black),
                                backgroundColor: Colors.white))
                          }),
                  new ListTile(
                    leading: new Icon(Icons.brush),
                    title: new Text('Black'),
                    onTap: () => {
                          themeChanger.setTheme(ThemeData(
                              iconTheme: IconThemeData(color: Colors.white),
                              backgroundColor: Colors.black,
                              textTheme: TextTheme(
                                  display1: TextStyle(
                                      color: Colors.white, fontSize: 20.0))))
                        },
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
