import 'package:flutter/material.dart';

class AppPalette {
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color tertiary;
  final Color onTertiary;
  final Color quatertiary;
  final Color onQuatertiary;
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
  final Color darkGrey;
  final Color grey;
  final Color lightGrey;
  final Color highlight;
  final Color titles;
  final Color card;
  final Color lightRed;
  final Color onLightRed;

  const AppPalette({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.onTertiary,
    required this.quatertiary,
    required this.onQuatertiary,
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
    required this.darkGrey,
    required this.grey,
    required this.lightGrey,
    required this.highlight,
    required this.titles,
    required this.card,
    required this.lightRed,
    required this.onLightRed,
  });
}

/// Paleta para tema claro
const appPaletteLight = AppPalette(
  primary: Color(0xFF182D73),
  onPrimary: Colors.white,
  secondary: Color(0xFF306AC6),
  onSecondary: Colors.white,
  tertiary: Color(0xFF3B82F6),
  onTertiary: Colors.white,
  quatertiary: Color(0xFFABC7F5),
  onQuatertiary: Colors.black,
  primaryContainer: Color(0xFFF3F7FB),
  onPrimaryContainer: Colors.black,
  // surface: Color(0xFFF2F2F2),
  // onSurface: Colors.black,
  outline: Color(0xFFA7F3D0),
  success: Color(0xFF2EB872),
  onSuccess: Colors.white,
  warning: Color(0xFFF59E0B),
  onWarning: Colors.white,
  error: Color(0xFFDC2626),
  onError: Colors.white,
  darkGrey: Color(0xFF404040),
  grey: Color(0xFF808080),
  lightGrey: Color(0xFFD3D3D3),
  highlight: Color(0xFF182D73),
  titles: Color.fromARGB(255, 127, 172, 245),
  // titles2: Color(0xFF99BCE6),
  card: Color(0xFFFFFFFF),
  lightRed: Color(0xFFFFEAEA),
  onLightRed: Color.fromARGB(255, 233, 104, 104),
);

/// Paleta para tema oscuro (ajusta los contrastes)
const appPaletteDark = AppPalette(
  primary: Color(0xFF182D73),
  onPrimary: Colors.white,
  secondary: Color(0xFF306AC6),
  onSecondary: Color(0xFF262626),
  tertiary: Color(0xFF3B82F6),
  onTertiary: Colors.black,
  quatertiary: Color(0xFFABC7F5),
  onQuatertiary: Colors.black,
  primaryContainer: Color(0xFF171717),
  onPrimaryContainer: Colors.white,
  // surface: Color(0xFF071A12),
  // onSurface: Color(0xFF0B0B0B),
  outline: Color(0xFFA7F3D0),
  success: Color(0xFF2EB872),
  onSuccess: Color(0xFF0B0B0B),
  warning: Color(0xFFF59E0B),
  onWarning: Color(0xFF0B0B0B),
  error: Color(0xFFDC2626),
  onError: Colors.white,
  darkGrey: Color(0xFF404040),
  grey: Color(0xFF808080),
  lightGrey: Color(0xFFD3D3D3),
  highlight: Colors.white,
  titles: Color(0xFF535353),
  card: Color(0xFF1E1E1E),
  lightRed: Color.fromARGB(255, 166, 13, 13),
  onLightRed: Colors.white,
);

/// Devuelve la paleta adecuada según el brillo del tema activo.
AppPalette appPaletteOf(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return isDark ? appPaletteDark : appPaletteLight;
}
