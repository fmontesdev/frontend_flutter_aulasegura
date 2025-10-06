import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/buttons_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/preferences/preferences_page.dart';

class CatalogPage extends StatelessWidget {
  final bool modoOscuro;
  final String idioma;
  final bool notificaciones;
  final ValueChanged<bool> onCambioModoOscuro;
  final ValueChanged<String> onCambioIdioma;
  final ValueChanged<bool> onCambioNotificaciones;

  const CatalogPage({
    super.key,
    required this.modoOscuro,
    required this.idioma,
    required this.notificaciones,
    required this.onCambioModoOscuro,
    required this.onCambioIdioma,
    required this.onCambioNotificaciones,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Componentes'),
        centerTitle: false,
        actions: [
          IconButton( // Botón de preferencias en la AppBar
            icon: const Icon(Icons.settings),
            tooltip: 'Preferencias',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PreferencesPage(
                    modoOscuro: modoOscuro,
                    idioma: idioma,
                    notificaciones: notificaciones,
                    onCambioModoOscuro: onCambioModoOscuro,
                    onCambioIdioma: onCambioIdioma,
                    onCambioNotificaciones: onCambioNotificaciones,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Botones'),
            subtitle: const Text('Variantes, estados y tamaños'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ButtonsDemo()));
            },
          ),
        ],
      ),
    );
  }
}
