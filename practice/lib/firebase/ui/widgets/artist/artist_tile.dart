import 'package:flutter/material.dart';
import '../../../model/artists/artist.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({super.key, required this.artist, this.onTap});

  final Artist artist;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(artist.imagerUrl.toString()),
          ),
          title: Text(
            artist.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(artist.genre),
        ),
      ),
    );
  }
}
