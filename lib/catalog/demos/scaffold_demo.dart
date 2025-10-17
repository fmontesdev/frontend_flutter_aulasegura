import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_scaffold.dart';

class ScaffoldDemo extends StatelessWidget {
  final bool modoOscuro;
  final String idioma;
  final bool notificaciones;
  final ValueChanged<bool> onCambioModoOscuro;
  final ValueChanged<String> onCambioIdioma;
  final ValueChanged<bool> onCambioNotificaciones;
  final StatefulNavigationShell navigationShell;

  const ScaffoldDemo({
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
    return AppScaffold(
      navigationShell: navigationShell,
      modoOscuro: modoOscuro,
      idioma: idioma,
      notificaciones: notificaciones,
      onCambioIdioma: onCambioIdioma,
      onCambioModoOscuro: onCambioModoOscuro,
      onCambioNotificaciones: onCambioNotificaciones,
    );
  }
}
