import 'package:flutter/material.dart';
import 'package:practice/firebase/data/repositories/artists/artist_repository.dart';
import 'package:practice/firebase/ui/screens/artist/view_model/artist_view_model.dart';
import 'package:practice/firebase/ui/screens/artist/widget/artist_content.dart';
import 'package:provider/provider.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ArtistsViewModel(repository: context.read<ArtistRepository>()),
      child: const ArtistContent(),
    );
  }
}
