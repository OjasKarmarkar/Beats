import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/widgets.dart';
import 'package:pref_dessert/pref_dessert.dart';
import 'RecentsHelper.dart';

class Recents extends ChangeNotifier{

  FuturePreferencesRepository<Song> last_played;
  var recently;

  Recents(){
    last_played = FuturePreferencesRepository<Song>(RecentsHelper());
    fetch_Last();
  }

  add(Song song){
    if (!alreadyExists(song)){
      if (recently.length > 1) last_played.remove(0);
      last_played.save(song);
      fetch_Last();
    }
  }

  alreadyExists(s){
    var list = <Song>[];
    list.forEach((item){
      if (s.uri==item.uri) return true;
    });
    return false;
  }

  fetch_Last() async {
    recently = await last_played.findAll();
    notifyListeners();
  }

}