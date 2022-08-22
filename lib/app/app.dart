import 'package:accounting/app/bloc/app_bloc.dart';
import 'package:accounting/app/view/app_view.dart';
import 'package:accounting/common/cached_repository.dart';
import 'package:accounting/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'view/view.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsBloc(
            cachedRepository: context.read<CachedRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => AppBloc(
            cachedRepository: context.read<CachedRepository>(),
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}
