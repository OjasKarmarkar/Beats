import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/widgets.dart';
import 'package:pref_dessert/pref_dessert.dart';
import 'SongHelper.dart';

class Recents extends ChangeNotifier{

  FuturePreferencesRepository<Song> last_played;
  var recently;

  PlayedModel(){
    last_played = FuturePreferencesRepository<Song>(SongHelper());
    fetch_Last();
  }

   add(Song song){
    last_played.save(song);
    fetch_Last();
  }

fetch_Last() async {
    recently = await last_played.findAll();
    notifyListeners();
  }

}