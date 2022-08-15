import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(
          const SettingsState(
            locale: Locale('ar'),
            themeMode: ThemeMode.light,
          ),
        ) {
    on<SettingsLanguageChanged>(_languageChanged);
    on<SettingsThemeChanged>(_themeChanged);
  }

  Future _languageChanged(
    SettingsLanguageChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(locale: event.local));
  }

  Future _themeChanged(
    SettingsThemeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
