import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_bottom_nav.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/preferences_demo.dart';

class AppScaffold extends StatefulWidget {
  final List<Widget>? pages;
  final StatefulNavigationShell navigationShell;
  final bool modoOscuro;
  final String idioma;
  final bool notificaciones;
  final ValueChanged<bool> onCambioModoOscuro;
  final ValueChanged<String> onCambioIdioma;
  final ValueChanged<bool> onCambioNotificaciones;

  const AppScaffold({
    super.key,
    this.pages,
    required this.navigationShell,
    required this.modoOscuro,
    required this.idioma,
    required this.notificaciones,
    required this.onCambioModoOscuro,
    required this.onCambioIdioma,
    required this.onCambioNotificaciones,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  String _page = 'Inicio';
  bool _isOverlayPage = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      appBar: AppBar(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0.5,
        toolbarHeight: 42,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44), // Alto de la franja inferior
          child: Container(
            height: 44, // Alto de la franja inferior
            padding: const EdgeInsets.only(left: 16, right: 4),
            alignment: Alignment.centerLeft,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text( // Título
                    _page,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headlineSmall?.copyWith(color: scheme.onPrimary),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton( // Perfil
                        icon: Transform.translate(
                          offset: const Offset(0, -3),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: scheme.primary,
                            // backgroundImage: NetworkImage(...), // si tienes foto
                            child: Icon(Icons.account_circle, size: 30, color: scheme.onPrimary),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _page = 'Perfil';
                            _isOverlayPage = true;
                          });
                          /* Ir a perfil */
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PreferencesDemo(
                                modoOscuro: widget.modoOscuro,
                                idioma: widget.idioma,
                                notificaciones: widget.notificaciones,
                                onCambioIdioma: widget.onCambioIdioma,
                                onCambioModoOscuro: widget.onCambioModoOscuro,
                                onCambioNotificaciones: widget.onCambioNotificaciones,
                              ),
                            ),
                          );
                        },
                        tooltip: 'Perfil',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: widget.navigationShell,
      ),
      bottomNavigationBar: AppBottomNav(
        navigationShell: widget.navigationShell,
        isOverlayPage: _isOverlayPage,
        onChanged: (p) => setState(() {
          _isOverlayPage = false;
          _page = p;
        }),
      ),
    );
  }
}

