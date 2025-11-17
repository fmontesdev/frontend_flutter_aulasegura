import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_icon_option_tile.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_selectable_tile.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class ListsDemo extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onToggleDarkMode;

  const ListsDemo({
    super.key,
    required this.darkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<ListsDemo> createState() => _ListsDemoState();
}

class _ListsDemoState extends State<ListsDemo> {
  String selectedLanguage = 'es';
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return ShowcaseScaffold(
      title: l10n.listsAndTiles,
      backgroundColor: scheme.primaryContainer,
      darkMode: widget.darkMode,
      onToggleDarkMode: widget.onToggleDarkMode,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            /// Card con IconOptionTile
            AppCard(
              title: l10n.iconOptionTile,
              children: [

                IconOptionTile(
                  icon: Icons.notifications_none_outlined,
                  title: l10n.notifications,
                  subtitle: notificationsEnabled ? l10n.activatedFeminine : l10n.deactivatedFeminine,
                  trailing: Switch(
                    value: notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                  ),
                  onTap: null,
                ),
                const Divider(),
                IconOptionTile(
                  icon: Icons.public_outlined,
                  title: l10n.language,
                  subtitle: l10n.languageName(selectedLanguage),
                  trailing: Icon(Icons.chevron_right, color: scheme.grey),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Card con SelectableTile
            AppCard(
              title: l10n.selectableTile,
              children: [
                SelectableTile(
                  icon: Icons.language,
                  label: l10n.languageName('es'),
                  selected: selectedLanguage == 'es',
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'es';
                    });
                  },
                ),
                SelectableTile(
                  icon: Icons.language,
                  label: l10n.languageName('ca'),
                  selected: selectedLanguage == 'ca',
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'ca';
                    });
                  },
                ),
                SelectableTile(
                  icon: Icons.language,
                  label: l10n.languageName('en'),
                  selected: selectedLanguage == 'en',
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'en';
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
