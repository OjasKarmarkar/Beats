import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:beats/models/ProgressModel.dart';
import 'dart:math';
import 'package:media_notification/media_notification.dart';
import 'RecentsModel.dart';

enum PlayerState { PLAYING, PAUSED, STOPPED }

class SongsModel extends ChangeNotifier {

  @override
  void dispose() {
    // TODO: implement dispose
    MediaNotification.hide();
    notifyListeners();
    super.dispose();
  }

  // Thousands of stuff packed into this ChangeNotifier
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
  static bool isTapped = false;

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
    MediaNotification.setListener('pause', () {
      pause();
    });
    MediaNotification.setListener('play', () {
      play();
    });
    MediaNotification.setListener('next', () {
      player.stop();
      next();
      play();
    });
    MediaNotification.setListener('prev', () {
      player.stop();
      previous();
      play();
    });
    notifyListeners();
  }

  updateUI() {
    MediaNotification.show(
        title: currentSong?.title,
        author: currentSong?.artist,
        play: currentState == PlayerState.PLAYING,
        art: currentSong.albumArt ?? "");
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
        random_Song();
      } else
        next();
    });
  }

  seek(pos) {
    player.seek(pos);
  }

  play() {
    isTapped = true;
    var song = currentSong;
    player.play(song.uri, isLocal: true);
    currentState = PlayerState.PLAYING;
    recents.add(song);
    updateUI();
  }

  pause() {
    player?.pause();
    currentState = PlayerState.PAUSED;
    updateUI();
  }

  next() {
    if (currentSong == songs[songs.length - 1]) {
      currentSong == songs[0];
    } else {
      currentSong = songs[songs.indexOf(currentSong) + 1];
    }
    updateUI();
  }

  previous() {
    if (currentSong == songs[0]) {
      currentSong == songs[songs.length - 1];
    } else {
      currentSong = songs[songs.indexOf(currentSong) - 1];
    }
    updateUI();
  }

  setRepeat(b) {
    repeat = b;
    notifyListeners();
  }

  setShuffle(b) {
    shuffle = b;
    notifyListeners();
  }

  current_Song() {
    player.stop();
    currentSong = songs[songs.indexOf(currentSong)];
    player.play(currentSong.uri);
    updateUI();
  }

  random_Song() {
    int max = songs.length;
    player.stop();
    currentSong = songs[rnd.nextInt(max)];
    player.play(currentSong.uri);
    updateUI();
  }

  bool tapped() {
    return isTapped;
  }
}
