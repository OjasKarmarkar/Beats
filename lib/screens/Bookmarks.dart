import 'dart:io';
import 'package:beats/screens/Player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:provider/provider.dart';
import 'package:beats/models/SongsModel.dart';
import 'package:beats/models/BookmarkModel.dart';
import '../custom_icons.dart';
import 'MusicLibrary.dart';
import 'package:beats/Animations/transitions.dart';

class Bookmarks extends StatelessWidget {
  SongsModel model;

  bool isPlayed = false;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    return Consumer<BookmarkModel>(
      builder: (context, bm, _) => WillPopScope(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Stack(
            children: <Widget>[
              (bm.bookmarks == null)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : (bm.bookmarks.length == 0 || bm.bookmarks.length == null)
                      ? Center(
                          child: Text(
                          "No Favourites",
                          style: Theme.of(context).textTheme.display1,
                        ))
                      : Container(
                          height: height * 0.2,
                          width: width,
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                Text("Liked Songs",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30.0)),
                              ],
                            ),
                          ),
                          // Add box decoration
                          decoration: BoxDecoration(
                            // Box decoration takes a gradient
                            gradient: LinearGradient(
                              // Where the linear gradient begins and ends
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              // Add one stop for each color. Stops should increase from 0 to 1
                              stops: [0.1, 0.5, 0.7, 0.9],
                              colors: [
                                Colors.lightBlue,
                                Colors.blue,
                                Colors.blueAccent,
                                Colors.blue,
                              ],
                            ),
                          )),
              Padding(
                padding: EdgeInsets.only(top: height * 0.2),
                child: ListView.builder(
                  itemCount: bm.bookmarks.length,
                  itemBuilder: (context, pos) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                      child: ListTile(
                        onTap: () {
                          model.player.stop();
                          model.playlist = true;
                          model.playlistSongs = bm.bookmarks;
                          model.currentSong = bm.bookmarks[pos];

                          model.play();
                        },
                        leading: CircleAvatar(child: getImage(bm, pos)),
                        title: Text(
                          bm.bookmarks[pos].title,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.display1.color),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            bm.bookmarks[pos].artist,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 12,
                                color:
                                    Theme.of(context).textTheme.display1.color),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              //showStatus(model , context)
            ],
          ),
        ),
        onWillPop: () {},
      ),
    );
  }

  getImage(bm, pos) {
    if (bm.bookmarks[pos].albumArt != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:
              Image.file(File.fromUri(Uri.parse(bm.bookmarks[pos].albumArt))));
    } else {
      return Icon(Icons.music_note);
    }
  }

  showStatus(model, context) {
    if (model.currentSong != null) {
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).textTheme.display1.color,
              ),
            )),
        height: height * 0.06,
        width: width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (context, pos) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, Scale(page: PlayBackPage()));
              },
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        color: Theme.of(context).textTheme.display1.color,
                        icon: Icon(Icons.arrow_drop_up),
                        onPressed: () {
                          Navigator.push(context, Scale(page: PlayBackPage()));
                        },
                      ),
                      Container(
                        width: width * 0.75,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            model.currentSong.title,
                            style: Theme.of(context).textTheme.display2,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: IconButton(
                          icon: model.currentState == PlayerState.PAUSED ||
                                  model.currentState == PlayerState.STOPPED
                              ? Icon(
                                  CustomIcons.play,
                                  color: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .color,
                                  size: 20.0,
                                )
                              : Icon(
                                  CustomIcons.pause,
                                  color: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .color,
                                  size: 20.0,
                                ),
                          onPressed: () {
                            if (model.currentState == PlayerState.PAUSED ||
                                model.currentState == PlayerState.STOPPED) {
                              model.play();
                            } else {
                              model.pause();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {}
  }
}
