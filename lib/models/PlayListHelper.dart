import 'package:flute_music_player/flute_music_player.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
class PlaylistHelper {

  String tableName;
  Database _database;

  PlaylistHelper(String playlist){
    tableName = playlist;
  }

  Future<Database> get database async {
    if (_database != null)
    return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  initDB() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "playlist.db";
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $tableName ("
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
  deletePlaylist() async{
    final db = await database;
    await db.rawDelete("drop $tableName");
  }
  deleteSong(Song s) async {
    final db = await database;
    await db.rawDelete("delete from $tableName where uri = ${s.uri}");
    //await db.rawDelete("delete from $tableName where rowid = (select max(rowid) from $tableName)");
  }
  add(Song s) async {
    final db = await database;
    var res = await db.insert(tableName, toMap(s));
    return res;
  }
  getSongs() async {
    final db = await database;
    var res = await db.query(tableName);
    List<Song> list =
        res.isNotEmpty ? res.map((c) => Song.fromMap(c)).toList() : [];
    return list;
  }
  toMap(Song s){
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
