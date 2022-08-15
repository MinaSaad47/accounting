import 'package:accounting/app/app.dart';
import 'package:accounting/common/common.dart';
import 'package:accounting_dio/accounting_dio.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cache_sharedpref/cache_sharedpref.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  var accountingRepository = AccountingRepository(
    AccountingDio(
      baseUrl: 'http://192.168.47.47:8000/api/',
    ),
  );
  runApp(
    App(
      cache: CacheSharedPref(),
      accountingRepository: accountingRepository,
    ),
  );
}
