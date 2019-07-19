import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beats/models/SongsModel.dart';
import 'package:beats/models/BookmarkModel.dart';

class Bookmarks extends StatelessWidget {
  SongsModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    return Consumer<BookmarkModel>(
      builder: (context, bookmark, _) => Scaffold(
        body: Container(
          child: Text("Hello"),
        ),
      ),
    );
  }

  getImage(bm, pos) {
    if (bm.bookmarkList[pos].albumArt != null) {
      print(bm.bookmarkList[pos].albumArt);
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
              File.fromUri(Uri.parse(bm.bookmarkList[pos].albumArt))));
    } else {
      return Icon(Icons.music_note);
    }
  }
}
