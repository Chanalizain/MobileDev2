import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  static final baseUri = Uri.https(
    "first-firebase-project-9c20d-default-rtdb.asia-southeast1.firebasedatabase.app",
    "artists.json",
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(baseUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> artistJson = json.decode(response.body);

      List<Artist> artists = [];
      artistJson.forEach((key, value) {
        artists.add(ArtistDto.fromJson(key, value));
      });

      return artists;
    } else {
      throw Exception('Failed to load artists');
    }
  }
}
