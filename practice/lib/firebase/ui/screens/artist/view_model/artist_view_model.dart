import 'package:flutter/material.dart';
import 'package:practice/firebase/data/repositories/artists/artist_repository.dart';
import 'package:practice/firebase/model/artists/artist.dart';
import '../../../utils/async_value.dart';

class ArtistsViewModel extends ChangeNotifier {
  final ArtistRepository repository;

  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();

  ArtistsViewModel({required this.repository}) {
    _init();
  }

  void _init() async {
    fetchArtists();
  }

  Future<void> fetchArtists() async {
    artistsValue = AsyncValue.loading();
    notifyListeners();

    try {
      final List<Artist> artists = await repository.fetchArtists();
      artistsValue = AsyncValue.success(artists);
    } catch (e) {
      artistsValue = AsyncValue.error(e);
    } finally {
      notifyListeners();
    }
  }
}
