import 'package:accounting/app/bloc/app_bloc.dart';
import 'package:accounting/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppLogout) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(AppLocalizations.of(context)!.accounting),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                context.read<AppBloc>().add(AppLoggedout());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.logout,
                    style: TextStyle(
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.logout_outlined,
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: const DrawerWidget(),
      ),
    );
  }
}
