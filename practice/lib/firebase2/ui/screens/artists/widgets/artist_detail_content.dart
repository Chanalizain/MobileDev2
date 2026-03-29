// lib/ui/screens/artist_detail/artist_detail_content.dart
import 'package:flutter/material.dart';
import 'package:practice/firebase2/model/artist/artist.dart';
import 'package:practice/firebase2/model/songs/song.dart';
import 'package:practice/firebase2/ui/screens/artists/view_model/artist_detail_view_model.dart';
import 'package:practice/firebase2/ui/screens/artists/widgets/comment_tile.dart';
import 'package:practice/firebase2/ui/screens/library/view_model/library_item_data.dart';
import 'package:practice/firebase2/ui/screens/library/widgets/library_item_tile.dart';
import '../../../utils/async_value.dart';

class ArtistDetailContent extends StatelessWidget {
  final ArtistDetailViewModel mv;
  final Artist artist;

  const ArtistDetailContent({
    super.key,
    required this.mv,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    Widget songsContent;

    switch (mv.artistSongs.state) {
      case AsyncValueState.loading:
        songsContent = const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
        break;
      case AsyncValueState.error:
        songsContent = SliverToBoxAdapter(
          child: Center(child: Text('Error: ${mv.artistSongs.error}')),
        );
        break;
      case AsyncValueState.success:
        final List<Song> songs = mv.artistSongs.data!;
        songsContent = SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final song = songs[index];

            // Convert Song to LibraryItemData for the Tile
            final itemData = LibraryItemData(song: song, artist: artist);

            return LibraryItemTile(
              data: itemData,
              isPlaying: false,
              onTap: () => print("Playing ${song.title}"),
              onLike: () => mv.likeSong(itemData),
            );
          }, childCount: songs.length),
        );
        break;
    }

    Widget commentsContent;
    switch (mv.comments.state) {
      case AsyncValueState.loading:
        commentsContent = const SliverToBoxAdapter(child: SizedBox());
        break;
      case AsyncValueState.error:
        commentsContent = const SliverToBoxAdapter(
          child: Text("Error loading comments"),
        );
        break;
      case AsyncValueState.success:
        final comments = mv.comments.data!;
        commentsContent = comments.isEmpty
            ? const SliverToBoxAdapter(child: Text("Be the first to comment!"))
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => CommentTile(comment: comments[index]),
                  childCount: comments.length,
                ),
              );
        break;
    }

    return CustomScrollView(
      slivers: [
        // 1. Header (Name/Image)
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(artist.imageUrl.toString()),
              ),
              const SizedBox(height: 10),
              Text(
                artist.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
            ],
          ),
        ),
        // 2. Songs Section
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Songs",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        songsContent,
        // 3. Comments Section
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Comments",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        commentsContent,
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}
