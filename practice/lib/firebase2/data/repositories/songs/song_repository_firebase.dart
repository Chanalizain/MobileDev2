import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {

  List<Song>? _cachedSongs;

  final Uri songsUri = Uri.https(
    'first-firebase-project-9c20d-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );

  @override
  Future<List<Song>> fetchSongs({bool forceFetch = true}) async {
    if (_cachedSongs != null && !forceFetch) {
      print("Returning from MEMORY CACHE");
      return _cachedSongs!;
    }

    print("CALLING FIREBASE API...");
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {

      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      _cachedSongs = result;
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<void> updateLikes(String songId, int newLikesCount) async {
    final Uri songUrl = Uri.https(
      'first-firebase-project-9c20d-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/songs/$songId.json', 
    );

    final response = await http.patch(
      songUrl,
      body: json.encode({
        SongDto.likesKey: newLikesCount, // Use the key from DTO
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update likes for song $songId');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
