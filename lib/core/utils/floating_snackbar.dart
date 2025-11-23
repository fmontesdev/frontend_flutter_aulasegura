import 'package:flutter/material.dart';

/// Muestra un SnackBar flotante
void showFloatingSnackBar(
  BuildContext context, {
  required String message,
  bool isError = false,
  Duration duration = const Duration(seconds: 3),
}) {
  final scheme = Theme.of(context).colorScheme;
  final messenger = ScaffoldMessenger.of(context);
  
  messenger.removeCurrentSnackBar(); // Elimina cualquier SnackBar existente antes de mostrar uno nuevo
  messenger.showSnackBar(
    SnackBar(
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: isError ? scheme.error : scheme.primary,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    ),
  );
}
