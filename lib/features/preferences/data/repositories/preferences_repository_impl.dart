import 'package:frontend_flutter_aulasegura/features/preferences/data/datasources/preferences_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/preferences/domain/entities/preferences.dart';
import 'package:frontend_flutter_aulasegura/features/preferences/domain/repositories/preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final PreferencesLocalDataSource localDataSource;
  PreferencesRepositoryImpl({required this.localDataSource});

  @override
  Future<Preferences> getPreferences() async {
    final savedPreferences = await localDataSource.fetchPreferences();
    final bool savedDarkmode = savedPreferences.getBool(Preferences.darkModeConst) ?? false;
    final String savedLanguage = savedPreferences.getString(Preferences.languageConst) ?? 'es';
    final bool savedNotifications = savedPreferences.getBool(Preferences.notificationsConst) ?? false;
    return Preferences(darkMode: savedDarkmode, language: savedLanguage, notifications: savedNotifications);
  }

  @override
  Future<void> setPreferences(Preferences preference, String key) async {
    await localDataSource.savePreferences(preference, key);
  }
}