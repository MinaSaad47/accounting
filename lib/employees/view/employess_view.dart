import 'package:accounting/common/common.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/employees/cubit/money_capital_cubit.dart';
import 'package:accounting/employees/empolyees.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class EmployessView extends StatelessWidget {
  const EmployessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarWidget(
          title: AppLocalizations.of(context)!.employees,
          tabBar: TabBar(
            tabs: [
              Tab(
                child: Text(AppLocalizations.of(context)!.employees),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context)!
                      .add(AppLocalizations.of(context)!.employee),
                ),
              ),
            ],
          ),
        ),
        drawer: const DrawerWidget(),
        body: const TabBarView(
          children: [
            _BuildListEmployees(),
            _BuildAddEmployee(),
          ],
        ),
      ),
    );
  }
}

class _BuildListEmployees extends StatelessWidget {
  const _BuildListEmployees({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeesCubit, EmployeesState>(
      listener: (context, state) {
        if (state.action == EmployeeAction.get &&
            state.status == EmployeeStatus.failure) {
          showToast(
            context,
            message: state.message,
            level: ToastLevel.error,
          );
        }
      },
      builder: (context, state) {
        if (state.status == EmployeeStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListItemWidget(
                  labels: [
                    TextLabelWidget(
                      icon: Icons.person_outline,
                      title: AppLocalizations.of(context)!.userName,
                      content: state.list[index].name,
                    ),
                    TextLabelWidget(
                      icon: Icons.money_outlined,
                      title: AppLocalizations.of(context)!.moneyCapital,
                      content: '${state.list[index].value}',
                    )
                  ],
                  title: '${state.list[index].id}',
                  onPressed: () {
                    Navigator.of(context)
                        .push(_BuildEmpolyeeInfo.route(state.list[index]));
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: state.list.length,
            ),
          );
        }
      },
    );
  }
}

class _BuildEmpolyeeInfo extends StatelessWidget {
  final UserModel userModel;
  const _BuildEmpolyeeInfo({Key? key, required this.userModel})
      : super(key: key);

  static route(UserModel userModel) => MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => MoneyCapitalCubit(
            context.read<AccountingRepository>(),
          )..getMoneyCapital(employeeId: userModel.id!),
          child: _BuildEmpolyeeInfo(userModel: userModel),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.employee)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListItemWidget(
              title: userModel.id.toString(),
              labels: [
                TextLabelWidget(
                  icon: Icons.person_outline,
                  title: AppLocalizations.of(context)!.userName,
                  content: userModel.name,
                ),
                TextLabelWidget(
                  icon: Icons.money_outlined,
                  title: AppLocalizations.of(context)!.moneyCapital,
                  content: '${userModel.value} LE',
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.companies,
              style: Theme.of(context).textTheme.headline2,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<MoneyCapitalCubit, MoneyCapitalState>(
                  builder: (context, state) {
                    return _BuildEmployeeMoneyCapitals(
                      companies: state.companies,
                      moneyCapitals: state.moneyCapitals,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildEmployeeMoneyCapitals extends StatefulWidget {
  final List<String> companies;
  final List<List<MoneyCapitalModel>> moneyCapitals;
  const _BuildEmployeeMoneyCapitals({
    Key? key,
    required this.companies,
    required this.moneyCapitals,
  }) : super(key: key);

  @override
  State<_BuildEmployeeMoneyCapitals> createState() =>
      _BuildEmployeeMoneyCapitalsState();
}

class _BuildEmployeeMoneyCapitalsState
    extends State<_BuildEmployeeMoneyCapitals> {
  late List<bool> _isOpend = List.filled(widget.companies.length, false);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        setState(() {
          _isOpend = List.filled(widget.companies.length, false);
          _isOpend[index] = !isExpanded;
        });
      },
      children: List.generate(
        widget.companies.length,
        (index) => ExpansionPanel(
          isExpanded: _isOpend[index],
          headerBuilder: (context, isExpanded) => ListTile(
            leading: const Icon(Icons.business_outlined),
            title: Text(widget.companies[index]),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, innerIndex) => MoneyCapitalItemWidget(
                moneyCapital: widget.moneyCapitals[index][innerIndex],
              ),
              separatorBuilder: (context, _) => const SizedBox(
                height: 10,
              ),
              itemCount: widget.moneyCapitals[index].length,
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildAddEmployee extends StatefulWidget {
  const _BuildAddEmployee({Key? key}) : super(key: key);

  @override
  State<_BuildAddEmployee> createState() => _BuildAddEmployeeState();
}

class _BuildAddEmployeeState extends State<_BuildAddEmployee> {
  var formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            Wrap(
              children: [
                FormBuilderTextFieldWidget(
                  context,
                  name: AppLocalizations.of(context)!.userName,
                ),
                FormBuilderTextFieldWidget(
                  context,
                  name: AppLocalizations.of(context)!.password,
                ),
                FormBuilderDropdownWidget(
                  name: AppLocalizations.of(context)!.permissions,
                  initialValue: AppLocalizations.of(context)!.user,
                  items: [
                    AppLocalizations.of(context)!.user,
                    AppLocalizations.of(context)!.admin,
                  ],
                )
              ],
            ),
            const Spacer(),
            BlocConsumer<EmployeesCubit, EmployeesState>(
              listener: (context, state) {
                if (state.action == EmployeeAction.create &&
                    state.status == EmployeeStatus.success) {
                  showToast(context, message: state.message);
                  context.read<EmployeesCubit>().getEmployees();
                } else if (state.action == EmployeeAction.create &&
                    state.status == EmployeeStatus.failure) {
                  showToast(
                    context,
                    message: state.message,
                    level: ToastLevel.error,
                  );
                }
              },
              builder: (context, state) {
                if (state.status == EmployeeStatus.loading) {
                  return const CircularProgressIndicator();
                } else {
                  return ElevatedButton(
                    child: Text(
                      AppLocalizations.of(context)!
                          .save(AppLocalizations.of(context)!.employee),
                    ),
                    onPressed: () {
                      var formState = formKey.currentState!;
                      if (formState.validate()) {
                        formState.save();
                        var employee = UserModel(
                          name: formState
                              .value[AppLocalizations.of(context)!.userName],
                          password: formState
                              .value[AppLocalizations.of(context)!.password],
                          isAdmin: formState.value[
                                  AppLocalizations.of(context)!.permissions] ==
                              AppLocalizations.of(context)!.admin,
                          value: 0,
                        );
                        context.read<EmployeesCubit>().createEmployee(employee);
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
