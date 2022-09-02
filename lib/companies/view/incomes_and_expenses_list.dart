import 'package:accounting/common/common.dart';
import 'package:accounting/companies/bloc/expense_bloc.dart';
import 'package:accounting/companies/bloc/income_bloc.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/helpers/helpers.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
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
              Utils.toast(context,
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
              Utils.toast(context,
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
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(
                  builder: (context) {
                    var incomesTotal = context.select(
                      (IncomeBloc bloc) => bloc.state.total,
                    );
                    var expensesTotal = context.select(
                      (ExpenseBloc bloc) => bloc.state.total,
                    );

                    var total = incomesTotal + expensesTotal;

                    var expensePerc = (expensesTotal / total) * 100;
                    var expenseStr = expensePerc.toStringAsFixed(
                      expensePerc.truncateToDouble() == expensePerc ? 0 : 2,
                    );
                    var incomePerc = (incomesTotal / total) * 100;
                    var incomeStr = incomePerc.toStringAsFixed(
                      incomePerc.truncateToDouble() == incomePerc ? 0 : 2,
                    );

                    return total > 0
                        ? ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: constraints.minHeight / 3,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Card(
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ListTile(
                                            leading: const Icon(
                                              Icons.payments_outlined,
                                            ),
                                            title: Text(
                                              AppLocalizations.of(context)!
                                                  .dues,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            subtitle: Text(
                                              '${expensesTotal - incomesTotal}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                          ),
                                          ElevatedButton(
                                            child: const Text('PDF'),
                                            onPressed: () {
                                              PdfHelper.generateInvoice(
                                                expenses: context
                                                    .read<ExpenseBloc>()
                                                    .state
                                                    .list,
                                                incomes: context
                                                    .read<IncomeBloc>()
                                                    .state
                                                    .list,
                                                total: total,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Card(
                                    elevation: 10,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) =>
                                          PieChart(
                                        PieChartData(
                                          centerSpaceRadius: 0,
                                          borderData: FlBorderData(show: false),
                                          sections: [
                                            if (incomePerc > 0)
                                              PieChartSectionData(
                                                radius:
                                                    constraints.maxHeight * 0.4,
                                                showTitle: true,
                                                titleStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                        color: Colors.white),
                                                color: Colors.blue,
                                                value: incomePerc,
                                                title: '$incomeStr %',
                                                titlePositionPercentageOffset:
                                                    0.4,
                                                badgePositionPercentageOffset:
                                                    1,
                                                badgeWidget: const Material(
                                                  color: Colors.blue,
                                                  child: Icon(
                                                    Icons
                                                        .move_to_inbox_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            if (expensePerc > 0)
                                              PieChartSectionData(
                                                radius:
                                                    constraints.maxHeight * 0.4,
                                                showTitle: true,
                                                color: Colors.red,
                                                titleStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                                value: expensePerc,
                                                title: '$expenseStr %',
                                                titlePositionPercentageOffset:
                                                    0.4,
                                                badgePositionPercentageOffset:
                                                    1,
                                                badgeWidget: const Material(
                                                  color: Colors.red,
                                                  child: Icon(
                                                    color: Colors.white,
                                                    Icons.outbox_outlined,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container();
                  },
                ),
                const SizedBox(height: 10),
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
                            const Icon(Icons.payments_outlined),
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
                                      context.read<IncomeBloc>().add(
                                            IncomeDeleteRequested(
                                              state.list[index].id!,
                                            ),
                                          );
                                    },
                                  ),
                                  separatorBuilder: (context, index) =>
                                      Container(
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
                            const Icon(Icons.payments_outlined),
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
                                  itemBuilder: (context, index) =>
                                      ExpenseWidget(
                                    expense: state.list[index],
                                    onDelete: () {
                                      context.read<ExpenseBloc>().add(
                                            ExpenseDeleteRequested(
                                              state.list[index].id!,
                                            ),
                                          );
                                    },
                                  ),
                                  separatorBuilder: (context, index) =>
                                      Container(
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
      ),
    );
  }
}
