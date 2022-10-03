import 'package:accounting/common/common.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/employees/cubit/expense_cubit.dart';
import 'package:accounting/employees/empolyees.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting/utils/utils.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EmployessView extends StatelessWidget {
  const EmployessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var user = context.read<LoginCubit>().state.user!;
    return DefaultTabController(
      length: user.isAdmin ? 2 : 1,
      child: Scaffold(
        appBar: AppBarWidget(
          title: l10n.employees,
          tabBar: TabBar(
            tabs: [
              Tab(
                child: Text(l10n.employees),
              ),
              if (user.isAdmin)
                Tab(
                  child: Text(
                    l10n.add(l10n.employee),
                  ),
                ),
            ],
          ),
        ),
        drawer: const DrawerWidget(),
        body: TabBarView(
          children: [
            const _BuildListEmployees(),
            if (user.isAdmin) const _BuildAddEmployee(),
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
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<EmployeesCubit, EmployeesState>(
      listener: (context, state) {
        if (state.action == EmployeeAction.get &&
            state.status == EmployeeStatus.failure) {
          Utils.toast(
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
                      title: l10n.username,
                      content: state.list[index].name,
                    ),
                    TextLabelWidget(
                      icon: Icons.money_outlined,
                      title: l10n.expenses,
                      content: '${state.list[index].value}',
                    )
                  ],
                  title: '${state.list[index].id}',
                  onPressed: () {
                    Navigator.of(context).push(_BuildEmpolyeeInfo.route(
                      context,
                      user: state.list[index],
                    ));
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

  static route(BuildContext context, {required UserModel user}) =>
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => MoneyCapitalCubit(
                context.read<AccountingRepository>(),
              )..getMoneyCapital(employeeId: user.id!),
            ),
            BlocProvider.value(
              value: context.read<EmployeesCubit>(),
            ),
          ],
          child: _BuildEmpolyeeInfo(userModel: user),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<EmployeesCubit, EmployeesState>(
      listener: (context, state) {
        if (state.action == EmployeeAction.pay) {
          if (state.status == EmployeeStatus.success) {
            Utils.toast(context, message: state.message);
            context.read<EmployeesCubit>().getEmployees();
            var loginCubit = context.read<LoginCubit>();
            if (state.selected!.id == loginCubit.state.user!.id) {
              loginCubit.getCurrentUser();
            }
          } else if (state.status == EmployeeStatus.failure) {
            Utils.toast(
              context,
              message: state.message,
              level: ToastLevel.error,
            );
          }
        } else if (state.action == EmployeeAction.delete) {
          if (state.status == EmployeeStatus.success) {
            Utils.toast(context, message: state.message);
            context.read<EmployeesCubit>().getEmployees();
            Navigator.of(context).pop();
          } else if (state.status == EmployeeStatus.failure) {
            Utils.toast(
              context,
              message: state.message,
              level: ToastLevel.error,
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.employee),
          actions: [
            if (context.read<LoginCubit>().state.user!.isAdmin &&
                !userModel.isAdmin)
              IconButton(
                color: Colors.red.shade900,
                tooltip: l10n.delete,
                iconSize: 40,
                onPressed: () => Utils.adminDo(context, fn: () {
                  context
                      .read<EmployeesCubit>()
                      .deleteEmployee(id: userModel.id!);
                }),
                icon: const Icon(
                  Icons.delete_outline,
                ),
              )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ListItemWidget(
                title: userModel.id.toString(),
                labels: [
                  TextLabelWidget(
                    icon: Icons.person_outline,
                    title: l10n.username,
                    content: userModel.name,
                  ),
                  if (!context.read<LoginCubit>().state.user!.isAdmin)
                    TextLabelWidget(
                      icon: Icons.attach_money_outlined,
                      title: l10n.expenses,
                      content: '${userModel.value}',
                    ),
                ],
              ),
              const SizedBox(height: 30),
              if (context.read<LoginCubit>().state.user!.isAdmin)
                _BuildEmployeeValue(
                  initial: userModel.value,
                  onSave: (value) {
                    context.read<EmployeesCubit>().payEmployee(
                          id: userModel.id!,
                          value: value,
                        );
                  },
                ),
              const SizedBox(height: 30),
              Text(
                l10n.companies,
                style: Theme.of(context).textTheme.headline2,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<MoneyCapitalCubit, ExpenseState>(
                    builder: (context, state) {
                      return _BuildEmployeeExpenses(
                        companies: state.companies,
                        expenses: state.expense,
                      );
                    },
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

class _BuildEmployeeValue extends StatefulWidget {
  final void Function(double) onSave;
  final double initial;
  const _BuildEmployeeValue({
    Key? key,
    required this.onSave,
    required this.initial,
  }) : super(key: key);

  @override
  State<_BuildEmployeeValue> createState() => _BuildEmployeeValueState();
}

class _BuildEmployeeValueState extends State<_BuildEmployeeValue> {
  var formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return FormBuilder(
      key: formKey,
      child: Row(
        children: [
          const Icon(
            Icons.attach_money_sharp,
            size: 50,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: FormBuilderTextFieldWidget(
              context,
              name: l10n.expenses,
              value: '${widget.initial}',
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(
                    errorText: l10n.expenses,
                  ),
                  FormBuilderValidators.numeric(
                    errorText: l10n.expect(
                      l10n.number,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => Utils.adminDo(context, fn: () {
              var formState = formKey.currentState!;
              if (formState.saveAndValidate()) {
                widget.onSave(
                  double.parse(
                    formState.value[l10n.expenses],
                  ),
                );
              }
            }),
            child: Text(
              l10n.save(''),
            ),
          )
        ],
      ),
    );
  }
}

class _BuildEmployeeExpenses extends StatefulWidget {
  final List<String> companies;
  final List<List<ExpenseModel>> expenses;
  const _BuildEmployeeExpenses({
    Key? key,
    required this.companies,
    required this.expenses,
  }) : super(key: key);

  @override
  State<_BuildEmployeeExpenses> createState() => _BuildEmployeeExpensesState();
}

class _BuildEmployeeExpensesState extends State<_BuildEmployeeExpenses> {
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.attach_money_outlined),
                const SizedBox(width: 5),
                Text(
                  widget.expenses[index]
                      .map((e) => e.value)
                      .fold(0.0, (p, c) => (p as double) + c)
                      .toString(),
                )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, innerIndex) => ExpenseWidget(
                expense: widget.expenses[index][innerIndex],
              ),
              separatorBuilder: (context, _) => const SizedBox(
                height: 10,
              ),
              itemCount: widget.expenses[index].length,
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
    final l10n = AppLocalizations.of(context)!;
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
                  name: l10n.username,
                ),
                FormBuilderTextFieldWidget(
                  context,
                  name: l10n.password,
                ),
                FormBuilderDropdownWidget(
                  name: l10n.permissions,
                  initialValue: l10n.user,
                  items: [l10n.user, l10n.admin],
                )
              ],
            ),
            const Spacer(),
            BlocConsumer<EmployeesCubit, EmployeesState>(
              listener: (context, state) {
                if (state.action == EmployeeAction.create &&
                    state.status == EmployeeStatus.success) {
                  Utils.toast(context, message: state.message);
                  context.read<EmployeesCubit>().getEmployees();
                } else if (state.action == EmployeeAction.create &&
                    state.status == EmployeeStatus.failure) {
                  Utils.toast(
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
                      l10n.save(l10n.employee),
                    ),
                    onPressed: () {
                      var formState = formKey.currentState!;
                      if (formState.validate()) {
                        formState.save();
                        var employee = UserModel(
                          name: formState.value[l10n.username],
                          password: formState.value[l10n.password],
                          isAdmin:
                              formState.value[l10n.permissions] == l10n.admin,
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
