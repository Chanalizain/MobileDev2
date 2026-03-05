import 'package:practice/app_settings/data/repositories/songs/user_history_repository.dart';

class UserHistoryMock implements UserHistoryRepository {
  final List<String> _recommendedSongIds = ['102', '101',];

  @override
  List<String> fetchRecommendedSongIds() {
    return _recommendedSongIds;
  }
}
