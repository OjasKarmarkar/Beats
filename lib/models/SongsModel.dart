import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

enum PlayerState{PLAYING,PAUSED,STOPPED}

class SongsModel extends ChangeNotifier{
  var songs = <Song>[];
  var currentSong;
  var currentState;

  fetchSongs() async{
    songs = await MusicFinder.allSongs();
    notifyListeners();
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