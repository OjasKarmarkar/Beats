import 'package:flutter/material.dart';
import '../../custom_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../MusicLibrary.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        AppBar(
            leading: Padding(
              padding: EdgeInsets.only(top: height * 0.01, left: width * 0.03),
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
          padding: EdgeInsets.only(top: height*0.07),
          child: ListView(
            children: <Widget>[
              Container(
                  height: height,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.07, top: height * 0.035),
                        child: Text(
                          "The Team",
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.02, top: height * 0.03),
                        child: ListTile(
                          leading: Icon(
                            Icons.person_outline,
                            color: Colors.blueAccent,
                          ),
                          title: Text("Selva",
                              style: Theme.of(context).textTheme.display1),
                          subtitle: Text(
                            "Lead Dev",
                            style: Theme.of(context).textTheme.display2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.02, top: height * 0.005),
                        child: ListTile(
                          leading: Icon(
                            Icons.person_outline,
                            color: Colors.blueAccent,
                          ),
                          title: Text("OjasK",
                              style: Theme.of(context).textTheme.display1),
                          subtitle: Text(
                            "Lead Dev",
                            style: Theme.of(context).textTheme.display2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.07, top: height * 0.02),
                        child: Text(
                          "Contact Us",
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.02, top: height * 0.03),
                        child: ListTile(
                          onTap: _launchTg,
                          leading: CircleAvatar(
                              backgroundColor: Theme.of(context).backgroundColor,
                              child: Icon(CustomIcons.paper_plane)),
                          title: Text("Telegram",
                              style: Theme.of(context).textTheme.display1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.02, top: height * 0.005),
                        child: ListTile(
                          onTap: _launchInsta,
                          leading: CircleAvatar(
                              backgroundColor: Theme.of(context).backgroundColor,
                              child: Icon(CustomIcons.instagram)),
                          title: Text("Instagram",
                              style: Theme.of(context).textTheme.display1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.02, top: height * 0.005),
                        child: ListTile(
                          onTap: _launchGmail,
                          leading: CircleAvatar(
                              backgroundColor: Theme.of(context).backgroundColor,
                              child: Icon(CustomIcons.google)),
                          title: Text("Gmail",
                              style: Theme.of(context).textTheme.display1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.07, top: height * 0.03),
                        child: Text(
                          "Credits to :",
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.08, top: height * 0.02),
                        child: Text("1. Pawan For The Flute Plugin",
                            style: Theme.of(context).textTheme.display2),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.08, top: height * 0.02),
                        child: Text("2. Launcher Icon Made by Freepik from www.flaticon.com",
                            style: Theme.of(context).textTheme.display2),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.08, top: height * 0.02),
                        child: Text("3.The Designer Behind the Images Used",
                            style: Theme.of(context).textTheme.display2),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Align(alignment: Alignment.center,
                          child: Text(
                            "Made In ❤️ With flutter",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.blueAccent),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        )
      ],
    ));
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
  const uri = 'https://telegram.me/selvasoft';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    // iOS
    const uri = 'https://telegram.me/selvasoft';
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
