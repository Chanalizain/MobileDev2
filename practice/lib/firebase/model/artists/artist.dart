class Artist {
  final String id;
  final String name;
  final String genre;
  final Uri imagerUrl;

  Artist({
    required this.id, 
    required this.name,
    required this.genre,
    required this.imagerUrl
  });

  @override
  String toString() {
    return 'Artist(id: $id, name: $name, genre: $genre, imagerUrl: $imagerUrl)';
  }
}
