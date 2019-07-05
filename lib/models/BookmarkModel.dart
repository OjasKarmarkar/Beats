import 'package:flute_music_player/flute_music_player.dart';
import 'package:pref_dessert/pref_dessert.dart';
import 'SongHelper.dart';

class BookmarkModel{
  add(Song song){
    var repo = FuturePreferencesRepository<Song>(SongHelper());
    repo.save(song);
  }
  getAll() async {
    var repo = FuturePreferencesRepository<Song>(SongHelper());
    return repo.findAll();
  }
}