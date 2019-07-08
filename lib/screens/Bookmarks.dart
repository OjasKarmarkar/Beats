import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:provider/provider.dart';

import 'package:beats/screens/Player.dart';
import 'package:beats/models/SongsModel.dart';
import 'package:beats/models/BookmarkModel.dart';

class Bookmarks extends StatelessWidget {
  
  SongsModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    return Consumer<BookmarkModel>(
      builder: (context, bookmark, _) => Scaffold(
            body: (bookmark.bookmarkList == null)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : (bookmark.bookmarkList.length == 0)
                    ? Center(child: Text("No Bookmarks"))
                    : ListView.builder(
                        itemCount: bookmark.bookmarkList.length,
                        itemBuilder: (context, pos) {
                          return ListTile(
                            onTap: () {
                              model.player.stop();
                              model.currentSong = bookmark.bookmarkList[pos];
                              model.filterResults(
                                  ""); //Reset the list. So we can change to next song.
                              model.play();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return PlayBackPage();
                              }));
                            },
                            leading: CircleAvatar(child: getImage(bookmark, pos)),
                            title: Text(
                              bookmark.bookmarkList[pos].title,
                              style: Theme.of(context).textTheme.display2,
                            ),
                          );
                        },
                      ),
          ),
    );
  }

  getImage(bm, pos) {
    if (bm.bookmarkList[pos].albumArt!="") {
      print(bm.bookmarkList[pos].albumArt);
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:
              Image.file(File.fromUri(Uri.parse(bm.bookmarkList[pos].albumArt))));
    } else {
      return Icon(Icons.music_note);
    }
  }
}
