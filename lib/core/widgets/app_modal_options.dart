import 'package:flutter/material.dart';

/// Modal reutilizable con título opcional y lista de opciones
class AppModalOptions extends StatelessWidget {
  final String? title;
  final List<Widget> options;

  const AppModalOptions({
    super.key,
    this.title,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        shrinkWrap: true,
        children: [
          if (title != null) ...[
            /// Título
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          
          /// Opciones
          ...options,
        ],
      ),
    );
  }
}
