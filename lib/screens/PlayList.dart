import 'package:beats/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:beats/widgets/CustomShapeClipper.dart';
import 'package:beats/widgets/SongClipper.dart';

class PLayListScreen extends StatefulWidget {
  @override
  _PLayListScreenState createState() => _PLayListScreenState();
}

class _PLayListScreenState extends State<PLayListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                expandedHeight: height * 0.45,
                floating: true,
                pinned: false,
                snap: false,
                bottom: PreferredSize(
                  preferredSize: Size(130.0, height * 0.16),
                  child: Container(
                    color: Colors.transparent,
                    height: height * 0.22,
                  ),
                ),
                flexibleSpace: ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.037, left: width * 0.034),
                              child: SizedBox(
                                width: 42.0,
                                height: 42.0,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.21,
                                  top: height * 0.032,
                                  right: width * 0.05),
                              child: TextField(
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                    labelText: "Search",
                                    hintText: "Search",
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0)))),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                                child: Padding(
                                  padding:  EdgeInsets.only(top:height*0.18),
                                  child: Text(
                                    "Playlist 1",
                                    style: TextStyle(
                                        fontSize: 40.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            
                          ],
                        )
                      ],
                    ),
                    color: Colors.blueAccent,
                  ),
                )),
          ];
        },
        body: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.001, left: width * 0.03),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/en/thumb/8/87/Jonas_Brothers_-_Sucker.png/220px-Jonas_Brothers_-_Sucker.png"),
                          ),
                          title: Text(
                            "Suckers",
                            style: TextStyle(fontSize: 19.0),
                          ),
                          subtitle: Text("Jonas Brothers"),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.elliptical(10, 4)),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://upload.wikimedia.org/wikipedia/en/thumb/8/87/Jonas_Brothers_-_Sucker.png/220px-Jonas_Brothers_-_Sucker.png"),
                            ),
                            title: Text(
                              "Suckers",
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Text(
                                "Jonas Brothers",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11.0),
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              iconSize: 30.0,
                              icon: Icon(
                                Icons.pause_circle_outline,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        color: Colors.black,
                        height: height * 0.11,
                        width: width * 0.59,
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
