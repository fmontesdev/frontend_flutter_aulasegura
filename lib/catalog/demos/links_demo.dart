import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_link.dart';

class LinksDemo extends StatelessWidget {
  const LinksDemo({
    super.key,
    required this.darkMode,
    required this.onToggleDarkMode,
  });

  final bool darkMode;
  final ValueChanged<bool> onToggleDarkMode;

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return ShowcaseScaffold(
      title: l10n.links,
      backgroundColor: scheme.primaryContainer,
      darkMode: darkMode,
      onToggleDarkMode: onToggleDarkMode,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.leftAlignedSmallLink, style: t.titleSmall),
          const SizedBox(height: 8),
          AppLink(
            text: l10n.forgotPassword,
            onTap: () => _showSnack(context, l10n.recoverPassword),
            size: AppLinkSize.sm,
            align: AppLinkAlign.start,
            color: Theme.of(context).colorScheme.secondary,
            hoverColor: Theme.of(context).colorScheme.secondary,
            // hoverUnderlineColor: Theme.of(context).colorScheme.secondary,
            // hoverUnderlineThickness: 1.0,
          ),
          const SizedBox(height: 18),

          Text(l10n.centeredMediumLink, style: t.titleSmall),
          const SizedBox(height: 12),
          AppLink(
            text: l10n.forgotPassword,
            onTap: () => _showSnack(context, l10n.recoverPassword),
            size: AppLinkSize.md,
            align: AppLinkAlign.center,
            color: Theme.of(context).colorScheme.secondary,
            hoverColor: Theme.of(context).colorScheme.secondary,
            // hoverUnderlineColor: Theme.of(context).colorScheme.secondary,
            // hoverUnderlineThickness: 1.0,
          ),
          const SizedBox(height: 18),

          Text(l10n.rightAlignedLargeLink, style: t.titleSmall),
          const SizedBox(height: 12),
          AppLink(
            text: l10n.forgotPassword,
            onTap: () => _showSnack(context, l10n.recoverPassword),
            size: AppLinkSize.lg,
            align: AppLinkAlign.end,
            color: Theme.of(context).colorScheme.secondary,
            hoverColor: Theme.of(context).colorScheme.secondary,
            // hoverUnderlineColor: Theme.of(context).colorScheme.secondary,
            // hoverUnderlineThickness: 1.0,
          ),
        ],
      ),
    );
  }
}
