import 'dart:io';
import 'package:beats/models/BookmarkModel.dart';
import 'package:beats/models/SongHelper.dart';
import 'package:beats/models/SongsModel.dart';
import 'package:pref_dessert/pref_dessert.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import '../custom_icons.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';
import 'package:beats/models/ProgressModel.dart';

class PlayBackPage extends StatelessWidget {
  SongsModel model;
   var lastPlayed = FuturePreferencesRepository<Song>(new SongHelper());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            leading: Padding(
              padding: EdgeInsets.only(top: height * 0.012, left: width * 0.03),
              child: IconButton(
                iconSize: 35.0,
                icon: Icon(
                  CustomIcons.arrow_circle_o_left,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Consumer<SongsModel>(
            builder: (context, model, _) => Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: height * 0.04),
                    child: Align(
                      alignment: Alignment.center,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(200)),
                          elevation: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: SizedBox(
                              height: 300,
                              width: 300,
                              child: ClipOval(
                                child: (model.currentSong.albumArt != null)
                                    ? Image.file(
                                        File.fromUri(Uri.parse(
                                            model.currentSong.albumArt)),
                                        width: 100,
                                        height: 100,
                                      )
                                    : Image.asset("assets/headphone.png"),
                              ),
                            ),
                          )),
                      //)
                    ) //;},
                    //),
                    ),
                Container(
                  height: height * 0.1,
                  child: Padding(
                    padding: EdgeInsets.only(top: 14),
                    child: Center(
                      child: Text(
                        model.currentSong.title,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height * 0.06,
                  child: Padding(
                    padding: EdgeInsets.only(top: 1.0),
                    child: Center(
                      child: Text(
                        model.currentSong.artist.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Consumer<ProgressModel>(builder: (context, a, _) {
                  return Slider(
                    max: a.duration.toDouble(),
                    onChanged: (double value) {
                      if (value.toDouble() == a.duration.toDouble()) {
                        model.player.stop();
                        model.next();
                        model.play();
                      } else {
                        a.setPosition(value);
                        model.seek(value);
                      }
                    },
                    value: a.position.toDouble(),
                  );
                }),
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.24, top: height * 0.04),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.1),
                        child: IconButton(
                          onPressed: () {
                            model.player.stop();
                            model.previous();
                            model.play();
                          },
                          icon: Icon(
                            CustomIcons.step_backward,
                            color: Colors.black,
                            size: 40.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: width * 0.1, top: height * 0.01),
                        child: InkWell(
                            onTap: () {
                              if (model.currentState == PlayerState.PAUSED ||
                                  model.currentState == PlayerState.STOPPED) {
                                model.play();
                              } else {
                                model.pause();
                              }
                            },
                            child: FloatingActionButton(
                              child: (model.currentState ==
                                          PlayerState.PAUSED ||
                                      model.currentState == PlayerState.STOPPED)
                                  ? Icon(
                                      CustomIcons.play,
                                      size: 30.0,
                                    )
                                  : Icon(CustomIcons.pause),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.1),
                        child: IconButton(
                          onPressed: () {
                            model.player.stop();
                            model.next();
                            model.play();
                          },
                          icon: Icon(
                            CustomIcons.step_forward,
                            color: Colors.black,
                            size: 40.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.075, top: height * 0.06),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.13),
                        child: Consumer<BookmarkModel>(
                              builder: (context, bookmark, _) => IconButton(
                                    onPressed: () {
                                      if (!bookmark.contains(model.currentSong)) {
                                        bookmark.add(model.currentSong);
                                      }else{
                                        bookmark.remove(model.currentSong);
                                      }
                                    },
                                    icon: Icon(
                                      bookmark.contains(model.currentSong) ? Icons.bookmark : Icons.bookmark_border,
                                      color: bookmark.contains(model.currentSong) ? Colors.pink : Colors.grey,
                                      size: 35.0,
                                    ),
                                  ),
                            ),
                      
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.13),
                        child: IconButton(
                          onPressed: () {
                            model.player.stop();
                            model.current_Song();
                            model.play();
                          },
                          icon: Icon(
                            Icons.loop,
                            color: Colors.grey,
                            size: 35.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.13),
                        child: IconButton(
                          onPressed: () {
                            model.player.stop();
                            model.random_Song();
                            model.play();
                          },
                          icon: Icon(
                            Icons.shuffle,
                            color: Colors.grey,
                            size: 35.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.05),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.16,
                                        horizontal: width * 0.13),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Container(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: height * 0.05,
                                                    horizontal: width * 0.13),
                                                child: Text("Add to Playlist",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .display1),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: height * 0.05,
                                                    horizontal: width * 0.1),
                                                child: Container(
                                                  height: height * 0.4,
                                                  child: ListView(
                                                    children: <Widget>[
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      4.0),
                                                          child: Material(
                                                            child: ListTile(
                                                              title: Text(
                                                                  "Playlist 1",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .display2),
                                                            ),
                                                          )),
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      4.0),
                                                          child: Material(
                                                            child: ListTile(
                                                              title: Text(
                                                                  "Playlist 2",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .display2),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.playlist_add,
                            color: Colors.grey,
                            size: 35.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
