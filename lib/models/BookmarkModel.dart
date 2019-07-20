import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/widgets.dart';
import 'BookmarkHelper.dart';

class BookmarkModel extends ChangeNotifier {
  BookmarkHelper db;
  List<Song> bookmarks = List<Song>();

  BookmarkModel() {
    db = BookmarkHelper();
    fetchBookmarks();
  }

  add(Song song) async {
    if (!alreadyExists(song)) {
      await db.add(song);
      fetchBookmarks();
    }
  }

  remove(Song song) async{
    await db.remove(song);
    fetchBookmarks();
  }

  alreadyExists(s) {
    for(Song item in bookmarks){
      if (s.uri==item.uri) return true;
    }
    return false;
  }

  fetchBookmarks() async {
    bookmarks = await db.getBookmarks();
    notifyListeners();
  }

}
