import 'package:flutter/widgets.dart';
import 'PlayListHelper.dart';

class PlayList_Model extends ChangeNotifier{

  PlaylistHelper db;
  var prefs;
  var lists;

  PlayList_Model(){
    fetchLast();
  }

  add(List list){
    //playlists_repo.save(list);
      fetchLast();
  }

  remove(List list){
    
  }

  fetchLast() async {
    //lists = await playlists_repo.findAll();
    notifyListeners();
  }

}
