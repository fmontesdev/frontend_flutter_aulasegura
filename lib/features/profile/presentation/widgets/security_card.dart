import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_icon_option_tile.dart';

class SecurityCard extends StatelessWidget {
  const SecurityCard({super.key,});

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return AppCard(
      title: l10n.security,
      children: [
        IconOptionTile(
          icon: Icons.lock_outline,
          title: l10n.changePassword,
          subtitle: l10n.updatePassword,
          trailing: Icon(Icons.chevron_right, color: scheme.grey),
          onTap: () => context.push('/change-password')
        ),
      ],
    );
  }
}