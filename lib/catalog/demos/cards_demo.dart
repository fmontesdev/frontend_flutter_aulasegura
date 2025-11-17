import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/features/home/presentation/widgets/welcome_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_schedule_card.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/presentation/widgets/notification_card.dart';

class CardsDemo extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onToggleDarkMode;

  const CardsDemo({
    super.key,
    required this.darkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<CardsDemo> createState() => _CardsDemoState();
}

class _CardsDemoState extends State<CardsDemo> {

  void _handleMarkRead(BuildContext context, int id, ColorScheme scheme) {
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;

    final imageServerUrl = dotenv.env['IMAGE_SERVER_URL'] ?? 'http://localhost:8090';

    return ShowcaseScaffold(
      title: l10n.cards,
      backgroundColor: scheme.primaryContainer,
      darkMode: widget.darkMode,
      onToggleDarkMode: widget.onToggleDarkMode,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.welcomeCard, style: text.titleSmall),
          const SizedBox(height: 12),
          WelcomeCard(
            date: 'Jueves, 27 de junio',
            name: 'Clara',
            role: 'Profesora',
            avatarUrl: '$imageServerUrl/avatar_1.webp',
          ),
          const SizedBox(height: 20),

          Text(l10n.scheduleCard, style: text.titleSmall),
          const SizedBox(height: 12),
          const AppScheduleCard(
            classroom: 'Aula 65',
            group: '2º DAM',
            timeRange: '16:05 - 17:00',
            subject: 'Acceso a datos',
          ),
          const SizedBox(height: 20),

          Text(l10n.notificationCard, style: text.titleSmall),
          const SizedBox(height: 12),
          NotificationCard(
            id: 1,
            type: 'alert',
            title: 'Aviso general',
            body: 'El centro permanecerá cerrado el próximo lunes por festividad local.',
            date: DateTime.parse('2025-10-11T09:00:00Z'),
            isRead: false,
            onMarkRead: () => _handleMarkRead(context, 1, scheme)
          ),
        ],
      ),
    );
  }
}
