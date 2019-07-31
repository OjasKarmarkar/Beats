import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beats/models/SongsModel.dart';
import 'package:beats/models/BookmarkModel.dart';
import '../custom_icons.dart';
import 'HomeScreen.dart';

class Bookmarks extends StatelessWidget {
  SongsModel model;
  bool isPlayed = false;

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
                : (bm.bookmarks.length == 0 || bm.bookmarks.length == null)
                    ? Center(
                        child: Text(
                        "No Bookmarks",
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
                        model.filterResults(
                            ""); //Reset the list. So we can change to next song.
                        model.play();
                      },
                      leading: CircleAvatar(child: getImage(bm, pos)),
                      title: Text(
                        bm.bookmarks[pos].title,
                        style: Theme.of(context).textTheme.display3,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          bm.bookmarks[pos].artist,
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            //showStatus(model)
          ],
        ),
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

  showStatus(model) {
    if (isPlayed = true) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.greenAccent),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(10.0),
                bottomRight: Radius.elliptical(10, 4)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              leading: CircleAvatar(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: (model.currentSong.albumArt != null)
                    ? Image.file(
                        File.fromUri(Uri.parse(model.currentSong.albumArt)),
                        width: 100,
                        height: 100,
                      )
                    : Image.asset("assets/headphone.png"),
              )),
              title: Text(
                model.currentSong.title,
                maxLines: 1,
                style: TextStyle(color: Colors.white, fontSize: 11.0),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 0, top: 5.0, bottom: 10.0),
                child: Text(
                  model.currentSong.artist,
                  style: TextStyle(
                      fontFamily: 'Sans', color: Colors.white, fontSize: 11.0),
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
          height: height * 0.1,
          width: width * 0.62,
        ),
      );
    } else {}
  }
}
