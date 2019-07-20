import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beats/models/SongsModel.dart';
import 'package:beats/models/BookmarkModel.dart';

import '../custom_icons.dart';
import 'HomeScreen.dart';
import 'Player.dart';

class Bookmarks extends StatelessWidget {
  SongsModel model;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    return Consumer<BookmarkModel>(
      builder: (context, bm, _) => Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Stack(
              children: <Widget>[
                (bm.bookmarks == null)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : (bm.bookmarks.length == 0)
                        ? Center(
                            child: Text(
                            "No Bookmarks",
                            style: Theme.of(context).textTheme.display1,
                          ))
                        : ListView.builder(
                            itemCount: bm.bookmarks.length,
                            itemBuilder: (context, pos) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 20.0),
                                child: ListTile(
                                  onTap: () {
                                    model.player.stop();
                                    model.currentSong = bm.bookmarks[pos];
                                    model.filterResults(
                                        ""); //Reset the list. So we can change to next song.
                                    model.play();
                                    isPressed = true;
                                  },
                                  leading:
                                      CircleAvatar(child: getImage(bm, pos)),
                                  title: Text(
                                    bm.bookmarks[pos].title,
                                    style: Theme.of(context).textTheme.display2,
                                  ),
                                ),
                              );
                            },
                          ),
                if(isPressed) showStatus(model)
              ],
            ),
          ),
    );
  }

  getImage(bm, pos) {
    if (bm.bookmarks[pos].albumArt != null) {
      print(bm.bookmarks[pos].albumArt);
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:
              Image.file(File.fromUri(Uri.parse(bm.bookmarks[pos].albumArt))));
    } else {
      return Icon(Icons.music_note);
    }
  }

  showStatus(model) {
      return Align(
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
                      child: ClipRect(
                    child: Image.file(
                        File.fromUri(Uri.parse(model.currentSong.albumArt))),
                  )),
                  title: Text(
                    model.currentSong.title,
                    style: TextStyle(),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10.0),
                    child: Text(
                      model.currentSong.artist,
                      style: TextStyle(color: Colors.white, fontSize: 11.0),
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          if (model.currentState == PlayerState.PAUSED ||
                              model.currentState == PlayerState.STOPPED) {
                            model.play();
                          } else {
                            model.pause();
                          }
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          child: FloatingActionButton(
                            child: (model.currentState == PlayerState.PAUSED ||
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
                  ),
                ),
              ),
              color: Colors.black,
              height: height * 0.11,
              width: width * 0.59,
            ),
          ));
    
  }
}
