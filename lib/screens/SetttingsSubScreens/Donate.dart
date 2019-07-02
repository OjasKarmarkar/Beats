import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:line_icons/line_icons.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Theme.of(context).backgroundColor,
      routes: {
        "/": (_) => new WebviewScaffold(
          url: "https://www.paypal.me/whatsnewofficial",
          withZoom: true,
          appBar: AppBar(
            leading: IconButton(
              iconSize: 35.0,
              icon: Icon(
                LineIcons.arrow_circle_o_left,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                
              },
            ),
          ),
      withLocalStorage: true,
       hidden: true,
        ),
      },
    );
  }
}