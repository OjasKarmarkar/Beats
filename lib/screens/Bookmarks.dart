import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:provider/provider.dart';

import 'package:beats/screens/Player.dart';
import 'package:beats/models/SongsModel.dart';
import 'package:beats/models/BookmarkModel.dart';

class Bookmarks extends StatefulWidget {
  @override
  State<Bookmarks> createState() {
    return _BookmarksState();
  }
}

class _BookmarksState extends State<Bookmarks> {

  SongsModel model;
  var bookmarkList;

  @override
  void initState() {
    super.initState();
    initRequirements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (bookmarkList == null && model == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: bookmarkList.length,
              itemBuilder: (context, pos) {
                return ListTile(
              onTap: () {
                model.player.stop();
                model.currentSong = model.songs[pos];
                model.filterResults(""); //Reset the list. So we can change to next song.
                model.play();

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PlayBackPage();
                }));
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

  void initRequirements() {
    bookmarkList = BookmarkModel().getAll();
    model = Provider.of<SongsModel>(context);
    setState(() {});
  }
}
