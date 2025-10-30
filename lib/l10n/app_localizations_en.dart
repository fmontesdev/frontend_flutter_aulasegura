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
  String get passwordValidation => 'Minimum 8 characters';

  @override
  String get recoverPassword => 'Recover password';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get descriptionHintText => 'Add a description...';

  @override
  String get checkFields => 'Check the fields';

  @override
  String loginError(Object error) {
    return 'We could not log in: $error';
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
  String get profile => 'Profile';

  @override
  String sessionError(Object error) {
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
  String loadingSchedulesError(Object error) {
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
}
