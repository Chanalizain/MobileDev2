import 'package:practice/firebase/model/artists/artist.dart';

class Song {
  final String id;
  final String title;
  final String artistId;
  final Duration duration;
  final Uri imageUrl;
  Artist? artist;

  Song({
    required this.id,
    required this.title,
    required this.artistId,
    required this.duration,
    required this.imageUrl,
    this.artist
  });

  @override
  String toString() {
    return 'Song(id: $id, title: $title, artist: $artistId, duration: $duration, imagerUrl: $imageUrl)';
  }
}
