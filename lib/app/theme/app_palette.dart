import 'package:flutter/material.dart';

class AppPalette {
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color tertiary;
  final Color onTertiary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  // final Color surface;
  // final Color onSurface;
  final Color outline;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color error;
  final Color onError;

  const AppPalette({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.onTertiary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    // required this.surface,
    // required this.onSurface,
    required this.outline,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.error,
    required this.onError,
  });
}

/// Paleta para tema claro
const appPaletteLight = AppPalette(
  primary: Color(0xFF1F3A5F),
  onPrimary: Colors.white,
  secondary: Color(0xFF3D78B8),
  onSecondary: Colors.white,
  // tertiary: Color(0xFF2A9D8F),
  tertiary: Color(0xFFBCD5F3),
  onTertiary: Colors.black,
  primaryContainer: Color.fromARGB(255, 244, 248, 255),
  onPrimaryContainer: Colors.white,
  // surface: Color(0xFFF2F2F2),
  // onSurface: Colors.black,
  outline: Color(0xFFA7F3D0),
  success: Color(0xFF2EB872),
  onSuccess: Colors.white,
  warning: Color(0xFFF59E0B),
  onWarning: Colors.white,
  error: Color(0xFFDC2626),
  onError: Colors.white,
);

/// Paleta para tema oscuro (ajusta los contrastes)
const appPaletteDark = AppPalette(
  primary: Color(0xFF1F3A5F),
  onPrimary: Colors.white,
  secondary: Color(0xFF3D78B8),
  onSecondary: Colors.white,
  tertiary: Color(0xFFBCD5F3),
  onTertiary: Colors.white,
  primaryContainer: Color(0xFF5C6B7A),
  onPrimaryContainer: Color(0xFF0B0B0B),
  // surface: Color(0xFF071A12),
  // onSurface: Color(0xFF0B0B0B),
  outline: Color(0xFFA7F3D0),
  success: Color(0xFF2EB872),
  onSuccess: Color(0xFF0B0B0B),
  warning: Color(0xFFF59E0B),
  onWarning: Color(0xFF0B0B0B),
  error: Color(0xFFDC2626),
  onError: Colors.white,
);

/// Devuelve la paleta adecuada según el brillo del tema activo.
AppPalette appPaletteOf(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return isDark ? appPaletteDark : appPaletteLight;
}
