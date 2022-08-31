import 'package:accounting/common/common.dart';
import 'package:accounting/companies/bloc/expense_bloc.dart';
import 'package:accounting/companies/bloc/income_bloc.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomesAndExpensesList extends StatefulWidget {
  final int companyId;
  const IncomesAndExpensesList({
    Key? key,
    required this.companyId,
  }) : super(key: key);

  @override
  State<IncomesAndExpensesList> createState() => _IncomesAndExpensesListState();
}

class _IncomesAndExpensesListState extends State<IncomesAndExpensesList> {
  final List<bool> _isOpen = List.filled(2, false);
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<IncomeBloc, IncomeState>(
          listener: (context, state) {
            if (state.status == IncomeStatus.failure) {
              showToast(context,
                  message: state.message, level: ToastLevel.error);
            } else if (state.action != IncomeAction.get &&
                state.status == IncomeStatus.success) {
              context.read<IncomeBloc>().add(IncomeGetRequested(
                    companyId: widget.companyId,
                  ));
            }
          },
        ),
        BlocListener<ExpenseBloc, ExpenseState>(
          listener: (context, state) {
            if (state.status == ExpenseStatus.failure) {
              showToast(context,
                  message: state.message, level: ToastLevel.error);
            } else if (state.action != ExpenseAction.get &&
                state.status == ExpenseStatus.success) {
              var user = context.read<LoginCubit>().state.user!;
              context.read<ExpenseBloc>().add(ExpenseGetRequested(
                    companyId: widget.companyId,
                    empolyeeId: !user.isAdmin ? user.id : null,
                  ));
              context.read<LoginCubit>().getCurrentUser();
            }
          },
        )
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ExpansionPanelList(
                children: [
                  ExpansionPanel(
                    isExpanded: _isOpen[0],
                    headerBuilder: (context, isExpanded) => ListTile(
                      leading: const Icon(Icons.move_to_inbox_outlined),
                      title: Text(
                        AppLocalizations.of(context)!.incomes,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.attach_money_outlined),
                          const SizedBox(width: 5),
                          BlocBuilder<IncomeBloc, IncomeState>(
                            builder: (context, state) {
                              return Text(state.total.toString());
                            },
                          )
                        ],
                      ),
                    ),
                    body: BlocBuilder<IncomeBloc, IncomeState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              if (state.status == ExpenseStatus.loading)
                                const LinearProgressIndicator(),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => IncomeWidget(
                                  income: state.list[index],
                                  onDelete: () {
                                    context.read<ExpenseBloc>().add(
                                          ExpenseDeleteRequested(
                                            state.list[index].id!,
                                          ),
                                        );
                                  },
                                ),
                                separatorBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.all(20),
                                  height: 2,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                                ),
                                itemCount: state.list.length,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  ExpansionPanel(
                    isExpanded: _isOpen[1],
                    headerBuilder: (context, isExpanded) => ListTile(
                      leading: const Icon(Icons.outbox_outlined),
                      title: Text(
                        AppLocalizations.of(context)!.expenses,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.attach_money_outlined),
                          const SizedBox(width: 5),
                          BlocBuilder<ExpenseBloc, ExpenseState>(
                            builder: (context, state) {
                              return Text(state.total.toString());
                            },
                          )
                        ],
                      ),
                    ),
                    body: BlocBuilder<ExpenseBloc, ExpenseState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              if (state.status == ExpenseStatus.loading)
                                const LinearProgressIndicator(),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => ExpenseWidget(
                                  expense: state.list[index],
                                  onDelete: () {
                                    context.read<ExpenseBloc>().add(
                                          ExpenseDeleteRequested(
                                            state.list[index].id!,
                                          ),
                                        );
                                  },
                                ),
                                separatorBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.all(20),
                                  height: 2,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                                ),
                                itemCount: state.list.length,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
                expansionCallback: (index, isOpen) {
                  setState(() {
                    _isOpen.fillRange(0, _isOpen.length, false);
                    _isOpen[index] = !isOpen;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
