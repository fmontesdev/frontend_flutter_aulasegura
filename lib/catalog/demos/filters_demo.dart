import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_filter_selector.dart';

class FiltersDemo extends StatefulWidget {
  final bool modoOscuro;
  final ValueChanged<bool> onCambioModoOscuro;

  const FiltersDemo({
    super.key,
    required this.modoOscuro,
    required this.onCambioModoOscuro,
  });

  @override
  State<FiltersDemo> createState() => _FiltersDemoState();
}

class _FiltersDemoState extends State<FiltersDemo> {
  int index1 = 0;
  int index2 = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return ShowcaseScaffold(
      title: 'Filtros',
      backgroundColor: scheme.primaryContainer,
      modoOscuro: widget.modoOscuro,
      onCambioModoOscuro: widget.onCambioModoOscuro,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Selector de 5 filtros', style: text.titleSmall),
          const SizedBox(height: 12),
          AppFilterSelector(
            options: const ['Todas', 'Accesos', 'Avisos', 'Alertas', 'Vistas'],
            selectedIndex: index1,
            onChanged: (i) => setState(() => index1 = i),
          ),
          const SizedBox(height: 24),

          Text('Selector de 2 filtros', style: text.titleSmall),
          const SizedBox(height: 12),
          AppFilterSelector(
            options: const ['Horario semanal', 'Reservas de aulas'],
            selectedIndex: index2,
            onChanged: (i) => setState(() => index2 = i),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
