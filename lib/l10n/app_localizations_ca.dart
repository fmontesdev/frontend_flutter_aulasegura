// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get enterEmail => 'Introdueix el teu email';

  @override
  String get emailValidation => 'Email no válid';

  @override
  String get emailHintText => 'exemple@domini.com';

  @override
  String get enterPassword => 'Introdueix la teva contrasenya';

  @override
  String get passwordValidation => 'Mínim 8 caracters';

  @override
  String get recoverPassword => 'Recuperar contrasenya';

  @override
  String get descriptionLabel => 'Descripció';

  @override
  String get descriptionHintText => 'Afegeix una descripció...';

  @override
  String get checkFields => 'Revisa els camps';

  @override
  String loginError(Object error) {
    return 'No s\'ha pogut iniciar sessió: $error';
  }

  @override
  String get forgotPassword => 'Has oblidat la contrasenya?';

  @override
  String get login => 'Inicia sessió';

  @override
  String get show => 'Mostrar';

  @override
  String get hide => 'Amagar';

  @override
  String page(String pageName) {
    String _temp0 = intl.Intl.selectLogic(pageName, {
      'home': 'Inici',
      'map': 'Mapa',
      'reservations': 'Reserves',
      'schedules': 'Horaris',
      'notifications': 'Notificacions',
      'other': 'Desconegut',
    });
    return '$_temp0';
  }

  @override
  String get profile => 'Perfil';

  @override
  String sessionError(Object error) {
    return 'Error de sessió: $error';
  }

  @override
  String salute(String userName) {
    return 'Hola $userName!';
  }

  @override
  String role(String rolName) {
    String _temp0 = intl.Intl.selectLogic(rolName, {
      'admin': 'Administrador',
      'teacher': 'Professor',
      'janitor': 'Conserge',
      'support_staff': 'Personal auxiliar',
      'other': 'Desconegut',
    });
    return '$_temp0';
  }

  @override
  String get nfcAccess => 'Accés per NFC';

  @override
  String get qrAccess => 'Accés per QR';

  @override
  String get today => 'Hui';

  @override
  String reservationSelectorOption(String nameOption) {
    String _temp0 = intl.Intl.selectLogic(nameOption, {
      'approved': 'Aprobades',
      'pending': 'Pendents',
      'revoked': 'Cancel·lades',
      'other': 'Desconegut',
    });
    return '$_temp0';
  }

  @override
  String get requestReservation => 'Sol·licitar reserva';

  @override
  String get delete => 'Eliminar';

  @override
  String get schedule => 'Horari';

  @override
  String get slideToSeeMoreSchedules => 'Llisca per veure més horaris';

  @override
  String get searchForAvailableClassrooms => 'Buscar aules disponibles';

  @override
  String dayOfWeek(String dayName) {
    String _temp0 = intl.Intl.selectLogic(dayName, {
      'monday': 'Dilluns',
      'tuesday': 'Dimarts',
      'wednesday': 'Dimec.',
      'thursday': 'Dijous',
      'friday': 'Divend.',
      'other': 'Desconegut',
    });
    return '$_temp0';
  }

  @override
  String loadingSchedulesError(Object error) {
    return 'Error carregant horaris: $error';
  }

  @override
  String notificationSelectorOption(String nameOption) {
    String _temp0 = intl.Intl.selectLogic(nameOption, {
      'pending': 'Pend.',
      'access': 'Accessos',
      'notice': 'Avisos',
      'warning': 'Alertes',
      'all': 'Totes',
      'other': 'Desconegut',
    });
    return '$_temp0';
  }

  @override
  String markAllAsRead(int pendingCount) {
    return 'Marcar totes com a llegides ($pendingCount)';
  }

  @override
  String get allMarkedAsRead =>
      'Totes les notificacions marcades como a llegides';

  @override
  String loadingNotificationsError(Object error) {
    return 'Error carregant notificacions: $error';
  }

  @override
  String get notiMarkedAsRead => 'Notificació marcada como a llegida';

  @override
  String get undo => 'Desfer';

  @override
  String notificationTitle(String nameTitle) {
    String _temp0 = intl.Intl.selectLogic(nameTitle, {
      'approved': 'Accés aprovat',
      'denied': 'Accés denegat',
      'notice': 'Avís general',
      'warning': 'Alerta',
      'other': 'Desconegut',
    });
    return '$_temp0';
  }

  @override
  String get markAsRead => 'Marcar como a llegida';
}
