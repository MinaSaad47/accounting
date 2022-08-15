import 'dart:developer';

import 'package:accounting/common/common.dart';
import 'package:accounting/companies/cubit/companies_cubit.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CompaniesView extends StatelessWidget {
  const CompaniesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarWidget(
          title: AppLocalizations.of(context)!.companies,
          tabBar: TabBar(
            tabs: [
              Tab(
                child: Text(AppLocalizations.of(context)!
                    .search(AppLocalizations.of(context)!.company)),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context)!
                      .add(AppLocalizations.of(context)!.company),
                ),
              ),
            ],
          ),
        ),
        drawer: const DrawerWidget(),
        body: const TabBarView(
          children: [
            _BuildSearchCompany(),
            _BuildAddCompany(),
          ],
        ),
      ),
    );
  }
}

class _BuildSearchCompany extends StatelessWidget {
  const _BuildSearchCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SearchWidget(
            hintText: AppLocalizations.of(context)!
                .search(AppLocalizations.of(context)!.company),
            onChanged: (query) {
              if (query.isNotEmpty) {
                context.read<CompaniesCubit>().getCompanies(query);
              }
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocConsumer<CompaniesCubit, CompaniesState>(
              listener: (context, state) {
                if (state is CompaniesGetInFailure) {
                  showToast(
                    context,
                    message: state.error,
                    level: ToastLevel.error,
                  );
                }
              },
              builder: (context, state) {
                if (state is CompaniesGetSuccess) {
                  return ListView.separated(
                    itemBuilder: (context, index) =>
                        _CompanyListItem(company: state.companies[index]),
                    separatorBuilder: (context, index) => Container(
                      margin: const EdgeInsets.all(10),
                      height: 2,
                    ),
                    itemCount: state.companies.length,
                  );
                } else if (state is CompaniesGetInProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class _CompanyListItem extends StatelessWidget {
  final CompanyModel company;
  const _CompanyListItem({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              company.id!,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(_BuildEditCompany.route(context, company));
                },
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.displayMore,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              )
            ],
          ),
          _BuildTextLabel(
            icon: Icons.featured_play_list_outlined,
            title: AppLocalizations.of(context)!.registerNumber,
            content: company.registerNumber,
          ),
          const SizedBox(height: 10),
          _BuildTextLabel(
            icon: Icons.person,
            title: AppLocalizations.of(context)!.funderName,
            content: company.funders[0].name,
          ),
          const SizedBox(height: 10),
          _BuildTextLabel(
            icon: Icons.featured_play_list_outlined,
            title: AppLocalizations.of(context)!.commercialFeature,
            content: company.commercialFeature,
          )
        ],
      ),
    );
  }
}

class _BuildTextLabel extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const _BuildTextLabel({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Row(
              children: [
                const SizedBox(width: 5),
                Icon(
                  icon,
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                ),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).appBarTheme.foregroundColor,
                      ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              content,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildAddCompany extends StatelessWidget {
  const _BuildAddCompany({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var funderName = _InputClass(
      AppLocalizations.of(context)!.funderName,
    );
    var commercialFeature = _InputClass(
      AppLocalizations.of(context)!.commercialFeature,
    );
    var legalEntity = _InputClass(
      AppLocalizations.of(context)!.legalEntity,
    );
    var registerNumber = _InputClass(
      AppLocalizations.of(context)!.registerNumber,
      type: TextInputType.number,
    );
    var generalTaxMission = _InputClass(
      AppLocalizations.of(context)!.generalTaxMission,
    );
    var activityNature = _InputClass(
      AppLocalizations.of(context)!.activityNature,
    );
    var activityLocation = _InputClass(
      AppLocalizations.of(context)!.activityLocation,
    );
    var accounts = _InputClass(
      AppLocalizations.of(context)!.accounts,
    );
    var userName = _InputClass(
      AppLocalizations.of(context)!.userName,
    );
    var email = _InputClass(
      AppLocalizations.of(context)!.email,
      type: TextInputType.emailAddress,
    );

    var inputs = [
      funderName,
      commercialFeature,
      legalEntity,
      registerNumber,
      generalTaxMission,
      activityNature,
      activityLocation,
      accounts,
      userName,
      email,
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Wrap(
              children: List.generate(
                inputs.length,
                (index) => _BuildTextField(
                  controller: inputs[index].controller,
                  label: inputs[index].label,
                  expect:
                      AppLocalizations.of(context)!.expect(inputs[index].label),
                  type: inputs[index].type,
                ),
              ),
            ),
          ),
          const Spacer(),
          LayoutBuilder(
            builder: (context, constraints) => SizedBox(
              width: constraints.maxWidth / 2,
              child: MaterialButton(
                color: Theme.of(context).secondaryHeaderColor,
                onPressed: () {
                  var formState = formKey.currentState;
                  if (formState != null && formState.validate()) {
                    var companyModel = CompanyModel(
                      funders: [FunderModel(name: funderName.controller.text)],
                      commercialFeature: commercialFeature.controller.text,
                      isWorking: false,
                      legalEntity: legalEntity.controller.text,
                      registerNumber: registerNumber.controller.text,
                      startDate: DateTime.now(),
                      generalTaxMission: generalTaxMission.controller.text,
                      activityNature: activityNature.controller.text,
                      activityLocation: activityLocation.controller.text,
                      accounts: accounts.controller.text,
                      naturalId: "dasda",
                      recordNumber: "dasda",
                      userName: userName.controller.text,
                      email: email.controller.text,
                    );
                    context
                        .read<AccountingRepository>()
                        .createCompany(companyModel)
                        .then((response) {
                      log('${response.data}');
                      showToast(
                        context,
                        message: response.message,
                        level: response.status
                            ? ToastLevel.success
                            : ToastLevel.error,
                      );
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.save(
                        AppLocalizations.of(context)!.company,
                      ),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const Icon(Icons.save_alt_outlined)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildEditCompany extends StatefulWidget {
  final CompanyModel company;
  const _BuildEditCompany({
    Key? key,
    required this.company,
  }) : super(key: key);

  static route(BuildContext context, CompanyModel companyModel) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider<CompaniesCubit>.value(
          value: context.read<CompaniesCubit>(),
          child: _BuildEditCompany(company: companyModel),
        ),
      );

  @override
  State<_BuildEditCompany> createState() => _BuildEditCompanyState();
}

class _BuildEditCompanyState extends State<_BuildEditCompany> {
  var formKey = GlobalKey<FormBuilderState>();
  late var company = widget.company;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.edit(widget.company.id!)),
      ),
      body: FormBuilder(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Wrap(
                        children: [
                          _BuildFormBuilderTextField(
                            context,
                            name:
                                AppLocalizations.of(context)!.commercialFeature,
                            value: company.commercialFeature,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.legalEntity,
                            value: company.legalEntity,
                          ),
                          _BuildFormBuilderDropdown(
                            initialValue: company.isWorking
                                ? AppLocalizations.of(context)!.working
                                : AppLocalizations.of(context)!.notWorking,
                            items: [
                              AppLocalizations.of(context)!.working,
                              AppLocalizations.of(context)!.notWorking,
                            ],
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.fileNumber,
                            value: company.fileNumber,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.registerNumber,
                            value: company.registerNumber,
                          ),
                          _BuildFormBuilderDateTimePicker(
                            context,
                            name: AppLocalizations.of(context)!.startDate,
                            value: company.startDate,
                          ),
                          _BuildFormBuilderDateTimePicker(
                            context,
                            name: AppLocalizations.of(context)!.stopDate,
                            value: company.stopDate,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name:
                                AppLocalizations.of(context)!.generalTaxMission,
                            value: company.generalTaxMission,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.activityNature,
                            value: company.activityNature,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name:
                                AppLocalizations.of(context)!.activityLocation,
                            value: company.activityLocation,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.accounts,
                            value: company.accounts,
                          ),
                          _BuildFormBuilderDateTimePicker(
                            context,
                            name: AppLocalizations.of(context)!.joiningDate,
                            value: company.joiningDate,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.naturalId,
                            required: false,
                            value: company.naturalId,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.recordSide,
                            value: company.recordSide?.toString(),
                            required: false,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.recordNumber,
                            value: company.recordNumber.toString(),
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.userName,
                            value: company.userName,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.passport,
                            value: company.passport,
                            required: false,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.email,
                            value: company.email,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: _BuildFunders(
                              funders: company.funders,
                              onUpdate: (funders) {
                                company = company.copyWith(funders: funders);
                              },
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            flex: 1,
                            child: _BuildMoneyCapitals(
                              moneyCapitals: company.moneyCapitals,
                              onUpdate: (moneyCapitals) {
                                company = company.copyWith(
                                  moneyCapitals: moneyCapitals,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              BlocConsumer<CompaniesCubit, CompaniesState>(
                listener: (context, state) {
                  if (state is CompaniesSaveInFailure) {
                    showToast(
                      context,
                      message: state.error,
                      level: ToastLevel.error,
                    );
                  } else if (state is CompaniesSaveSuccess) {
                    showToast(
                      context,
                      message: state.message,
                    );
                  }
                },
                builder: (context, state) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: state is CompaniesSaveInProgress
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            var formState = formKey.currentState!;
                            if (formState.validate()) {
                              formState.save();
                              company = company.copyWith(
                                accounts: formState.value[
                                    AppLocalizations.of(context)!.accounts],
                                isWorking: formState.value[
                                        AppLocalizations.of(context)!
                                            .isWorking] ==
                                    AppLocalizations.of(context)!.working,
                                joiningDate: formState.value[
                                    AppLocalizations.of(context)!.joiningDate],
                                stopDate: formState.value[
                                    AppLocalizations.of(context)!.stopDate],
                                startDate: formState.value[
                                    AppLocalizations.of(context)!.startDate],
                                fileNumber: formState.value[
                                    AppLocalizations.of(context)!.fileNumber],
                                email: formState
                                    .value[AppLocalizations.of(context)!.email],
                                passport: formState.value[
                                    AppLocalizations.of(context)!.passport],
                                userName: formState.value[
                                    AppLocalizations.of(context)!.userName],
                                recordNumber: formState.value[
                                    AppLocalizations.of(context)!.recordNumber],
                                recordSide: formState.value[
                                    AppLocalizations.of(context)!.recordSide],
                                valueTaxMission: formState.value[
                                    AppLocalizations.of(context)!
                                        .valueTaxMission],
                                naturalId: formState.value[
                                    AppLocalizations.of(context)!.naturalId],
                                activityLocation: formState.value[
                                    AppLocalizations.of(context)!
                                        .activityLocation],
                                activityNature: formState.value[
                                    AppLocalizations.of(context)!
                                        .activityNature],
                                generalTaxMission: formState.value[
                                    AppLocalizations.of(context)!
                                        .generalTaxMission],
                                registerNumber: formState.value[
                                    AppLocalizations.of(context)!
                                        .registerNumber],
                                legalEntity: formState.value[
                                    AppLocalizations.of(context)!.legalEntity],
                                commercialFeature: formState.value[
                                    AppLocalizations.of(context)!
                                        .commercialFeature],
                                verificationCode: formState.value[
                                    AppLocalizations.of(context)!
                                        .verificationCode],
                              );
                              log(company.toString());
                              context
                                  .read<CompaniesCubit>()
                                  .saveCompany(company);
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!
                                .save(AppLocalizations.of(context)!.company),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildMoneyCapitals extends StatefulWidget {
  final List<MoneyCapitalModel>? moneyCapitals;
  final Function(List<MoneyCapitalModel>) onUpdate;
  const _BuildMoneyCapitals({
    Key? key,
    this.moneyCapitals,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<_BuildMoneyCapitals> createState() => _BuildMoneyCapitalsState();
}

class _BuildMoneyCapitalsState extends State<_BuildMoneyCapitals> {
  late var moneyCapitals = widget.moneyCapitals;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.moneyCapital,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    var inputs = await showTextInputDialog(
                      context: context,
                      textFields: [
                        DialogTextField(
                          hintText: AppLocalizations.of(context)!.moneyCapital,
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.numeric(
                                errorText: AppLocalizations.of(context)!.expect(
                                  AppLocalizations.of(context)!.number,
                                ),
                              ),
                              FormBuilderValidators.required(
                                errorText: AppLocalizations.of(context)!.expect(
                                  AppLocalizations.of(context)!.moneyCapital,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                    var value = inputs![0];
                    setState(() {
                      moneyCapitals = [
                        ...?moneyCapitals,
                        MoneyCapitalModel(
                          value: num.parse(value),
                          time: DateTime.now(),
                        )
                      ];
                    });
                    widget.onUpdate(moneyCapitals!);
                  },
                  icon: const Icon(Icons.add_outlined),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              height: 2,
            ),
          ),
          ...?moneyCapitals
              ?.map((m) => ListTile(
                    leading: Icon(
                      Icons.attach_money_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(m.value.toString()),
                    trailing: Text(m.time.toString()),
                  ))
              .toList(),
        ],
      ),
    );
  }
}

class _BuildFunders extends StatefulWidget {
  final List<FunderModel>? funders;
  final Function(List<FunderModel>) onUpdate;
  const _BuildFunders({
    Key? key,
    this.funders,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<_BuildFunders> createState() => _BuildFundersState();
}

class _BuildFundersState extends State<_BuildFunders> {
  late var funders = widget.funders;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.funders,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    var inputs = await showTextInputDialog(
                      context: context,
                      textFields: [
                        DialogTextField(
                          hintText: AppLocalizations.of(context)!.funderName,
                          validator: FormBuilderValidators.required(
                            errorText: AppLocalizations.of(context)!.expect(
                              AppLocalizations.of(context)!.funderName,
                            ),
                          ),
                        ),
                      ],
                    );
                    var name = inputs![0];
                    setState(() {
                      funders = [...?funders, FunderModel(name: name)];
                    });
                    widget.onUpdate(funders!);
                  },
                  icon: const Icon(Icons.add_outlined),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              height: 2,
            ),
          ),
          ...?funders
              ?.map((f) => ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(f.name),
                  ))
              .toList(),
        ],
      ),
    );
  }
}

class _BuildFormBuilderDropdown extends StatelessWidget {
  final String initialValue;
  final List<String> items;
  const _BuildFormBuilderDropdown({
    Key? key,
    required this.initialValue,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = double.infinity;
        if (constraints.maxWidth > 600) {
          width = constraints.maxWidth / 2;
        }
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderDropdown(
              name: AppLocalizations.of(context)!.isWorking,
              initialValue: initialValue,
              style: Theme.of(context).textTheme.headline4,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.isWorking,
              ),
              items: items
                  .map((e) => DropdownMenuItem(
                      value: e, child: FittedBox(child: Text(e))))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}

class _BuildFormBuilderDateTimePicker extends StatelessWidget {
  final String name;
  final DateTime? value;
  final bool required;
  const _BuildFormBuilderDateTimePicker(
    BuildContext context, {
    Key? key,
    required this.name,
    this.value,
    this.required = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = double.infinity;
        if (constraints.maxWidth > 600) {
          width = constraints.maxWidth / 2;
        }
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderDateTimePicker(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.joiningDate,
              ),
              style: Theme.of(context).textTheme.headline6,
              initialValue: value,
              name: name,
              validator: (date) {
                if (!required || date != null) return null;
                return AppLocalizations.of(context)!.expect(name);
              },
            ),
          ),
        );
      },
    );
  }
}

class _BuildFormBuilderTextField extends StatelessWidget {
  final String name;
  final String? value;
  final bool required;
  final String? Function(String?)? validator;
  _BuildFormBuilderTextField(
    BuildContext context, {
    Key? key,
    required this.name,
    this.value,
    this.required = true,
    String? Function(String?)? validator,
  })  : validator = validator ??
            FormBuilderValidators.required(
              errorText: AppLocalizations.of(context)!.expect(name),
            ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = double.infinity;
        if (constraints.maxWidth > 600) {
          width = constraints.maxWidth / 2;
        }
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: width,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
              initialValue: value,
              name: name,
              decoration: InputDecoration(
                labelText: name,
              ),
              style: Theme.of(context).textTheme.headline6,
              validator: (text) {
                if (!required) return null;
                return validator != null ? validator!(text) : null;
              },
            ),
          ),
        );
      },
    );
  }
}

class _InputClass {
  final String label;
  final TextEditingController controller;
  final TextInputType type;

  _InputClass(this.label, {this.type = TextInputType.text, String? text})
      : controller = TextEditingController()..text = text ?? '';
}

class _BuildTextField extends StatelessWidget {
  const _BuildTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.expect,
    this.type = TextInputType.text,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String expect;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = double.infinity;
        if (constraints.maxWidth > 600) {
          width = constraints.maxWidth / 2;
        }
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: width,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldWidget(
              controller: controller,
              label: label,
              expect: expect,
              type: type,
            ),
          ),
        );
      },
    );
  }
}
