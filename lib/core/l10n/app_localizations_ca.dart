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
  String get emailValidation => 'Email no vàlid';

  @override
  String get emailHintText => 'exemple@domini.com';

  @override
  String get enterPassword => 'Introdueix la teva contrasenya';

  @override
  String get passwordValidation =>
      'Mínim 8 caràcters, amb majúscula, minúscula, i número';

  @override
  String get recoverPassword => 'Recuperar contrasenya';

  @override
  String get descriptionLabel => 'Descripció';

  @override
  String get descriptionHintText => 'Afegeix una descripció...';

  @override
  String get checkFields => 'Revisa els camps';

  @override
  String loginError(String error) {
    String _temp0 = intl.Intl.selectLogic(error, {
      'User_not_found': 'Usuari no trobat',
      'Incorrect_password': 'Contrasenya incorrecta',
      'other': 'error',
    });
    return 'No s\'ha pogut iniciar sessió: $_temp0';
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
  String get profile => 'El meu perfil';

  @override
  String sessionError(String error) {
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
  String get qrAccess => 'Accés QR';

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
  String loadingSchedulesError(String error) {
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
      'Totes les notificacions marcades com a llegides';

  @override
  String loadingNotificationsError(Object error) {
    return 'Error carregant notificacions: $error';
  }

  @override
  String get notiMarkedAsRead => 'Notificació marcada com a llegida';

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
  String get markAsRead => 'Marcar com a llegida';

  @override
  String department(String departmentName) {
    String _temp0 = intl.Intl.selectLogic(departmentName, {
      'artes_plasticas': 'Arts Plàstiques',
      'biologia_y_geologia': 'Biologia i Geologia',
      'economia': 'Economia',
      'educacion_fisica': 'Educació Física',
      'administracion': 'Administració',
      'comercio': 'Comerç',
      'informatica': 'Informàtica',
      'filosofia': 'Filosofia',
      'fisica_y_quimica': 'Física i Química',
      'fol': 'Fol',
      'frances': 'Francés',
      'geografia_e_historia': 'Geografia i Història',
      'ingles': 'Anglés',
      'latin': 'Llatí',
      'castellano': 'Castellà',
      'valenciano': 'Valencià',
      'matematicas': 'Matemàtiques',
      'musica': 'Música',
      'orientacion': 'Orientació',
      'religion': 'Religió',
      'tecnologia': 'Tecnologia',
      'other': 'Desconegut',
    });
    return '$_temp0';
  }

  @override
  String get logout => 'Tancar sessió';

  @override
  String get security => 'Seguretat';

  @override
  String get changePassword => 'Canviar contrasenya';

  @override
  String get updatePassword => 'Actualitza la teva contrasenya';

  @override
  String get currentPassword => 'Contrasenya actual';

  @override
  String get newPassword => 'Nova contrasenya';

  @override
  String get confirmPassword => 'Confirmar contrasenya';

  @override
  String get passwordsDoNotMatch => 'Les contrasenyes no coincideixen';

  @override
  String get newPasswordMustBeDifferent =>
      'La nova contrasenya ha de ser diferent de l\'actual';

  @override
  String passwordStrength(String strength) {
    String _temp0 = intl.Intl.selectLogic(strength, {
      'weak': 'Feble',
      'medium': 'Mitjana',
      'strong': 'Forta',
      'other': 'Desconeguda',
    });
    return '$_temp0';
  }

  @override
  String get saveChanges => 'Guardar canvis';

  @override
  String get saving => 'Guardant...';

  @override
  String get passwordChangedSuccessfully => 'Contrasenya canviada correctament';

  @override
  String changePasswordError(String error) {
    String _temp0 = intl.Intl.selectLogic(error, {
      'Incorrect_current_password': 'Contrasenya actual incorrecta',
      'other': 'error',
    });
    return 'No s\'ha pogut canviar la contrasenya: $_temp0';
  }

  @override
  String get requirements => 'Requisits';

  @override
  String get minimumCharacters => 'Mínim 8 caràcters';

  @override
  String get oneUppercaseLetter => 'Una lletra majúscula';

  @override
  String get oneLowercaseLetter => 'Una lletra minúscula';

  @override
  String get oneNumber => 'Un número';

  @override
  String get preferences => 'Preferències';

  @override
  String get darkTheme => 'Tema fosc';

  @override
  String get lightTheme => 'Tema clar';

  @override
  String get home => 'Inici';

  @override
  String get bringPhoneCloser => 'Apropa el teu mòbil al lector';

  @override
  String get validatingAccess => 'Validant accés...';

  @override
  String get accessGranted => 'Accés permès';

  @override
  String get accessDenied => 'Accés denegat';

  @override
  String accessAt(String time) {
    return 'Accés a les $time';
  }

  @override
  String get nfcDisabled => 'NFC deshabilitat';

  @override
  String get enableNfcMessage =>
      'Si us plau, habilita NFC a la configuració del teu dispositiu';

  @override
  String get openSettings => 'Obrir configuració';

  @override
  String get accessTimeout => 'Temps d\'espera esgotat';

  @override
  String get understood => 'Entès';

  @override
  String onOff(String boolean) {
    String _temp0 = intl.Intl.selectLogic(boolean, {
      'true': 'Activat',
      'false': 'Desactivat',
      'other': 'Desconegut',
    });
    return '$_temp0';
  }

  @override
  String get language => 'Idioma';

  @override
  String languageName(String languageTag) {
    String _temp0 = intl.Intl.selectLogic(languageTag, {
      'es': 'Castellà',
      'ca': 'Valencià',
      'en': 'Anglés',
      'other': 'Desconegut',
    });
    return '$_temp0';
  }

  @override
  String get notifications => 'Notificacions';

  @override
  String onOffFemeninPlural(String boolean) {
    String _temp0 = intl.Intl.selectLogic(boolean, {
      'true': 'Activades',
      'false': 'Desactivades',
      'other': 'Desconegut',
    });
    return '$_temp0';
  }

  @override
  String get development => 'Desenvolupament';

  @override
  String get widgetCatalog => 'Catàleg de Widgets';

  @override
  String get exploreComponents => 'Explora els components de l\'app';

  @override
  String get listsAndTiles => 'Llistes i Tiles';

  @override
  String get selectableTilesWithSwitch => 'Tiles seleccionables i amb switch';

  @override
  String get selectors => 'Selectors';

  @override
  String get horizontalSlideSelectors => 'Selectors lliscants horitzontals';

  @override
  String get calendars => 'Calendaris';

  @override
  String get monthlyCalendarWithSelection => 'Calendari mensual amb selecció';

  @override
  String get iconOptionTile => 'Llista amb icones';

  @override
  String get selectableTile => 'Llista seleccionable';

  @override
  String get activated => 'Activat';

  @override
  String get deactivated => 'Desactivat';

  @override
  String get activatedFeminine => 'Activades';

  @override
  String get deactivatedFeminine => 'Desactivades';

  @override
  String get simpleSelector => 'Selector Simple';

  @override
  String get singleElementSelection => 'Selecció única d\'elements';

  @override
  String get multipleSelector => 'Selector Múltiple';

  @override
  String get multipleElementSelection => 'Selecció múltiple d\'elements';

  @override
  String get selected => 'Seleccionat';

  @override
  String get selectedPlural => 'Seleccionats';

  @override
  String get tableCalendar => 'Calendari en format taula';

  @override
  String get monthlyCalendarWithDaySelection =>
      'Calendari mensual amb selecció de dies';

  @override
  String get selectedDate => 'Data seleccionada';

  @override
  String get date => 'Data';

  @override
  String get componentCatalog => 'Catàleg de Components';

  @override
  String get components => 'Components';

  @override
  String get buttons => 'Botons';

  @override
  String get variantsStatesAndSizes => 'Variants, estats i mides';

  @override
  String get textInputs => 'Inputs de Text';

  @override
  String get variantsAndValidations => 'Variants i validacions';

  @override
  String get links => 'Enllaços';

  @override
  String get secondaryActionLinks => 'Enllaços d\'acció secundaris';

  @override
  String get cards => 'Targetes';

  @override
  String get differentCardsWithContent => 'Diferents targetes amb contingut';

  @override
  String get filters => 'Filtres';

  @override
  String get differentTypesOfFilters => 'Diferents tipus de filtres';

  @override
  String get primaryColorButton => 'Botó color primari';

  @override
  String get secondaryColorButton => 'Botó color secundari';

  @override
  String get dangerColorButton => 'Botó color perill';

  @override
  String get homePageButtons => 'Botons de la pàgina d\'inici';

  @override
  String get floatingActionButton => 'Botó d\'acció flotant (FAB)';

  @override
  String get small => 'Petit';

  @override
  String get medium => 'Mitjà';

  @override
  String get large => 'Gran';

  @override
  String get email => 'Email';

  @override
  String get passwordToggleShowHide => 'Contrasenya (canviar mostrar/ocultar)';

  @override
  String get multiline => 'Multilínia';

  @override
  String get validateInputs => 'Validar inputs';

  @override
  String get enterYourEmail => 'Introdueix el teu email';

  @override
  String get invalidEmail => 'Email no vàlid';

  @override
  String get enterYourPassword => 'Introdueix la teva contrasenya';

  @override
  String get minimum8Characters => 'Mínim 8 caràcters';

  @override
  String get enterDescription => 'Introdueix una descripció';

  @override
  String get reviewFields => 'Revisa els camps';

  @override
  String get validatedCorrectly => 'Validat correctament';

  @override
  String get leftAlignedSmallLink => 'Enllaç a l\'esquerra petit';

  @override
  String get centeredMediumLink => 'Enllaç centrat mitjà';

  @override
  String get rightAlignedLargeLink => 'Enllaç a la dreta gran';

  @override
  String get welcomeCard => 'Targeta de benvinguda';

  @override
  String get scheduleCard => 'Targeta d\'horari';

  @override
  String get notificationCard => 'Targeta de notificació';

  @override
  String get selectorOf5Filters => 'Selector de 5 filtres';

  @override
  String get selectorOf2Filters => 'Selector de 2 filtres';

  @override
  String get monday => 'Dilluns';

  @override
  String get tuesday => 'Dimarts';

  @override
  String get wednesday => 'Dimecres';

  @override
  String get thursday => 'Dijous';

  @override
  String get friday => 'Divendres';

  @override
  String get saturday => 'Dissabte';

  @override
  String get sunday => 'Diumenge';

  @override
  String get room => 'Aula';

  @override
  String get building => 'Edifici';

  @override
  String get floor => 'Planta';

  @override
  String get userNotAuthenticated => 'Usuari no autenticat';

  @override
  String get classroomReservation => 'Reserva d\'aula';

  @override
  String get reservationCreatedSuccessfully => 'Reserva creada correctament';

  @override
  String get errorCreatingReservation => 'Error en crear la reserva';

  @override
  String get pleaseSelectDate => 'Si us plau selecciona una data';

  @override
  String get pleaseSelectSchedule => 'Si us plau selecciona un horari';

  @override
  String get noAvailableClassrooms => 'No hi ha aules disponibles';

  @override
  String get errorLoadingTimeSlots => 'Error carregant franges horàries';

  @override
  String get noScheduleForThisTime => 'No hi ha horari per a aquesta hora';

  @override
  String get outsideScheduledTime => 'Fora de l\'horari programat';

  @override
  String get inactivePermission => 'Permís inactiu';

  @override
  String get userNotFound => 'Usuari no trobat';

  @override
  String get readerNotFound => 'Lector no trobat';

  @override
  String get errorTitle => 'Error';

  @override
  String get accessTime => 'Accés a les';

  @override
  String get focusQrCode => 'Enfoca el codi QR del lector';

  @override
  String accessDenialReason(String reason) {
    String _temp0 = intl.Intl.selectLogic(reason, {
      'Tag_not_found': 'Targeta no trobada',
      'Inactive_tag': 'Targeta inactiva',
      'The_NFC_does_not_belong_to_the_authenticated_user':
          'La targeta NFC no pertany a l\'usuari autenticat',
      'Reader_not_found': 'Lector no trobat',
      'Inactive_reader': 'Lector inactiu',
      'No_valid_permission_found': 'No s\'ha trobat un permís vàlid',
      'Internal_error_while_validating_access':
          'Error intern al validar l\'accés',
      'other': 'Motiu desconegut',
    });
    return '$_temp0';
  }

  @override
  String get reservationDeleted => 'Reserva eliminada';

  @override
  String get errorLoadingReservations => 'Error carregant reserves';

  @override
  String get noGroup => 'Sense grup';

  @override
  String get noSubject => 'Sense assignatura';

  @override
  String get changeAvatar => 'Canviar avatar';

  @override
  String get takePhoto => 'Fer foto';

  @override
  String get selectFromGallery => 'Seleccionar de la galeria';

  @override
  String get avatarUpdatedSuccessfully =>
      'Foto de perfil actualitzada correctament';

  @override
  String avatarError(String error) {
    String _temp0 = intl.Intl.selectLogic(error, {
      'errorTakingPhoto': 'Error en prendre foto',
      'errorSelectingImage': 'Error en seleccionar imatge',
      'invalidImageFormat': 'Format no permés. Usa: jpg, jpeg, png, webp',
      'imageTooLarge': 'La imatge és massa gran. Màxim 5MB',
      'errorCompressingImage': 'Error en comprimir imatge',
      'userNotAuthenticated': 'Usuari no autenticat',
      'other': 'Error desconegut',
    });
    return '$_temp0';
  }
}
