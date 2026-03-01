import 'package:flutter/widgets.dart';

import '../../model/settings/app_settings.dart';
import '../../../app_settings/data/repositories/app_settings_repository.dart';

class AppSettingsState extends ChangeNotifier {
  final AppSettingsRepository _repository;
  AppSettings? _appSettings;

  AppSettingsState(this._repository);

  Future<void> init() async {
    // Might be used to load data from repository
    _appSettings = await _repository.load();
    notifyListeners();
  }

  ThemeColor get theme => _appSettings?.themeColor ?? ThemeColor.blue;

  Future<void> changeTheme(ThemeColor themeColor) async {

    final current = _appSettings ?? AppSettings(themeColor: ThemeColor.blue);

    // Update the local state
    _appSettings = current.copyWith(themeColor: themeColor);

    await _repository.save(_appSettings!);

    notifyListeners();
  }
}
