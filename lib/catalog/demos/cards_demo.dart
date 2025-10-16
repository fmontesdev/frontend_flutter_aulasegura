import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_welcome_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_schedule_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_notification_card.dart';

class CardsDemo extends StatefulWidget {
  final bool modoOscuro;
  final ValueChanged<bool> onCambioModoOscuro;

  const CardsDemo({
    super.key,
    required this.modoOscuro,
    required this.onCambioModoOscuro,
  });

  @override
  State<CardsDemo> createState() => _CardsDemoState();
}

class _CardsDemoState extends State<CardsDemo> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return ShowcaseScaffold(
      title: 'Cards',
      backgroundColor: scheme.primaryContainer,
      modoOscuro: widget.modoOscuro,
      onCambioModoOscuro: widget.onCambioModoOscuro,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Card de bienvenida', style: text.titleSmall),
          const SizedBox(height: 12),
          const AppWelcomeCard(
            date: 'Jueves, 27 de junio',
            name: 'Clara',
            role: 'Profesora',
            avatar: 'assets/images/avatar.webp',
          ),
          const SizedBox(height: 24),

          Text('Card de horario', style: text.titleSmall),
          const SizedBox(height: 12),
          const AppScheduleCard(
            classroom: 'Aula 65',
            group: '2º DAM',
            timeRange: '16:05 - 17:00',
            subject: 'Acceso a datos',
          ),
          const SizedBox(height: 24),

          Text('Card de notificación', style: text.titleSmall),
          const SizedBox(height: 12),
          const AppNotificationCard(
            icon: Icons.error_outline,
            title: 'Aviso general',
            date: '30/10/2025 10:00',
            body: 'El centro permanecerá cerrado el próximo lunes por festividad local.',
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
