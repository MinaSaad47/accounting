part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final Locale locale;
  final ThemeMode themeMode;

  const SettingsState({required this.locale, required this.themeMode});

  SettingsState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
  }) =>
      SettingsState(
        locale: locale ?? this.locale,
        themeMode: themeMode ?? this.themeMode,
      );

  @override
  List<Object?> get props => [locale, themeMode];
}
