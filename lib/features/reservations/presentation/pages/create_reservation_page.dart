import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_table_calendar.dart';

class CreateReservationPage extends StatelessWidget {
  const CreateReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(86),
        child: AppBar(
          backgroundColor: scheme.primary,
          elevation: 0.5,
          automaticallyImplyLeading: false, // Desactiva el botón automático
          flexibleSpace: SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft, // Alinea contenido abajo a la izquierda
                child: Row(
                children: [
                  // Flecha de retroceso
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: scheme.onPrimary,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 8),
                  // Título
                  Text(
                    'Solicitar reserva',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            AppTableCalendar(
              onDaySelected: (selectedDay) {
                // Lógica al seleccionar un día
              },
            ),
          ],
        ),
      ),
    );
  }
}