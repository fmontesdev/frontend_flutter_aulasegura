import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_link.dart';

class LinksDemo extends StatelessWidget {
  const LinksDemo({
    super.key,
    required this.modoOscuro,
    required this.onCambioModoOscuro,
  });

  final bool modoOscuro;
  final ValueChanged<bool> onCambioModoOscuro;

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return ShowcaseScaffold(
      title: 'Links',
      modoOscuro: modoOscuro,
      onCambioModoOscuro: onCambioModoOscuro,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Enlaces centrados pequeños', style: t.titleSmall),
          const SizedBox(height: 8),
          AppLink(
            text: '¿Has olvidado tu contraseña?',
            onTap: () => _showSnack(context, 'Recuperar contraseña'),
            size: AppLinkSize.sm,
            align: AppLinkAlign.center,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          const SizedBox(height: 18),

          Text('Enlaces a la izquierda medianos', style: t.titleSmall),
          const SizedBox(height: 8),
          AppLink(
            text: '¿Has olvidado tu contraseña?',
            onTap: () => _showSnack(context, 'Recuperar contraseña'),
            size: AppLinkSize.md,
            align: AppLinkAlign.start,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 18),

          Text('Enlaces a la derecha grande', style: t.titleSmall),
          const SizedBox(height: 8),
          AppLink(
            text: '¿Has olvidado tu contraseña?',
            onTap: () => _showSnack(context, 'Recuperar contraseña'),
            size: AppLinkSize.lg,
            align: AppLinkAlign.end,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
