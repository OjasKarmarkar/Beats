import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:beats/models/ProgressModel.dart';
import 'dart:math';

import 'package:pref_dessert/pref_dessert_internal.dart';

import 'SongHelper.dart';

enum PlayerState { PLAYING, PAUSED, STOPPED }

class SongsModel extends ChangeNotifier {
  var songs = <Song>[];
  var duplicate = <Song>[]; // Duplicate of songs variable for Search function
  Song currentSong;
  var currentState;
  MusicFinder player;
  ProgressModel prog;
  var position;
  Random rnd = new Random();
  var lastPlayed = FuturePreferencesRepository<Song>(new SongHelper());

  SongsModel(prov) {
    fetchSongs();
    prog = prov;
  }

  fetchSongs() async {
    songs = await MusicFinder.allSongs();
    player = new MusicFinder();
    initValues();
    player.setPositionHandler((p) {
      prog.setPosition(p.inSeconds);
      position = p.toString();
      debugPrint(position);
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
    //lastPlayed.update(0 , currentSong);
    if(lastPlayed.findOne(0) != null){
      lastPlayed.save(currentSong);
    }
    else{
      lastPlayed.update(1, currentSong);
    }
    
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

  getPositon() {
    return position;
  }

  current_Song() {
    currentSong = songs[songs.indexOf(currentSong)];
    notifyListeners();
  }

  random_Song() {
    int max = songs.length;
    print(rnd.nextInt(max));
    currentSong = songs[rnd.nextInt(max)];
    notifyListeners();
  }
}
