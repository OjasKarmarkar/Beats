import 'package:flutter/material.dart';

import '../widgets/welcome.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        getWelcome(height, width),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child:SizedBox(
            height: height*0.3,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:Container(
                      width: width *0.3,
                      color: Colors.blue,
                      child: Center(child:Text("PlayList 1",style: TextStyle(color: Colors.white))),
                    )
                  ),
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:Container(
                        width: width *0.3,
                        color: Colors.pinkAccent,
                        child: Center(child:Text("PlayList 2",style: TextStyle(color: Colors.white),)),
                      )
                  ),
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:Container(
                        width: width *0.3,
                        child: Center(child:Icon(Icons.add)),
                      )
                  ),
                ),
              ],
            )
          )
        )
      ],
    );
  }
}
