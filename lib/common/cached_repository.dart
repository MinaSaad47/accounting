import 'package:cache/cache.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class CachedRepository {
  final Cache _cache;
  Locale? _locale;
  ThemeMode? _themeMode;
  String? _token;

  CachedRepository._(
    this._cache,
    this._locale,
    this._themeMode,
    this._token,
  );

  Locale? get locale => _locale;
  ThemeMode? get themeMode => _themeMode;
  String? get token => _token;

  set locale(Locale? locale) {
    _locale = locale;
    if (locale != null) {
      _cache.save(key: 'locale', value: locale.languageCode);
    } else {
      _cache.remove('locale');
    }
  }

  set themeMode(ThemeMode? themeMode) {
    _themeMode = themeMode;
    if (themeMode != null) {
      _cache.save(key: 'themeMode', value: themeMode.name);
    } else {
      _cache.remove('themeMode');
    }
  }

  set token(String? token) {
    _token = token;
    if (token != null) {
      _cache.save(key: 'token', value: token);
    } else {
      _cache.remove('token');
    }
  }

  static Future<CachedRepository> instance(Cache cache) async {
    String? cachedLocale = await cache.load('locale');
    String? cachedThemeMode = await cache.load('themeMode');
    String? cachedToken = await cache.load('token');
    return CachedRepository._(
      cache,
      cachedLocale != null ? Locale(cachedLocale) : const Locale('ar'),
      cachedThemeMode != null && cachedThemeMode == 'dark'
          ? ThemeMode.dark
          : ThemeMode.light,
      cachedToken,
    );
  }
}
