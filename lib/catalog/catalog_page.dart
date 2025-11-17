import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/profile/presentation/providers/preferences_providers.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_overlay_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_icon_option_tile.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/buttons_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/text_form_fields_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/links_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/cards_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/filters_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/lists_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/selectors_demo.dart';
import 'package:frontend_flutter_aulasegura/catalog/demos/calendars_demo.dart';

class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final prefsAsync = ref.watch(preferencesProvider);
    final notifier = ref.read(preferencesProvider.notifier);
    
    final darkMode = prefsAsync.maybeWhen(
      data: (prefs) => prefs.darkMode,
      orElse: () => false,
    );
    
    return AppOverlayScaffold(
      title: l10n.componentCatalog,
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            AppCard(
              title: l10n.components,
              children: [
                /// Botones
                IconOptionTile(
                  icon: Icons.smart_button_outlined,
                  title: l10n.buttons,
                  subtitle: l10n.variantsStatesAndSizes,
                  trailing: Icon(Icons.chevron_right, color: scheme.grey),
                  onTap: () {
                    Navigator.of(context).push(
                      _slideFromRightRoute(
                        ButtonsDemo(
                          darkMode: darkMode ?? false,
                          onToggleDarkMode: (d) => notifier.updateDarkMode(d),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),

                /// Inputs de Texto
                IconOptionTile(
                  icon: Icons.text_fields_outlined,
                  title: l10n.textInputs,
                  subtitle: l10n.variantsAndValidations,
                  trailing: Icon(Icons.chevron_right, color: scheme.grey),
                  onTap: () {
                    Navigator.of(context).push(
                      _slideFromRightRoute(
                        TextFieldsDemo(
                          darkMode: darkMode ?? false,
                          onToggleDarkMode: (d) => notifier.updateDarkMode(d),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),

                /// Links
                IconOptionTile(
                  icon: Icons.link_outlined,
                  title: l10n.links,
                  subtitle: l10n.secondaryActionLinks,
                  trailing: Icon(Icons.chevron_right, color: scheme.grey),
                  onTap: () {
                    Navigator.of(context).push(
                      _slideFromRightRoute(
                        LinksDemo(
                          darkMode: darkMode ?? false,
                          onToggleDarkMode: (d) => notifier.updateDarkMode(d),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),

                /// Cards
                IconOptionTile(
                  icon: Icons.credit_card_outlined,
                  title: l10n.cards,
                  subtitle: l10n.differentCardsWithContent,
                  trailing: Icon(Icons.chevron_right, color: scheme.grey),
                  onTap: () {
                    Navigator.of(context).push(
                      _slideFromRightRoute(
                        CardsDemo(
                          darkMode: darkMode ?? false,
                          onToggleDarkMode: (d) => notifier.updateDarkMode(d),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),

                /// Filtros
                IconOptionTile(
                  icon: Icons.filter_list_outlined,
                  title: l10n.filters,
                  subtitle: l10n.differentTypesOfFilters,
                  trailing: Icon(Icons.chevron_right, color: scheme.grey),
                  onTap: () {
                    Navigator.of(context).push(
                      _slideFromRightRoute(
                        FiltersDemo(
                          darkMode: darkMode ?? false,
                          onToggleDarkMode: (d) => notifier.updateDarkMode(d),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),

                /// Listas y Tiles
                IconOptionTile(
                  icon: Icons.list_outlined,
                  title: l10n.listsAndTiles,
                  subtitle: l10n.selectableTilesWithSwitch,
                  trailing: Icon(Icons.chevron_right, color: scheme.grey),
                  onTap: () {
                    Navigator.of(context).push(
                      _slideFromRightRoute(
                        ListsDemo(
                          darkMode: darkMode ?? false,
                          onToggleDarkMode: (d) => notifier.updateDarkMode(d),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),

                /// Selectores
                IconOptionTile(
                  icon: Icons.tune_outlined,
                  title: l10n.selectors,
                  subtitle: l10n.horizontalSlideSelectors,
                  trailing: Icon(Icons.chevron_right, color: scheme.grey),
                  onTap: () {
                    Navigator.of(context).push(
                      _slideFromRightRoute(
                        SelectorsDemo(
                          darkMode: darkMode ?? false,
                          onToggleDarkMode: (d) => notifier.updateDarkMode(d),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),

                /// Calendarios
                IconOptionTile(
                  icon: Icons.calendar_month_outlined,
                  title: l10n.calendars,
                  subtitle: l10n.monthlyCalendarWithSelection,
                  trailing: Icon(Icons.chevron_right, color: scheme.grey),
                  onTap: () {
                    Navigator.of(context).push(
                      _slideFromRightRoute(
                        CalendarsDemo(
                          darkMode: darkMode ?? false,
                          onToggleDarkMode: (d) => notifier.updateDarkMode(d),
                        ),
                      ),
                    );
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

/// Helper para crear transición de deslizamiento desde la derecha
Route<dynamic> _slideFromRightRoute(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeOutCubic));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
