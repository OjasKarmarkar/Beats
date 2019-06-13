import 'package:flutter/material.dart';
import 'PLayList.dart';
import '../widgets/welcome.dart';

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
    return Column(
      children: <Widget>[
        getWelcome(height, width),
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
                          Navigator.of(context).push(
                              new MaterialPageRoute(
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
          padding: EdgeInsets.only(top: height * 0.03),
          child: Text(
            "Recently Played",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
            height: height * 0.2,
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                  title: Text("Song 1"),
                )
              ],
            ))
      ],
    );
  }
}
