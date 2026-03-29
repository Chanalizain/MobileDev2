import 'package:practice/firebase2/model/artist/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> fetchComments(String artistId);
  Future<void> addComment(String artistId, String text);
}
