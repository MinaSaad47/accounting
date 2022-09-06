import 'package:accounting/common/common.dart';
import 'package:accounting/companies/bloc/expense_bloc.dart';
import 'package:accounting/companies/bloc/income_bloc.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/helpers/helpers.dart';
import 'package:accounting/utils/utils.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomesAndExpensesList extends StatefulWidget {
  const IncomesAndExpensesList({
    Key? key,
  }) : super(key: key);

  @override
  State<IncomesAndExpensesList> createState() => _IncomesAndExpensesListState();
}

class _IncomesAndExpensesListState extends State<IncomesAndExpensesList> {
  final List<bool> _isOpen = List.filled(2, false);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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

                  var incomes = context.select(
                    (IncomeBloc bloc) => bloc.state.list,
                  );
                  var expenses = context.select(
                    (ExpenseBloc bloc) => bloc.state.list,
                  );

                  return expensesTotal > 0 || incomesTotal > 0
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: constraints.minHeight / 2,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 4,
                                child: _BuildChartItem(
                                  incomesTotal: incomesTotal,
                                  expensesTotal: expensesTotal,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: _BuildDuoItem(
                                  incomes: incomes,
                                  expenses: expenses,
                                  incomesTotal: incomesTotal,
                                  expensesTotal: expensesTotal,
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
                                  onDelete: () =>
                                      Utils.adminDo(context, fn: () {
                                    context.read<IncomeBloc>().add(
                                          IncomeDeleteRequested(
                                            state.list[index].id!,
                                          ),
                                        );
                                  }),
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

class _BuildChartItem extends StatelessWidget {
  const _BuildChartItem({
    Key? key,
    required this.incomesTotal,
    required this.expensesTotal,
  }) : super(key: key);

  final double incomesTotal;
  final double expensesTotal;

  @override
  Widget build(BuildContext context) {
    double sum = incomesTotal + expensesTotal;
    var incomesPerc = (incomesTotal / sum) * 100;
    var expensesPerc = (expensesTotal / sum) * 100;
    return Card(
      elevation: 10,
      child: LayoutBuilder(
        builder: (context, constraints) => PieChart(
          PieChartData(
            centerSpaceRadius: 0,
            borderData: FlBorderData(show: false),
            sections: [
              if (incomesPerc > 0)
                PieChartSectionData(
                  radius: constraints.maxHeight * 0.4,
                  showTitle: true,
                  titleStyle: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.white),
                  color: Colors.blue,
                  value: incomesPerc,
                  title: '${incomesPerc.toStringAsFixed(2)} %',
                  titlePositionPercentageOffset: 0.4,
                  badgePositionPercentageOffset: 1,
                  badgeWidget: const Material(
                    color: Colors.blue,
                    child: Icon(
                      Icons.move_to_inbox_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (expensesPerc > 0)
                PieChartSectionData(
                  radius: constraints.maxHeight * 0.4,
                  showTitle: true,
                  color: Colors.red,
                  titleStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                      ),
                  value: expensesPerc,
                  title: '${expensesPerc.toStringAsFixed(2)} %',
                  titlePositionPercentageOffset: 0.4,
                  badgePositionPercentageOffset: 1,
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
    );
  }
}

class _BuildDuoItem extends StatelessWidget {
  const _BuildDuoItem({
    Key? key,
    required this.incomes,
    required this.expenses,
    required this.incomesTotal,
    required this.expensesTotal,
  }) : super(key: key);

  final List<IncomeModel> incomes;
  final List<ExpenseModel> expenses;
  final double incomesTotal;
  final double expensesTotal;

  @override
  Widget build(BuildContext context) {
    var total = expensesTotal - incomesTotal;
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.payments_outlined,
                  size: 40,
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dues,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      '$total',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.print_outlined),
              color: Theme.of(context).colorScheme.secondary,
              iconSize: 40,
              onPressed: () {
                PdfHelper.generateInvoice(
                  context,
                  company: context.read<CompanyModel>(),
                  expenses: expenses,
                  incomes: incomes,
                  total: total,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
