import 'package:beats/models/RecentsHelper.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/widgets.dart';


class Recents extends ChangeNotifier{

  RecentsHelper db;
  List<Song> recently = List<Song>();

  Recents(){
    db = RecentsHelper();
    fetchRecents();
  }

  add(Song song)async {
    if (!alreadyExists(song)){
      if (recently.length > 1) await db.deleteLast();
      await db.add(song);
      fetchRecents();
    }
  }

  alreadyExists(s){
    for(Song item in recently){
      if (s.uri==item.uri) return true;
    }
    return false;
  }

  fetchRecents() async {
    recently = await db.getRecents();
    notifyListeners();
  }

}