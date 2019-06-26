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
              style: Theme.of(context).textTheme.display1
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          leading: Padding(
            padding: EdgeInsets.only(top: height * 0.012, left: width * 0.03),
            child: IconButton(
              iconSize: 35.0,
              icon: Icon(
                LineIcons.arrow_circle_o_left,
                color: Colors.grey,
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
                          style: Theme.of(context).textTheme.display1
                        ),
                        subtitle: Text("Lead Dev" , style: Theme.of(context).textTheme.display2,),
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
                          style: Theme.of(context).textTheme.display1
                        ),
                        subtitle: Text("Lead Dev" , style: Theme.of(context).textTheme.display2,),
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
