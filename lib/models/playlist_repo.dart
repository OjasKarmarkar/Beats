import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaylistRepo extends ChangeNotifier {
  List<String> playlist;
  SharedPreferences prefList;

  PlaylistRepo() {
    init();
  }

  init() async {
    prefList = await SharedPreferences.getInstance();
    List<String> list = prefList.getStringList("Playlist");
    updatePlayList(list);
  }

  getList() {
    return playlist;
  }

  updatePlayList(List<String> list) {
    playlist = list;
    notifyListeners();
  }

  add(String name) async {
    playlist.add(name);
    await prefList.setStringList("PlayList", playlist);
    notifyListeners();
  }
}
