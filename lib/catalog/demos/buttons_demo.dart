import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_button.dart';

class ButtonsDemo extends StatelessWidget {
  final bool modoOscuro;
  final ValueChanged<bool> onCambioModoOscuro;

  const ButtonsDemo({
    super.key,
    required this.modoOscuro,
    required this.onCambioModoOscuro,
  });

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      title: 'Botones',
      modoOscuro: modoOscuro,
      onCambioModoOscuro: onCambioModoOscuro,
      body: Builder(
        builder: (innerCtx) {
          final theme = Theme.of(innerCtx).textTheme;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [

              /// Primary Buttons
              Text(
                'AppButton – Primary',
                style: theme.titleSmall,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Pequeño',
                      onPressed: () {},
                      size: AppButtonSize.sm,
                      variant: AppButtonVariant.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: 'Mediano',
                      onPressed: () {},
                      size: AppButtonSize.md,
                      variant: AppButtonVariant.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: 'Grande',
                      onPressed: () {},
                      size: AppButtonSize.lg,
                      variant: AppButtonVariant.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// Secondary Buttons
              Text(
                'AppButton – Secondary',
                style: theme.titleSmall,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Pequeño',
                      onPressed: () {},
                      size: AppButtonSize.sm,
                      variant: AppButtonVariant.secondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: 'Mediano',
                      onPressed: () {},
                      size: AppButtonSize.md,
                      variant: AppButtonVariant.secondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: 'Grande',
                      onPressed: () {},
                      size: AppButtonSize.lg,
                      variant: AppButtonVariant.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// Danger Buttons
              Text(
                'AppButton – Danger',
                style: theme.titleSmall,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Pequeño',
                      onPressed: () {},
                      size: AppButtonSize.sm,
                      variant: AppButtonVariant.danger,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: 'Mediano',
                      onPressed: () {},
                      size: AppButtonSize.md,
                      variant: AppButtonVariant.danger,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: 'Grande',
                      onPressed: () {},
                      size: AppButtonSize.lg,
                      variant: AppButtonVariant.danger,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// Primary Buttons
              Text(
                'AppButton – Home Page',
                style: theme.titleSmall,
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      icon: Icons.nfc_rounded,
                      onPressed: () {},
                      size: AppButtonSize.xl,
                      variant: AppButtonVariant.secondary,
                      isCircular: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      icon: Icons.qr_code,
                      onPressed: () {},
                      size: AppButtonSize.xl,
                      variant: AppButtonVariant.secondary,
                      isCircular: true,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
