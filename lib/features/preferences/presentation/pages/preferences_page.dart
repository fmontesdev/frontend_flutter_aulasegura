import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/preferences/presentation/providers/preferences_providers.dart';

class PreferencesPage extends ConsumerStatefulWidget {
  const PreferencesPage({super.key,});

  @override
  ConsumerState<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends ConsumerState<PreferencesPage> {
  final FocusNode _dropdownFocusNode = FocusNode();

  static const List<String> _idiomasDisponibles = ['es', 'ca', 'en'];

  @override
  void dispose() {
    super.dispose();
    _dropdownFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final prefsAsync = ref.watch(preferencesProvider);
    final notifier = ref.read(preferencesProvider.notifier);

    final darkMode = prefsAsync.maybeWhen(
      data: (prefs) => prefs.darkMode,
      orElse: () => false,
    );
    final language = prefsAsync.maybeWhen(
      data: (prefs) => prefs.language,
      orElse: () => 'es',
    );
    final notifications = prefsAsync.maybeWhen(
      data: (prefs) => prefs.notifications,
      orElse: () => false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferencias'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              'Configuraciones disponibles',
              style: theme.titleMedium,
            ),
            const SizedBox(height: 12),

            /// Switch para tema oscuro
            SwitchListTile(
              title: const Text('Modo oscuro'),
              subtitle: const Text('Activar/desctivar modo oscuro'),
              value: darkMode!,
              onChanged: (value) => notifier.updateDarkMode(value),
              secondary: const Icon(Icons.dark_mode),
            ),
            const Divider(),

            /// Selector de idioma
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Idioma'),
              subtitle: const Text('Seleccionar idioma de la aplicación'),
              trailing: TapRegion(
                onTapOutside: (_) {
                  if (_dropdownFocusNode.hasFocus) {
                    _dropdownFocusNode.unfocus();
                  }
                },
                child: DropdownButton<String>(
                  value: language,
                  focusNode: _dropdownFocusNode, // mantiene focus/hover durante la interacción
                  items: _idiomasDisponibles
                    .map((code) => DropdownMenuItem<String>(
                        value: code,
                        child: Text(code[0].toUpperCase() + code.substring(1)),
                      ))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    notifier.updateLanguage(value);
                    _dropdownFocusNode.unfocus();
                  },
                ),
              ),
            ),
            const Divider(),

            /// Switch para Notificaciones del móvil
            SwitchListTile(
              title: const Text('Notificaciones'),
              subtitle: const Text('Activar/desactivar notificaciones del dispositivo'),
              value: notifications!,
              onChanged: (value) => notifier.updateNotifications(value),
              secondary: const Icon(Icons.notifications_active_outlined),
            ),
            const Divider(),
            
            /// Selector de tamaño de texto (placeholder)
            const ListTile(
              leading: Icon(Icons.format_size),
              title: Text('Tamaño del texto'),
              subtitle: Text('Ajustar densidad o escala tipográfica'),
            ),
          ],
        ),
      ),
    );
  }
}
