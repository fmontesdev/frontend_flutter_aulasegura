import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_bottom_nav.dart';

class AppScaffold extends StatefulWidget {
  final Widget body;
  final List<Widget>? pages;

  const AppScaffold({
    super.key,
    required this.body,
    this.pages,
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
                      IconButton( // Notificaciones con badge
                        icon: Transform.translate(
                          offset: const Offset(0, -3),
                          child: Badge(
                            backgroundColor: scheme.warning, // color del badge
                            // textColor: scheme.onTertiary,     // Color del texto del badge
                            label: const Text('2'), // o el contador real
                            child: Icon(Icons.notifications_none, size: 30, color: scheme.onPrimary),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _page = 'Notificaciones';
                            _isOverlayPage = true;
                          });
                          /* Ir a notificaciones */
                        },
                        tooltip: 'Notificaciones',
                      ),
                      IconButton( // Perfil
                        icon: Transform.translate(
                          offset: const Offset(0, -3),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: scheme.primary,
                            // backgroundImage: NetworkImage(...), // si tienes foto
                            child: const Icon(Icons.account_circle, size: 30),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _page = 'Perfil';
                            _isOverlayPage = true;
                          });
                          /* Ir a perfil */
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
      body: SafeArea(child: widget.body),
      bottomNavigationBar: AppBottomNav(
        isOverlayPage: _isOverlayPage,
        onChanged: (p) => setState(() {
          _isOverlayPage = false;
          _page = p;
        }),
      ),
    );
  }
}

