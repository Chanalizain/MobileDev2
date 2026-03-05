import 'package:flutter/material.dart';
import 'package:practice/app_settings/data/repositories/songs/song_repository_mock.dart';
import 'package:practice/app_settings/data/repositories/songs/user_history_mock.dart';
import '.../../../../states/player_state.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/songs/song_repository.dart';
import '../../../data/repositories/songs/user_history_repository.dart';
import './view_model/home_view_model.dart';
import './view/home_contents.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserHistoryRepository>(create: (_) => UserHistoryMock()),

        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(
            // Use read for all dependencies inside create
            songRepo: context.read<SongRepository>(),
            historyRepo: context.read<UserHistoryRepository>(),
            playerState: context.read<PlayerState>(),
          ),
        ),
      ],
      child: const HomeContent(),
    );
  }
}
