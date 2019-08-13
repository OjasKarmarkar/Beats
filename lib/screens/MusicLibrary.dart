import 'package:beats/Animations/transitions.dart';
import 'package:beats/Models/PlayListHelper.dart';
import 'package:beats/models/PlaylistRepo.dart';
import 'package:beats/models/ThemeModel.dart';
import 'package:beats/models/BookmarkModel.dart';
import 'package:beats/models/const.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:beats/models/SongsModel.dart';
import '../custom_icons.dart';
import 'package:provider/provider.dart';
import 'Player.dart';

double height, width;

class Library extends StatelessWidget {
  TextEditingController editingController;
  SongsModel model;
  BookmarkModel b;
  ThemeChanger themeChanger;
  TextEditingController txt = TextEditingController();
  bool error = false;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    b = Provider.of<BookmarkModel>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        body: (model.songs == null)
            ? Center(
                child: Text(
                  "No Songs",
                  style: Theme.of(context).textTheme.display1,
                ),
              )
            : NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverOverlapAbsorber(
                          child: SliverSafeArea(
                            top: false,
                            sliver: SliverAppBar(
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: IconButton(
                                    icon: Icon(Icons.search,
                                        color: Theme.of(context)
                                            .textTheme
                                            .display1
                                            .color),
                                    onPressed: () {
                                      showSearch(
                                          context: context, delegate: Search());
                                    },
                                  ),
                                ),
                              ],
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              expandedHeight: height * 0.11,
                              pinned: true,
                              flexibleSpace: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: width * 0.06),
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Songs",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .display1
                                                  .color),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context))
                    ],
                body: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[getLoading(model)],
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: showStatus(model),
                    )
                  ],
                )));
  }

  getLoading(SongsModel model) {
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
            return Consumer<PlaylistRepo>(builder: (context, repo, _) {
              return ListTile(
                trailing: PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                  onSelected: (String choice) async {
                    print("debug " + choice);
                    if (choice == Constants.pl) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Add to Playlist",
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.maxFinite,
                                  child: (repo.playlist.length != 0)
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: repo.playlist.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.0),
                                              child: ListTile(
                                                onTap: () {
                                                  PlaylistHelper(
                                                          repo.playlist[index])
                                                      .add(model.songs[pos]);
                                                  Navigator.pop(context);
                                                },
                                                title: Text(
                                                  repo.playlist[index],
                                                  style: Theme.of(context)
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
                    } else if (choice == Constants.bm) {
                      if (!b.alreadyExists(model.songs[pos])) {
                        b.add(model.songs[pos]);
                      } else {
                        b.remove(model.songs[pos]);
                      }
                    }else if(choice == Constants.de){
                      await File(model.songs[pos].uri).delete();
                      model.fetchSongs();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return Constants.choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            choice,
                            style: Theme.of(context).textTheme.display2,
                          ),
                        ),
                      );
                    }).toList();
                  },
                ),
                onTap: () {
                  model.player.stop();
                  model.playlist = false;
                  model.currentSong = model.songs[pos];
                  model.filterResults(
                      ""); //Reset the list. So we can change to next song.
                  model.play();
                },
                leading: CircleAvatar(child: getImage(model, pos)),
                title: Text(
                  model.songs[pos].title,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.display2,
                ),
              );
            });
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
      return Container(
          child: IconButton(
            icon: Icon(
              Icons.music_note,
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            // Box decoration takes a gradient
            gradient: LinearGradient(
              colors: <Color>[
                themeChanger.accentColor,
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
              ],
            ),
          ));
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
              onTap: () {
                Navigator.push(context, Scale(page: PlayBackPage()));
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
                              backgroundColor: themeChanger.accentColor,
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

class Search extends SearchDelegate<Song> {
  SongsModel model;
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(
          Icons.clear,
          color: Colors.grey,
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.grey,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // show results
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    List<Song> dummy = <Song>[];
    List<Song> recents = <Song>[];
    for (int i = 0; i < model.songs.length; i++) {
      dummy.add(model.songs[i]);
    }
    //for (int i = 0; i < 4; i++) {
    // recents.add(model.songs[i].title);
    //}
    var suggestion = query.isEmpty
        ? recents
        : dummy
            .where((p) => p.title.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    // hint when searches
    return ListView.builder(
      itemCount: suggestion.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              model.player.stop();
              model.playURI(suggestion[index].uri);
              model.playlist = false;
              close(context, null);
            },
            title: Text(
              suggestion[index].title,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: CircleAvatar(child: Icon(Icons.music_note)),
          ),
        );
      },
    );
  }
}
