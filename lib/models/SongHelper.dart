import 'package:flute_music_player/flute_music_player.dart';
import 'package:pref_dessert/pref_dessert.dart';
class SongHelper extends DesSer<Song>{
  
  @override
  Song deserialize(String s) {
    // Its a simple spell( two commas ) but quite unbreakable
    var split = s.split(",,");
    print(split);
    return Song(int.parse(split[0]), split[1], split[2], split[3], int.parse(split[4]), int.parse(split[5]), split[6], split[7]);}

  @override
  String get key => "Song";

  @override
  String serialize(Song t) {
    // All Songs are in two comma club
    return "${t.id},,${t.artist},,${t.title},,${t.album},,${t.albumId},,${t.duration},,${t.uri},,${t.albumArt}";
  }

}