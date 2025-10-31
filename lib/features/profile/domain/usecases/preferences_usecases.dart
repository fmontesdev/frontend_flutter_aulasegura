import 'package:frontend_flutter_aulasegura/features/profile/domain/entities/preferences.dart';
import 'package:frontend_flutter_aulasegura/features/profile/domain/repositories/preferences_repository.dart';

class PreferencesUseCases {
  final Future<Preferences> Function() getPreferences;
  final Future<void> Function(Preferences preference, String key) setPreferences;

  PreferencesUseCases(PreferencesRepository repo)
    : getPreferences = repo.getPreferences,
      setPreferences = repo.setPreferences;
}