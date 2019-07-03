import 'dart:io';
import 'package:beats/models/SongsModel.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';
import 'package:beats/models/ProgressModel.dart';

class PlayBackPage extends StatelessWidget {
  SongsModel model;
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
                  LineIcons.arrow_circle_o_left,
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
                                child: model.currentSong.albumArt != null
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
                      a.setPosition(value);
                      model.seek(value);
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
                            Icons.skip_previous,
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
                                      LineIcons.play,
                                      size: 30.0,
                                    )
                                  : Icon(LineIcons.pause),
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
                            Icons.skip_next,
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
                        child: IconButton(
                          icon: Icon(
                            LineIcons.bookmark,
                            color: Colors.grey,
                            size: 35.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.13),
                        child: IconButton(
                          icon: Icon(
                            LineIcons.scissors,
                            color: Colors.grey,
                            size: 35.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.13),
                        child: IconButton(
                          icon: Icon(
                            LineIcons.refresh,
                            color: Colors.grey,
                            size: 35.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.05),
                        child: IconButton(
                          icon: Icon(
                            LineIcons.recycle,
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
