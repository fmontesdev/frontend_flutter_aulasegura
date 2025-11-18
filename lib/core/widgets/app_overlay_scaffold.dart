import 'package:flutter/material.dart';

class AppOverlayScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const AppOverlayScaffold({
    super.key,
    required this.title,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(66),
        child: AppBar(
          backgroundColor: scheme.primary,
          elevation: 0.5,
          automaticallyImplyLeading: false, // Desactiva el botón automático
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 1, bottom: 3),
              child: Align(
                alignment: Alignment.bottomLeft, // Alinea contenido abajo a la izquierda
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
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: scheme.onPrimary,
                        fontSize: 21,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}