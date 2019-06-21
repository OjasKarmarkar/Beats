import 'package:flutter/material.dart';
import 'dart:io';
import 'package:beats/models/SongsModel.dart';
import 'package:provider/provider.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {

  SongsModel model;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    model.fetchSongs();
    return Scaffold(
      appBar: AppBar(title: Text("Songs"),),
      body: ListView.builder(
        itemBuilder: (context,pos){
          return ListTile(
            leading: CircleAvatar(child: getImage(pos)),
            title: Text(model.songs[pos].title),
          );
        },
        itemCount: model.songs.length,
      ),
    );
  }

  getImage(pos){
    if(model.songs[pos].albumArt!=null){
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(File.fromUri(Uri.parse(model.songs[pos].albumArt)))
      );
    }else{
      return Icon(Icons.music_note);
    }
  }
}
