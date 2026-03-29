import 'package:flutter/material.dart';
import '../../model/songs/song.dart';

class PlayerState extends ChangeNotifier {
  Song? _currentSong;

  Song? get currentSong => _currentSong;

  void play(Song song) {
    _currentSong = song;
    notifyListeners();
  }

  void stop() {
    _currentSong = null;
    notifyListeners();
  }
}
