import 'package:flutter/material.dart';
import 'package:practice/firebase2/ui/screens/artists/artist_detail_screen.dart';
import '../../../model/artist/artist.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({
    super.key,
    required this.artist,
    
  });

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: () {
            // This is the magic line that connects the screens!
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArtistDetailScreen(artist: artist),
              ),
            );
          },
          title: Text(artist.name),
          subtitle: Text("Genre: ${artist.genre}"),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(artist.imageUrl.toString()),
          ),
        ),
      ),
    );
  }
}
