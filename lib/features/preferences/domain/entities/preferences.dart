import 'package:equatable/equatable.dart';

class Preferences extends Equatable {
  static const darkModeConst = 'DARKMODE';
  static const languageConst = 'LANGUAGE';
  static const notificationsConst = 'NOTIFICATIONS';

  final bool? darkMode;
  final String? language;
  final bool? notifications;

  const Preferences({
    this.darkMode,
    this.language,
    this.notifications,
  });

  Preferences copyWith({
    bool? darkMode,
    String? language,
    bool? notifications,
  }) => Preferences(
    darkMode: darkMode ?? this.darkMode,
    language: language ?? this.language,
    notifications: notifications ?? this.notifications,
  );

  @override
  List<Object?> get props => [darkMode, language, notifications];
}