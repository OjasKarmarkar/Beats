import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BookmarkHelper.dart';
import 'PlayListHelper.dart';

class PlayList_Model extends ChangeNotifier{

  PlaylistHelper db;
  var prefs;
  var lists;

  PlayList_Model(){
    fetch_Last();
  }

  add(List list){
    //playlists_repo.save(list);
      fetch_Last();
  }

  remove(List list){
    
  }

  fetch_Last() async {
    //lists = await playlists_repo.findAll();
    notifyListeners();
  }

}
