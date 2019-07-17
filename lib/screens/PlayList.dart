import 'package:beats/models/SongsModel.dart';
import 'package:beats/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:beats/widgets/SongClipper.dart';

import '../custom_icons.dart';

class PLayListScreen extends StatefulWidget {
  @override
  _PLayListScreenState createState() => _PLayListScreenState();
}

class _PLayListScreenState extends State<PLayListScreen> {
  SongsModel model;
  TextEditingController editingController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).backgroundColor,
                expandedHeight: height * 0.4,
                floating: true,
                pinned: false,
                snap: false,
                flexibleSpace: Container(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.04, left: width * 0.034),
                            child: SizedBox(
                              width: 42.0,
                              height: 42.0,
                              child: IconButton(
                                iconSize: 35.0,
                                icon: Icon(
                                  CustomIcons.arrow_circle_o_left,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.21,
                                top: height * 0.032,
                                right: width * 0.05),
                            child: TextField(
                                cursorColor: Colors.black,
                                onChanged: (value) {
                                  model.filterResults(value);
                                },
                                controller: editingController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    contentPadding: EdgeInsets.all(13.0),
                                    hintStyle:
                                        Theme.of(context).textTheme.display2,
                                    hintText: "Search",
                                    prefixIcon: Icon(
                                      CustomIcons.search,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide:
                                            BorderSide(color: Colors.white)))),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: height * 0.18),
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
              ),
            ];
          },
          body: Scaffold(
             backgroundColor: Theme.of(context).backgroundColor,
             
          )),
    );
  }
}
