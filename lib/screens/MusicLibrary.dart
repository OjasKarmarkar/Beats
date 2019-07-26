import 'package:beats/Animations/transitions.dart';
import 'package:beats/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:beats/models/SongsModel.dart';
import '../custom_icons.dart';
import 'package:provider/provider.dart';
import 'Player.dart';

class Library extends StatelessWidget {
  TextEditingController editingController;
  SongsModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: (model.songs == null) ? Center(child: Text("No Songs", style: Theme.of(context).textTheme.display1,),) : Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.04,
                      top: height * 0.03,
                      bottom: height * 0.01),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 10),
                    child: TextField(
                        onChanged: (value) {
                          model.filterResults(value);
                        },
                        controller: editingController,
                        decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide(color: Colors.greenAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide(color: Colors.greenAccent)),
                            hintStyle: Theme.of(context).textTheme.display2,
                            hintText: "Search",
                            prefixIcon: Icon(
                              CustomIcons.search,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide(color: Colors.greenAccent)))),
                  ),
                ),
                getLoading(model),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: showStatus(model),
            )
          ],
        ));
  }

  getLoading(model) {
    if (model.songs.length == 0) {
      return Expanded(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: model.songs.length,
          itemBuilder: (context, pos) {
            return ListTile(
              trailing: PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
                itemBuilder: (context){

                },
              ),
              onTap: () {
                model.player.stop();
                model.currentSong = model.songs[pos];
                model.filterResults(
                    ""); //Reset the list. So we can change to next song.
                model.play();
              },
              leading: CircleAvatar(child: getImage(model, pos)),
              title: Text(
                model.songs[pos].title,
                style: Theme.of(context).textTheme.display2,
              ),
            );
          },
        ),
      );
    }
  }

  getImage(model, pos) {
    if (model.songs[pos].albumArt != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:
              Image.file(File.fromUri(Uri.parse(model.songs[pos].albumArt))));
    } else {
      return Icon(Icons.music_note);
    }
  }

  push(context) {
    Navigator.push(context, Scale(page: PlayBackPage()));
  }

  showStatus(model) {
    if (model.currentSong != null) {
      return Container(
        height: 45,
        width: width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (context, pos) {
            return GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dy < 0) {
                  push(context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    border: Border(top: BorderSide(color: Colors.greenAccent))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: width * 0.65,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Text(
                                model.currentSong.title,
                                style: Theme.of(context).textTheme.display2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          model.player.stop();
                          model.previous();
                          model.play();
                        },
                        icon: Icon(
                          CustomIcons.step_backward,
                          color: Colors.grey,
                          size: 25.0,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            if (model.currentState == PlayerState.PAUSED ||
                                model.currentState == PlayerState.STOPPED) {
                              model.play();
                            } else {
                              model.pause();
                            }
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            child: FloatingActionButton(
                              child: (model.currentState ==
                                          PlayerState.PAUSED ||
                                      model.currentState == PlayerState.STOPPED)
                                  ? Icon(
                                      CustomIcons.play,
                                      size: 20.0,
                                    )
                                  : Icon(
                                      CustomIcons.pause,
                                      size: 20.0,
                                    ),
                            ),
                          )),
                      IconButton(
                        onPressed: () {
                          model.player.stop();
                          model.next();
                          model.play();
                        },
                        icon: Icon(
                          CustomIcons.step_forward,
                          color: Colors.grey,
                          size: 25.0,
                        ),
                      ),
                    ]),
              ),
            );
          },
        ),
      );
    } else {}
  }
}
