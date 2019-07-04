import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:beats/models/ProgressModel.dart';

enum PlayerState { PLAYING, PAUSED, STOPPED }

class SongsModel extends ChangeNotifier {
  var songs = <Song>[];
  var duplicate = <Song>[]; // Duplicate of songs variable for Search function
  var currentSong;
  var currentState;
  MusicFinder player;
  ProgressModel prog;
  List bookmarks = <Song>[];

  SongsModel(prov){
    fetchSongs();
    prog = prov;
  }

  fetchSongs() async {
    songs = await MusicFinder.allSongs();
    player = new MusicFinder();
    initValues();
    songs.forEach((item) {
      duplicate.add(item);
    });
    notifyListeners();
  }

  filterResults(String value) {
    if (value.isNotEmpty) {
      String low = value.toLowerCase();
      List<Song> dummy = <Song>[];
      duplicate.forEach((item) {
        if (item.title.toLowerCase().startsWith(low)) {
          dummy.add(item);
        }
      });
      songs.clear();
      songs.addAll(dummy);
      notifyListeners();
    } else {
      songs.clear();
      songs.addAll(duplicate);
      notifyListeners();
    }
  }

  initValues(){
    player.setDurationHandler((d){
      prog.setDuration(d.inSeconds);
    });
    player.setPositionHandler((p){
      prog.setPosition(p.inSeconds);
    });
    player.setCompletionHandler((){
      next();
    });
  }

  seek(pos){
    player.seek(pos);
  }

  play() {
    var song = currentSong;
    player.play(song.uri, isLocal: true);
    currentState = PlayerState.PLAYING;
    notifyListeners();
  }

  pause() {
    player?.pause();
    currentState = PlayerState.PAUSED;
    notifyListeners();
  }

  next() {
    if (currentSong == songs[songs.length-1]) {
      currentSong == songs[0];
    } else {
      currentSong = songs[songs.indexOf(currentSong) + 1];
    }
    notifyListeners();
  }

  previous() {
    if (currentSong == songs[0]) {
      currentSong == songs[songs.length-1];
    } else {
      currentSong = songs[songs.indexOf(currentSong) - 1];
    }
    notifyListeners();
  }
}
