// lib/ui/screens/artist_detail/artist_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:practice/firebase2/data/repositories/artist/comment_repository.dart';
import 'package:practice/firebase2/ui/screens/artists/view_model/artist_detail_view_model.dart';
import 'package:practice/firebase2/ui/screens/artists/widgets/artist_detail_content.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/songs/song_repository.dart';
import '../../../model/artist/artist.dart';
import 'widgets/comment_input.dart';

class ArtistDetailScreen extends StatelessWidget {
  final Artist artist;

  const ArtistDetailScreen({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArtistDetailViewModel(
        artistId: artist.id,
        songRepository: context.read<SongRepository>(),
        commentRepository: context.read<CommentRepository>(),
      ),
      child: Consumer<ArtistDetailViewModel>(
        builder: (context, mv, child) {
          return Scaffold(
            // resizeToAvoidBottomInset: true ensures the keyboard pushes the input up
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text(artist.name),
              elevation: 0,
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ArtistDetailContent(mv: mv, artist: artist),
                ),

                SafeArea(
                  child: CommentInput(onSend: (text) => mv.sendComment(text)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
