import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/widgets.dart';
import 'package:pref_dessert/pref_dessert.dart';
import 'BookmarkHelper.dart';

class Recents extends ChangeNotifier{

  FuturePreferencesRepository<Song> last_played;
  var recently;

  Recents(){
    last_played = FuturePreferencesRepository<Song>(BookmarkHelper());
    fetch_Last();
  }

  add(Song song){
    if (recently.length >= 1) last_played.remove(1);
    last_played.save(song);
    fetch_Last();
  }

  fetch_Last() async {
    recently = await last_played.findAll();
    notifyListeners();
  }

}