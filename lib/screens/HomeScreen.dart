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
          SizedBox(
              height: height * 0.2,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: width * 0.07, top: height * 0.03),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/en/thumb/8/87/Jonas_Brothers_-_Sucker.png/220px-Jonas_Brothers_-_Sucker.png"),
                      ),
                      title: Text("Suckers",
                          style: Theme.of(context).textTheme.display1),
                      subtitle: Text("Jonas Brothers",
                          style: Theme.of(context).textTheme.display2),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: width * 0.07, top: height * 0.01),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/en/thumb/a/af/Alan_Walker_-_On_My_Way.png/220px-Alan_Walker_-_On_My_Way.png"),
                      ),
                      title: Text("On My Way",
                          style: Theme.of(context).textTheme.display1),
                      subtitle: Text("Alan Walker",
                          style: Theme.of(context).textTheme.display2),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
