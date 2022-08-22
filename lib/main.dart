import 'package:accounting/app/app.dart';
import 'package:accounting/common/common.dart';
import 'package:accounting_dio/accounting_dio.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:cache_sharedpref/cache_sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  var cachedRepository = await CachedRepository.instance(CacheSharedPref());
  var accountingRepository = AccountingRepository(
    AccountingDio(
      baseUrl: 'http://localhost:8000/api/',
      token: cachedRepository.token,
    ),
  );

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
