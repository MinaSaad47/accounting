import 'package:accounting/common/common.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/employees/cubit/money_capital_cubit.dart';
import 'package:accounting/employees/empolyees.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EmployessView extends StatelessWidget {
  const EmployessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = context.read<LoginCubit>().state.user!;
    return DefaultTabController(
      length: user.isAdmin ? 2 : 1,
      child: Scaffold(
        appBar: AppBarWidget(
          title: AppLocalizations.of(context)!.employees,
          tabBar: TabBar(
            tabs: [
              Tab(
                child: Text(AppLocalizations.of(context)!.employees),
              ),
              if (user.isAdmin)
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
    return BlocListener<EmployeesCubit, EmployeesState>(
      listener: (context, state) {
        if (state.action == EmployeeAction.pay) {
          if (state.status == EmployeeStatus.success) {
            showToast(context, message: state.message);
            context.read<EmployeesCubit>().getEmployees();
            var loginCubit = context.read<LoginCubit>();
            if (state.user!.id == loginCubit.state.user!.id) {
              loginCubit.getCurrentUser();
            }
          } else if (state.status == EmployeeStatus.failure) {
            showToast(
              context,
              message: state.message,
              level: ToastLevel.error,
            );
          }
        } else if (state.action == EmployeeAction.delete) {
          if (state.status == EmployeeStatus.success) {
            showToast(context, message: state.message);
            context.read<EmployeesCubit>().getEmployees();
            Navigator.of(context).pop();
          } else if (state.status == EmployeeStatus.failure) {
            showToast(
              context,
              message: state.message,
              level: ToastLevel.error,
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.employee),
          actions: [
            if (context.read<LoginCubit>().state.user!.isAdmin &&
                !userModel.isAdmin)
              IconButton(
                color: Colors.red.shade900,
                tooltip: AppLocalizations.of(context)!.delete,
                iconSize: 40,
                onPressed: () {
                  context
                      .read<EmployeesCubit>()
                      .deleteEmployee(id: userModel.id!);
                },
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
                    title: AppLocalizations.of(context)!.userName,
                    content: userModel.name,
                  ),
                  if (!context.read<LoginCubit>().state.user!.isAdmin)
                    TextLabelWidget(
                      icon: Icons.attach_money_outlined,
                      title: AppLocalizations.of(context)!.moneyCapital,
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
              name: AppLocalizations.of(context)!.moneyCapital,
              value: '${widget.initial}',
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(
                    errorText: AppLocalizations.of(context)!.moneyCapital,
                  ),
                  FormBuilderValidators.numeric(
                    errorText: AppLocalizations.of(context)!.expect(
                      AppLocalizations.of(context)!.number,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              var formState = formKey.currentState!;
              if (formState.saveAndValidate()) {
                widget.onSave(
                  double.parse(
                    formState.value[AppLocalizations.of(context)!.moneyCapital],
                  ),
                );
              }
            },
            child: Text(
              AppLocalizations.of(context)!.save(''),
            ),
          )
        ],
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.attach_money_outlined),
                const SizedBox(width: 5),
                Text(
                  widget.moneyCapitals[index]
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
