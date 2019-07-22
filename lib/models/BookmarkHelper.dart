import 'package:flute_music_player/flute_music_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class BookmarkHelper {
  static Database _database;
  String table = "bookmarks";

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "bookmarks.db";
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $table ("
          "id INTEGER,"
          "artist TEXT,"
          "title TEXT,"
          "album TEXT,"
          "albumId INTEGER,"
          "duration INTEGER,"
          "uri TEXT,"
          "albumArt TEXT"
          ")");
    });
  }

  remove(Song s) async {
    final db = await database;
    await db.rawDelete("delete from $table where id = ${s.id}");
    //await db.rawDelete("delete from $table where rowid = (select max(rowid) from $table)");
  }

  add(Song s) async {
    final db = await database;
    var res = await db.insert(table, toMap(s));
    return res;
  }

  getBookmarks() async {
    final db = await database;
    var res = await db.query(table);
    List<Song> list =
        res.isNotEmpty ? res.map((c) => Song.fromMap(c)).toList() : List<Song>();
    return list;
  }

  toMap(Song s) {
    return {
      'id': s.id,
      'artist': s.artist,
      'title': s.title,
      'album': s.album,
      'albumId': s.albumId,
      'duration': s.duration,
      'uri': s.uri,
      'albumArt': s.albumArt
    };
  }
}
