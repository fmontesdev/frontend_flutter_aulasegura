import 'package:frontend_flutter_aulasegura/features/preferences/domain/entities/preferences.dart';

abstract class PreferencesRepository {
  Future<Preferences> getPreferences();
  Future<void> setPreferences(Preferences preference, String key);
}