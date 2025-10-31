import 'package:frontend_flutter_aulasegura/features/profile/domain/entities/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesLocalDataSource {
  Future<SharedPreferences> fetchPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> savePreferences(Preferences preference, String key) async {
    final preferences = await SharedPreferences.getInstance();

    // Solo guarda la preferencia que coincide con la clave proporcionada
    if (key == Preferences.darkModeConst && preference.darkMode != null) {
      await preferences.setBool(Preferences.darkModeConst, preference.darkMode!);
    }
    if (key == Preferences.languageConst && preference.language != null) {
      await preferences.setString(Preferences.languageConst, preference.language!);
    }
    if (key == Preferences.notificationsConst && preference.notifications != null) {
      await preferences.setBool(Preferences.notificationsConst, preference.notifications!);
    }
  }
}