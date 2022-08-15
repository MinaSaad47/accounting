part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class SettingsLanguageChanged extends SettingsEvent {
  final Locale local;

  const SettingsLanguageChanged(this.local);
  @override
  List<Object?> get props => [local];
}

class SettingsThemeChanged extends SettingsEvent {
  final ThemeMode themeMode;

  const SettingsThemeChanged(this.themeMode);
  @override
  List<Object?> get props => [themeMode];
}
