import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ca.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ca'),
    Locale('en'),
    Locale('es'),
  ];

  /// Static message (enter your email)
  ///
  /// In es, this message translates to:
  /// **'Introduce tu email'**
  String get enterEmail;

  /// Static message (invalid email)
  ///
  /// In es, this message translates to:
  /// **'Email no válido'**
  String get emailValidation;

  /// Static message (example@domain.com)
  ///
  /// In es, this message translates to:
  /// **'ejemplo@dominio.com'**
  String get emailHintText;

  /// Static message (enter your password)
  ///
  /// In es, this message translates to:
  /// **'Introduce tu contraseña'**
  String get enterPassword;

  /// Static message (minimum 8 characters)
  ///
  /// In es, this message translates to:
  /// **'Mínimo 8 caracteres'**
  String get passwordValidation;

  /// Static message (recover password)
  ///
  /// In es, this message translates to:
  /// **'Recuperar contraseña'**
  String get recoverPassword;

  /// Static message (description)
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get descriptionLabel;

  /// Static message (add a description)
  ///
  /// In es, this message translates to:
  /// **'Añade una descripción...'**
  String get descriptionHintText;

  /// Static message (check the fields)
  ///
  /// In es, this message translates to:
  /// **'Revisa los campos'**
  String get checkFields;

  /// Error message (login) with dynamic parameter (error)
  ///
  /// In es, this message translates to:
  /// **'No se pudo iniciar sesión: {error}'**
  String loginError(Object error);

  /// Static message (Did you forget your password?)
  ///
  /// In es, this message translates to:
  /// **'¿Se te olvidó la contraseña?'**
  String get forgotPassword;

  /// Static message (login)
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión'**
  String get login;

  /// Static message (show)
  ///
  /// In es, this message translates to:
  /// **'Mostrar'**
  String get show;

  /// Static message (hide)
  ///
  /// In es, this message translates to:
  /// **'Ocultar'**
  String get hide;

  /// Localized page by pageName
  ///
  /// In es, this message translates to:
  /// **'{pageName, select, home{Inicio} map{Mapa} reservations{Reservas} schedules{Horarios} notifications{Notificaciones} other{Desconocido}}'**
  String page(String pageName);

  /// Static message (my profile)
  ///
  /// In es, this message translates to:
  /// **'Mi perfil'**
  String get profile;

  /// Error message (loading session) with dynamic parameter (error)
  ///
  /// In es, this message translates to:
  /// **'Error de sesión: {error}'**
  String sessionError(Object error);

  /// Message (salute) with dynamic parameter (username)
  ///
  /// In es, this message translates to:
  /// **'Hola {userName}!'**
  String salute(String userName);

  /// Localized role by roleName
  ///
  /// In es, this message translates to:
  /// **'{rolName, select, admin{Administrador} teacher{Profesor} janitor{Conserje} support_staff{Personal auxiliar} other{Desconocido}}'**
  String role(String rolName);

  /// Static message (access type)
  ///
  /// In es, this message translates to:
  /// **'Acceso por NFC'**
  String get nfcAccess;

  /// Static message (access type)
  ///
  /// In es, this message translates to:
  /// **'Acceso por QR'**
  String get qrAccess;

  /// Static message (today)
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get today;

  /// No description provided for @reservationSelectorOption.
  ///
  /// In es, this message translates to:
  /// **'{nameOption, select, approved{Aprobadas} pending{Pendientes} revoked{Canceladas} other{Desconocido}}'**
  String reservationSelectorOption(String nameOption);

  /// Static message (request reservation)
  ///
  /// In es, this message translates to:
  /// **'Solicitar reserva'**
  String get requestReservation;

  /// Static message (delete)
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// Static message (schedule)
  ///
  /// In es, this message translates to:
  /// **'Horario'**
  String get schedule;

  /// Static message (slide to see more schedules)
  ///
  /// In es, this message translates to:
  /// **'Desliza para ver más horarios'**
  String get slideToSeeMoreSchedules;

  /// Static message (search for available classrooms)
  ///
  /// In es, this message translates to:
  /// **'Buscar aulas disponibles'**
  String get searchForAvailableClassrooms;

  /// Localized day of week by dayName
  ///
  /// In es, this message translates to:
  /// **'{dayName, select, monday{Lunes} tuesday{Martes} wednesday{Miérc.} thursday{Jueves} friday{Viernes} other{Desconocido}}'**
  String dayOfWeek(String dayName);

  /// Error message (loading schedules) with dynamic parameter (error)
  ///
  /// In es, this message translates to:
  /// **'Error cargando horarios: {error}'**
  String loadingSchedulesError(Object error);

  /// Localized notification selector option by nameOption
  ///
  /// In es, this message translates to:
  /// **'{nameOption, select, pending{Pend.} access{Accesos} notice{Avisos} warning{Alertas} all{Todas} other{Desconocido}}'**
  String notificationSelectorOption(String nameOption);

  /// Botton message (mark all as read) with dynamic parameter (pendingCount)
  ///
  /// In es, this message translates to:
  /// **'Marcar todas como leídas ({pendingCount})'**
  String markAllAsRead(int pendingCount);

  /// Snackbar message when marking all as read
  ///
  /// In es, this message translates to:
  /// **'Todas las notificaciones marcadas como leídas'**
  String get allMarkedAsRead;

  /// Error message (loading notifications) with dynamic parameter (error)
  ///
  /// In es, this message translates to:
  /// **'Error cargando notificaciones: {error}'**
  String loadingNotificationsError(Object error);

  /// Static message (Notification marked as read)
  ///
  /// In es, this message translates to:
  /// **'Notificación marcada como leida'**
  String get notiMarkedAsRead;

  /// Static message (undo)
  ///
  /// In es, this message translates to:
  /// **'Deshacer'**
  String get undo;

  /// Localized notification title option by nameTitle
  ///
  /// In es, this message translates to:
  /// **'{nameTitle, select, approved{Acceso aprobado} denied{Acceso denegado} notice{Aviso general} warning{Alerta} other{Desconocido}}'**
  String notificationTitle(String nameTitle);

  /// Static message (Mark as read)
  ///
  /// In es, this message translates to:
  /// **'Marcar como leida'**
  String get markAsRead;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ca', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca':
      return AppLocalizationsCa();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
