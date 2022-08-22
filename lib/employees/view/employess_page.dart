import 'package:accounting/employees/empolyees.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployessPage extends StatelessWidget {
  const EmployessPage({Key? key}) : super(key: key);

  static route() => MaterialPageRoute(
        builder: (context) => const EmployessPage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeesCubit(
        context.read<AccountingRepository>(),
      ),
      child: const EmployessView(),
    );
  }
}
