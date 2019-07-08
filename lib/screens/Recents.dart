import 'dart:io';
import 'package:beats/Models/Recently_played.dart';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:provider/provider.dart';
import 'package:beats/screens/Player.dart';
import 'package:beats/models/SongsModel.dart';

import 'HomeScreen.dart';


class LastPlayed extends StatelessWidget {
  
  SongsModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    return Consumer<Recents>(
      builder: (context, lastPlayed, _) => Scaffold(
            body: SizedBox(
                 height: height * 0.2,
                          child: (lastPlayed.recently == null)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : (lastPlayed.recently.length == 0)
                      ? Center(child: Text("No last Played"))
                      : ListView.builder(
                          itemCount: lastPlayed.recently.length,
                          itemBuilder: (context, pos) {
                            return ListTile(
                              onTap: () {
                                model.player.stop();
                                model.currentSong = lastPlayed.recently[pos];
                                model.filterResults(
                                    ""); //Reset the list. So we can change to next song.
                                model.play();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PlayBackPage();
                                }));
                              },
                              leading: CircleAvatar(child: getImage(lastPlayed, pos)),
                              title: Text(
                                lastPlayed.recently[pos].title,
                                style: Theme.of(context).textTheme.display2,
                              ),
                            );
                          },
                        ),
            ),
          ),
    );
  }

  getImage(lastPlayed, pos) {
    if (lastPlayed.recently[pos].albumArt != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:
              Image.file(File.fromUri(Uri.parse(lastPlayed.recently[pos].albumArt))));
    } else {
      return Icon(Icons.music_note);
    }
  }
}
