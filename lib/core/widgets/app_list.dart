import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class AppList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;

  const AppList({
    super.key,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;

    if (items.isEmpty) {
      return Align( // evita que se expanda a todo el alto si el padre le da espacio infinito
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: double.infinity, // Ocupa todo el ancho disponible
          child: Material(
            color: scheme.onSecondary,
            elevation: 1.5,
            shadowColor: scheme.onPrimaryContainer.withValues(alpha: 0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
              side: BorderSide(
                color: scheme.grey.withValues(alpha: 0.2),
                width: 0.6,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 35),  
              child: Column(
                mainAxisSize: MainAxisSize.min, // para que el Column ocupe solo el espacio necesario
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.data_object, color: scheme.lightGrey, size: 40),
                  const SizedBox(height: 20),
                  Text(
                    'No hay datos para mostrar',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: scheme.lightGrey,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 13),
          child: itemBuilder(item),
        );
      },
    );
  }
}
