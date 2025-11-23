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
      'Incorrect_password': 'Incorrect password',
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
  String get qrAccess => 'QR Access';

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
  String get currentPassword => 'Current password';

  @override
  String get newPassword => 'New password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get newPasswordMustBeDifferent =>
      'New password must be different from current password';

  @override
  String passwordStrength(String strength) {
    String _temp0 = intl.Intl.selectLogic(strength, {
      'weak': 'Weak',
      'medium': 'Medium',
      'strong': 'Strong',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get saveChanges => 'Save changes';

  @override
  String get saving => 'Saving...';

  @override
  String get passwordChangedSuccessfully => 'Password changed successfully';

  @override
  String changePasswordError(String error) {
    String _temp0 = intl.Intl.selectLogic(error, {
      'Incorrect_current_password': 'Incorrect current password',
      'other': 'error',
    });
    return 'Could not change password: $_temp0';
  }

  @override
  String get requirements => 'Requirements';

  @override
  String get minimumCharacters => 'Minimum 8 characters';

  @override
  String get oneUppercaseLetter => 'One uppercase letter';

  @override
  String get oneLowercaseLetter => 'One lowercase letter';

  @override
  String get oneNumber => 'One number';

  @override
  String get preferences => 'Preferences';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get lightTheme => 'Light theme';

  @override
  String get home => 'Home';

  @override
  String get bringPhoneCloser => 'Bring your phone closer to the reader';

  @override
  String get validatingAccess => 'Validating access...';

  @override
  String get accessGranted => 'Access granted';

  @override
  String get accessDenied => 'Access denied';

  @override
  String accessAt(String time) {
    return 'Access at $time';
  }

  @override
  String get nfcDisabled => 'NFC disabled';

  @override
  String get enableNfcMessage => 'Please enable NFC in your device settings';

  @override
  String get openSettings => 'Open settings';

  @override
  String get accessTimeout => 'Timeout exceeded';

  @override
  String get understood => 'Understood';

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

  @override
  String get development => 'Development';

  @override
  String get widgetCatalog => 'Widget Catalog';

  @override
  String get exploreComponents => 'Explore the app components';

  @override
  String get listsAndTiles => 'Lists and Tiles';

  @override
  String get selectableTilesWithSwitch => 'Selectable tiles with switch';

  @override
  String get selectors => 'Selectors';

  @override
  String get horizontalSlideSelectors => 'Horizontal slide selectors';

  @override
  String get calendars => 'Calendars';

  @override
  String get monthlyCalendarWithSelection => 'Monthly calendar with selection';

  @override
  String get iconOptionTile => 'List with icons';

  @override
  String get selectableTile => 'Selectable list';

  @override
  String get activated => 'On';

  @override
  String get deactivated => 'Off';

  @override
  String get activatedFeminine => 'On';

  @override
  String get deactivatedFeminine => 'Off';

  @override
  String get simpleSelector => 'Simple Selector';

  @override
  String get singleElementSelection => 'Single element selection';

  @override
  String get multipleSelector => 'Multiple Selector';

  @override
  String get multipleElementSelection => 'Multiple element selection';

  @override
  String get selected => 'Selected';

  @override
  String get selectedPlural => 'Selected';

  @override
  String get tableCalendar => 'Table Calendar';

  @override
  String get monthlyCalendarWithDaySelection =>
      'Monthly calendar with day selection';

  @override
  String get selectedDate => 'Selected date';

  @override
  String get date => 'Date';

  @override
  String get componentCatalog => 'Component Catalog';

  @override
  String get components => 'Components';

  @override
  String get buttons => 'Buttons';

  @override
  String get variantsStatesAndSizes => 'Variants, states and sizes';

  @override
  String get textInputs => 'Text Inputs';

  @override
  String get variantsAndValidations => 'Variants and validations';

  @override
  String get links => 'Links';

  @override
  String get secondaryActionLinks => 'Secondary action links';

  @override
  String get cards => 'Cards';

  @override
  String get differentCardsWithContent => 'Different cards with content';

  @override
  String get filters => 'Filters';

  @override
  String get differentTypesOfFilters => 'Different types of filters';

  @override
  String get primaryColorButton => 'Primary color button';

  @override
  String get secondaryColorButton => 'Secondary color button';

  @override
  String get dangerColorButton => 'Danger color button';

  @override
  String get homePageButtons => 'Home page buttons';

  @override
  String get floatingActionButton => 'Floating Action Button (FAB)';

  @override
  String get small => 'Small';

  @override
  String get medium => 'Medium';

  @override
  String get large => 'Large';

  @override
  String get email => 'Email';

  @override
  String get passwordToggleShowHide => 'Password (toggle show/hide)';

  @override
  String get multiline => 'Multiline';

  @override
  String get validateInputs => 'Validate inputs';

  @override
  String get enterYourEmail => 'Enter your email';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String get minimum8Characters => 'Minimum 8 characters';

  @override
  String get enterDescription => 'Enter a description';

  @override
  String get reviewFields => 'Review fields';

  @override
  String get validatedCorrectly => 'Validated correctly';

  @override
  String get leftAlignedSmallLink => 'Left aligned small link';

  @override
  String get centeredMediumLink => 'Centered medium link';

  @override
  String get rightAlignedLargeLink => 'Right aligned large link';

  @override
  String get welcomeCard => 'Welcome card';

  @override
  String get scheduleCard => 'Schedule card';

  @override
  String get notificationCard => 'Notification card';

  @override
  String get selectorOf5Filters => 'Selector of 5 filters';

  @override
  String get selectorOf2Filters => 'Selector of 2 filters';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get room => 'Room';

  @override
  String get building => 'Building';

  @override
  String get floor => 'Floor';

  @override
  String get userNotAuthenticated => 'User not authenticated';

  @override
  String get classroomReservation => 'Classroom reservation';

  @override
  String get reservationCreatedSuccessfully =>
      'Reservation created successfully';

  @override
  String get errorCreatingReservation => 'Error creating reservation';

  @override
  String get pleaseSelectDate => 'Please select a date';

  @override
  String get pleaseSelectSchedule => 'Please select a schedule';

  @override
  String get noAvailableClassrooms => 'No available classrooms';

  @override
  String get errorLoadingTimeSlots => 'Error loading time slots';

  @override
  String get noScheduleForThisTime => 'No schedule for this time';

  @override
  String get outsideScheduledTime => 'Outside scheduled time';

  @override
  String get inactivePermission => 'Inactive permission';

  @override
  String get userNotFound => 'User not found';

  @override
  String get readerNotFound => 'Reader not found';

  @override
  String get errorTitle => 'Error';

  @override
  String get accessTime => 'Access at';

  @override
  String get focusQrCode => 'Focus the reader\'s QR code';

  @override
  String accessDenialReason(String reason) {
    String _temp0 = intl.Intl.selectLogic(reason, {
      'Tag_not_found': 'Tag not found',
      'Inactive_tag': 'Inactive tag',
      'The_NFC_does_not_belong_to_the_authenticated_user':
          'NFC tag does not belong to authenticated user',
      'Reader_not_found': 'Reader not found',
      'Inactive_reader': 'Inactive reader',
      'No_valid_permission_found': 'No valid permission found',
      'Internal_error_while_validating_access':
          'Internal error while validating access',
      'other': 'Unknown reason',
    });
    return '$_temp0';
  }

  @override
  String get reservationDeleted => 'Reservation deleted';

  @override
  String get errorLoadingReservations => 'Error loading reservations';

  @override
  String get noGroup => 'No group';

  @override
  String get noSubject => 'No subject';

  @override
  String get changeAvatar => 'Change avatar';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get selectFromGallery => 'Select from gallery';

  @override
  String get avatarUpdatedSuccessfully =>
      'Profile picture updated successfully';

  @override
  String avatarError(String error) {
    String _temp0 = intl.Intl.selectLogic(error, {
      'errorTakingPhoto': 'Error taking photo',
      'errorSelectingImage': 'Error selecting image',
      'invalidImageFormat': 'Invalid format. Use: jpg, jpeg, png, webp',
      'imageTooLarge': 'Image is too large. Maximum 5MB',
      'errorCompressingImage': 'Error compressing image',
      'userNotAuthenticated': 'User not authenticated',
      'other': 'Unknown error',
    });
    return '$_temp0';
  }
}
