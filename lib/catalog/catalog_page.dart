import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/buttons_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/textFormFields_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/links_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/scaffold_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/cards_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/filters_demo.dart';

class CatalogPage extends StatelessWidget {
  final bool modoOscuro;
  final String idioma;
  final bool notificaciones;
  final ValueChanged<bool> onCambioModoOscuro;
  final ValueChanged<String> onCambioIdioma;
  final ValueChanged<bool> onCambioNotificaciones;
  final StatefulNavigationShell navigationShell;

  const CatalogPage({
    super.key,
    required this.modoOscuro,
    required this.idioma,
    required this.notificaciones,
    required this.onCambioModoOscuro,
    required this.onCambioIdioma,
    required this.onCambioNotificaciones,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    
    return ShowcaseScaffold(
      title: 'Catálogo de Componentes',
      backgroundColor: scheme.primaryContainer,
      modoOscuro: modoOscuro,
      onCambioModoOscuro: onCambioModoOscuro,
      body: Builder(
        builder: (context) {
          return ListView(
            children: [
              ListTile(
                title: Text('Botones', style: text.titleSmall?.copyWith(color: scheme.secondary)),
                subtitle: Text('Variantes, estados y tamaños', style: text.bodyMedium?.copyWith(color: scheme.grey)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context,).push(
                    MaterialPageRoute(
                      builder: (_) => ButtonsDemo(
                        modoOscuro: modoOscuro,
                        onCambioModoOscuro: onCambioModoOscuro,
                      )));
                },
              ),
              ListTile(
                title: Text('Inputs de Texto', style: text.titleSmall?.copyWith(color: scheme.secondary)),
                subtitle: Text('Variantes y validaciones', style: text.bodyMedium?.copyWith(color: scheme.grey)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context,).push(
                    MaterialPageRoute(
                      builder: (_) => TextFieldsDemo(
                        modoOscuro: modoOscuro,
                        onCambioModoOscuro: onCambioModoOscuro,
                      )));
                },
              ),
              ListTile(
                title: Text('Links', style: text.titleSmall?.copyWith(color: scheme.secondary)),
                subtitle: Text('Enlaces de acción secundarios', style: text.bodyMedium?.copyWith(color: scheme.grey)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context,).push(
                    MaterialPageRoute(
                      builder: (_) => LinksDemo(
                        modoOscuro: modoOscuro,
                        onCambioModoOscuro: onCambioModoOscuro,
                      )));
                },
              ),
              ListTile(
                title: Text('Cards', style: text.titleSmall?.copyWith(color: scheme.secondary)),
                subtitle: Text('Diferentes tarjetas con contenido', style: text.bodyMedium?.copyWith(color: scheme.grey)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context,).push(
                    MaterialPageRoute(
                      builder: (_) => CardsDemo(
                        modoOscuro: modoOscuro,
                        onCambioModoOscuro: onCambioModoOscuro,
                      )));
                },
              ),
              ListTile(
                title: Text('Filtros', style: text.titleSmall?.copyWith(color: scheme.secondary)),
                subtitle: Text('Diferentes tipos de filtros', style: text.bodyMedium?.copyWith(color: scheme.grey)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context,).push(
                    MaterialPageRoute(
                      builder: (_) => FiltersDemo(
                        modoOscuro: modoOscuro,
                        onCambioModoOscuro: onCambioModoOscuro,
                      )));
                },
              ),
              ListTile(
                title: Text('Estructura básica',  style: text.titleSmall?.copyWith(color: scheme.secondary)),
                subtitle: Text('Scaffold con AppBar y Bottom NavigationBar', style: text.bodyMedium?.copyWith(color: scheme.grey)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context,).push(
                    MaterialPageRoute(
                      builder: (_) => ScaffoldDemo(
                        modoOscuro: modoOscuro,
                        idioma: idioma,
                        notificaciones: notificaciones,
                        onCambioIdioma: onCambioIdioma,
                        onCambioModoOscuro: onCambioModoOscuro,
                        onCambioNotificaciones: onCambioNotificaciones,
                        navigationShell: navigationShell,
                      )));
                },
              ),
            ],
          );
        }
      ),
    );
  }
}

