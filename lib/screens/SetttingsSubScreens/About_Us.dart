import 'package:beats/models/SongsModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../custom_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../MusicLibrary.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  SongsModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBar(
            leading: IconButton(
              iconSize: 25.0,
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            centerTitle: false,
            title: Text("About", style: Theme.of(context).textTheme.display1),
          ),
          Padding(
              padding: EdgeInsets.only(top: height * 0.07),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Align(
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.03),
                        child: Card(
                          elevation: 20.0,
                          child: Container(
                            height: height * 0.2,
                            width: width * 0.9,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFF0D47A1),
                                    Color(0xFF1976D2),
                                    Color(0xFF42A5F5),
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: width * 0.12,
                                  top: height * 0.065,
                                  child: CircleAvatar(
                                    child: Icon(CustomIcons.user),
                                  ),
                                ),
                                Positioned(
                                    left: width * 0.3,
                                    top: height * 0.05,
                                    child: Text.rich(TextSpan(
                                        text: "Selva,\n",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                        children: <TextSpan>[
                                          new TextSpan(
                                              text: 'Lead Developer',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17))
                                        ]))),
                                Positioned(
                                  left: width * 0.27,
                                  top: height * 0.135,
                                  child: IconButton(
                                    color: Colors.transparent,
                                    icon: Icon(
                                      CustomIcons.paper_plane,
                                      color: Colors.white,
                                    ),
                                    onPressed: _launchTg,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.03),
                        child: Card(
                          elevation: 15.0,
                          child: Container(
                            height: height * 0.2,
                            width: width * 0.9,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xff007991),
                                    Color(0xFF78ffd6),
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: width * 0.12,
                                  top: height * 0.065,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    child: Icon(CustomIcons.user,
                                        color: Colors.white),
                                  ),
                                ),
                                Positioned(
                                    left: width * 0.3,
                                    top: height * 0.05,
                                    child: Text.rich(TextSpan(
                                        text: "OjasK,\n",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                        children: <TextSpan>[
                                          new TextSpan(
                                              text: 'Lead Developer',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17))
                                        ]))),
                                Positioned(
                                  left: width * 0.27,
                                  top: height * 0.135,
                                  child: IconButton(
                                    color: Colors.transparent,
                                    icon: Icon(
                                      CustomIcons.instagram,
                                      color: Colors.white,
                                    ),
                                    onPressed: _launchInsta,
                                  ),
                                ),
                                Positioned(
                                  left: width * 0.35,
                                  top: height * 0.135,
                                  child: IconButton(
                                    color: Colors.transparent,
                                    icon: Icon(
                                      CustomIcons.google,
                                      color: Colors.white,
                                    ),
                                    onPressed: _launchGmail,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.03),
                        child: Card(
                          elevation: 10.0,
                          child: Container(
                            height: height * 0.3,
                            width: width * 0.9,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xffFF5F6D),
                                    Color(0xFFFFC371),
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Special Thanks To:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.02),
                                  child: Text(
                                    "1. Pawan For The Flute Plugin\n\n2. Launcher Icon Made by Freepik from\n www.flaticon.com",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.02),
                                  child: Text(
                                    "3.The Designer Behind the Images Used",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

_launchInsta() async {
  const uri = 'https://www.instagram.com/ojask002/';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    // iOS
    const uri = 'https://www.instagram.com/ojask002/';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}

_launchTg() async {
  const uri = 'https://selvasoft.in/';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    // iOS
    const uri = 'https://selvasoft.in/';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}

_launchGmail() async {
  const uri = 'mailto:<ojask2002@gmail.com>?subject=Regarding Beats&body=';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    // iOS
    const uri = 'https://mail.google.com/';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
