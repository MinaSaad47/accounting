import 'package:accounting/app/app.dart';
import 'package:accounting/settings/settings.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:cache/cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'view/view.dart';

class App extends StatelessWidget {
  final Cache _cache;
  final AccountingRepository _accountingRepository;

  const App({
    Key? key,
    required Cache cache,
    required AccountingRepository accountingRepository,
  })  : _cache = cache,
        _accountingRepository = accountingRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _accountingRepository,
      child: BlocProvider(
        create: (context) => SettingsBloc(),
        child: const AppView(),
      ),
    );
  }
}
