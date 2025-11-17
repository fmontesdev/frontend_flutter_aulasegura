import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_bottom_nav.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';

class AppMainScaffold extends ConsumerStatefulWidget {
  final List<Widget>? pages;
  final StatefulNavigationShell navigationShell;

  const AppMainScaffold({
    super.key,
    this.pages,
    required this.navigationShell,
  });

  @override
  ConsumerState<AppMainScaffold> createState() => _AppMainScaffoldState();
}

class _AppMainScaffoldState extends ConsumerState<AppMainScaffold> {
  String _page = 'home';
  bool _isOverlayPage = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final userAsync = ref.watch(authProvider);
    final imageServerUrl = dotenv.env['IMAGE_SERVER_URL'] ?? 'http://localhost:8090';

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
            padding: const EdgeInsets.only(left: 16, right: 8, bottom: 8),
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

                userAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text(l10n.sessionError(error.toString()))), //? Mensaje de error de sesión con internacionalización
                  data: (authUser) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Perfil
                          IconButton(
                            padding: EdgeInsets.zero, // quita el relleno interior
                            icon: Transform.translate(
                              offset: const Offset(0, -3),
                              child: CircleAvatar(
                                  radius: 16, // radio del avatar
                                  backgroundImage: CachedNetworkImageProvider('$imageServerUrl/${authUser!.avatar}'),
                                ),
                              ),
                            onPressed: () => context.push('/profile'),
                            tooltip: l10n.profile, //? Tooltip del botón de perfil con internacionalización
                          ),
                        ],
                      ),
                    );
                  },
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