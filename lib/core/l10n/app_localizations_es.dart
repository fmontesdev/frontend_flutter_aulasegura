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
      'Incorrect_password': 'Contraseña incorrecta',
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
  String get qrAccess => 'Acceso QR';

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
  String get currentPassword => 'Contraseña actual';

  @override
  String get newPassword => 'Nueva contraseña';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get newPasswordMustBeDifferent =>
      'La nueva contraseña debe ser diferente a la actual';

  @override
  String passwordStrength(String strength) {
    String _temp0 = intl.Intl.selectLogic(strength, {
      'weak': 'Débil',
      'medium': 'Media',
      'strong': 'Fuerte',
      'other': 'Desconocida',
    });
    return '$_temp0';
  }

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get saving => 'Guardando...';

  @override
  String get passwordChangedSuccessfully => 'Contraseña cambiada correctamente';

  @override
  String changePasswordError(String error) {
    String _temp0 = intl.Intl.selectLogic(error, {
      'Incorrect_current_password': 'Contraseña actual incorrecta',
      'other': 'error',
    });
    return 'No se pudo cambiar la contraseña: $_temp0';
  }

  @override
  String get requirements => 'Requisitos';

  @override
  String get minimumCharacters => 'Mínimo 8 caracteres';

  @override
  String get oneUppercaseLetter => 'Una letra mayúscula';

  @override
  String get oneLowercaseLetter => 'Una letra minúscula';

  @override
  String get oneNumber => 'Un número';

  @override
  String get preferences => 'Preferencias';

  @override
  String get darkTheme => 'Tema oscuro';

  @override
  String get lightTheme => 'Tema claro';

  @override
  String get home => 'Inicio';

  @override
  String get bringPhoneCloser => 'Acerca tu móvil al lector';

  @override
  String get validatingAccess => 'Validando acceso...';

  @override
  String get accessGranted => 'Acceso permitido';

  @override
  String get accessDenied => 'Acceso denegado';

  @override
  String accessAt(String time) {
    return 'Acceso a las $time';
  }

  @override
  String get nfcDisabled => 'NFC deshabilitado';

  @override
  String get enableNfcMessage =>
      'Por favor, habilita NFC en la configuración de tu dispositivo';

  @override
  String get openSettings => 'Abrir configuración';

  @override
  String get accessTimeout => 'Tiempo de espera agotado';

  @override
  String get understood => 'Entendido';

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

  @override
  String get development => 'Desarrollo';

  @override
  String get widgetCatalog => 'Catálogo de Widgets';

  @override
  String get exploreComponents => 'Explora los componentes de la app';

  @override
  String get listsAndTiles => 'Listas y Tiles';

  @override
  String get selectableTilesWithSwitch => 'Tiles seleccionables y con switch';

  @override
  String get selectors => 'Selectores';

  @override
  String get horizontalSlideSelectors => 'Selectores deslizables horizontales';

  @override
  String get calendars => 'Calendarios';

  @override
  String get monthlyCalendarWithSelection => 'Calendario mensual con selección';

  @override
  String get iconOptionTile => 'Lista con iconos';

  @override
  String get selectableTile => 'Lista seleccionable';

  @override
  String get activated => 'Activado';

  @override
  String get deactivated => 'Desactivado';

  @override
  String get activatedFeminine => 'Activadas';

  @override
  String get deactivatedFeminine => 'Desactivadas';

  @override
  String get simpleSelector => 'Selector Simple';

  @override
  String get singleElementSelection => 'Selección única de elementos';

  @override
  String get multipleSelector => 'Selector Múltiple';

  @override
  String get multipleElementSelection => 'Selección múltiple de elementos';

  @override
  String get selected => 'Seleccionado';

  @override
  String get selectedPlural => 'Seleccionados';

  @override
  String get tableCalendar => 'Calendario en formato tabla';

  @override
  String get monthlyCalendarWithDaySelection =>
      'Calendario mensual con selección de días';

  @override
  String get selectedDate => 'Fecha seleccionada';

  @override
  String get date => 'Fecha';

  @override
  String get componentCatalog => 'Catálogo de Componentes';

  @override
  String get components => 'Componentes';

  @override
  String get buttons => 'Botones';

  @override
  String get variantsStatesAndSizes => 'Variantes, estados y tamaños';

  @override
  String get textInputs => 'Inputs de Texto';

  @override
  String get variantsAndValidations => 'Variantes y validaciones';

  @override
  String get links => 'Links';

  @override
  String get secondaryActionLinks => 'Enlaces de acción secundarios';

  @override
  String get cards => 'Cards';

  @override
  String get differentCardsWithContent => 'Diferentes tarjetas con contenido';

  @override
  String get filters => 'Filtros';

  @override
  String get differentTypesOfFilters => 'Diferentes tipos de filtros';

  @override
  String get primaryColorButton => 'Botón color primario';

  @override
  String get secondaryColorButton => 'Botón color secundario';

  @override
  String get dangerColorButton => 'Botón color peligro';

  @override
  String get homePageButtons => 'Botones de la página de inicio';

  @override
  String get floatingActionButton => 'Botón de acción flotante (FAB)';

  @override
  String get small => 'Pequeño';

  @override
  String get medium => 'Mediano';

  @override
  String get large => 'Grande';

  @override
  String get email => 'Email';

  @override
  String get passwordToggleShowHide => 'Contraseña (toggle mostrar/ocultar)';

  @override
  String get multiline => 'Multilínea';

  @override
  String get validateInputs => 'Validar inputs';

  @override
  String get enterYourEmail => 'Introduce tu email';

  @override
  String get invalidEmail => 'Email no válido';

  @override
  String get enterYourPassword => 'Introduce tu contraseña';

  @override
  String get minimum8Characters => 'Mínimo 8 caracteres';

  @override
  String get enterDescription => 'Introduce una descripción';

  @override
  String get reviewFields => 'Revisa los campos';

  @override
  String get validatedCorrectly => 'Validado correctamente';

  @override
  String get leftAlignedSmallLink => 'Enlace a la izquierda pequeño';

  @override
  String get centeredMediumLink => 'Enlace centrado mediano';

  @override
  String get rightAlignedLargeLink => 'Enlace a la derecha grande';

  @override
  String get welcomeCard => 'Card de bienvenida';

  @override
  String get scheduleCard => 'Card de horario';

  @override
  String get notificationCard => 'Card de notificación';

  @override
  String get selectorOf5Filters => 'Selector de 5 filtros';

  @override
  String get selectorOf2Filters => 'Selector de 2 filtros';

  @override
  String get monday => 'Lunes';

  @override
  String get tuesday => 'Martes';

  @override
  String get wednesday => 'Miércoles';

  @override
  String get thursday => 'Jueves';

  @override
  String get friday => 'Viernes';

  @override
  String get saturday => 'Sábado';

  @override
  String get sunday => 'Domingo';

  @override
  String get room => 'Aula';

  @override
  String get building => 'Edificio';

  @override
  String get floor => 'Planta';

  @override
  String get userNotAuthenticated => 'Usuario no autenticado';

  @override
  String get classroomReservation => 'Reserva de aula';

  @override
  String get reservationCreatedSuccessfully => 'Reserva creada correctamente';

  @override
  String get errorCreatingReservation => 'Error al crear la reserva';

  @override
  String get pleaseSelectDate => 'Por favor selecciona una fecha';

  @override
  String get pleaseSelectSchedule => 'Por favor selecciona un horario';

  @override
  String get noAvailableClassrooms => 'No hay aulas disponibles';

  @override
  String get errorLoadingTimeSlots => 'Error cargando franjas horarias';

  @override
  String get noScheduleForThisTime => 'No hay horario para esta hora';

  @override
  String get outsideScheduledTime => 'Fuera del horario programado';

  @override
  String get inactivePermission => 'Permiso inactivo';

  @override
  String get userNotFound => 'Usuario no encontrado';

  @override
  String get readerNotFound => 'Lector no encontrado';

  @override
  String get errorTitle => 'Error';

  @override
  String get accessTime => 'Acceso a las';

  @override
  String get focusQrCode => 'Enfoca el código QR del lector';

  @override
  String accessDenialReason(String reason) {
    String _temp0 = intl.Intl.selectLogic(reason, {
      'Tag_not_found': 'Tarjeta no encontrada',
      'Inactive_tag': 'Tarjeta inactiva',
      'The_NFC_does_not_belong_to_the_authenticated_user':
          'La tarjeta NFC no pertenece al usuario autenticado',
      'Reader_not_found': 'Lector no encontrado',
      'Inactive_reader': 'Lector inactivo',
      'No_valid_permission_found': 'No se encontró un permiso válido',
      'Internal_error_while_validating_access':
          'Error interno al validar el acceso',
      'other': 'Motivo desconocido',
    });
    return '$_temp0';
  }

  @override
  String get reservationDeleted => 'Reserva eliminada';

  @override
  String get errorLoadingReservations => 'Error cargando reservas';

  @override
  String get noGroup => 'Sin grupo';

  @override
  String get noSubject => 'Sin asignatura';

  @override
  String get changeAvatar => 'Cambiar avatar';

  @override
  String get takePhoto => 'Tomar foto';

  @override
  String get selectFromGallery => 'Seleccionar de galería';

  @override
  String get avatarUpdatedSuccessfully =>
      'Foto de perfil actualizada correctamente';

  @override
  String avatarError(String error) {
    String _temp0 = intl.Intl.selectLogic(error, {
      'errorTakingPhoto': 'Error al tomar foto',
      'errorSelectingImage': 'Error al seleccionar imagen',
      'invalidImageFormat': 'Formato no permitido. Usa: jpg, jpeg, png, webp',
      'imageTooLarge': 'La imagen es muy grande. Máximo 5MB',
      'errorCompressingImage': 'Error al comprimir imagen',
      'userNotAuthenticated': 'Usuario no autenticado',
      'other': 'Error desconocido',
    });
    return '$_temp0';
  }
}
