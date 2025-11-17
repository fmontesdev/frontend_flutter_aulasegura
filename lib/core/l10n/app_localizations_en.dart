// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get emailValidation => 'Invalid email';

  @override
  String get emailHintText => 'example@domain.com';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get passwordValidation =>
      'Minimum 8 characters, with uppercase, lowercase, and number';

  @override
  String get recoverPassword => 'Recover password';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get descriptionHintText => 'Add a description...';

  @override
  String get checkFields => 'Check the fields';

  @override
  String loginError(String error) {
    String _temp0 = intl.Intl.selectLogic(error, {
      'User_not_found': 'User not found',
      'other': 'error',
    });
    return 'We couldn\'t log in: $_temp0';
  }

  @override
  String get forgotPassword => 'Did you forget your password?';

  @override
  String get login => 'Log in';

  @override
  String get show => 'Show';

  @override
  String get hide => 'Hide';

  @override
  String page(String pageName) {
    String _temp0 = intl.Intl.selectLogic(pageName, {
      'home': 'Home',
      'map': 'Map',
      'reservations': 'Reservations',
      'schedules': 'Schedules',
      'notifications': 'Notifications',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get profile => 'My profile';

  @override
  String sessionError(String error) {
    return 'Session error: $error';
  }

  @override
  String salute(String userName) {
    return 'Hello $userName!';
  }

  @override
  String role(String rolName) {
    String _temp0 = intl.Intl.selectLogic(rolName, {
      'admin': 'Administrator',
      'teacher': 'Teacher',
      'janitor': 'Janitor',
      'support_staff': 'Support staff',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get nfcAccess => 'NFC access';

  @override
  String get qrAccess => 'QR access';

  @override
  String get today => 'Today';

  @override
  String reservationSelectorOption(String nameOption) {
    String _temp0 = intl.Intl.selectLogic(nameOption, {
      'approved': 'Approved',
      'pending': 'Pending',
      'revoked': 'Revoked',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get requestReservation => 'Request reservation';

  @override
  String get delete => 'Delete';

  @override
  String get schedule => 'Schedule';

  @override
  String get slideToSeeMoreSchedules => 'Slide to see more schedules';

  @override
  String get searchForAvailableClassrooms => 'Search for available classrooms';

  @override
  String dayOfWeek(String dayName) {
    String _temp0 = intl.Intl.selectLogic(dayName, {
      'monday': 'Mon.',
      'tuesday': 'Tues.',
      'wednesday': 'Wed.',
      'thursday': 'Thurs.',
      'friday': 'Fri.',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String loadingSchedulesError(String error) {
    return 'Loading schedules error: $error';
  }

  @override
  String notificationSelectorOption(String nameOption) {
    String _temp0 = intl.Intl.selectLogic(nameOption, {
      'pending': 'Pend.',
      'access': 'Access',
      'notice': 'Notice',
      'warning': 'Warning',
      'all': 'All',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String markAllAsRead(int pendingCount) {
    return 'Mark all as read ($pendingCount)';
  }

  @override
  String get allMarkedAsRead => 'All notifications marked as read';

  @override
  String loadingNotificationsError(Object error) {
    return 'Loading notifications error: $error';
  }

  @override
  String get notiMarkedAsRead => 'Notification marked as read';

  @override
  String get undo => 'Undo';

  @override
  String notificationTitle(String nameTitle) {
    String _temp0 = intl.Intl.selectLogic(nameTitle, {
      'approved': 'Access approved',
      'denied': 'Access denied',
      'notice': 'General notice',
      'warning': 'Warning',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get markAsRead => 'Mark as read';

  @override
  String department(String departmentName) {
    String _temp0 = intl.Intl.selectLogic(departmentName, {
      'artes_plasticas': 'Visual Arts',
      'biologia_y_geologia': 'Biology and Geology',
      'economia': 'Economics',
      'educacion_fisica': 'Physical Education',
      'administracion': 'Business Administration',
      'comercio': 'Commerce',
      'informatica': 'Computer Science',
      'filosofia': 'Philosophy',
      'fisica_y_quimica': 'Physics and Chemistry',
      'fol': 'Fol',
      'frances': 'French',
      'geografia_e_historia': 'Geography and History',
      'ingles': 'English',
      'latin': 'Latin',
      'castellano': 'Spanish',
      'valenciano': 'Valencian',
      'matematicas': 'Mathematics',
      'musica': 'Music',
      'orientacion': 'Guidance',
      'religion': 'Religion',
      'tecnologia': 'Technology',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get logout => 'Log out';

  @override
  String get security => 'Security';

  @override
  String get changePassword => 'Change password';

  @override
  String get updatePassword => 'Update your password';

  @override
  String get preferences => 'Preferences';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String onOff(String boolean) {
    String _temp0 = intl.Intl.selectLogic(boolean, {
      'true': 'On',
      'false': 'Off',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get language => 'Language';

  @override
  String languageName(String languageTag) {
    String _temp0 = intl.Intl.selectLogic(languageTag, {
      'es': 'Spanish',
      'ca': 'Valencian',
      'en': 'English',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get notifications => 'Notifications';

  @override
  String onOffFemeninPlural(String boolean) {
    String _temp0 = intl.Intl.selectLogic(boolean, {
      'true': 'On',
      'false': 'Off',
      'other': 'Unknown',
    });
    return '$_temp0';
  }
}
