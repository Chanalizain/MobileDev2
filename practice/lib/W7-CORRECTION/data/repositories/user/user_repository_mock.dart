import 'package:x_code/spotify/part_7_home_view_model/model/user/user.dart';

import 'user_repository.dart';

class UserRepositoryMock extends UserRepository {
  User _user = User(name: "Ronan", favoriteSongs: ["s1", "s5"]);

  @override
  Future<User> getUser() async {
    return _user;
  }

  @override
  Future<User> updateUser({String? name, List<String>? favoriteSongs}) async {
    _user = _user.copyWith(name: name, favoriteSongs: favoriteSongs);
    return _user;
  }
}
