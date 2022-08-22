import 'package:accounting/common/cached_repository.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting/login/login.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        accountingRepository: context.read<AccountingRepository>(),
        cachedRepository: context.read<CachedRepository>(),
      ),
      child: const LoginView(),
    );
  }
}
