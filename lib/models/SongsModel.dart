import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

enum PlayerState { PLAYING, PAUSED, STOPPED }

class SongsModel extends ChangeNotifier {
  var songs = <Song>[];
  var duplicate = <Song>[]; // Duplicate of songs variable
  var currentSong;
  var currentState;
  MusicFinder player = new MusicFinder();

  SongsModel() {
    fetchSongs();
  }

  fetchSongs() async {
    songs = await MusicFinder.allSongs();
    songs.forEach((item){
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
    }else{
      songs.clear();
      songs.addAll(duplicate);
      notifyListeners();
    }
  }

  play() {
    var song = currentSong;
    player.play(song.uri, isLocal: true);
    currentState = PlayerState.PLAYING;
  }

  pause() {
    player.pause();
    currentState = PlayerState.PAUSED;
  }

  next() {
    if (currentSong == songs.length) {
      currentSong = 0;
    } else {
      currentSong++;
    }
    notifyListeners();
  }

  previous() {
    if (currentSong == 0) {
      currentSong == songs.length;
    } else {
      currentSong--;
    }
    notifyListeners();
  }
}
