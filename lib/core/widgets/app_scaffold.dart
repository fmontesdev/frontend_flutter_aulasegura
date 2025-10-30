import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_bottom_nav.dart';
import 'package:frontend_flutter_aulasegura/features/preferences/presentation/pages/preferences_page.dart';
import 'package:frontend_flutter_aulasegura/l10n/app_localizations.dart';

class AppScaffold extends StatefulWidget {
  final List<Widget>? pages;
  final StatefulNavigationShell navigationShell;

  const AppScaffold({
    super.key,
    this.pages,
    required this.navigationShell,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  String _page = 'home';
  bool _isOverlayPage = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      appBar: AppBar(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0.5,
        toolbarHeight: 32,
        // Franja inferior con título de sección y botón de perfil
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44), // Alto de la franja inferior
          child: Container(
            height: 44, // Alto de la franja inferior
            padding: const EdgeInsets.only(left: 16, right: 7, bottom: 8),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                /// Título de la página actual
                Expanded(
                  child: Text(
                    l10n.page(_page), //? Nombre de la página actual con internacionalización
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: scheme.onPrimary,
                      fontSize: 21
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Perfil
                      IconButton(
                        icon: Transform.translate(
                          offset: const Offset(0, -11),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: scheme.primary,
                            // backgroundImage: NetworkImage(...), // si tienes foto
                            child: Icon(Icons.account_circle, size: 34, color: scheme.onPrimary),
                          ),
                        ),
                        onPressed: () {
                          // setState(() {
                          //   _page = 'Perfil';
                          //   _isOverlayPage = true;
                          // });
                          /* Ir a perfil */
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const PreferencesPage(),
                            ),
                          );
                        },
                        tooltip: l10n.profile, //? Tooltip del botón de perfil con internacionalización
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