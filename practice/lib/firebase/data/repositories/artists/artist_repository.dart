import 'package:practice/firebase/model/artists/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists();
}
