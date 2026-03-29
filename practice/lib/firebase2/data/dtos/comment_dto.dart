import 'package:practice/firebase2/model/artist/comment.dart';

class CommentDto {
  static Comment fromJson(
    String id,
    String artistId,
    Map<String, dynamic> json,
  ) {
    return Comment(
      id: id,
      artistId: artistId,
      text: json['text'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  static Map<String, dynamic> toJson(String text) {
    return {'text': text, 'createdAt': DateTime.now().toIso8601String()};
  }
}
