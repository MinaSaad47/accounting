import 'package:accounting/companies/companies.dart';
import 'package:accounting/companies/cubit/companies_cubit.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({Key? key}) : super(key: key);

  static route() => MaterialPageRoute(
        builder: (context) => const CompaniesPage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompaniesCubit(context.read<AccountingRepository>()),
      child: const CompaniesView(),
    );
  }
}
