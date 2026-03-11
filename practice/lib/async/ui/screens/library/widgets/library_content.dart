import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),
    
          Expanded(child: _buildBody(mv)),
        ],
      ),
    );
  }
  Widget _buildBody(LibraryViewModel mv) {
    // Use .when to handle the 3 states of AsyncValue [cite: 25, 26]
    return mv.songs.when(
      // 1. Handle Loading State
      loading: () => const Center(
        child: CircularProgressIndicator(), // [cite: 27]
      ),

      // 2. Handle Error State
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error: $err", textAlign: TextAlign.center), // [cite: 23, 26]
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => mv.fetchSongs(), // Retry logic
              child: const Text("Retry"),
            ),
          ],
        ),
      ),

      // 3. Handle Success State
      data: (songsList) => ListView.builder(
        itemCount: songsList.length,
        itemBuilder: (context, index) {
          final song = songsList[index];
          return SongTile(
            song: song,
            isPlaying: mv.isSongPlaying(song),
            onTap: () => mv.start(song),
          );
        },
      ),
    );
  }
}
