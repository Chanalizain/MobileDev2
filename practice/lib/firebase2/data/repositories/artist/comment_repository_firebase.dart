import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practice/firebase2/model/artist/comment.dart';
import '../../dtos/comment_dto.dart';
import 'comment_repository.dart';

class CommentRepositoryFirebase extends CommentRepository {
  @override
  Future<List<Comment>> fetchComments(String artistId) async {
    final Uri url = Uri.https(
      'first-firebase-project-9c20d-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/comments/$artistId.json',
    );

    final response = await http.get(url);

    if (response.statusCode == 200 && response.body != 'null') {
      final Map<String, dynamic> data = json.decode(response.body);
      return data.entries
          .map((e) => CommentDto.fromJson(e.key, artistId, e.value))
          .toList();
    }
    return []; // Return empty list if no comments exist
  }

  @override
  Future<void> addComment(String artistId, String text) async {
    final Uri url = Uri.https(
      'first-firebase-project-9c20d-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/comments/$artistId.json',
    );

    final response = await http.post(
      url,
      body: json.encode(CommentDto.toJson(text)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to post comment');
    }
  }
}
