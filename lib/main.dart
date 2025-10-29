import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/app/router.dart';
import 'package:frontend_flutter_aulasegura/features/preferences/presentation/providers/preferences_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que los widgets estén inicializados
  await initializeDateFormatting('es_ES', null); // Inicializa la localización para 'es_ES'

  runApp(const ProviderScope(child: MyApp()),);
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(preferencesProvider);

    final darkMode = prefsAsync.maybeWhen(
      data: (p) => p.darkMode,
      orElse: () => false,
    );

    final language = prefsAsync.maybeWhen(
      data: (p) => p.language,
      orElse: () => 'es',
    );

    final notifications = prefsAsync.maybeWhen(
      data: (p) => p.notifications,
      orElse: () => false,
    );

    return MaterialApp.router(
      title: 'AulaSegura',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: darkMode! ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router,
    );
  }
}
