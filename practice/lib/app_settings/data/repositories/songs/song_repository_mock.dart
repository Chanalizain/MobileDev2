// song_repository_mock.dart

import 'package:practice/app_settings/model/settings/app_settings.dart';

import '../../../model/songs/song.dart';
import '../app_settings_repository.dart';
import 'song_repository.dart';

class SongRepositoryMock implements SongRepository, AppSettingsRepository {

  AppSettings _mockSettings = AppSettings(themeColor: ThemeColor.blue);
  
  final List<Song> _songs = [
    Song(
      id: '101',
      title: 'Mock Song 1',
      artist: 'Mock Artist',
      duration: const Duration(minutes: 2, seconds: 50),
    ),
    Song(
      id: '102',
      title: 'Mock Song 2',
      artist: 'Mock Artist',
      duration: const Duration(minutes: 3, seconds: 20),
    ),
  ];

  @override
  List<Song> fetchSongs() {
    return _songs;
  }

  @override
  Song? fetchSongById(String id) {
    try {
      return _songs.firstWhere((song) => song.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<AppSettings> load() async {
    return _mockSettings;
  }

  @override
  Future<void> save(AppSettings settings) async {
    _mockSettings = settings;
  }
}
