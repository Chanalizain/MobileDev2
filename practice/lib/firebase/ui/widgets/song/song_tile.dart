import 'package:flutter/material.dart';

import '../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final int totalSeconds = song.duration.inSeconds;

    final int minutes = totalSeconds ~/ 60;
    final int seconds = totalSeconds % 60;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(song.title),
          leading: CircleAvatar(backgroundImage: NetworkImage(song.imageUrl.toString()),),
          
          subtitle: Text(
            "$minutes:${seconds.toString().padLeft(2, '0')} mn  ${song.artist?.name ?? 'Unknown Artist'} - ${song.artist?.genre}",
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
