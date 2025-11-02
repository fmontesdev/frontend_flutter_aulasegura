import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_icon_option_tile.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_selectable_tile.dart';

class PreferencesCard extends StatelessWidget {
  final bool darkMode;
  final String language;
  final bool notifications;
  final ValueChanged<bool> onToggleDarkMode;
  final ValueChanged<String> onChangeLanguage;
  final ValueChanged<bool> onToggleNotifications;

  const PreferencesCard({
    super.key,
    required this.darkMode,
    required this.language,
    required this.notifications,
    required this.onToggleDarkMode,
    required this.onChangeLanguage,
    required this.onToggleNotifications,
  });

  final languageOptions = const ['es', 'ca', 'en'];

  /// Modal para seleccionar el idioma
  void showLanguageSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            shrinkWrap: true, // Ajusta el tamaño al contenido (de lo contrario ocupa toda la pantalla)
            itemCount: languageOptions.length,
            itemBuilder: (context, index) {
              final option = languageOptions[index];
              return SelectableTile(
                icon: Icons.language,
                label: l10n.languageName(option),
                selected: language == option,
                onTap: () {
                  onChangeLanguage(option);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return AppCard(
      title: l10n.preferences,
      children: [

        /// Tema oscuro
        IconOptionTile(
          icon: Icons.dark_mode_outlined,
          title: l10n.darkTheme,
          subtitle: darkMode ? l10n.onOff(darkMode.toString()) : l10n.onOff(darkMode.toString()),
          trailing: Switch(
            value: darkMode,
            onChanged: onToggleDarkMode,
          ),
          onTap: null, // sin acción
        ),

        const Divider(), // separador

        /// Idioma
        IconOptionTile(
          icon: Icons.public_outlined,
          title: l10n.language,
          subtitle: l10n.languageName(language),
          trailing: Icon(Icons.chevron_right, color: scheme.grey),
          onTap: () => showLanguageSheet(context, l10n),
        ),

        const Divider(), // separador

        /// Notificaciones
        IconOptionTile(
          icon: Icons.notifications_none_outlined,
          title: l10n.notifications,
          subtitle: notifications ? l10n.onOffFemeninPlural(notifications.toString()) : l10n.onOffFemeninPlural(notifications.toString()),
          trailing: Switch(
            value: notifications,
            onChanged: onToggleNotifications,
          ),
          onTap: null, // sin acción
        ),
      ],
    );
  }
}