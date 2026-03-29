import '../data/repositories/songs/song_repository_mock.dart';
import '../data/repositories/songs/song_repository.dart';
import '../model/songs/song.dart';

void main() async {
  //   Instantiate the  song_repository_mock
  SongRepository songRepository = SongRepositoryMock();

  // Test both the success and the failure of the post request
  Song? song = await songRepository.fetchSongById("s1");
  print("Song received ${song!.title}");

  try {
    Song? song = await songRepository.fetchSongById("s9");
    print("Song received ${song!.title}");

  } catch (e) {
    print(e);
  }

  // Handle the Future using 2 ways  (2 tests)
  // - Using then() with .catchError().
  // - Using async/await with try/catch.
}
