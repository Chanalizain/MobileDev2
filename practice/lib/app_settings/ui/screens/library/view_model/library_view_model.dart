import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState; 
  List<Song> _songs = [];

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    _songs = songRepository.fetchSongs();

    playerState.addListener(notifyListeners);
  }

  List<Song> get songs => _songs;

  bool isCurrentSong(Song song) => playerState.currentSong?.id == song.id;

  void togglePlay(Song song) {
    if (isCurrentSong(song)) {
      playerState.stop();
    } else {
      playerState.start(song);
    }
  }

  @override
  void dispose() {
    // Clean up the listener when the screen is closed
    playerState.removeListener(notifyListeners);
    super.dispose();
  }
}
