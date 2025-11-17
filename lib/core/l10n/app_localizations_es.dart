// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get enterEmail => 'Introduce tu email';

  @override
  String get emailValidation => 'Email no válido';

  @override
  String get emailHintText => 'ejemplo@dominio.com';

  @override
  String get enterPassword => 'Introduce tu contraseña';

  @override
  String get passwordValidation =>
      'Mínimo 8 caracteres, con mayúscula, minúscula, y número';

  @override
  String get recoverPassword => 'Recuperar contraseña';

  @override
  String get descriptionLabel => 'Descripción';

  @override
  String get descriptionHintText => 'Añade una descripción...';

  @override
  String get checkFields => 'Revisa los campos';

  @override
  String loginError(String error) {
    String _temp0 = intl.Intl.selectLogic(error, {
      'User_not_found': 'Usuario no encontrado',
      'other': 'error',
    });
    return 'No se pudo iniciar sesión: $_temp0';
  }

  @override
  String get forgotPassword => '¿Se te olvidó la contraseña?';

  @override
  String get login => 'Inicia sesión';

  @override
  String get show => 'Mostrar';

  @override
  String get hide => 'Ocultar';

  @override
  String page(String pageName) {
    String _temp0 = intl.Intl.selectLogic(pageName, {
      'home': 'Inicio',
      'map': 'Mapa',
      'reservations': 'Reservas',
      'schedules': 'Horarios',
      'notifications': 'Notificaciones',
      'other': 'Desconocido',
    });
    return '$_temp0';
  }

  @override
  String get profile => 'Mi perfil';

  @override
  String sessionError(String error) {
    return 'Error de sesión: $error';
  }

  @override
  String salute(String userName) {
    return 'Hola $userName!';
  }

  @override
  String role(String rolName) {
    String _temp0 = intl.Intl.selectLogic(rolName, {
      'admin': 'Administrador',
      'teacher': 'Profesor',
      'janitor': 'Conserje',
      'support_staff': 'Personal auxiliar',
      'other': 'Desconocido',
    });
    return '$_temp0';
  }

  @override
  String get nfcAccess => 'Acceso por NFC';

  @override
  String get qrAccess => 'Acceso por QR';

  @override
  String get today => 'Hoy';

  @override
  String reservationSelectorOption(String nameOption) {
    String _temp0 = intl.Intl.selectLogic(nameOption, {
      'approved': 'Aprobadas',
      'pending': 'Pendientes',
      'revoked': 'Canceladas',
      'other': 'Desconocido',
    });
    return '$_temp0';
  }

  @override
  String get requestReservation => 'Solicitar reserva';

  @override
  String get delete => 'Eliminar';

  @override
  String get schedule => 'Horario';

  @override
  String get slideToSeeMoreSchedules => 'Desliza para ver más horarios';

  @override
  String get searchForAvailableClassrooms => 'Buscar aulas disponibles';

  @override
  String dayOfWeek(String dayName) {
    String _temp0 = intl.Intl.selectLogic(dayName, {
      'monday': 'Lunes',
      'tuesday': 'Martes',
      'wednesday': 'Miérc.',
      'thursday': 'Jueves',
      'friday': 'Viernes',
      'other': 'Desconocido',
    });
    return '$_temp0';
  }

  @override
  String loadingSchedulesError(String error) {
    return 'Error cargando horarios: $error';
  }

  @override
  String notificationSelectorOption(String nameOption) {
    String _temp0 = intl.Intl.selectLogic(nameOption, {
      'pending': 'Pend.',
      'access': 'Accesos',
      'notice': 'Avisos',
      'warning': 'Alertas',
      'all': 'Todas',
      'other': 'Desconocido',
    });
    return '$_temp0';
  }

  @override
  String markAllAsRead(int pendingCount) {
    return 'Marcar todas como leídas ($pendingCount)';
  }

  @override
  String get allMarkedAsRead => 'Todas las notificaciones marcadas como leídas';

  @override
  String loadingNotificationsError(Object error) {
    return 'Error cargando notificaciones: $error';
  }

  @override
  String get notiMarkedAsRead => 'Notificación marcada como leida';

  @override
  String get undo => 'Deshacer';

  @override
  String notificationTitle(String nameTitle) {
    String _temp0 = intl.Intl.selectLogic(nameTitle, {
      'approved': 'Acceso aprobado',
      'denied': 'Acceso denegado',
      'notice': 'Aviso general',
      'warning': 'Alerta',
      'other': 'Desconocido',
    });
    return '$_temp0';
  }

  @override
  String get markAsRead => 'Marcar como leida';

  @override
  String department(String departmentName) {
    String _temp0 = intl.Intl.selectLogic(departmentName, {
      'artes_plasticas': 'Artes Plásticas',
      'biologia_y_geologia': 'Biología y Geología',
      'economia': 'Economía',
      'educacion_fisica': 'Educación Física',
      'administracion': 'Administración',
      'comercio': 'Comercio',
      'informatica': 'Informática',
      'filosofia': 'Filosofía',
      'fisica_y_quimica': 'Física y Química',
      'fol': 'Fol',
      'frances': 'Francés',
      'geografia_e_historia': 'Geografía e Historia',
      'ingles': 'Inglés',
      'latin': 'Latín',
      'castellano': 'Castellano',
      'valenciano': 'Valenciano',
      'matematicas': 'Matemáticas',
      'musica': 'Música',
      'orientacion': 'Orientación',
      'religion': 'Religión',
      'tecnologia': 'Tecnología',
      'other': 'Desconocido',
    });
    return '$_temp0';
  }

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get security => 'Seguridad';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get updatePassword => 'Actualiza tu contraseña';

  @override
  String get preferences => 'Preferencias';

  @override
  String get darkTheme => 'Tema oscuro';

  @override
  String onOff(String boolean) {
    String _temp0 = intl.Intl.selectLogic(boolean, {
      'true': 'Activado',
      'false': 'Desactivado',
      'other': 'Desconocido',
    });
    return '$_temp0';
  }

  @override
  String get language => 'Idioma';

  @override
  String languageName(String languageTag) {
    String _temp0 = intl.Intl.selectLogic(languageTag, {
      'es': 'Castellano',
      'ca': 'Valenciano',
      'en': 'Inglés',
      'other': 'Desconocido',
    });
    return '$_temp0';
  }

  @override
  String get notifications => 'Notificaciones';

  @override
  String onOffFemeninPlural(String boolean) {
    String _temp0 = intl.Intl.selectLogic(boolean, {
      'true': 'Activadas',
      'false': 'Desactivadas',
      'other': 'Desconocido',
    });
    return '$_temp0';
  }
}
