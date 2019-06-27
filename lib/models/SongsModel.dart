import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

enum PlayerState{PLAYING,PAUSED,STOPPED}

class SongsModel extends ChangeNotifier{
  var songs = <Song>[];
  var currentSong;
  var currentState;
  MusicFinder player = new MusicFinder();

  SongsModel(){
    fetchSongs();
  }

  fetchSongs() async{
    songs = await MusicFinder.allSongs();
    notifyListeners();
  }

   play(model) {
    var song = model.songs[model.currentSong];
    player.play(song.uri, isLocal: true);
    model.currentState = PlayerState.PLAYING;
  }

  pause(model){
    player.pause();
    model.currentState = PlayerState.PAUSED;
  }

  next(){
    if(currentSong==songs.length){
      currentSong = 0;
    }else{
      currentSong++;
    }
    notifyListeners();
  }

  previous(){
    if(currentSong==0){
      currentSong==songs.length;
    }else{
      currentSong--;
    }
    notifyListeners();
  }
}