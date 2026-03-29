import 'package:flutter/material.dart';
import 'package:practice/firebase2/data/repositories/artist/comment_repository.dart';
import 'package:practice/firebase2/model/artist/comment.dart';
import 'package:practice/firebase2/model/songs/song.dart';
import 'package:practice/firebase2/ui/screens/library/view_model/library_item_data.dart';
import '../../../utils/async_value.dart';
import 'package:practice/firebase2/data/repositories/songs/song_repository.dart';

class ArtistDetailViewModel extends ChangeNotifier {
  final String artistId;
  final SongRepository songRepository;
  final CommentRepository commentRepository;

  AsyncValue<List<Song>> artistSongs = AsyncValue.loading();
  AsyncValue<List<Comment>> comments = AsyncValue.loading();

  ArtistDetailViewModel({
    required this.artistId,
    required this.songRepository,
    required this.commentRepository,
  }) {
    fetchData();
  }

  Future<void> fetchData() async {
    artistSongs = AsyncValue.loading();
    comments = AsyncValue.loading();
    notifyListeners();

    try {
      final List<Song> allSongs = await songRepository.fetchSongs();

      final List<Song> filteredSongs = allSongs
          .where((song) => song.artistId == artistId)
          .toList();

      artistSongs = AsyncValue.success(filteredSongs);

      final List<Comment> fetchedComments = await commentRepository
          .fetchComments(artistId);
      comments = AsyncValue.success(fetchedComments);
    } catch (e) {
      artistSongs = AsyncValue.error(e);
      comments = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void likeSong(LibraryItemData item) {
    songRepository.updateLikes(item.song.id, item.song.likes);

    fetchData();
  }

  Future<void> sendComment(String text) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty) return;

    try {
      await commentRepository.addComment(artistId, cleanText);
      await fetchData();
    } catch (e) {
      debugPrint("Error sending comment: $e");
    }
  }
}
