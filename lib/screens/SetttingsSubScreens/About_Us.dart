import 'package:beats/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        AppBar(
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: height * 0.022),
            child: Text(
              "About Us",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 35.0,
                  fontFamily: 'sans-serif'),
            ),
          ),
          backgroundColor: Colors.white,
          leading: Padding(
            padding: EdgeInsets.only(top: height * 0.012, left: width * 0.03),
            child: IconButton(
              iconSize: 35.0,
              icon: Icon(
                LineIcons.arrow_circle_o_left,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        ListView(
          children: <Widget>[
            Container(
                height: height,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding:EdgeInsets.only(
                          left: width * 0.07, top: height * 0.12),
                      child: Text(
                        "The Team",
                      
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green
                        ),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.02, top: height * 0.03),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/selva.jpg"
                          )
                        ),
                        title: Text(
                          "Selva",
                          style: TextStyle(fontSize: 19.0),
                        ),
                        subtitle: Text("Lead Dev"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.02, top: height * 0.005),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              "assets/Ojas.jpg"),
                        ),
                        title: Text(
                          "OjasK",
                          style: TextStyle(fontSize: 19.0),
                        ),
                        subtitle: Text("Lead Dev"),
                      ),
                    )
                  ],
                ))
          ],
        )
      ],
    ));
  }
}
