import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_palette.dart';

class AppTheme {
  // ================== Tipografías ==================

  static final TextTheme _textTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 62, fontWeight: FontWeight.w700),
    
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),

    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),

    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
    bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, height: 1.5),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.5),

    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 11, letterSpacing: 0.2, fontWeight: FontWeight.w500),
    
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

  // ================== ElevatedButton ==================

  static ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme scheme) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(48, 40)),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        elevation: const WidgetStatePropertyAll(2),
        shadowColor: WidgetStatePropertyAll(scheme.onPrimaryContainer.withValues(alpha: 0.25)),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
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

  // ================== IconButton ==================

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

  // ================== AppBar ==================

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

  // ================== Switch ==================

  static SwitchThemeData _switchTheme(ColorScheme scheme) {
    return SwitchThemeData(
      // Color del "thumb" (círculo)
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurface.withValues(alpha: 0.38);
        }
        return states.contains(WidgetState.selected)
            ? scheme.onPrimary // thumb cuando está ON
            : scheme.onPrimary; // thumb cuando está OFF
      }),
      // Color de la "track" (pista)
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurface.withValues(alpha: 0.12);
        }
        return states.contains(WidgetState.selected)
            ? scheme.secondary // track ON
            : scheme.tertiary; // track OFF
      }),
      // Contorno de la pista (opcional; útil en OFF)
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurface.withValues(alpha: 0.12);
        }
        return states.contains(WidgetState.selected)
            ? scheme.secondary // contorno ON
            : scheme.quatertiary; // contorno OFF
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

  // ================== NavigationBar ==================

  static NavigationBarThemeData _navBarTheme(ColorScheme scheme) {
    return NavigationBarThemeData(
      height: 56,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide, // Muestra solo iconos
      backgroundColor: scheme.surface,
      elevation: 5, // Sombra superior vía elevación
      shadowColor: scheme.primary, // Color de la sombra
      // surfaceTintColor: scheme.surfaceTint, // Controla el tinte de superficie
      indicatorColor: scheme.secondary.withValues(alpha: 0.12), // Indicador seleccionado
      indicatorShape: const StadiumBorder(), // Indicador con bordes redondeados
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final isSelected = states.contains(WidgetState.selected);
        return TextStyle(
          fontWeight: FontWeight.w600,
          color: isSelected ? scheme.primary : scheme.onSurfaceVariant,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final isSelected = states.contains(WidgetState.selected);
        return IconThemeData(
          color: isSelected ? scheme.primary : scheme.primary.withValues(alpha: 0.75),
          size: 30,
        );
      }),
    );
  }

  // ================== BottomSheet ==================

  static BottomSheetThemeData _bottomSheetTheme(ColorScheme scheme) {
    return BottomSheetThemeData(
      backgroundColor: scheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      elevation: 8,
      modalElevation: 8,
      shadowColor: scheme.onPrimaryContainer.withValues(alpha: 0.25),
      dragHandleColor: scheme.lightGrey, // Color del “pill”
      dragHandleSize: const Size(38, 4), // Ancho y alto
    );
  }

  // ================== Divider ==================

  static DividerThemeData _dividerTheme(ColorScheme scheme) {
    return DividerThemeData(
      color: scheme.lightGrey,
      space: 20,
      thickness: 1,
      indent: 12,
      endIndent: 12,
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
    navigationBarTheme: _navBarTheme(_lightScheme),
    bottomSheetTheme: _bottomSheetTheme(_lightScheme),
    dividerTheme: _dividerTheme(_lightScheme),
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
    navigationBarTheme: _navBarTheme(_darkScheme),
    bottomSheetTheme: _bottomSheetTheme(_darkScheme),
    dividerTheme: _dividerTheme(_darkScheme),
  );
}

/// Extensión para añadir success/warning al ColorScheme.
/// Usa automáticamente la paleta light/dark según el tema activo.

extension AppColorScheme on ColorScheme {
  Color get quatertiary => brightness == Brightness.dark
    ? appPaletteDark.quatertiary
    : appPaletteLight.quatertiary;

  Color get onQuatertiary => brightness == Brightness.dark
      ? appPaletteDark.onQuatertiary
      : appPaletteLight.onQuatertiary;

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

  Color get darkGrey => brightness == Brightness.dark
    ? appPaletteDark.darkGrey
    : appPaletteLight.darkGrey;
  
  Color get grey => brightness == Brightness.dark
    ? appPaletteDark.grey
    : appPaletteLight.grey;

  Color get lightGrey => brightness == Brightness.dark
    ? appPaletteDark.lightGrey
    : appPaletteLight.lightGrey;

  Color get highlight => brightness == Brightness.dark
    ? appPaletteDark.highlight
    : appPaletteLight.highlight;

  Color get titles => brightness == Brightness.dark
    ? appPaletteDark.titles
    : appPaletteLight.titles;

  Color get card => brightness == Brightness.dark
    ? appPaletteDark.card
    : appPaletteLight.card;

  Color get lightRed => brightness == Brightness.dark
      ? appPaletteDark.lightRed
      : appPaletteLight.lightRed;

  Color get onLightRed => brightness == Brightness.dark
    ? appPaletteDark.onLightRed
    : appPaletteLight.onLightRed;
}