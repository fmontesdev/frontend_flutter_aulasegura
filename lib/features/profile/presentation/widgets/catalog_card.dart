import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_icon_option_tile.dart';

//* Card que permite acceder al catálogo de widgets
class CatalogCard extends StatelessWidget {
  const CatalogCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return AppCard(
      title: l10n.development,
      children: [
        IconOptionTile(
          icon: Icons.widgets_outlined,
          title: l10n.widgetCatalog,
          subtitle: l10n.exploreComponents,
          trailing: Icon(Icons.chevron_right, color: scheme.grey),
          onTap: () => context.push('/catalog'),
        ),
      ],
    );
  }
}
