import 'dart:io';

import 'package:accounting/app/app.dart';
import 'package:accounting/common/common.dart';
import 'package:accounting_dio/accounting_dio.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:cache_sharedpref/cache_sharedpref.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  EquatableConfig.stringify = true;

  var cachedRepository = await CachedRepository.instance(CacheSharedPref());

  AccountingRepository accountingRepository;

  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    var envIP = Platform.environment['SAMEH_SERVER'];
    accountingRepository = AccountingRepository(
      AccountingDio(
        baseUrl: 'http://${envIP ?? '192.168.1.47:4747'}/api/',
        token: cachedRepository.token,
      ),
    );
  } else {
    accountingRepository = AccountingRepository(
      AccountingDio(
        baseUrl: 'http://192.168.1.47:4747/api/',
        token: cachedRepository.token,
      ),
    );
  }

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: cachedRepository),
        RepositoryProvider.value(value: accountingRepository),
      ],
      child: const App(),
    ),
  );
}
