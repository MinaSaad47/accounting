import 'package:accounting/common/cached_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final CachedRepository cachedRepository;
  SettingsBloc({required this.cachedRepository})
      : super(
          SettingsState(
            locale: cachedRepository.locale ?? const Locale('ar'),
            themeMode: cachedRepository.themeMode ?? ThemeMode.light,
          ),
        ) {
    on<SettingsLanguageChanged>(_languageChanged);
    on<SettingsThemeChanged>(_themeChanged);
  }

  Future _languageChanged(
    SettingsLanguageChanged event,
    Emitter<SettingsState> emit,
  ) async {
    cachedRepository.locale = event.locale;
    emit(state.copyWith(locale: event.locale));
  }

  Future _themeChanged(
    SettingsThemeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    cachedRepository.themeMode = event.themeMode;
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
