import 'package:beats/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import '../Models/CustomShapeClipper.dart';

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
                backgroundColor: Colors.white,
                expandedHeight: height * 0.45,
                floating: false,
                pinned: true,
                flexibleSpace: ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            
                            Padding(
                              padding: const EdgeInsets.only(top: 100.0),
                              child: Text(
                                "Playlist 1",
                                style: TextStyle(
                                    fontSize: 40.0, color: Colors.white),
                              ),
                            )
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
          child: Center(
            child: Text("Sample Text"),
          ),
        ),
      ),
    );
  }
}