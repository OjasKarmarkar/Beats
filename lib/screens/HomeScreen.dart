import 'package:beats/screens/Recents.dart';
import 'package:flutter/material.dart';
import 'PlayList.dart';


double height, width;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          Container(
            height: height * 0.25,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(top: height * 0.1, left: width * 0.1),
                      child: Text("User,",
                          style: Theme.of(context).textTheme.headline,),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, left: width * 0.1),
                      child: Text("Welcome",
                          style: Theme.of(context).textTheme.subhead),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Image.asset("assets/headphone.png"))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: width * 0.08, top: height * 0.04),
              child: SizedBox(
                  height: height * 0.31,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => new PLayListScreen()));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: width * 0.4,
                                color: Colors.blue,
                                child: Center(
                                    child: Text("PlayList 1",
                                        style: TextStyle(color: Colors.white))),
                              )),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: width * 0.4,
                              color: Colors.pinkAccent,
                              child: Center(
                                  child: Text(
                                "PlayList 2",
                                style: TextStyle(color: Colors.white),
                              )),
                            )),
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: width * 0.3,
                              child: Center(child: Icon(Icons.add)),
                            )),
                      ),
                    ],
                  ))),
          Padding(
            padding: EdgeInsets.only(top: height * 0.03, left: 20.0),
            child: Text(
              "Recently Played",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          LastPlayed()
        ],
      ),
    );
  }
}
