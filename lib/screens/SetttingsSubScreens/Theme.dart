import '../../models/ThemeModel.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../HomeScreen.dart';
import 'package:beats/themes/Themes.dart';

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
                  Text("Themes", style: Theme.of(context).textTheme.display1),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 120.0, left: width * 0.02),
            child: ListTile(
              trailing: Icon(
                Icons.brush,
                size: 25.0,
                color: Colors.grey,
              ),
              title: Text("Current Theme",
                  style: Theme.of(context).textTheme.display2),
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
      backgroundColor: Theme.of(context).backgroundColor,
        context: context,
        builder: (BuildContext bc) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.brush ,  color: Colors.grey,),
                      title: new Text('White'
                      , style: Theme.of(context).textTheme.display2,
                      ),
                      onTap: () => {
                            themeChanger.setTheme(lightTheme())
                          }),
                  new ListTile(
                    leading: new Icon(Icons.brush, color: Colors.grey,),
                    title: new Text('Black'
                    ,style: Theme.of(context).textTheme.display2,),
                    onTap: () => {
                          themeChanger.setTheme(darkTheme())
                          
                        },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.brush,
                    color: Colors.grey,
                    ),
                    title: new Text('Black AF',
                    style: Theme.of(context).textTheme.display2,),
                    onTap: () => {},
                  ),
                ],
              ),
            ),
          );
        });
  }
}
