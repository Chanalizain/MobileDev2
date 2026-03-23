import '../../model/songs/song.dart';

class SongDto {
  static const String titleKey = 'title';
  static const String artistKey = 'artistId';
  static const String durationKey = 'duration'; // in ms
  static const String imageKey = 'imageUrl';

  static Song fromJson(String id, Map<String, dynamic> json) {
    assert(json[titleKey] is String);
    assert(json[artistKey] is String);
    assert(json[durationKey] is int);
    assert(json[imageKey] is String);

    return Song(
      id: id,
      title: json[titleKey],
      artistId: json[artistKey],
      duration: Duration(milliseconds: json[durationKey]),
      imageUrl: Uri.parse(json[imageKey])
    );
  }

  /// Convert Song to JSON
  Map<String, dynamic> toJson(Song song) {
    return {
      titleKey: song.title,
      artistKey: song.artistId,
      durationKey: song.duration.inMilliseconds,
      imageKey: song.imageUrl,
    };
  }
}
