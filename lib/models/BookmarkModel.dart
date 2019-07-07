import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/widgets.dart';
import 'package:pref_dessert/pref_dessert.dart';
import 'SongHelper.dart';

class BookmarkModel extends ChangeNotifier{

  FuturePreferencesRepository<Song> repo;
  var bookmarkList;

  BookmarkModel(){
    repo = FuturePreferencesRepository<Song>(SongHelper());
    fetchBookmarks();
  }

  add(Song song){
    repo.save(song);
    fetchBookmarks();
  }

  remove(Song song){
    repo.removeWhere((s)=>s.uri==song.uri);
    fetchBookmarks();
  }

  fetchBookmarks() async {
    bookmarkList = await repo.findAll();
    notifyListeners();
  }

  contains(Song s){
    for(Song song in bookmarkList){
      if(song.uri == s.uri){
        return true;
      }
    };
    return false;
  }

}