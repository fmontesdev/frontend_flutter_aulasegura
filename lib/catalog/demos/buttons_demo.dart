import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_button.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_fab.dart';

class ButtonsDemo extends StatelessWidget {
  final bool darkMode;
  final ValueChanged<bool> onToggleDarkMode;

  const ButtonsDemo({
    super.key,
    required this.darkMode,
    required this.onToggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return ShowcaseScaffold(
      title: l10n.buttons,
      backgroundColor: scheme.primaryContainer,
      darkMode: darkMode,
      onToggleDarkMode: onToggleDarkMode,
      body: Builder(
        builder: (innerCtx) {
          final theme = Theme.of(innerCtx).textTheme;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [

              /// Botones color primario
              Text(
                l10n.primaryColorButton,
                style: theme.titleSmall,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: l10n.small,
                      onPressed: () {},
                      size: AppButtonSize.sm,
                      variant: AppButtonVariant.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: l10n.medium,
                      onPressed: () {},
                      size: AppButtonSize.md,
                      variant: AppButtonVariant.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: l10n.large,
                      onPressed: () {},
                      size: AppButtonSize.lg,
                      variant: AppButtonVariant.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /// Botones color secundario
              Text(
                l10n.secondaryColorButton,
                style: theme.titleSmall,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: l10n.small,
                      onPressed: () {},
                      size: AppButtonSize.sm,
                      variant: AppButtonVariant.secondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: l10n.medium,
                      onPressed: () {},
                      size: AppButtonSize.md,
                      variant: AppButtonVariant.secondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: l10n.large,
                      onPressed: () {},
                      size: AppButtonSize.lg,
                      variant: AppButtonVariant.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /// Botones color peligro
              Text(
                l10n.dangerColorButton,
                style: theme.titleSmall,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: l10n.small,
                      onPressed: () {},
                      size: AppButtonSize.sm,
                      variant: AppButtonVariant.danger,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: l10n.medium,
                      onPressed: () {},
                      size: AppButtonSize.md,
                      variant: AppButtonVariant.danger,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: l10n.large,
                      onPressed: () {},
                      size: AppButtonSize.lg,
                      variant: AppButtonVariant.danger,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /// Botones de la página de inicio
              Text(
                l10n.homePageButtons,
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
              const SizedBox(height: 20),

              /// Botones de acción flotante (FAB)
              Text(
                l10n.floatingActionButton,
                style: theme.titleSmall,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        AppFab(
                          icon: Icons.add,
                          size: AppFabSize.sm,
                          variant: AppFabVariant.primary,
                          onPressed: () {},
                          heroTag: 'fab_sm_primary',
                        ),
                        const SizedBox(height: 4),
                        Text(l10n.small, style: theme.bodySmall),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        AppFab(
                          icon: Icons.edit,
                          size: AppFabSize.md,
                          variant: AppFabVariant.secondary,
                          onPressed: () {},
                          heroTag: 'fab_md_primary',
                        ),
                        const SizedBox(height: 4),
                        Text(l10n.medium, style: theme.bodySmall),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        AppFab(
                          icon: Icons.check,
                          size: AppFabSize.lg,
                          variant: AppFabVariant.danger,
                          onPressed: () {},
                          heroTag: 'fab_lg_primary',
                        ),
                        const SizedBox(height: 4),
                        Text(l10n.large, style: theme.bodySmall),
                      ],
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
