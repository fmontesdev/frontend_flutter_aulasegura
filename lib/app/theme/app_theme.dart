import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_palette.dart';

class AppTheme {
  // ================== Tipografías ==================

  static final TextTheme _textTheme = const TextTheme(
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),

    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),

    bodyLarge: TextStyle(fontSize: 16, height: 1.4),
    bodyMedium: TextStyle(fontSize: 14, height: 1.4),
    bodySmall: TextStyle(fontSize: 12, height: 1.4),

    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    labelSmall: TextStyle(fontSize: 11, letterSpacing: 0.2),
  );

  // ================== ColorSchemes ==================

  static final ColorScheme _lightScheme = ColorScheme.light(
    primary: appPaletteLight.primary,
    onPrimary: appPaletteLight.onPrimary,
    secondary: appPaletteLight.secondary,
    onSecondary: appPaletteLight.onSecondary,
    tertiary: appPaletteLight.tertiary,
    onTertiary: appPaletteLight.onTertiary,
    primaryContainer: appPaletteLight.primaryContainer,
    onPrimaryContainer: appPaletteLight.onPrimaryContainer,
    outline: appPaletteLight.outline,
    error: appPaletteLight.error,
    onError: appPaletteLight.onError,
  );

  static final ColorScheme _darkScheme = ColorScheme.dark(
    primary: appPaletteDark.primary,
    onPrimary: appPaletteDark.onPrimary,
    secondary: appPaletteDark.secondary,
    onSecondary: appPaletteDark.onSecondary,
    tertiary: appPaletteDark.tertiary,
    onTertiary: appPaletteDark.onTertiary,
    primaryContainer: appPaletteDark.primaryContainer,
    onPrimaryContainer: appPaletteDark.onPrimaryContainer,
    outline: appPaletteDark.outline,
    error: appPaletteDark.error,
    onError: appPaletteDark.onError,
  );

  // ================== elevatedButton ==================

  static ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme scheme) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(48, 40)),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        elevation: const WidgetStatePropertyAll(2),
        shape: const WidgetStatePropertyAll(StadiumBorder()),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return scheme.primary.withValues(alpha: 0.38);
          }
          return scheme.primary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return scheme.onPrimary.withValues(alpha: 0.38);
          }
          return scheme.onPrimary;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          final base = scheme.onPrimary;
          if (states.contains(WidgetState.pressed)) return base.withValues(alpha: 0.20);
          if (states.contains(WidgetState.hovered)) return base.withValues(alpha: 0.10);
          if (states.contains(WidgetState.focused)) return base.withValues(alpha: 0.15);
          return null;
        }),
      ),
    );
  }

  // ================== iconButton ==================

  static IconButtonThemeData _iconButtonTheme(ColorScheme scheme) {
    return IconButtonThemeData(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return scheme.onSurface.withValues(alpha: 0.38);
          }
          return scheme.primary;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          final base = scheme.primary;
          if (states.contains(WidgetState.pressed)) return base.withValues(alpha: 0.20);
          if (states.contains(WidgetState.hovered)) return base.withValues(alpha: 0.08);
          if (states.contains(WidgetState.focused)) return base.withValues(alpha: 0.12);
          return null;
        }),
      ),
    );
  }

  // ================== appBar ==================

  static AppBarTheme _appBarTheme(TextTheme textTheme, ColorScheme scheme) {
    return AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: false, // norma global; cámbiala si prefieres centrado
      titleTextStyle: textTheme.titleLarge?.copyWith(color: scheme.onSurface),
      toolbarHeight: 56,
      iconTheme: IconThemeData(color: scheme.onSurface),
      actionsIconTheme: IconThemeData(color: scheme.onSurface),
    );
  }

  // ================== switch ==================

  static SwitchThemeData _switchTheme(ColorScheme scheme) {
    return SwitchThemeData(
      // Color del "thumb" (círculo)
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurface.withValues(alpha: 0.38);
        }
        return states.contains(WidgetState.selected)
            ? scheme.onPrimary // thumb cuando está ON
            : scheme.onSurfaceVariant; // thumb cuando está OFF
      }),
      // Color de la "track" (pista)
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurface.withValues(alpha: 0.12);
        }
        return states.contains(WidgetState.selected)
            ? scheme.secondary // track ON
            : scheme.onPrimaryContainer;  // track OFF
      }),
      // Contorno de la pista (opcional; útil en OFF)
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurface.withValues(alpha: 0.12);
        }
        return states.contains(WidgetState.selected)
            ? scheme.secondary
            : scheme.secondary;
      }),
      // Efectos de interacción
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) return scheme.primary.withValues(alpha: 0.15);
        if (states.contains(WidgetState.hovered)) return scheme.primary.withValues(alpha: 0.1);
        if (states.contains(WidgetState.focused)) return scheme.primary.withValues(alpha: 0.15);
        return null;
      }),
    );
  }

  /// ================== Temas ==================

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _lightScheme,
    textTheme: _textTheme,
    elevatedButtonTheme: _elevatedButtonTheme(_lightScheme),
    iconButtonTheme: _iconButtonTheme(_lightScheme),
    appBarTheme: _appBarTheme(_textTheme, _lightScheme),
    switchTheme: _switchTheme(_lightScheme),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: _darkScheme,
    textTheme: _textTheme,
    elevatedButtonTheme: _elevatedButtonTheme(_darkScheme),
    iconButtonTheme: _iconButtonTheme(_darkScheme),
    appBarTheme: _appBarTheme(_textTheme, _darkScheme),
    switchTheme: _switchTheme(_darkScheme),
  );
}

/// Extensión para añadir success/warning al ColorScheme.
/// Usa automáticamente la paleta light/dark según el tema activo.

extension AppColorScheme on ColorScheme {
  Color get success => brightness == Brightness.dark
      ? appPaletteDark.success
      : appPaletteLight.success;

  Color get onSuccess => brightness == Brightness.dark
      ? appPaletteDark.onSuccess
      : appPaletteLight.onSuccess;

  Color get warning => brightness == Brightness.dark
      ? appPaletteDark.warning
      : appPaletteLight.warning;

  Color get onWarning => brightness == Brightness.dark
      ? appPaletteDark.onWarning
      : appPaletteLight.onWarning;
}