import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/preferences/data/datasources/preferences_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/preferences/data/repositories/preferences_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/preferences/domain/repositories/preferences_repository.dart';
import 'package:frontend_flutter_aulasegura/features/preferences/domain/usecases/preferences_usecases.dart';
import 'package:frontend_flutter_aulasegura/features/preferences/domain/entities/preferences.dart';

// import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';

/// DataSource
final preferencesLocalDSProvider = Provider<PreferencesLocalDataSource>((ref) {
  return PreferencesLocalDataSource();
});

/// Repositorio
final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  final ds = ref.watch(preferencesLocalDSProvider);
  return PreferencesRepositoryImpl(localDataSource: ds);
});

/// Casos de uso
final preferencesUseCasesProvider = Provider<PreferencesUseCases>((ref) {
  final repo = ref.watch(preferencesRepositoryProvider);
  return PreferencesUseCases(repo);
});

/// Notifier para manejar el estado de las reservas
class PreferencesNotifier extends AsyncNotifier<Preferences> {
  late final PreferencesUseCases preferencesUseCases;

  /// Inicializa el Notifier
  @override
  Future<Preferences> build() async {
    preferencesUseCases = ref.watch(preferencesUseCasesProvider);

    // // Obtiene el usuario autenticado
    // final user = await ref.watch(authProvider.future);
    // if (user == null) {
    //   // Sin sesión no hay reservas
    //   return <EventSchedule>[];
    // }
    
    // Carga inicial de preferencias desde SharedPreferences del usuario autenticado
    return await preferencesUseCases.getPreferences();
  }

  /// Actualiza una preferencia específica por su clave
  Future<void> updateDarkMode(bool value) async {
    await _updatePreference(
      (prefs) => prefs.copyWith(darkMode: value),
      Preferences.darkModeConst,
    );
  }

  Future<void> updateLanguage(String value) async {
    await _updatePreference(
      (prefs) => prefs.copyWith(language: value),
      Preferences.languageConst,
    );
  }

  Future<void> updateNotifications(bool value) async {
    await _updatePreference(
      (prefs) => prefs.copyWith(notifications: value),
      Preferences.notificationsConst,
    );
  }

  /// Método privado genérico para actualizar preferencias
  Future<void> _updatePreference(Preferences Function(Preferences) update, String key) async {
    final prev = state.value; // Guarda el estado previo para rollback
    if (prev == null) return; // No hace nada si no hay estado previo

    final newPreference = update(prev); // Crea la nueva preferencia con el cambio
    state = AsyncValue.data(newPreference); // Actualiza el estado

    try {
      await preferencesUseCases.setPreferences(newPreference, key); // Guarda en SharedPreferences
      state = await AsyncValue.guard(() => preferencesUseCases.getPreferences()); // Recarga desde SharedPreferences
    } catch (error, stack) {
      // Rollback si hay error
      state = AsyncValue.data(prev);
      state = AsyncError(error, stack);
    }
  }
}

final preferencesProvider = AsyncNotifierProvider<PreferencesNotifier, Preferences>(() {
  return PreferencesNotifier();
});