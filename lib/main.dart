import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_flutter_aulasegura/app/router.dart';

const kClaveModoOscuro = 'modoOscuro';
const kClaveIdioma = 'idioma';
const kClaveNotificaciones = 'notificaciones'; 

Future<void> main() async {
  // Asegura que los widgets estén inicializados
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa la localización para 'es_ES'
  await initializeDateFormatting('es_ES', null);

  // Leemos la preferencia antes de arrancar la app
  final preferencias = await SharedPreferences.getInstance();
  final modoOscuroGuardado = preferencias.getBool(kClaveModoOscuro) ?? false;
  final idiomaGuardado = preferencias.getString(kClaveIdioma) ?? 'es';
  final notifsGuardadas = preferencias.getBool(kClaveNotificaciones) ?? true;

  runApp(
    ProviderScope(child: MyApp(
      modoOscuroInicial: modoOscuroGuardado,
      idiomaInicial: idiomaGuardado,
      notificacionesInicial: notifsGuardadas,
    )),
  );
}

class MyApp extends StatefulWidget {
  final bool modoOscuroInicial;
  final String idiomaInicial;
  final bool notificacionesInicial;

  const MyApp({
    super.key,
    required this.modoOscuroInicial,
    required this.idiomaInicial,
    required this.notificacionesInicial,
  });

  @override
  State<MyApp> createState() => _EstadoAplicacion();
}

class _EstadoAplicacion extends State<MyApp> {
  late bool _modoOscuro;
  late String _idioma;
  late bool _notificaciones;
  late final AppRouter appRouter; 

  bool get modoOscuro => _modoOscuro;
  String get idioma => _idioma;
  bool get notificaciones => _notificaciones;

  @override
  void initState() {
    super.initState();
    _modoOscuro = widget.modoOscuroInicial;
    _idioma = widget.idiomaInicial;
    _notificaciones = widget.notificacionesInicial;

    // Inicializamos el router pasando getters y callbacks
    appRouter = AppRouter(
      getModoOscuro: () => _modoOscuro,
      getIdioma: () => _idioma,
      getNotificaciones: () => _notificaciones,
      onCambioModoOscuro: _actualizarModoOscuro,
      onCambioIdioma: _actualizarIdioma,
      onCambioNotificaciones: _actualizarNotifs,
    );
  }

  Future<void> _actualizarModoOscuro(bool valor) async {
    // Guardamos en shared_preferences
    final preferencias = await SharedPreferences.getInstance();
    await preferencias.setBool(kClaveModoOscuro, valor);

    // Actualizamos el tema en caliente
    setState(() => _modoOscuro = valor);
  }

  Future<void> _actualizarIdioma(String valor) async {
    final preferencias = await SharedPreferences.getInstance();
    await preferencias.setString(kClaveIdioma, valor);
    setState(() => _idioma = valor);
  }

  Future<void> _actualizarNotifs(bool valor) async {
    final preferencias = await SharedPreferences.getInstance();
    await preferencias.setBool(kClaveNotificaciones, valor);
    setState(() => _notificaciones = valor);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AulaSegura',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _modoOscuro ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter.router,
    );
  }
}
