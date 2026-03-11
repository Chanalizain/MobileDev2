import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  // Use AsyncValue to wrap your list of songs
  AsyncValue<List<Song>> _songs = const AsyncValue.loading();

  AsyncValue<List<Song>> get songs => _songs;

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    await fetchSongs();
  }

  Future<void> fetchSongs() async {
    _songs = const AsyncValue.loading();
    notifyListeners();

    try {
      final songs = await songRepository.fetchSongs();
      _songs = AsyncValue.data(songs);
    } catch (error, stackTrace) {
      // Catching the simulated error from the repo 
      _songs = AsyncValue.error(error, stackTrace);
    }

    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
