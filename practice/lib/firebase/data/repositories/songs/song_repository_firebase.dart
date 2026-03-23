import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  static final baseUri = Uri.http(
    "first-firebase-project-9c20d-default-rtdb.asia-southeast1.firebasedatabase.app",
  );

  static final songsUri = baseUri.replace(path: '/songs.json');
  static final artistsUri = baseUri.replace(path: '/artists.json');

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      final Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> songs = [];
      songJson.forEach((key, value) {
        songs.add(SongDto.fromJson(key, value));
      });

      return songs;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
