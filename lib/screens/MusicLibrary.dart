import 'package:beats/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:beats/models/SongsModel.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:flute_music_player/flute_music_player.dart';

import 'Player.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {

  TextEditingController editingController;
  var duplicateItem = <Song>[];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,SongsModel model,_){
        return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.05, right: width * 0.05, top: height * 0.06),
              child: TextField(
                  controller: editingController,
                  decoration: InputDecoration(
                     disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(),
                      hintText: "Search",
                      prefixIcon: Icon(LineIcons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.grey)
                      ))),
            ),
            getLoading(model)
          ],
        ),
      );
      },
    );
  }

  filterResults(String value){
    /*List<Songs> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if(value.isNotEmpty){

    }*/

  }

  getLoading(model){
    if (model.songs.length==0){
      return Expanded(child:Center(child: CircularProgressIndicator(),));
    }else{
      return Expanded(
            child: ListView.builder(
              itemCount: model.songs.length,
              itemBuilder: (context, pos) {
                return ListTile(
                  onTap: () {
                    model.currentSong = pos;
                    model.play(model);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PlayBackPage();
                    }));
                  },
                  leading: CircleAvatar(child: getImage(model,pos)),
                  title: Text(
                    model.songs[pos].title,
                    style: Theme.of(context).textTheme.display2,
                  ),
                );
              },
            ),
          );
    }
  }

  getImage(model,pos) {
    if (model.songs[pos].albumArt != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:
              Image.file(File.fromUri(Uri.parse(model.songs[pos].albumArt))));
    } else {
      return Icon(Icons.music_note);
    }
  }
}
