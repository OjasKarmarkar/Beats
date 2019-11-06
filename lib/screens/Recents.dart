import 'dart:io';
import 'package:beats/models/RecentsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:provider/provider.dart';
import 'package:beats/screens/Player.dart';
import 'package:beats/models/SongsModel.dart';
import 'MusicLibrary.dart';

class LastPlayed extends StatefulWidget {
  @override
  _LastPlayedState createState() => _LastPlayedState();
}

class _LastPlayedState extends State<LastPlayed> {
  SongsModel model;

  @override
  void initState() {
    MediaNotification.setListener('next', () {
      setState(() {
        model.player.stop();
        model.next();
        MediaNotification.showNotification(
            title: model.currentSong.title, author: model.currentSong.artist);
        model.play();
      });
    });

    MediaNotification.setListener('prev', () {
      setState(() {
        model.player.stop();
        model.previous();
        MediaNotification.showNotification(
            title: model.currentSong.title, author: model.currentSong.artist);
        model.play();
      });
    });

    MediaNotification.setListener('pause', () {
      setState(() {
        model.pause();
      });
    });
    MediaNotification.setListener('play', () {
      setState(() {
        model.play();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    return Consumer<Recents>(
      builder: (context, lastPlayed, _) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (lastPlayed.recently == null)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (lastPlayed.recently.length == 0)
                  ? Center(
                      child: Text(
                      "Play Something!",
                      style: Theme.of(context).textTheme.display3,
                    ))
                  : Container(
                      height: height * 0.16,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: lastPlayed.recently.length,
                          itemBuilder: (context, pos) {
                            return ListTile(
                              onTap: () {
                                model.player.stop();
                                model.currentSong = lastPlayed.recently[pos];
                                MediaNotification.showNotification(
                                    title: model.currentSong.title,
                                    author: model.currentSong.artist);
                                model.play();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PlayBackPage();
                                }));
                              },
                              leading: CircleAvatar(
                                  child: getImage(lastPlayed, pos)),
                              title: Text(
                                lastPlayed.recently[pos].title,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.display2,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  getImage(lastPlayed, pos) {
    if (lastPlayed.recently[pos].albumArt != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
              File.fromUri(Uri.parse(lastPlayed.recently[pos].albumArt))));
    } else {
      return Icon(Icons.music_note);
    }
  }
}
