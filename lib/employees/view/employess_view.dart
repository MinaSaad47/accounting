import 'package:accounting/common/common.dart';
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
            onTap: (index) => {
              if (index == 0) {context.read<EmployeesCubit>().getEmployees()}
            },
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
        if (state is EmployeesGetFailure) {
          showToast(
            context,
            message: state.error,
            level: ToastLevel.error,
          );
        }
      },
      builder: (context, state) {
        if (state is EmployeesGetSuccess) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListItemWidget(
                  labels: [
                    TextLabelWidget(
                      icon: Icons.person_outline,
                      title: AppLocalizations.of(context)!.userName,
                      content: state.users[index].name,
                    ),
                    TextLabelWidget(
                      icon: Icons.money_outlined,
                      title: AppLocalizations.of(context)!.moneyCapital,
                      content: '${state.users[index].value}',
                    )
                  ],
                  title: '1',
                  onPressed: () {
                    Navigator.of(context)
                        .push(_BuildEmpolyeeInfo.route(state.users[index]));
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: state.users.length,
            ),
          );
        } else if (state is EmployeesGetInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
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
        builder: (context) => _BuildEmpolyeeInfo(userModel: userModel),
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
              child: ListView.separated(
                itemBuilder: (context, index) => const SizedBox(
                  height: 50,
                ),
                separatorBuilder: (context, index) => Container(
                  height: 2,
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
                ),
                itemCount: 5,
              ),
            ),
          ],
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
                if (state is EmployeeCreateSuccess) {
                  showToast(context, message: state.message);
                } else if (state is EmployeeCreateFailure) {
                  showToast(
                    context,
                    message: state.error,
                    level: ToastLevel.error,
                  );
                }
              },
              builder: (context, state) {
                if (state is EmployeeCreateInProgress) {
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
