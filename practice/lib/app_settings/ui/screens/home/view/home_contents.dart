import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/songs/song.dart';
import '../../../states/settings_state.dart';
import '../../../theme/theme.dart';
import '../view_model/home_view_model.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    AppSettingsState settingsState = context.read<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text("Home", style: AppTextStyles.heading),

          const SizedBox(height: 30),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Recently Played'),
                  // isPlayable = true
                  _buildSongList(viewModel.recentSongs, viewModel, true),

                  const Divider(color: Colors.white24),

                  _buildSectionTitle('Recommended for You'),
                  // isPlayable = false
                  _buildSongList(viewModel.recommendedSongs, viewModel, false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSongList(
    List<Song> songs,
    HomeViewModel viewModel,
    bool isPlayable,
  ) {
    if (songs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("No songs found.", style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        final isPlaying = viewModel.isCurrentSong(song);

        return ListTile(
          title: Text(song.title),
          subtitle: Text(
            song.artist,
            style: const TextStyle(color: Colors.grey),
          ),
          // Only show icon if it is playable
          trailing: isPlayable
              ? Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                )
              : null,
          // Disable tap if not playable
          onTap: isPlayable ? () => viewModel.togglePlay(song) : null,
        );
      },
    );
  }
}
