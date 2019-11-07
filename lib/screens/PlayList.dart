import 'dart:io';

import 'package:beats/models/PlaylistRepo.dart';
import 'package:beats/models/SongsModel.dart';
import 'package:beats/models/PlayListHelper.dart';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:provider/provider.dart';
import '../custom_icons.dart';
import 'MusicLibrary.dart';

class PLayListScreen extends StatefulWidget {
  @override
  _PLayListScreenState createState() => _PLayListScreenState();
}

class _PLayListScreenState extends State<PLayListScreen> {
  PlaylistRepo playlistRepo;
  SongsModel model;
  String name;
  TextEditingController editingController;
  List<Song> songs;

  

  @override
  void didChangeDependencies() {
    playlistRepo = Provider.of<PlaylistRepo>(context);
    name = playlistRepo.playlist[playlistRepo.selected];
    initData();
    model = Provider.of<SongsModel>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).backgroundColor,
                  expandedHeight: height * 0.25,
                  floating: true,
                  pinned: false,
                  snap: false,
                  flexibleSpace: Container(
                    height: 200,
                    color: Colors.blue,
                    child: Stack(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.01, left: width * 0.034),
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
                          )),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.02),
                          child: Text(
                            name,
                            style:
                                TextStyle(fontSize: 40.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ]),
                  )),
            ];
          },
          body: (songs != null)
              ? (songs.length != 0)
                  ? Stack(children: <Widget>[
                      ListView.builder(
                        itemCount: songs.length,
                        itemBuilder: (context, pos) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 0.0, left: 10.0),
                            child: ListTile(
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.grey,
                                ),
                                onPressed: () async {
                                  model.player.stop();
                                  await PlaylistHelper(name)
                                      .deleteSong(songs[pos]);
                                  initData();
                                },
                              ),
                              onTap: () {
                                //isPlayed = true;
                                model.player.stop();
                                model.playlist = true;
                                model.playlistSongs = songs;
                                model.currentSong = songs[pos];
                             
                                model.play();
                              },
                              leading: CircleAvatar(child: getImage(pos)),
                              title: Text(
                                songs[pos].title,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.display3,
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  songs[pos].artist,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.display2,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: showStatus(),
                      )
                    ])
                  : Center(
                      child: Text(
                        "No Songs",
                        style: Theme.of(context).textTheme.display2,
                      ),
                    )
              : Center(
                  child: Text(
                    "Loading...",
                    style: Theme.of(context).textTheme.display2,
                  ),
                )),
    );
  }

  void initData() async {
    var helper = PlaylistHelper(name);
    songs = await helper.getSongs();
    setState(() {});
  }

  getImage(pos) {
    if (songs[pos].albumArt != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(File.fromUri(Uri.parse(songs[pos].albumArt))));
    } else {
      return Icon(Icons.music_note);
    }
  }

  showStatus() {
    if (model.currentSong != null) {
      return Container(
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
                maxLines: 1,
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
      );
    } else {}
  }
}
