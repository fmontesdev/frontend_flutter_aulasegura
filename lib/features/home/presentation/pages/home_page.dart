import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_welcome_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_button.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_schedule_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key,});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text   = Theme.of(context).textTheme;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          // Card de bienvenida
          const AppWelcomeCard(
            date: '30 de Octubre de 2025',
            name: 'Clara',
            role: 'Profesora',
            avatar: 'assets/images/avatar.webp',
          ),
          const SizedBox(height: 18),

          // Título “Acceder al aula”
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Acceso',
                textAlign: TextAlign.center,
                style: text.titleLarge?.copyWith(
                  fontSize: 21,
                  color: scheme.titles,
                  height: 0.9,
                ),
              ),
            ),
          ),
          // const SizedBox(height: 12),

          // Botones NFC + QR
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
              const SizedBox(width: 16),
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
          // const SizedBox(height: 18),

          // Título “Hoy”
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Hoy',
                textAlign: TextAlign.center,
                style: text.titleLarge?.copyWith(
                  fontSize: 21,
                  color: scheme.titles,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Horarios
          const AppScheduleCard(
            classroom: 'Aula 55',
            group: '2º DAW',
            timeRange: '10:00 - 11:00',
            subject: 'Digitalización',
          ),
          const SizedBox(height: 13),
          const AppScheduleCard(
            classroom: 'Aula 63',
            group: '2º DAM',
            timeRange: '11:00 - 12:00',
            subject: 'Sostenibilidad',
          ),
          const SizedBox(height: 13),
          const AppScheduleCard(
            classroom: 'Aula 55',
            group: '2º DAW',
            timeRange: '12:00 - 13:00',
            subject: 'Despliegue',
          ),
          const SizedBox(height: 13),
          const AppScheduleCard(
            classroom: 'Aula 60',
            group: '1º DAW',
            timeRange: '13:00 - 14:00',
            subject: 'Proyecto intermodular I',
          ),
        ],
      ),
    );
  }
}