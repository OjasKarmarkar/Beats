import 'dart:io';
import 'package:beats/models/ThemeModel.dart';
import 'package:beats/models/PlaylistRepo.dart';
import 'package:beats/models/BookmarkModel.dart';
import 'package:beats/models/PlayListHelper.dart';
import 'package:beats/models/SongsModel.dart';
import 'package:beats/models/Now_Playing.dart';
import 'package:flutter/material.dart';
import '../custom_icons.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';
import 'package:beats/models/ProgressModel.dart';

class PlayBackPage extends StatefulWidget {
  @override
  _PlayBackPageState createState() => _PlayBackPageState();
}

class _PlayBackPageState extends State<PlayBackPage> {
  SongsModel model;
  ThemeChanger themeChanger;

  Now_Playing Play_Screen;

  TextEditingController txt = TextEditingController();

  bool error = false;
  List<String> playlist = new List();

  @override
  Widget build(BuildContext context) {
    Play_Screen = Provider.of<Now_Playing>(context);
    themeChanger = Provider.of<ThemeChanger>(context);

    if (Play_Screen.get_Screen() == true) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: <Widget>[
            Consumer<SongsModel>(
                builder: (context, model, _) => Column(children: [
                      SizedBox(
                        height: height * 0.63,
                        width: width,
                        child: (model.currentSong.albumArt != null)
                            ? Image.file(
                                File.fromUri(
                                    Uri.parse(model.currentSong.albumArt)),
                                fit: BoxFit.fill,
                                width: width,
                                height: height * 0.63,
                              )
                            : Image.asset(
                                "assets/headphone.png",
                                alignment: Alignment.center,
                              ),
                      ),
                      Consumer<ProgressModel>(builder: (context, a, _) {
                        return Slider(
                          activeColor: themeChanger.accentColor,
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
                      Container(
                        height: height * 0.03,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0.1),
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
                        height: height * 0.035,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0.02),
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
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.015),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                model.repeat
                                    ? model.setRepeat(false)
                                    : model.setRepeat(true);
                              },
                              icon: Icon(
                                Icons.loop,
                                color: model.repeat ? Colors.pink : Colors.grey,
                                size: 35.0,
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
                                size: 40.0,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  if (model.currentState ==
                                          PlayerState.PAUSED ||
                                      model.currentState ==
                                          PlayerState.STOPPED) {
                                    model.play();
                                  } else {
                                    model.pause();
                                  }
                                },
                                child: FloatingActionButton(
                                  backgroundColor: themeChanger.accentColor,
                                  child: (model.currentState ==
                                              PlayerState.PAUSED ||
                                          model.currentState ==
                                              PlayerState.STOPPED)
                                      ? Icon(
                                          CustomIcons.play,
                                          size: 30.0,
                                        )
                                      : Icon(CustomIcons.pause),
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
                                size: 40.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.01),
                              child: IconButton(
                                  onPressed: () {
                                    model.shuffle
                                        ? model.setShuffle(false)
                                        : model.setShuffle(true);
                                  },
                                  icon: Icon(
                                    Icons.shuffle,
                                    color: model.shuffle
                                        ? Colors.pink
                                        : Colors.grey,
                                    size: 35.0,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                iconSize: 35.0,
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2.0),
                              child: Consumer<BookmarkModel>(
                                builder: (context, bookmark, _) => IconButton(
                                  onPressed: () {
                                    if (!bookmark
                                        .alreadyExists(model.currentSong)) {
                                      bookmark.add(model.currentSong);
                                    } else {
                                      bookmark.remove(model.currentSong);
                                    }
                                  },
                                  icon: Icon(
                                    bookmark.alreadyExists(model.currentSong)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: bookmark
                                            .alreadyExists(model.currentSong)
                                        ? Colors.pink
                                        : Colors.grey,
                                    size: 35.0,
                                  ),
                                ),
                              ),
                            ),
                            Consumer<PlaylistRepo>(
                              builder: (context, repo, _) {
                                return IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return SimpleDialog(
                                            backgroundColor: Theme.of(context)
                                                .backgroundColor,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text(
                                                    "Add to Playlist",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .display1,
                                                  ),
                                                  Container(
                                                    height: 25,
                                                    width: 25,
                                                    child: FloatingActionButton(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .backgroundColor,
                                                      onPressed: () {
                                                        _displayDialog(
                                                            context, repo);
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .add_circle_outline,
                                                        color:
                                                            Colors.greenAccent,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                width: double.maxFinite,
                                                child: (repo.playlist.length !=
                                                        0)
                                                    ? ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: repo
                                                            .playlist.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10.0),
                                                            child: ListTile(
                                                              onTap: () {
                                                                PlaylistHelper(
                                                                        repo.playlist[
                                                                            index])
                                                                    .add(model
                                                                        .currentSong);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              title: Text(
                                                                repo.playlist[
                                                                    index],
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .display2,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    : Center(
                                                        child:
                                                            Text("No Playlist"),
                                                      ),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.playlist_add,
                                    color: Colors.grey,
                                    size: 35.0,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ])),
          ],
        ),
      );
    } else {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: <Widget>[
            AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              leading: Padding(
                padding:
                    EdgeInsets.only(top: height * 0.012, left: width * 0.03),
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
                                height: 290,
                                width: 290,
                                child: ClipOval(
                                  child: (model.currentSong.albumArt != null)
                                      ? Image.file(
                                          File.fromUri(Uri.parse(
                                              model.currentSong.albumArt)),
                                          width: 100,
                                          height: 100,
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 30.0),
                                          child: Image.asset(
                                              "assets/headphone.png")),
                                ),
                              ),
                            )),
                        //)
                      ) //;},
                      //),
                      ),
                  Container(
                    height: height * 0.09,
                    child: Padding(
                      padding: EdgeInsets.only(top: 12),
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
                    height: height * 0.04,
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
                      activeColor: themeChanger.accentColor,
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
                        EdgeInsets.only(left: width * 0.1, top: height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            model.player.stop();
                            model.previous();
                            model.play();
                          },
                          icon: Icon(
                            CustomIcons.step_backward,
                            color: Colors.grey,
                            size: 40.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.01),
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
                                backgroundColor: themeChanger.accentColor,
                                child:
                                    (model.currentState == PlayerState.PAUSED ||
                                            model.currentState ==
                                                PlayerState.STOPPED)
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
                              color: Colors.grey,
                              size: 40.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.001, top: height * 0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Consumer<BookmarkModel>(
                            builder: (context, bookmark, _) => IconButton(
                              onPressed: () {
                                if (!bookmark
                                    .alreadyExists(model.currentSong)) {
                                  bookmark.add(model.currentSong);
                                } else {
                                  bookmark.remove(model.currentSong);
                                }
                              },
                              icon: Icon(
                                bookmark.alreadyExists(model.currentSong)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: bookmark.alreadyExists(model.currentSong)
                                    ? Colors.pink
                                    : Colors.grey,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            model.repeat
                                ? model.setRepeat(false)
                                : model.setRepeat(true);
                          },
                          icon: Icon(
                            Icons.loop,
                            color: model.repeat ? Colors.pink : Colors.grey,
                            size: 35.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            model.shuffle
                                ? model.setShuffle(false)
                                : model.setShuffle(true);
                          },
                          icon: Icon(
                            Icons.shuffle,
                            color: model.shuffle ? Colors.pink : Colors.grey,
                            size: 35.0,
                          ),
                        ),
                        Consumer<PlaylistRepo>(
                          builder: (context, repo, _) {
                            return IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        backgroundColor:
                                            Theme.of(context).backgroundColor,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text(
                                                "Add to Playlist",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1,
                                              ),
                                              Container(
                                                height: 25,
                                                width: 25,
                                                child: FloatingActionButton(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .backgroundColor,
                                                  onPressed: () {
                                                    _displayDialog(
                                                        context, repo);
                                                  },
                                                  child: Icon(
                                                    Icons.add_circle_outline,
                                                    color: Colors.greenAccent,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: double.maxFinite,
                                            child: (repo.playlist.length != 0)
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        repo.playlist.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0),
                                                        child: ListTile(
                                                          onTap: () {
                                                            PlaylistHelper(
                                                                    repo.playlist[
                                                                        index])
                                                                .add(model
                                                                    .currentSong);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          title: Text(
                                                            repo.playlist[
                                                                index],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .display2,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Center(
                                                    child: Text("No Playlist"),
                                                  ),
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.playlist_add,
                                color: Colors.grey,
                                size: 35.0,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]));
    }
  }

  _displayDialog(BuildContext context, repo) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlertDialog(
              shape: Border.all(color: Colors.greenAccent),
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                'Add',
                style: Theme.of(context).textTheme.display2,
              ),
              content: TextFormField(
                controller: txt,
                decoration: InputDecoration(
                    errorText: error ? "Name cant be null" : null,
                    errorStyle: Theme.of(context).textTheme.display2,
                    labelText: "Enter Name",
                    labelStyle: Theme.of(context).textTheme.display2,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    'Create',
                    style: Theme.of(context).textTheme.display2,
                  ),
                  onPressed: () {
                    validate(context, repo);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
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
