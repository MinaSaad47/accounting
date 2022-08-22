part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class SettingsLanguageChanged extends SettingsEvent {
  final Locale locale;

  const SettingsLanguageChanged(this.locale);
  @override
  List<Object?> get props => [locale];
}

class SettingsThemeChanged extends SettingsEvent {
  final ThemeMode themeMode;

  const SettingsThemeChanged(this.themeMode);
  @override
  List<Object?> get props => [themeMode];
}
