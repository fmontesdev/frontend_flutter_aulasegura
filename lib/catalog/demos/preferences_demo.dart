import 'package:flutter/material.dart';

class PreferencesDemo extends StatefulWidget {
  final bool modoOscuro;
  final String idioma;
  final bool notificaciones;
  final ValueChanged<bool> onCambioModoOscuro;
  final ValueChanged<String> onCambioIdioma;
  final ValueChanged<bool> onCambioNotificaciones;

  const PreferencesDemo({
    super.key,
    required this.modoOscuro,
    required this.idioma,
    required this.notificaciones,
    required this.onCambioModoOscuro,
    required this.onCambioIdioma,
    required this.onCambioNotificaciones,
  });

    @override
  State<PreferencesDemo> createState() => _PreferencesDemoState();
}

class _PreferencesDemoState extends State<PreferencesDemo> {
  late bool _modoOscuroLocal;
  late String _idiomaLocal;
  late bool _notificacionesLocal;
  final FocusNode _dropdownFocusNode = FocusNode();

  static const List<String> _idiomasDisponibles = ['es', 'en', 'fr', 'de', 'it', 'pt'];

  @override
  void initState() {
    super.initState();
    _modoOscuroLocal = widget.modoOscuro;
    _idiomaLocal = widget.idioma;
    _notificacionesLocal = widget.notificaciones;
  }

  Future<void> _alternarModoOscuro(bool valor) async {
    setState(() => _modoOscuroLocal = valor);
    widget.onCambioModoOscuro(valor);
  }

  Future<void> _cambiarIdioma(String nuevoIdioma) async {
    setState(() => _idiomaLocal = nuevoIdioma);
    widget.onCambioIdioma(nuevoIdioma);

    // Forzamos pérdida de foco una vez seleccionado un idioma
    _dropdownFocusNode.unfocus();
  }

  Future<void> _alternarNotificaciones(bool valor) async {
    setState(() => _notificacionesLocal = valor);
    widget.onCambioNotificaciones(valor);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

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
              value: _modoOscuroLocal,
              onChanged: _alternarModoOscuro,
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
                  value: _idiomaLocal,
                  focusNode: _dropdownFocusNode, // mantiene focus/hover durante la interacción
                  items: _idiomasDisponibles
                      .map((code) => DropdownMenuItem<String>(
                            value: code,
                            child: Text(code[0].toUpperCase() + code.substring(1)),
                          ))
                      .toList(),
                  onChanged: (valor) {
                    if (valor == null) return;
                    _cambiarIdioma(valor); // actualiza estado + persiste (vía callback)
                  },
                ),
              ),
            ),
            const Divider(),

            /// Switch para Notificaciones del móvil
            SwitchListTile(
              title: const Text('Notificaciones'),
              subtitle: const Text('Activar/desactivar notificaciones del dispositivo'),
              value: _notificacionesLocal,
              onChanged: _alternarNotificaciones,
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
