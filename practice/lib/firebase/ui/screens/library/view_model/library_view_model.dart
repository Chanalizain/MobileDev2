import 'package:flutter/material.dart';
import 'package:practice/firebase/data/repositories/artists/artist_repository.dart';
import 'package:practice/firebase/model/artists/artist.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<Song>> songsValue = AsyncValue.loading();

  LibraryViewModel({required this.songRepository, required this.artistRepository, required this.playerState}) {
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
    fetchSongsWithArtists();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Song> songs = await songRepository.fetchSongs();
      songsValue = AsyncValue.success(songs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  Future<void> fetchSongsWithArtists() async {
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // Fetch both in parallel 
      final results = await Future.wait([
        songRepository.fetchSongs(),
        artistRepository.fetchArtists(),
      ]);

      List<Song> songs = results[0] as List<Song>;
      List<Artist> artists = results[1] as List<Artist>;

      for (var song in songs) {
        song.artist = artists.firstWhere(
          (a) => a.id == song.artistId,
          orElse: () => Artist(
            id: '0',
            name: 'Unknown',
            genre: 'N/A',
            imagerUrl: Uri.parse(''),
          ),
        );
      }

      songsValue = AsyncValue.success(songs);
    } catch (e) {
      songsValue = AsyncValue.error(e);
    } finally {
      notifyListeners();
    }
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
