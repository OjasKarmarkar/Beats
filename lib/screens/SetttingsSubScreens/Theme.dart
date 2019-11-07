import 'package:beats/models/SongsModel.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import '../../models/ThemeModel.dart';
import 'package:flutter/material.dart';
import '../../custom_icons.dart';
import 'package:provider/provider.dart';
import '../MusicLibrary.dart';
import 'package:beats/themes/Themes.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class Themes extends StatefulWidget {
  @override
  _ThemesState createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {
  ThemeChanger themeChanger;

  SongsModel model;


  @override
  Widget build(BuildContext context) {
    themeChanger = Provider.of<ThemeChanger>(context);
    model = Provider.of<SongsModel>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
              child: Text("Now Playing",
                  style: Theme.of(context).textTheme.display1),
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
          ),
          Padding(
            padding: EdgeInsets.only(top: 190.0, left: width * 0.02),
            child: ListTile(
              title: Text("Accent Color",
                  style: Theme.of(context).textTheme.display2),
              trailing: CircleColor(
                color: themeChanger.getAccent(),
                circleSize: 25.0,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.14, horizontal: width * 0.15),
                    child: Container(
                      color: Theme.of(context).backgroundColor,
                      height: height * 0.2,
                      width: width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Color Picker",
                                  style: Theme.of(context).textTheme.display1),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialColorPicker(
                                colors: [
                                  Colors.blue,
                                  Colors.red,
                                  Colors.deepPurpleAccent,
                                  Colors.green,
                                  Colors.greenAccent
                                ],
                                allowShades: false,
                                selectedColor: themeChanger.getAccent(),
                                circleSize: 70,
                                onMainColorChange: (ColorSwatch selectedColor) {
                                  themeChanger.setAccent(selectedColor);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: FloatingActionButton(
                                child: Icon(CustomIcons.leaf),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
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
                      Icons.brush,
                      color: Colors.grey,
                    ),
                    title: new Text(
                      'White',
                      style: Theme.of(context).textTheme.display2,
                    ),
                    onTap: () => {
                          themeChanger.setTheme(lightTheme()),
                          Navigator.pop(context)
                        }),
                new ListTile(
                  leading: new Icon(
                    Icons.brush,
                    color: Colors.grey,
                  ),
                  title: new Text(
                    'Dark',
                    style: Theme.of(context).textTheme.display2,
                  ),
                  onTap: () => {
                    themeChanger.setTheme(darkTheme()),
                    Navigator.pop(context)
                  },
                ),
                new ListTile(
                  leading: new Icon(
                    Icons.brush,
                    color: Colors.grey,
                  ),
                  title: new Text(
                    'Amoled Black',
                    style: Theme.of(context).textTheme.display2,
                  ),
                  onTap: () => {
                    themeChanger.setTheme(darkAFTheme()),
                    Navigator.pop(context)
                  },
                ),
              ],
            ),
          );
        });
  }
}
