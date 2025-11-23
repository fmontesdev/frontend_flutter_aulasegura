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

  /// Static message (password validation)
  ///
  /// In es, this message translates to:
  /// **'Mínimo 8 caracteres, con mayúscula, minúscula, y número'**
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
  /// **'No se pudo iniciar sesión: {error, select, User_not_found{Usuario no encontrado} Incorrect_password{Contraseña incorrecta} other{error}}'**
  String loginError(String error);

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
  String sessionError(String error);

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

  /// Static message (qr access)
  ///
  /// In es, this message translates to:
  /// **'Acceso QR'**
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
  String loadingSchedulesError(String error);

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

  /// Localized department by departmentName
  ///
  /// In es, this message translates to:
  /// **'{departmentName, select, artes_plasticas{Artes Plásticas} biologia_y_geologia{Biología y Geología} economia{Economía} educacion_fisica{Educación Física} administracion{Administración} comercio{Comercio} informatica{Informática} filosofia{Filosofía} fisica_y_quimica{Física y Química} fol{Fol} frances{Francés} geografia_e_historia{Geografía e Historia} ingles{Inglés} latin{Latín} castellano{Castellano} valenciano{Valenciano} matematicas{Matemáticas} musica{Música} orientacion{Orientación} religion{Religión} tecnologia{Tecnología} other{Desconocido}}'**
  String department(String departmentName);

  /// Static message (logout)
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get logout;

  /// Static message (security)
  ///
  /// In es, this message translates to:
  /// **'Seguridad'**
  String get security;

  /// Static message (change password)
  ///
  /// In es, this message translates to:
  /// **'Cambiar contraseña'**
  String get changePassword;

  /// Static message (update password)
  ///
  /// In es, this message translates to:
  /// **'Actualiza tu contraseña'**
  String get updatePassword;

  /// Static message (current password)
  ///
  /// In es, this message translates to:
  /// **'Contraseña actual'**
  String get currentPassword;

  /// Static message (new password)
  ///
  /// In es, this message translates to:
  /// **'Nueva contraseña'**
  String get newPassword;

  /// Static message (confirm password)
  ///
  /// In es, this message translates to:
  /// **'Confirmar contraseña'**
  String get confirmPassword;

  /// Error message (passwords do not match)
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get passwordsDoNotMatch;

  /// Error message (new password must be different from current)
  ///
  /// In es, this message translates to:
  /// **'La nueva contraseña debe ser diferente a la actual'**
  String get newPasswordMustBeDifferent;

  /// Localized password strength
  ///
  /// In es, this message translates to:
  /// **'{strength, select, weak{Débil} medium{Media} strong{Fuerte} other{Desconocida}}'**
  String passwordStrength(String strength);

  /// Static message (save changes)
  ///
  /// In es, this message translates to:
  /// **'Guardar cambios'**
  String get saveChanges;

  /// Static message (saving)
  ///
  /// In es, this message translates to:
  /// **'Guardando...'**
  String get saving;

  /// Success message (password changed)
  ///
  /// In es, this message translates to:
  /// **'Contraseña cambiada correctamente'**
  String get passwordChangedSuccessfully;

  /// Error message (change password) with dynamic parameter (error)
  ///
  /// In es, this message translates to:
  /// **'No se pudo cambiar la contraseña: {error, select, Incorrect_current_password{Contraseña actual incorrecta} other{error}}'**
  String changePasswordError(String error);

  /// Static message (requirements)
  ///
  /// In es, this message translates to:
  /// **'Requisitos'**
  String get requirements;

  /// Static message (minimum 8 characters)
  ///
  /// In es, this message translates to:
  /// **'Mínimo 8 caracteres'**
  String get minimumCharacters;

  /// Static message (one uppercase letter)
  ///
  /// In es, this message translates to:
  /// **'Una letra mayúscula'**
  String get oneUppercaseLetter;

  /// Static message (one lowercase letter)
  ///
  /// In es, this message translates to:
  /// **'Una letra minúscula'**
  String get oneLowercaseLetter;

  /// Static message (one number)
  ///
  /// In es, this message translates to:
  /// **'Un número'**
  String get oneNumber;

  /// Static message (preferences)
  ///
  /// In es, this message translates to:
  /// **'Preferencias'**
  String get preferences;

  /// Static message (dark theme)
  ///
  /// In es, this message translates to:
  /// **'Tema oscuro'**
  String get darkTheme;

  /// Static message (light theme)
  ///
  /// In es, this message translates to:
  /// **'Tema claro'**
  String get lightTheme;

  /// Static message (home)
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get home;

  /// Static message (NFC instruction)
  ///
  /// In es, this message translates to:
  /// **'Acerca tu móvil al lector'**
  String get bringPhoneCloser;

  /// Static message (processing access)
  ///
  /// In es, this message translates to:
  /// **'Validando acceso...'**
  String get validatingAccess;

  /// Static message (access granted)
  ///
  /// In es, this message translates to:
  /// **'Acceso permitido'**
  String get accessGranted;

  /// Static message (access denied)
  ///
  /// In es, this message translates to:
  /// **'Acceso denegado'**
  String get accessDenied;

  /// Access timestamp
  ///
  /// In es, this message translates to:
  /// **'Acceso a las {time}'**
  String accessAt(String time);

  /// Static message (NFC disabled)
  ///
  /// In es, this message translates to:
  /// **'NFC deshabilitado'**
  String get nfcDisabled;

  /// Static message (enable NFC message)
  ///
  /// In es, this message translates to:
  /// **'Por favor, habilita NFC en la configuración de tu dispositivo'**
  String get enableNfcMessage;

  /// Static message (open settings button)
  ///
  /// In es, this message translates to:
  /// **'Abrir configuración'**
  String get openSettings;

  /// Static message (timeout error)
  ///
  /// In es, this message translates to:
  /// **'Tiempo de espera agotado'**
  String get accessTimeout;

  /// Static message (understood button)
  ///
  /// In es, this message translates to:
  /// **'Entendido'**
  String get understood;

  /// Localized action by boolean
  ///
  /// In es, this message translates to:
  /// **'{boolean, select, true{Activado} false{Desactivado} other{Desconocido}}'**
  String onOff(String boolean);

  /// Static message (language)
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get language;

  /// Localized language by languageTag
  ///
  /// In es, this message translates to:
  /// **'{languageTag, select, es{Castellano} ca{Valenciano} en{Inglés} other{Desconocido}}'**
  String languageName(String languageTag);

  /// Static message (notifications)
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notifications;

  /// No description provided for @onOffFemeninPlural.
  ///
  /// In es, this message translates to:
  /// **'{boolean, select, true{Activadas} false{Desactivadas} other{Desconocido}}'**
  String onOffFemeninPlural(String boolean);

  /// Static message (development)
  ///
  /// In es, this message translates to:
  /// **'Desarrollo'**
  String get development;

  /// Static message (widget catalog)
  ///
  /// In es, this message translates to:
  /// **'Catálogo de Widgets'**
  String get widgetCatalog;

  /// Static message (explore components)
  ///
  /// In es, this message translates to:
  /// **'Explora los componentes de la app'**
  String get exploreComponents;

  /// Static message (lists and tiles)
  ///
  /// In es, this message translates to:
  /// **'Listas y Tiles'**
  String get listsAndTiles;

  /// Static message (selectable tiles with switch)
  ///
  /// In es, this message translates to:
  /// **'Tiles seleccionables y con switch'**
  String get selectableTilesWithSwitch;

  /// Static message (selectors)
  ///
  /// In es, this message translates to:
  /// **'Selectores'**
  String get selectors;

  /// Static message (horizontal slide selectors)
  ///
  /// In es, this message translates to:
  /// **'Selectores deslizables horizontales'**
  String get horizontalSlideSelectors;

  /// Static message (calendars)
  ///
  /// In es, this message translates to:
  /// **'Calendarios'**
  String get calendars;

  /// Static message (monthly calendar with selection)
  ///
  /// In es, this message translates to:
  /// **'Calendario mensual con selección'**
  String get monthlyCalendarWithSelection;

  /// Static message (IconOptionTile)
  ///
  /// In es, this message translates to:
  /// **'Lista con iconos'**
  String get iconOptionTile;

  /// Static message (SelectableTile)
  ///
  /// In es, this message translates to:
  /// **'Lista seleccionable'**
  String get selectableTile;

  /// Static message (activated - masculine)
  ///
  /// In es, this message translates to:
  /// **'Activado'**
  String get activated;

  /// Static message (deactivated - masculine)
  ///
  /// In es, this message translates to:
  /// **'Desactivado'**
  String get deactivated;

  /// Static message (activated - feminine plural)
  ///
  /// In es, this message translates to:
  /// **'Activadas'**
  String get activatedFeminine;

  /// Static message (deactivated - feminine plural)
  ///
  /// In es, this message translates to:
  /// **'Desactivadas'**
  String get deactivatedFeminine;

  /// Static message (simple selector)
  ///
  /// In es, this message translates to:
  /// **'Selector Simple'**
  String get simpleSelector;

  /// Static message (single element selection)
  ///
  /// In es, this message translates to:
  /// **'Selección única de elementos'**
  String get singleElementSelection;

  /// Static message (multiple selector)
  ///
  /// In es, this message translates to:
  /// **'Selector Múltiple'**
  String get multipleSelector;

  /// Static message (multiple element selection)
  ///
  /// In es, this message translates to:
  /// **'Selección múltiple de elementos'**
  String get multipleElementSelection;

  /// Static message (selected - singular)
  ///
  /// In es, this message translates to:
  /// **'Seleccionado'**
  String get selected;

  /// Static message (selected - plural)
  ///
  /// In es, this message translates to:
  /// **'Seleccionados'**
  String get selectedPlural;

  /// Static message (table calendar)
  ///
  /// In es, this message translates to:
  /// **'Calendario en formato tabla'**
  String get tableCalendar;

  /// Static message (monthly calendar with day selection)
  ///
  /// In es, this message translates to:
  /// **'Calendario mensual con selección de días'**
  String get monthlyCalendarWithDaySelection;

  /// Static message (selected date)
  ///
  /// In es, this message translates to:
  /// **'Fecha seleccionada'**
  String get selectedDate;

  /// Static message (date)
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get date;

  /// Static message (component catalog)
  ///
  /// In es, this message translates to:
  /// **'Catálogo de Componentes'**
  String get componentCatalog;

  /// Static message (components)
  ///
  /// In es, this message translates to:
  /// **'Componentes'**
  String get components;

  /// Static message (buttons)
  ///
  /// In es, this message translates to:
  /// **'Botones'**
  String get buttons;

  /// Static message (variants, states and sizes)
  ///
  /// In es, this message translates to:
  /// **'Variantes, estados y tamaños'**
  String get variantsStatesAndSizes;

  /// Static message (text inputs)
  ///
  /// In es, this message translates to:
  /// **'Inputs de Texto'**
  String get textInputs;

  /// Static message (variants and validations)
  ///
  /// In es, this message translates to:
  /// **'Variantes y validaciones'**
  String get variantsAndValidations;

  /// Static message (links)
  ///
  /// In es, this message translates to:
  /// **'Links'**
  String get links;

  /// Static message (secondary action links)
  ///
  /// In es, this message translates to:
  /// **'Enlaces de acción secundarios'**
  String get secondaryActionLinks;

  /// Static message (cards)
  ///
  /// In es, this message translates to:
  /// **'Cards'**
  String get cards;

  /// Static message (different cards with content)
  ///
  /// In es, this message translates to:
  /// **'Diferentes tarjetas con contenido'**
  String get differentCardsWithContent;

  /// Static message (filters)
  ///
  /// In es, this message translates to:
  /// **'Filtros'**
  String get filters;

  /// Static message (different types of filters)
  ///
  /// In es, this message translates to:
  /// **'Diferentes tipos de filtros'**
  String get differentTypesOfFilters;

  /// Static message (primary color button)
  ///
  /// In es, this message translates to:
  /// **'Botón color primario'**
  String get primaryColorButton;

  /// Static message (secondary color button)
  ///
  /// In es, this message translates to:
  /// **'Botón color secundario'**
  String get secondaryColorButton;

  /// Static message (danger color button)
  ///
  /// In es, this message translates to:
  /// **'Botón color peligro'**
  String get dangerColorButton;

  /// Static message (home page buttons)
  ///
  /// In es, this message translates to:
  /// **'Botones de la página de inicio'**
  String get homePageButtons;

  /// Static message (floating action button FAB)
  ///
  /// In es, this message translates to:
  /// **'Botón de acción flotante (FAB)'**
  String get floatingActionButton;

  /// Static message (small)
  ///
  /// In es, this message translates to:
  /// **'Pequeño'**
  String get small;

  /// Static message (medium)
  ///
  /// In es, this message translates to:
  /// **'Mediano'**
  String get medium;

  /// Static message (large)
  ///
  /// In es, this message translates to:
  /// **'Grande'**
  String get large;

  /// Static message (email)
  ///
  /// In es, this message translates to:
  /// **'Email'**
  String get email;

  /// Static message (password toggle show/hide)
  ///
  /// In es, this message translates to:
  /// **'Contraseña (toggle mostrar/ocultar)'**
  String get passwordToggleShowHide;

  /// Static message (multiline)
  ///
  /// In es, this message translates to:
  /// **'Multilínea'**
  String get multiline;

  /// Static message (validate inputs)
  ///
  /// In es, this message translates to:
  /// **'Validar inputs'**
  String get validateInputs;

  /// Static message (enter your email)
  ///
  /// In es, this message translates to:
  /// **'Introduce tu email'**
  String get enterYourEmail;

  /// Static message (invalid email)
  ///
  /// In es, this message translates to:
  /// **'Email no válido'**
  String get invalidEmail;

  /// Static message (enter your password)
  ///
  /// In es, this message translates to:
  /// **'Introduce tu contraseña'**
  String get enterYourPassword;

  /// Static message (minimum 8 characters)
  ///
  /// In es, this message translates to:
  /// **'Mínimo 8 caracteres'**
  String get minimum8Characters;

  /// Static message (enter description)
  ///
  /// In es, this message translates to:
  /// **'Introduce una descripción'**
  String get enterDescription;

  /// Static message (review fields)
  ///
  /// In es, this message translates to:
  /// **'Revisa los campos'**
  String get reviewFields;

  /// Static message (validated correctly)
  ///
  /// In es, this message translates to:
  /// **'Validado correctamente'**
  String get validatedCorrectly;

  /// Static message (left aligned small link)
  ///
  /// In es, this message translates to:
  /// **'Enlace a la izquierda pequeño'**
  String get leftAlignedSmallLink;

  /// Static message (centered medium link)
  ///
  /// In es, this message translates to:
  /// **'Enlace centrado mediano'**
  String get centeredMediumLink;

  /// Static message (right aligned large link)
  ///
  /// In es, this message translates to:
  /// **'Enlace a la derecha grande'**
  String get rightAlignedLargeLink;

  /// Static message (welcome card)
  ///
  /// In es, this message translates to:
  /// **'Card de bienvenida'**
  String get welcomeCard;

  /// Static message (schedule card)
  ///
  /// In es, this message translates to:
  /// **'Card de horario'**
  String get scheduleCard;

  /// Static message (notification card)
  ///
  /// In es, this message translates to:
  /// **'Card de notificación'**
  String get notificationCard;

  /// Static message (selector of 5 filters)
  ///
  /// In es, this message translates to:
  /// **'Selector de 5 filtros'**
  String get selectorOf5Filters;

  /// Static message (selector of 2 filters)
  ///
  /// In es, this message translates to:
  /// **'Selector de 2 filtros'**
  String get selectorOf2Filters;

  /// Static message (monday)
  ///
  /// In es, this message translates to:
  /// **'Lunes'**
  String get monday;

  /// Static message (tuesday)
  ///
  /// In es, this message translates to:
  /// **'Martes'**
  String get tuesday;

  /// Static message (wednesday)
  ///
  /// In es, this message translates to:
  /// **'Miércoles'**
  String get wednesday;

  /// Static message (thursday)
  ///
  /// In es, this message translates to:
  /// **'Jueves'**
  String get thursday;

  /// Static message (friday)
  ///
  /// In es, this message translates to:
  /// **'Viernes'**
  String get friday;

  /// Static message (saturday)
  ///
  /// In es, this message translates to:
  /// **'Sábado'**
  String get saturday;

  /// Static message (sunday)
  ///
  /// In es, this message translates to:
  /// **'Domingo'**
  String get sunday;

  /// Static message (room)
  ///
  /// In es, this message translates to:
  /// **'Aula'**
  String get room;

  /// Static message (building)
  ///
  /// In es, this message translates to:
  /// **'Edificio'**
  String get building;

  /// Static message (floor)
  ///
  /// In es, this message translates to:
  /// **'Planta'**
  String get floor;

  /// Static message (user not authenticated)
  ///
  /// In es, this message translates to:
  /// **'Usuario no autenticado'**
  String get userNotAuthenticated;

  /// Static message (classroom reservation)
  ///
  /// In es, this message translates to:
  /// **'Reserva de aula'**
  String get classroomReservation;

  /// Static message (reservation created successfully)
  ///
  /// In es, this message translates to:
  /// **'Reserva creada correctamente'**
  String get reservationCreatedSuccessfully;

  /// Static message (error creating reservation)
  ///
  /// In es, this message translates to:
  /// **'Error al crear la reserva'**
  String get errorCreatingReservation;

  /// Static message (please select date)
  ///
  /// In es, this message translates to:
  /// **'Por favor selecciona una fecha'**
  String get pleaseSelectDate;

  /// Static message (please select schedule)
  ///
  /// In es, this message translates to:
  /// **'Por favor selecciona un horario'**
  String get pleaseSelectSchedule;

  /// Static message (no available classrooms)
  ///
  /// In es, this message translates to:
  /// **'No hay aulas disponibles'**
  String get noAvailableClassrooms;

  /// Static message (error loading time slots)
  ///
  /// In es, this message translates to:
  /// **'Error cargando franjas horarias'**
  String get errorLoadingTimeSlots;

  /// Static message (no schedule for this time)
  ///
  /// In es, this message translates to:
  /// **'No hay horario para esta hora'**
  String get noScheduleForThisTime;

  /// Static message (outside scheduled time)
  ///
  /// In es, this message translates to:
  /// **'Fuera del horario programado'**
  String get outsideScheduledTime;

  /// Static message (inactive permission)
  ///
  /// In es, this message translates to:
  /// **'Permiso inactivo'**
  String get inactivePermission;

  /// Static message (user not found)
  ///
  /// In es, this message translates to:
  /// **'Usuario no encontrado'**
  String get userNotFound;

  /// Static message (reader not found)
  ///
  /// In es, this message translates to:
  /// **'Lector no encontrado'**
  String get readerNotFound;

  /// Static message (error title)
  ///
  /// In es, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// Static message (access time)
  ///
  /// In es, this message translates to:
  /// **'Acceso a las'**
  String get accessTime;

  /// Static message (focus the reader's QR code)
  ///
  /// In es, this message translates to:
  /// **'Enfoca el código QR del lector'**
  String get focusQrCode;

  /// Localized access denial reason by reason code
  ///
  /// In es, this message translates to:
  /// **'{reason, select, Tag_not_found{Tarjeta no encontrada} Inactive_tag{Tarjeta inactiva} The_NFC_does_not_belong_to_the_authenticated_user{La tarjeta NFC no pertenece al usuario autenticado} Reader_not_found{Lector no encontrado} Inactive_reader{Lector inactivo} No_valid_permission_found{No se encontró un permiso válido} Internal_error_while_validating_access{Error interno al validar el acceso} other{Motivo desconocido}}'**
  String accessDenialReason(String reason);

  /// Static message (reservation deleted)
  ///
  /// In es, this message translates to:
  /// **'Reserva eliminada'**
  String get reservationDeleted;

  /// Static message (error loading reservations)
  ///
  /// In es, this message translates to:
  /// **'Error cargando reservas'**
  String get errorLoadingReservations;
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
