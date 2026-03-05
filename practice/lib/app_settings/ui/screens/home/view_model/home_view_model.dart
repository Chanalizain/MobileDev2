import 'package:flutter/material.dart';
import '../../../states/player_state.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../data/repositories/songs/user_history_repository.dart';
import '../../../../model/songs/song.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository songRepo;
  final UserHistoryRepository historyRepo;
  final PlayerState playerState;

  List<Song> recentSongs = [];
  List<Song> recommendedSongs = [];
  bool isLoading = false;

  HomeViewModel({
    required this.songRepo,
    required this.historyRepo,
    required this.playerState,
  }) {
    playerState.addListener(notifyListeners);
    _loadHomeData();
  }

  void _loadHomeData() {
    isLoading = true;
    notifyListeners();
    try {
      final List<String> recentIds = historyRepo.fetchRecommendedSongIds();
      recentSongs = recentIds
          .map((id) => songRepo.fetchSongById(id))
          .whereType<Song>()
          .toList();

      recommendedSongs = songRepo.fetchSongs();
    } catch (e) {
      debugPrint("Error loading home data: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // MOVED OUTSIDE _loadHomeData
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
    playerState.removeListener(notifyListeners); 
    super.dispose();
  }
}