import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/widgets.dart';
import 'package:pref_dessert/pref_dessert.dart';
import 'BookmarkHelper.dart';
import 'PlayListHelper.dart';

class PlayList_Model extends ChangeNotifier{

  FuturePreferencesRepository<List> playlists_repo;
  var lists;

  PlayList_Model(){
    playlists_repo = FuturePreferencesRepository<List>(PlayListsHelper());
    fetch_Last();
  }

  add(List list){
    playlists_repo.save(list);
      fetch_Last();
  }

  remove(List list){
    
  }

   fetch_Last() async {
    lists = await playlists_repo.findAll();
    notifyListeners();
  }

}