import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/catalog/catalog_page.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kClaveModoOscuro = 'modoOscuro';
const kClaveIdioma = 'idioma';
const kClaveNotificaciones = 'notificaciones'; 

Future<void> main() async {
  // Asegura que los widgets estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Leemos la preferencia antes de arrancar la app
  final preferencias = await SharedPreferences.getInstance();
  final modoOscuroGuardado = preferencias.getBool(kClaveModoOscuro) ?? false;
  final idiomaGuardado = preferencias.getString(kClaveIdioma) ?? 'es';
  final notifsGuardadas = preferencias.getBool(kClaveNotificaciones) ?? true;

  runApp(
    Aplicacion(
      modoOscuroInicial: modoOscuroGuardado,
      idiomaInicial: idiomaGuardado,
      notificacionesInicial: notifsGuardadas,
    ),
  );
}

class Aplicacion extends StatefulWidget {
  final bool modoOscuroInicial;
  final String idiomaInicial;
  final bool notificacionesInicial;

  const Aplicacion({
    super.key,
    required this.modoOscuroInicial,
    required this.idiomaInicial,
    required this.notificacionesInicial,
  });

  @override
  State<Aplicacion> createState() => _EstadoAplicacion();
}

class _EstadoAplicacion extends State<Aplicacion> {
  late bool _modoOscuro;
  late String _idioma;
  late bool _notificaciones;

  bool get modoOscuro => _modoOscuro;
  String get idioma => _idioma;
  bool get notificaciones => _notificaciones;

  @override
  void initState() {
    super.initState();
    _modoOscuro = widget.modoOscuroInicial;
    _idioma = widget.idiomaInicial;
    _notificaciones = widget.notificacionesInicial;
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

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Catálogo de Componentes',
  //     debugShowCheckedModeBanner: false,
  //     theme: AppTheme.light,
  //     darkTheme: AppTheme.dark,
  //     themeMode: _modoOscuro ? ThemeMode.dark : ThemeMode.light,
  //     home: CatalogPage(
  //       modoOscuro: _modoOscuro,
  //       idioma: _idioma,
  //       notificaciones: _notificaciones, 
  //       onCambioModoOscuro: _actualizarModoOscuro,
  //       onCambioIdioma: _actualizarIdioma,
  //       onCambioNotificaciones: _actualizarNotifs,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AulaSegura',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _modoOscuro ? ThemeMode.dark : ThemeMode.light,
      home: LoginPage(
        // modoOscuro: _modoOscuro,
        // idioma: _idioma,
        // notificaciones: _notificaciones, 
        // onCambioModoOscuro: _actualizarModoOscuro,
        // onCambioIdioma: _actualizarIdioma,
        // onCambioNotificaciones: _actualizarNotifs,
      ),
    );
  }
}

