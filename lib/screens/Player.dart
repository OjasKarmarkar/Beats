import 'dart:io';
import 'package:beats/Models/SongsModel.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';

class PlayBackPage extends StatefulWidget {
  @override
  _PlayBackPageState createState() => _PlayBackPageState();
}

class _PlayBackPageState extends State<PlayBackPage> {

  SongsModel model;
  @override
  Widget build(BuildContext context) {
    
    model = Provider.of<SongsModel>(context);
  MusicFinder player = new MusicFinder();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.white,
            leading: Padding(
              padding: EdgeInsets.only(top: height * 0.012, left: width * 0.03),
              child: IconButton(
                iconSize: 35.0,
                icon: Icon(
                  LineIcons.arrow_circle_o_left,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Column(
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: model.songs[model.currentSong].albumArt != null
                        ? Image.file(File.fromUri(
                            Uri.parse(model.songs[model.currentSong].albumArt)))
                        : Text(model.songs[model.currentSong].title),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
