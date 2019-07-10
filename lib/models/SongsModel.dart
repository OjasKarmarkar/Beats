import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:beats/models/ProgressModel.dart';
import 'dart:math';

import 'package:pref_dessert/pref_dessert_internal.dart';

import 'Recently_played.dart';

enum PlayerState { PLAYING, PAUSED, STOPPED }

class SongsModel extends ChangeNotifier {
  var songs = <Song>[];
  var duplicate = <Song>[]; // Duplicate of songs variable for Search function
  Song currentSong;
  var currentState;
  MusicFinder player;
  ProgressModel prog;
  var position;
  bool shuffle = false;
  bool repeat = false;
  Random rnd = new Random();
  Recents recents;

  SongsModel(prov, rec) {
    fetchSongs();
    prog = prov;
    recents = rec;
  }

  fetchSongs() async {
    songs = await MusicFinder.allSongs();
    player = new MusicFinder();
    initValues();
    player.setPositionHandler((p) {
      prog.setPosition(p.inSeconds);
    });
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
          // TODO: add regex to optimize search using letters in the middle
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

  initValues() {
    player.setDurationHandler((d) {
      prog.setDuration(d.inSeconds);
    });

    player.setCompletionHandler(() {
      if (repeat) {
        random_Song();
      } else if (shuffle) {
        current_Song();
      } else
        next();
    });
  }

  seek(pos) {
    player.seek(pos);
  }

  play() {
    var song = currentSong;
    player.play(song.uri, isLocal: true);
    currentState = PlayerState.PLAYING;
    recents.add(song);
    notifyListeners();
  }

  pause() {
    player?.pause();
    currentState = PlayerState.PAUSED;
    notifyListeners();
  }

  next() {
    if (currentSong == songs[songs.length - 1]) {
      currentSong == songs[0];
    } else {
      currentSong = songs[songs.indexOf(currentSong) + 1];
    }
    notifyListeners();
  }

  previous() {
    if (currentSong == songs[0]) {
      currentSong == songs[songs.length - 1];
    } else {
      currentSong = songs[songs.indexOf(currentSong) - 1];
    }
    notifyListeners();
  }

  setRepeat(b){
    repeat = b;
    notifyListeners();
  }

  setShuffle(b){
    shuffle = b;
    notifyListeners();
  }

  current_Song() {
    player.stop();
    currentSong = songs[songs.indexOf(currentSong)];
    player.play(currentSong.uri);
    notifyListeners();
  }

  random_Song() {
    int max = songs.length;
    player.stop();
    currentSong = songs[rnd.nextInt(max)];
    player.play(currentSong.uri);
    notifyListeners();
  }
}
