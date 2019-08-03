import 'package:beats/Models/Username.dart';
import 'package:beats/models/PlayListHelper.dart';
import 'package:beats/screens/Recents.dart';
import 'package:beats/models/PlaylistRepo.dart';
//import 'package:beats/Models/playlist_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'PlayList.dart';

double height, width;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Username username;
  TextEditingController txt = TextEditingController();
  bool error = false;

  @override
  Widget build(BuildContext context) {
    username = Provider.of<Username>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      padding: EdgeInsets.only(
                          top: height * 0.08, left: width * 0.1),
                      child: Text(
                        username.getName() + ",",
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.005, left: width * 0.1),
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
              padding: EdgeInsets.only(top: height * 0.04),
              child: SizedBox(
                height: height * 0.31,
                child: Consumer<PlaylistRepo>(
                  builder: (context, playlistRepo, _) => ListView.builder(
                    itemCount: playlistRepo.playlist.length + 1,
                    itemBuilder: (context, pos) {
                      var padd = (pos == 0) ? width * 0.08 : 5.0;
                      if (pos == (playlistRepo.playlist.length)) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AlertDialog(
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                    contentPadding: EdgeInsets.only(top: 10.0),
                                    content: Container(
                                      width: 200.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                "New Playlist",
                                                style: TextStyle(
                                                    fontSize: 24.0,
                                                    fontFamily: 'Sans'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                            height: 4.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 30.0,
                                                right: 30.0,
                                                top: 30.0,
                                                bottom: 30.0),
                                            child: TextFormField(
                                              controller: txt,
                                              decoration: InputDecoration(
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .greenAccent)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .greenAccent)),
                                                  errorText: error
                                                      ? "Name cant be null"
                                                      : null,
                                                  errorStyle: Theme.of(context)
                                                      .textTheme
                                                      .display2,
                                                  labelText: "Enter Name",
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .display2,
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4))),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              validate(context, playlistRepo);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 10.0, bottom: 20.0),
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(32.0),
                                                    bottomRight:
                                                        Radius.circular(32.0)),
                                              ),
                                              child: Text(
                                                "Create!",
                                                style: TextStyle(
                                                    fontFamily: 'Sans',
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.only(left: padd, right: 5.0),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                    width: width * 0.4,
                                    child: Center(child: Icon(Icons.add)))),
                          ),
                        );
                      } else {
                        return Card(
                          margin: EdgeInsets.only(left: padd, right: 5.0),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                            onTap: () {
                              playlistRepo.selected = pos;
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => new PLayListScreen()));
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: width * 0.4,
                                  color: Colors.blue,
                                  child: Stack(children: <Widget>[
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete_outline,
                                            color: Colors.white,
                                          ),
                                          onPressed: () async {
                                            PlaylistHelper temp =
                                                await PlaylistHelper(
                                                    playlistRepo.playlist[pos]);
                                            temp.deletePlaylist();
                                            playlistRepo.delete(
                                                playlistRepo.playlist[pos]);
                                            //playlistRepo.init();
                                          },
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 40.0, top: 8.0),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: AlertDialog(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .backgroundColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30.0)),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 10.0),
                                                    content: Container(
                                                      width: 200.0,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Text(
                                                                "Edit",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        24.0,
                                                                    fontFamily:
                                                                        'Sans'),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Divider(
                                                            color: Colors.grey,
                                                            height: 4.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 30.0,
                                                                    right: 30.0,
                                                                    top: 30.0,
                                                                    bottom:
                                                                        30.0),
                                                            child:
                                                                TextFormField(
                                                              controller: txt,
                                                              decoration: InputDecoration(
                                                                  disabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .greenAccent)),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .greenAccent)),
                                                                  errorText: error
                                                                      ? "Name cant be null"
                                                                      : null,
                                                                  errorStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .display2,
                                                                  labelText:
                                                                      "Enter Name",
                                                                  labelStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .display2,
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4))),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              playlistRepo.playlist[pos] = "HI";
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 10.0,
                                                                      bottom:
                                                                          20.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.blue,
                                                                borderRadius: BorderRadius.only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            32.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            32.0)),
                                                              ),
                                                              child: Text(
                                                                "Done",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Sans',
                                                                    color: Colors
                                                                        .white),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Center(
                                        child: Text(playlistRepo.playlist[pos],
                                            style:
                                                TextStyle(color: Colors.white)))
                                  ]),
                                )),
                          ),
                        );
                      }
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: height * 0.03, left: 20.0),
            child: Text(
              "Recently Played",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Expanded(
            child: LastPlayed(),
          )
        ],
      ),
    );
  }

  void validate(context, repo) {
    setState(() {
      txt.text.isEmpty ? error = true : error = false;
    });
    if (txt.text.isNotEmpty) {
      repo.add(txt.text);
      txt.clear();
      Navigator.of(context).pop();
    } else {}
  }
}
