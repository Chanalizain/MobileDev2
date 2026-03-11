 
import 'package:practice/async/data/repositories/songs/song_repository_mock.dart';

void main() async {
  //   Instantiate the  song_repository_mock
  final songRepo = SongRepositoryMock();
 
  // Test both the success and the failure of the post request
 
  // Handle the Future using 2 ways  (2 tests)
  // - Using then() with .catchError().
  // - Using async/await with try/catch.

  // Test 1: Using async/await with try/catch 
  print('\nTest 1 (Async/Await): Fetching songs...');
  try {
    final songs = await songRepo.fetchSongs(); // Triggers 3s delay 
    print('Success! Fetched ${songs.length} songs.'); 
  } catch (e) {
    print('Caught expected error: $e'); 
  }

  // Test 2: Using then() with .catchError() 
  print('\nTest 2 (Then/CatchError): Fetching songs again...');
  // Since this is the 2nd try, the mock should throw an exception 
  songRepo.fetchSongs().then((songs) {
    print('Success! Fetched ${songs.length} songs.'); 
  }).catchError((error) {
    print('Caught expected error via .catchError(): $error'); 
  });
}
