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
  String get passwordValidation => 'Mínimo 8 caracteres';

  @override
  String get recoverPassword => 'Recuperar contraseña';

  @override
  String get descriptionLabel => 'Descripción';

  @override
  String get descriptionHintText => 'Añade una descripción...';

  @override
  String get checkFields => 'Revisa los campos';

  @override
  String loginError(Object error) {
    return 'No se pudo iniciar sesión: $error';
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
  String sessionError(Object error) {
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
  String loadingSchedulesError(Object error) {
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
}
