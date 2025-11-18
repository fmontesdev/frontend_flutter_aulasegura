import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class ShowcaseScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final Color? backgroundColor;
  final bool darkMode;
  final ValueChanged<bool> onToggleDarkMode;

  const ShowcaseScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.darkMode,
    this.backgroundColor,
    required this.onToggleDarkMode,
  });

  @override
  State<ShowcaseScaffold> createState() => _ShowcaseScaffoldState();
}

class _ShowcaseScaffoldState extends State<ShowcaseScaffold> {
  late bool _localDarkMode;

  @override
  void initState() {
    super.initState();
    _localDarkMode = widget.darkMode;
  }

  // Sincroniza el estado local si cambia la prop externa
  @override
  void didUpdateWidget(covariant ShowcaseScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.darkMode != widget.darkMode) {
      setState(() => _localDarkMode = widget.darkMode);
    }
  }

  Future<void> _localOnToggleDarkMode(bool valor) async {
    setState(() => _localDarkMode = valor);
    widget.onToggleDarkMode(valor);
  }

  @override
  Widget build(BuildContext context) {
    final theme = _localDarkMode ? AppTheme.dark : AppTheme.light;
    final scheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: widget.backgroundColor ?? scheme.primaryContainer,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(66),
          child: AppBar(
            backgroundColor: scheme.primary,
            elevation: 0.5,
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 1, bottom: 3),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      /// Flecha de retroceso
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: scheme.onPrimary,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      /// Título
                      Expanded(
                        child: Text(
                          widget.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: scheme.onPrimary,
                            fontSize: 21,
                          ),
                        ),
                      ),
                      /// Botón home
                      IconButton(
                        tooltip: l10n.home,
                        icon: Icon(
                          Icons.home_outlined,
                          color: scheme.onPrimary,
                        ),
                        onPressed: () => context.go('/home'),
                      ),
                      /// Icono modo oscuro
                      IconButton(
                        tooltip: _localDarkMode ? l10n.lightTheme : l10n.darkTheme,
                        icon: Icon(
                          _localDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: scheme.onPrimary,
                        ),
                        onPressed: () => _localOnToggleDarkMode(!_localDarkMode),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: widget.body,
      ),
    );
  }
}
