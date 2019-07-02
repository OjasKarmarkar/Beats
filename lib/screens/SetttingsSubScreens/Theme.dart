import '../../models/ThemeModel.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../HomeScreen.dart';
import 'package:beats/themes/Themes.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class Themes extends StatelessWidget {
  ThemeChanger themeChanger;
  MaterialColor color = Colors.blue;

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
          ),
          Padding(
            padding: EdgeInsets.only(top: 190.0, left: width * 0.02),
            child: ListTile(
              title: Text("Accent Color",
                  style: Theme.of(context).textTheme.display2),
              trailing: CircleColor(
                color: color,
                circleSize: 25.0,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.2, horizontal: width * 0.15),
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
                                allowShades: false,
                                selectedColor: color,
                                circleSize: 70,
                                onMainColorChange: (ColorSwatch SelectedColor) {
                                  debugPrint(SelectedColor.toString());
                                  color = SelectedColor;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: FloatingActionButton(
                                child: Icon(LineIcons.leaf),
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
                    onTap: () => {themeChanger.setTheme(lightTheme())}),
                new ListTile(
                  leading: new Icon(
                    Icons.brush,
                    color: Colors.grey,
                  ),
                  title: new Text(
                    'Dark',
                    style: Theme.of(context).textTheme.display2,
                  ),
                  onTap: () => {themeChanger.setTheme(darkTheme())},
                ),
                new ListTile(
                  leading: new Icon(
                    Icons.brush,
                    color: Colors.grey,
                  ),
                  title: new Text(
                    'Dark AF',
                    style: Theme.of(context).textTheme.display2,
                  ),
                  onTap: () => {themeChanger.setTheme(darkAFTheme())},
                ),
              ],
            ),
          );
        });
  }
}
