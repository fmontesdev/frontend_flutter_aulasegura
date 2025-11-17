import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_check_item.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';

//* Widget que muestra una tarjeta con los requisitos de contraseña y su estado de cumplimiento
class RequirementsCard extends StatelessWidget {
  final String password; // El texto de la contraseña que se está validando

  const RequirementsCard({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppCard(
      title: l10n.requirements,
      children: [
        AppCheckItem(
          text: l10n.minimumCharacters,
          isChecked: password.length >= 8,
        ),
        AppCheckItem(
          text: l10n.oneUppercaseLetter,
          isChecked: password.contains(RegExp(r'[A-Z]')),
        ),
        AppCheckItem(
          text: l10n.oneLowercaseLetter,
          isChecked: password.contains(RegExp(r'[a-z]')),
        ),
        AppCheckItem(
          text: l10n.oneNumber,
          isChecked: password.contains(RegExp(r'[0-9]')),
        ),
      ],
    );
  }
}
